理由はわからないが全然スクリプト compute_genotype_pcs.py が動かなかった、修正点は：
- bimファイルの染色体番号からchrを除く
- famファイルのphenotype列を1にしてmissing扱いしない
- smartpca.perlのploteig以降が動かないので、対応する中間ファイル削除をコメントアウト

eigensoftは、からダウンロードして、smartpcaを自分でコンパイル
plink2は、NIG環境であれば、以下のようなラッパーを作ってパスへ入れておく
```
#!/bin/bash
THREADS=${PLINK_THREADS:-4}
MEMORY=${PLINK_MEMORY:-16000}

IMG="/usr/local/biotools/p/plink2xxxxx"

singularity exec $IMG \
  plink2 \
  --threads "$THREADS" \
  --memory "$MEMORY" \
  "$@"
```
