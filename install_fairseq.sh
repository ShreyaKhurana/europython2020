#!/bin/bash
set -ex
git clone https://github.com/pytorch/fairseq
cd fairseq
pip3 install --editable .
cd ..
