# Ultimate OpenCode — Multi-arch Container
# Supported: linux/amd64, linux/arm64

FROM ubuntu:24.04 AS base

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git npm ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://opencode.ai/install | bash

FROM base AS installer
COPY . /tmp/ultimate-opencode
RUN bash /tmp/ultimate-opencode/install.sh --no-plugins --no-mcp

FROM base AS final
LABEL org.opencontainers.image.title="Ultimate OpenCode"
LABEL org.opencontainers.image.description="Sıfır opencode'u full mod'a çeviren paket"
LABEL org.opencontainers.image.source="https://github.com/zehedisode/ultimate-opencode"

COPY --from=installer /root/.config/opencode /root/.config/opencode
COPY --from=installer /root/.opencode /root/.opencode

CMD ["opencode"]
