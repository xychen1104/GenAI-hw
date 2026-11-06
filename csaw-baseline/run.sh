#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"
mkdir -p build
iverilog -g2012 -s spi_baseline_tb -o build/spi_baseline.vvp \
    sim/cells_sim.v rtl/qualifier_core.v tb/spi_baseline_tb.v
cd build
vvp spi_baseline.vvp "$@"
