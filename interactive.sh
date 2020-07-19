fairseq-interactive data-bin/iwslt14.tokenized.de-en \
    --path checkpoints/checkpoint_best.pt \
    --bpe subword_nmt \
    --remove-bpe \
    --bpe-codes iwslt14.tokenized.de-en/code \
    --beam 10
