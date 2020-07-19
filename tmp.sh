src=de
tgt=en
BPEROOT=subword-nmt/subword_nmt
BPE_CODE=iwslt14.tokenized.de-en/code
prep=iwslt14.tokenized.de-en
tmp=$prep/tmp

for L in $src $tgt; do
    for f in train.$L valid.$L test.$L; do
        echo "apply_bpe.py to ${f}..."
        python $BPEROOT/apply_bpe.py -c $BPE_CODE < $tmp/$f > $prep/$f
    done
done
