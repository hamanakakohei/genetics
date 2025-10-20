#!/usr/bin/env python3
import pandas as pd
import gwaslab as gl
import argparse
from pathlib import Path


def main():
  parser = argparse.ArgumentParser( description="" )
  parser.add_argument("--variants", type=Path, required=True, help="variant_id、chr、pos、ref、alt列がある表")
  parser.add_argument("--from", dest="from_build", choices=["19", "38"], required=True)
  parser.add_argument("--to", dest="to_build", choices=["19", "38"], required=True)
  parser.add_argument("--threads", type=int, default=1)
  parser.add_argument("--out", type=Path, required=True, help="")
  args = parser.parse_args()

  # 保存先ディレクトリ作る
  args.out.parent.mkdir(parents=True, exist_ok=True)

  sumsta = gl.Sumstats(
    str(args.variants),
    snpid = "variant_id",
    chrom = "chr",
    pos   = "pos",
    ref   = "ref",
    alt   = "alt"
  )

  sumsta.basic_check( verbose = True )
  sumsta.liftover( n_cores=args.threads, from_build=args.from_build, to_build=args.to_build )
  sumsta.data.to_csv( args.out, sep='\t', index=False )


if __name__ == "__main__":
  main()
