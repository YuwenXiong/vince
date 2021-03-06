#!/usr/bin/env bash

ulimit -n 99999

TITLE="vince"
BASE_LOG_LOCATION="logs"
LOG_LOCATION=${BASE_LOG_LOCATION}"/"${TITLE}

mkdir -p ${LOG_LOCATION}
cp "$(readlink -f $0)" ${LOG_LOCATION}

python solver_runner.py \
  --title ${TITLE} \
  --base-logdir ${BASE_LOG_LOCATION} \
  --description r18-b-256-q-65536-jigsaw \
  --solver VinceSolver \
  --backbone ResNet18 \
  --dataset R2V2Dataset \
  --transform JigsawTransform \
  --jigsaw \
  --num-workers 40 \
  --pytorch-gpu-ids 0 \
  --feature-extractor-gpu-ids 1,2,3,4,5,6,7 \
  --batch-size 256 \
  --base-lr 0.03 \
  --vince-queue-size 65536 \
  --vince-momentum 0.999 \
  --vince-temperature 0.07 \
  --epochs 200 \
  --save-frequency 5000 \
  --iterations-per-epoch 5000 \
  --image-log-frequency 5000 \
  --long-save-frequency 10 \
  --log-frequency 10 \
  --input-width 225 \
  --input-height 225 \
  --use-videos \
  --num-frames 4 \
  --inter-batch-comparison \
  --imagenet-data-path /usr/lusers/xkcd/datasets/imagenet \
  --data-path /gscratch/scrubbed/xkcd/datasets/r2v2_large_with_ids/ \
  --use-apex
