#!/bin/bash
set -x
json_out=`pwd`/errors.json
report_out=`pwd`/report
rm -rf $json_out
rm -rf $report_out

apt install -y autoconf libncurses5-dev libncursesw5-dev
./autogen.sh
./configure CC=kcc LD=kcc CFLAGS="-fissue-report=$json_out" --disable-unicode
make
timeout 10s ./htop # run the program
touch $json_out && rv-html-report $json_out -o $report_out
rv-upload-report $report_out
