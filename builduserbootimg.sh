#!/bin/bash
#

if [ -d "out_eng" ]; then
	echo "out check passed"

elif [ -d "out_user" ]; then
	mv out out_eng
	mv out_user out
	echo "out check passed"

else
	echo "out check failed"
	exit 1
fi

. build/envsetup.sh
lunch falcon-user
make bootimage -j8 | tee falcon.log
