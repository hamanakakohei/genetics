#!/usr/bin/env bash
set -euo pipefail

vcf=inputs/ALL.correctRefAlt.norm.vcf.gz
vcf_file=$(basename $vcf)
genotype_pc=results/${vcf_file%.vcf.gz}.maf05_geno01.pruned.pca.evec
genotype_pc_tr=${genotype_pc}.tr


# 設定
# plink、smartpca、smartpca.perl、ploteigなどへパスを通す
export PLINK_THREADS=4
export PLINK_MEMORY=8000
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/github/eigensoft/bin:$PATH"
export PATH="$HOME/github/eigensoft/src/perlsrc:$PATH"

eval "$(conda shell.bash hook)"
conda activate misc_20250301

source <(curl -fsSL https://raw.githubusercontent.com/hamanakakohei/misc/refs/heads/main/utils/general.sh)


# gtex-piplineのスクリプトを使ってeigensoftを動かす
# ただ、smartpca.perl内のploteig以降でエラーが出たまま
scripts/01_compute_genotype_pcs.edit.py \
  ${vcf} \
  -o results \
  > logs/01.txt 2>&1


# 必須でないが、転置した結果も出力する
tail -n+2 $genotype_pc \
  | cut -d":" -f2- \
  | transpose \
  | awk 'NR==1{print "ID\t"$0} NR>1{print "PC"NR-1"\t"$0}' \
  > $genotype_pc_tr
