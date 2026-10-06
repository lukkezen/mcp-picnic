FROM ghcr.io/openai/tunnel-client:v0.0.15 AS tunnel

FROM ghcr.io/ivo-toby/mcp-picnic:latest

USER root

RUN apk add --no-cache ca-certificates jq

COPY --from=tunnel /usr/bin/tunnel-client /usr/bin/tunnel-client
COPY run.sh /run.sh
RUN chmod 755 /run.sh /usr/bin/tunnel-client

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.type="app" \
    io.hass.arch="${BUILD_ARCH}"

HEALTHCHECK --interval=30s --timeout=5s --start-period=20s --retries=3 \
    CMD node -e "fetch('http://127.0.0.1:8080/readyz').then(r=>process.exit(r.ok?0:1)).catch(()=>process.exit(1))"

ENTRYPOINT ["/run.sh"]
