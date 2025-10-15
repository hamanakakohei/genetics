gtex-pipelineの `compute_genotype_pcs.py` でPCAする。


### 修正点
理由はわからないが、全然動かなかった。  
修正点は以下の通り：

- `.bim` ファイルの染色体番号から `chr` を除く  
- `.fam` ファイルの phenotype 列を `1` にして missing 扱いしない  
- `smartpca.perl` の `ploteig` 以降が動かないので、対応する中間ファイル削除をコメントアウト  

### 準備
EIGENSOFT は https://github.com/argriffing/eigensoft/tree/master からダウンロードし、`smartpca` を自分でコンパイルする。  
NIG環境ではコンパイル時にエラーが出て、「-lm」の位置を変えた。

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
```

### To do
gtexスクリプトを使うためにわざわざサブモジュール化したが、run_pipeline.sh内でwgetして使うようにした方がシンプル。
