FROM rust:1.86-bookworm AS builder

WORKDIR /build

# Copy workspace manifests first for layer caching
COPY Cargo.toml Cargo.lock rust-toolchain.toml ./
COPY yellowstone-grpc-proto/Cargo.toml yellowstone-grpc-proto/
COPY yellowstone-grpc-client/Cargo.toml yellowstone-grpc-client/
COPY yellowstone-grpc-geyser/Cargo.toml yellowstone-grpc-geyser/
COPY examples/rust/Cargo.toml examples/rust/

# Create dummy sources so cargo can resolve the workspace
RUN mkdir -p yellowstone-grpc-proto/src && echo "" > yellowstone-grpc-proto/src/lib.rs && \
    mkdir -p yellowstone-grpc-proto/proto && \
    mkdir -p yellowstone-grpc-proto/benches && echo "fn main(){}" > yellowstone-grpc-proto/benches/encode.rs && \
    mkdir -p yellowstone-grpc-client/src && echo "" > yellowstone-grpc-client/src/lib.rs && \
    mkdir -p yellowstone-grpc-geyser/src/bin && echo "" > yellowstone-grpc-geyser/src/lib.rs && \
    echo "fn main(){}" > yellowstone-grpc-geyser/src/bin/config-check.rs && \
    mkdir -p examples/rust/src/bin && \
    echo "fn main(){}" > examples/rust/src/bin/client.rs && \
    echo "fn main(){}" > examples/rust/src/bin/subscribe-ping.rs && \
    echo "fn main(){}" > examples/rust/src/bin/tx-blocktime.rs

# Pre-fetch dependencies
RUN cargo fetch

# Copy real sources
COPY yellowstone-grpc-proto/ yellowstone-grpc-proto/
COPY yellowstone-grpc-client/ yellowstone-grpc-client/
COPY yellowstone-grpc-geyser/ yellowstone-grpc-geyser/
COPY examples/rust/ examples/rust/

# Touch source files so cargo knows they changed
RUN touch yellowstone-grpc-proto/src/lib.rs \
    yellowstone-grpc-client/src/lib.rs \
    examples/rust/src/bin/client.rs

RUN cargo build --release --bin client -p yellowstone-grpc-client-simple

# --- Runtime stage ---
FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/target/release/client /usr/local/bin/client
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENV ENDPOINT="https://yellowstone-solana-mainnet.core.chainstack.com"
ENV X_TOKEN=""
ENV TRANSACTIONS_VOTE="false"
ENV TRANSACTIONS_FAILED="false"
ENV ACCOUNTS=""

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
