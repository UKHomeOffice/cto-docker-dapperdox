ARG DAPPER_VER=1.2.2

FROM golang:1.12.7 AS builder
ARG DAPPER_VER
ENV VER=$DAPPER_VER

# install unzip utility
RUN apt-get -y update && apt-get -y install zip

# download and unzip Dapperdox sources
RUN cd /go/src/ && \
    curl -L -o dapperdox.zip https://github.com/DapperDox/dapperdox/archive/v${VER}.zip && \
    unzip dapperdox.zip && \
    rm dapperdox.zip

WORKDIR /go/src/dapperdox-${VER}

RUN go get ./
# build and ensure binary is fully linked
RUN CGO_ENABLED=0 go build -o /go/bin/dapperdox

FROM alpine
ARG DAPPER_VER
ENV VER=$DAPPER_VER

COPY --from=builder /go/bin/dapperdox /go/bin/dapperdox
COPY --from=builder /go/src/dapperdox-${VER}/assets /go/bin/assets

WORKDIR /go/bin

COPY assets/ assets
COPY specs/ specs

USER 1000
EXPOSE 3123

ENV SPEC_DIR specs
ENV ASSETS_DIR assets
ENV THEME_DIR assets
ENV THEME dapperdox-theme-gov-uk
ENV LOGLEVEL info
ENV BIND_ADDR 0.0.0.0:3123
ENV FORCE_SPECIFICATION_LIST true
ENV SPEC_FILENAME="uber/swagger.json"

CMD ./dapperdox

