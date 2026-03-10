#!/bin/bash

cargo run --bin client -- \
  --endpoint  "https://perryte-mainnet-1de7.mainnet.rpcpool.com" \
  --x-token  "23bc9873-7e47-4255-a60c-c7a802cb91e7" \
  subscribe \
  --transactions \
  --transactions-vote false \
  --transactions-account-include Czfq3xZZDmsdGdUyrNLtRhGc47cXcZtLG4crryfu44zE  \
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
