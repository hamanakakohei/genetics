理由はわからないが、スクリプト `compute_genotype_pcs.py` が動かなかった。  
修正点は以下の通り：

- `.bim` ファイルの染色体番号から `chr` を除く  
- `.fam` ファイルの phenotype 列を `1` にして missing 扱いしない  
- `smartpca.perl` の `ploteig` 以降が動かないので、対応する中間ファイル削除をコメントアウト  


EIGENSOFT は公式サイトからダウンロードし、`smartpca` を自分でコンパイルして使用する。  


PLINK2は、NIG 環境であれば、以下のようなラッパーを作ってパスへ入れておく：  

```bash
#!/bin/bash
THREADS=${PLINK_THREADS:-4}
MEMORY=${PLINK_MEMORY:-16000}

IMG="/usr/local/biotools/p/plink2xxxxx"

singularity exec "$IMG" \
  plink2 \
  --threads "$THREADS" \
  --memory "$MEMORY" \
  "$@"
