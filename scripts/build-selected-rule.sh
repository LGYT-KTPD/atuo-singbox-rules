#!/bin/bash

set -e

BASE="$HOME/atuo-singbox-build"

FULL="$BASE/output/sing-rule-full/geo"
OUT="$BASE/output/sing-rule/geo"


echo "== 创建目录 =="

mkdir -p "$OUT/geosite"
mkdir -p "$OUT/geoip"


echo "== 清理旧 geo 规则 =="

rm -f "$OUT/geosite"/*.srs
rm -f "$OUT/geoip"/*.srs


echo
echo "== geosite =="


GEOSITE_LIST=(
cn
geolocation-cn
geolocation-!cn

category-ads-all

apple
apple@cn
icloud
icloud@cn
icloudprivaterelay

google
google@!cn
google-play
google-gemini

youtube
youtube@ads

github
github-copilot

telegram

steam
steam@cn

openai

category-ai-!cn
category-ai-chat-!cn
)


for i in "${GEOSITE_LIST[@]}"
do
    if [ -f "$FULL/geosite/$i.srs" ]; then
        cp "$FULL/geosite/$i.srs" "$OUT/geosite/"
        echo "OK   $i"
    else
        echo "MISS $i"
    fi
done


echo
echo "== geoip =="


GEOIP_LIST=(
cn
private
cloudflare
cloudfront
us
jp
hk
sg
tw
)


for i in "${GEOIP_LIST[@]}"
do
    if [ -f "$FULL/geoip/$i.srs" ]; then
        cp "$FULL/geoip/$i.srs" "$OUT/geoip/"
        echo "OK   $i"
    else
        echo "MISS $i"
    fi
done


echo
echo "== 完成 =="

echo "geosite:"
find "$OUT/geosite" -name "*.srs" | wc -l

echo "geoip:"
find "$OUT/geoip" -name "*.srs" | wc -l

du -sh "$OUT/geosite"
du -sh "$OUT/geoip"
