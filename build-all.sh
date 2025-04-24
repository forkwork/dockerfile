#!/bin/bash
set -e
set -o pipefail

# Path to this script
SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
JOBS="${JOBS:-2}"

# Errors file
ERRORS="$(pwd)/errors"

# Check for GNU Parallel
if ! command -v parallel &> /dev/null; then
  echo "[ERROR] GNU Parallel is required but not installed. Please install it and retry." >&2
  exit 2
fi

# Clear errors file at the start


build_and_push(){
  local base="$1"
  local suite="$2"
  local build_dir="$3"

  echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
  # Build the Docker image
  docker build --rm --force-rm -t "${REPO_URL}/${base}:${suite}" "${build_dir}" || return 1

  # On successful build, push the image
  echo "                       ---                                   "
  echo "Successfully built ${base}:${suite} with context ${build_dir}"
  echo "                       ---                                   "

  # Try push a few times because notary server sometimes returns 401 for no reason
  local n=0
  until [ "$n" -ge 5 ]; do
    docker push --disable-content-trust=false "${REPO_URL}/${base}:${suite}" && break
    echo "Try #$n failed... sleeping for 15 seconds"
    n=$((n+1))
    sleep 15
  done

  # Also push the tag latest for certain suites
  if [[ "$suite" == "stable" ]] || [[ "$suite" == "3.6" ]] || [[ "$suite" == "tools" ]]; then
    docker tag "${REPO_URL}/${base}:${suite}" "${REPO_URL}/${base}:latest"
    docker push --disable-content-trust=false "${REPO_URL}/${base}:latest"
  fi
}

dofile() {
	local f="$1"
	local image="${f%Dockerfile}"
	local base="${image%%/*}"
	local build_dir
	build_dir="$(dirname "$f")"
	local suite
	suite="${build_dir##*/}"

	if [[ -z "$suite" ]] || [[ "$suite" == "$base" ]]; then
		suite=latest
	fi

	# Call build_and_push and record errors if any
	if ! "$SCRIPT" build_and_push "$base" "$suite" "$build_dir"; then
		echo "$base:$suite" >> "$ERRORS"
	fi

echo
}

main(){
	# get the dockerfile
	IFS=$'\n'
	mapfile -t files < <(find -L . -iname '*Dockerfile' | sed 's|./||' | sort)
	unset IFS

	# build all dockerfile
	echo "Running in parallel with ${JOBS} jobs."
	parallel --tag --verbose --ungroup -j"${JOBS}" "$SCRIPT" dofile "{1}" ::: "${files[@]}"

	if [[ ! -f "$ERRORS" ]]; then
		echo "No errors, hooray!"
	else
		echo "[ERROR] Some images did not build correctly, see below." >&2
		echo "These images failed: $(cat "$ERRORS")" >&2
		exit 1
	fi
}

run(){
	args=$*
	f=$1

	if [[ "$f" == "" ]]; then
		main "$args"
	else
		$args
	fi
}

run "$@"
