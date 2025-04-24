FROM cockroachdb/cockroach:latest-v22.2

LABEL maintainer="KhulnaSoft DevOps <info@khulnasoft.com>"

# Copy and use bash for scripting
SHELL ["/bin/bash", "-c"]

# Create entrypoint script
RUN echo '#!/bin/bash' > /entrypoint.sh && \
    echo 'cockroach start-single-node --insecure --store=type=mem,size=100MiB &' >> /entrypoint.sh && \
    echo 'echo "Waiting for CockroachDB to start..."' >> /entrypoint.sh && \
    echo 'until cockroach sql --insecure -e "SELECT 1" > /dev/null 2>&1; do sleep 1; done' >> /entrypoint.sh && \
    echo 'echo "Running cluster setup..."' >> /entrypoint.sh && \
    echo 'cockroach sql --insecure <<EOF' >> /entrypoint.sh && \
    echo 'CREATE USER prisma;' >> /entrypoint.sh && \
    echo 'GRANT admin TO prisma;' >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING kv.range_merge.queue_interval = '50ms';" >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING kv.raft_log.disable_synchronization_unsafe = true;" >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING jobs.retention_time = '15s';" >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING jobs.registry.interval.cancel = '180s';" >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING jobs.registry.interval.gc = '30s';" >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING sql.stats.automatic_collection.enabled = false;" >> /entrypoint.sh && \
    echo "SET CLUSTER SETTING kv.range_split.by_load_merge_delay = '5s';" >> /entrypoint.sh && \
    echo "ALTER RANGE default CONFIGURE ZONE USING gc.ttlseconds = '5';" >> /entrypoint.sh && \
    echo "ALTER DATABASE system CONFIGURE ZONE USING gc.ttlseconds = '5';" >> /entrypoint.sh && \
    echo 'EOF' >> /entrypoint.sh && \
    echo 'wait -n' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
