#!/bin/bash

cargo run --bin client -- \
  --endpoint "https://yellowstone-solana-mainnet.core.chainstack.com" \
  --x-token "51bd6e348ae5e28d55a8d6374c1e4645" \
  subscribe \
  --transactions \
  --transactions-vote false \
  --transactions-account-include whirLbMiicVdio4qvUfM5KAg6Ct8VwpYzGff3uctyCc \
  # --transactions-failed false \
  # --transactions-account-required whirLbMiicVdio4qvUfM5KAg6Ct8VwpYzGff3uctyCc \
  # --transactions-account-include Czfq3xZZDmsdGdUyrNLtRhGc47cXcZtLG4crryfu44zE \
  # --transactions-account-required EPjFWdd5AufqSSqeM2qN1xzybapC8G4wEGGkZwyTDt1v \
  # --transactions-account-required So11111111111111111111111111111111111111112\

#  Build succeeded. The image is ready as yellowstone_grpc_perry-client. You can run it with:
#
#   X_TOKEN=your-token docker compose up
#
#
