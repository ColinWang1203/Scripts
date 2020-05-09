#!/bin/bash
#
rm ~/FinishedTime
rc=0
#===================================================
#==================7_Elektra_PRD====================
#===================================================

cd ~/7_Elektra_PRD/

repo sync -f -c --no-tags -j8 &> ~/log/sync-7_Elektra_PRD.log
echo "7_Elektra_PRD sync finished at :" >> ~/FinishedTime
date >> ~/FinishedTime
cd LA.UM.7.2/LINUX/android

#------USER BUILD---------------------------------------------------

./builduserall.sh

mv out/target/product/helios/boot.img ~/daily_build/7_Elektra_PRD/user/
mv out/target/product/helios/dt.img ~/daily_build/7_Elektra_PRD/user/
mv out/target/product/helios/system.img ~/daily_build/7_Elektra_PRD/user/
mv out/target/product/helios/vendor.img ~/daily_build/7_Elektra_PRD/user/

cp helios-user.log ~/log/build-user-7_Elektra_PRD.log
if grep -q "Install system fs image" ~/log/build-user-7_Elektra_PRD.log; then
  echo "7_Elektra_PRD user build finished at : (Success)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '7_Elektra_PRD user Build Success !'
else
  echo "7_Elektra_PRD user build finished at : (Failed)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '7_Elektra_PRD user Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime

#------ENG BUILD---------------------------------------------------

./buildengall.sh

mv out/target/product/helios/boot.img ~/daily_build/7_Elektra_PRD/eng/
mv out/target/product/helios/dt.img ~/daily_build/7_Elektra_PRD/eng/
mv out/target/product/helios/system.img ~/daily_build/7_Elektra_PRD/eng/
mv out/target/product/helios/vendor.img ~/daily_build/7_Elektra_PRD/eng/

cp helios-eng.log ~/log/build-eng-7_Elektra_PRD.log
if grep -q "Install system fs image" ~/log/build-eng-7_Elektra_PRD.log; then
  echo "7_Elektra_PRD eng build finished at : (Success)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '7_Elektra_PRD eng Build Success !'
else
  echo "7_Elektra_PRD eng build finished at : (Failed)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '7_Elektra_PRD eng Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime


#===================================================
#=================== 6_Elektra =====================
#===================================================

cd ~/6_Elektra/

repo sync -f -c --no-tags -j8 &> ~/log/sync-6_Elektra.log
echo "6_Elektra sync finished at :" >> ~/FinishedTime
date >> ~/FinishedTime
cd LA.UM.7.2/LINUX/android

#-----USER BUILD---------------------------------------------------
./builduserall.sh

mv out/target/product/helios/boot.img ~/daily_build/6_Elektra/user/
mv out/target/product/helios/dt.img ~/daily_build/6_Elektra/user/
mv out/target/product/helios/system.img ~/daily_build/6_Elektra/user/
mv out/target/product/helios/vendor.img ~/daily_build/6_Elektra/user/

cp helios-user.log ~/log/build-user-6_Elektra.log
if grep -q "Install system fs image" ~/log/build-user-6_Elektra.log; then
  echo "6_Elektra user build finished at : (Success)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra user Build Success !'
else
  echo "6_Elektra user build finished at : (Failed)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra user Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime

#------ENG BUILD---------------------------------------------------
./buildengall.sh

mv out/target/product/helios/boot.img ~/daily_build/6_Elektra/eng/
mv out/target/product/helios/dt.img ~/daily_build/6_Elektra/eng/
mv out/target/product/helios/system.img ~/daily_build/6_Elektra/eng/
mv out/target/product/helios/vendor.img ~/daily_build/6_Elektra/eng/

cp helios-eng.log ~/log/build-eng-6_Elektra.log
if grep -q "Install system fs image" ~/log/build-eng-6_Elektra.log; then
  echo "6_Elektra eng build finished at : (Success)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra eng Build Success !'
else
  echo "6_Elektra eng build finished at : (Failed)" >> ~/FinishedTime
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra eng Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime


#===================================================
#================= Final_result ====================
#===================================================

if [ "$rc" = "0" ] ; then
  mail -s "Build Finished !" lykaios1203@gmail.com <<< 'All Build Success !'
else
  mail -s "Build Finished !" lykaios1203@gmail.com <<< 'Some Build Failed !'
fi

#===================================================
#===================================================
#===================================================

#cd ~/2_zebra_factory_660/
#
#repo sync -f -c --no-tags -j8 > ~/log/sync-2_zebra_factory_660.log 2>&1 
#echo "2_zebra_factory_660 sync finished at :" >> ~/FinishedTime
#date >> ~/FinishedTime
#cd LA.UM.6.2/LINUX/android
#
#export JAVA_HOME=/Data/tw024698/2_zebra_factory_660/LA.UM.6.2/LINUX/android/prebuilts/jdk/jdk8/linux-x86/
#./prebuilts/sdk/tools/jack-admin kill-server
#./prebuilts/sdk/tools/jack-admin start-server
#
#. build/envsetup.sh
#lunch helios-eng
#make -j8 > ~/log/build-2_zebra_factory_660.log 2>&1
#echo "2_zebra_factory_660 eng build finished at :" >> ~/FinishedTime
#date >> ~/FinishedTime

#---------------------------------------------------
#---------------------------------------------------

#cd ~/4_zebra_product/
#
#repo sync -f -c --no-tags -j8 > ~/log/sync-4_zebra_product.log 2>&1
#echo "4_zebra_product sync finished at :" >> ~/FinishedTime
#date >> ~/FinishedTime
#cd LA.UM.6.2/LINUX/android
#
#export JAVA_HOME=/Data/tw024698/4_zebra_product/LA.UM.6.2/LINUX/android/prebuilts/jdk/jdk8/linux-x86/
#./prebuilts/sdk/tools/jack-admin kill-server
#./prebuilts/sdk/tools/jack-admin start-server
#
#. build/envsetup.sh
#lunch helios-eng
#make -j8 > ~/log/build-4_zebra_product.log 2>&1
#echo "4_zebra_product eng build finished at :" >> ~/FinishedTime
#date >> ~/FinishedTime

#---------------------------------------------------
