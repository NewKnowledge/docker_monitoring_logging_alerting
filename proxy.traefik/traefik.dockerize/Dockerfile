FROM traefik:alpine

ENV DOCKERIZE_VERSION v0.5.0
RUN apk add --no-cache bash curl openssl && \
    curl -L https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
      | tar -C /usr/local/bin -xzv -f -

WORKDIR /etc/traefik

ENTRYPOINT [ "/usr/local/bin/dockerize", "-template", "traefik.in.toml:traefik.toml" ]
CMD traefik
