ARG ARCH="amd64"
ARG OS="linux"

FROM golang:alpine as builder
ADD . /build
RUN cd /build/cmd/operator && go build

FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest

COPY --from=builder /build/cmd/operator /bin/

# On busybox 'nobody' has uid `65534'
USER 65534

ENTRYPOINT ["/bin/operator"]
