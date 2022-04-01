#!/bin/sh -ue
# ステートマシンを実行するサンプル。
# デプロイ後、準備として
# pip3 install -U -r requirements.txt
# ./export1.py
# で、./export.{yaml,sh} ファイルを生成の後
# このスクリプトを実行すること

. ./.export.sh
NAME1=$(date +%Y-%m-%d-%H-%M-%S.%N)

aws stepfunctions start-execution \
  --state-machine-arn "$StockTradingStateMachineArn" \
  --name "$NAME1" \
  --input '{"dummy":"dummy"}'
