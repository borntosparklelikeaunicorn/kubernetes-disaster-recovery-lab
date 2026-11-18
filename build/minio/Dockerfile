# Stage 1: Build MinIO from official source

FROM golang:1.24-alpine AS builder

RUN apk add --no-cache git ca-certificates

ARG MINIO_REF=RELEASE.2025-10-15T17-29-55Z

RUN git clone \
    --depth 1 \
    --branch "${MINIO_REF}" \
    https://github.com/minio/minio.git \
    /src

WORKDIR /src

RUN CGO_ENABLED=0 GOOS=linux \
    go build -trimpath -o /out/minio .


# Stage 2: Create runtime image

FROM alpine:3.22

RUN apk add --no-cache ca-certificates \
    && mkdir -p /data

COPY --from=builder /out/minio /usr/local/bin/minio

EXPOSE 9000 9001

ENTRYPOINT ["/usr/local/bin/minio"]

CMD ["server", "/data", "--console-address", ":9001"]