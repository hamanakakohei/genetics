理由はわからないが、gtex-pipelineの `compute_genotype_pcs.py` が全然動かなかった。  
修正点は以下の通り：

- `.bim` ファイルの染色体番号から `chr` を除く  
- `.fam` ファイルの phenotype 列を `1` にして missing 扱いしない  
- `smartpca.perl` の `ploteig` 以降が動かないので、対応する中間ファイル削除をコメントアウト  


EIGENSOFT は https://github.com/argriffing/eigensoft/tree/master からダウンロードし、`smartpca` を自分でコンパイルする。  


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
