#!/bin/bash
#

. build/envsetup.sh
lunch helios-eng

make bootimage -j8 | tee helios-eng.log

if grep -q "Target boot image from recovery" helios-eng.log; then
  echo "=========================================================="
  echo "        MAKE bootimg Success !"
  echo "=========================================================="
else
  echo "=========================================================="
  echo "        MAKE bootimg Failed !"
  echo "=========================================================="
  exit
fi

make out/target/product/helios/dt.img -j8 | tee helios-eng-dt.log

if grep -q "Target dt image" helios-eng-dt.log; then
  echo "=========================================================="
  echo "        MAKE Kernel Success !"
  echo "=========================================================="
else
  echo "=========================================================="
  echo "        MAKE dt Failed !"
  echo "=========================================================="
  exit
fi


