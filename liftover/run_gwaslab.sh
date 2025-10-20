#!/usr/bin/env bash

eval "$(conda shell.bash hook)"
conda activate gwaslab3

IN=inputs/variants.txt
OUT=results/variants.hg19.txt

scripts/liftover_gwaslab.py \
  --variants $IN \
  --from 38 \
  --to 19 \
  --threads 10 \
  --out $OUT \
  > logs/log 2>&
