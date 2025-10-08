理由はわからないが全然スクリプト compute_genotype_pcs.py が動かなかった、修正点は：
- bimファイルの染色体番号からchrを除く
- famファイルのphenotype列を1にしてmissing扱いしない
- smartpca.perlのploteig以降が動かないので、対応する中間ファイル削除をコメントアウト

eigensoftは、からダウンロードして、smartpcaを自分でコンパイル
plink2は、
