FROM rust as builder

ADD . /capstone-rs
WORKDIR /capstone-rs/capstone-rs/fuzz

RUN rustup toolchain add nightly
RUN rustup default nightly
RUN cargo +nightly install -f cargo-fuzz

RUN cargo +nightly fuzz build

FROM ubuntu:20.04

COPY --from=builder /capstone-rs/capstone-rs/fuzz/target/x86_64-unknown-linux-gnu/release/fuzz_target_disasm_x86_64 /
