#!/bin/bash
#

if [ -d "out_eng" ]; then
	mv out out_user
	mv out_eng out
	echo "out check passed"

elif [ -d "out_user" ]; then
	echo "out check passed"

else
	echo "out check failed"
	exit 1
fi

. build/envsetup.sh
lunch helios-eng
make bootimage out/target/product/helios/dt.img -j12 | tee helios-eng.log
echo "=========================================================="
mail -s "Build Finished !" lykaios1203@gmail.com <<< 'Build Finished !'

