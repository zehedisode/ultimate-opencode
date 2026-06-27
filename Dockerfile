FROM ubuntu:24.04

RUN apt-get update && apt-get install -y curl git npm && \
    curl -fsSL https://opencode.ai/install | bash

COPY . /tmp/ultimate-opencode
RUN cd /tmp/ultimate-opencode && bash install.sh

CMD ["opencode"]
