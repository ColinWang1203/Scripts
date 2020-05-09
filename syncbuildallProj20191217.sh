#!/bin/bash
#
rm -f ~/FinishedTime.txt
rc=0

#==================================================================
#======================== 3_SDM660_10_PRD ============================
#==================================================================

#------------------------ Vars ------------------------------------

project=3_SDM660_10_PRD
android_path=LA.UM.8.2/LINUX/android
FILE1=builduserall.sh
FILE2=make_install_clean_user.sh
FILE3=buildengall.sh
FILE4=make_install_clean_eng.sh

#------------------------ Init ------------------------------------

mkdir -p ~/daily_build/$project/user/ ~/daily_build/$project/eng/
cd ~/$project
echo "Start syncing $project ..."
repo sync -f -c --no-tags -j8 2>&1 | tee ~/log/sync-$project.log
echo "$project sync finished at :" >> ~/FinishedTime.txt
date >> ~/FinishedTime.txt
cd $android_path
if ! { [ -f "$FILE1" ] && [ -f "$FILE2" ] && [ -f "$FILE3" ] && [ -f "$FILE4" ]; }; then :
    echo "File missing"
    exit 1
fi
chmod 775 builduserall.sh make_install_clean_user.sh buildengall.sh make_install_clean_eng.sh

#------------------------ User Build ------------------------------------

# echo "Building $project user build..."
# ./make_install_clean_user.sh
# ./builduserall.sh

# cp helios-user.log ~/log/build-user-$project.log
# if grep -q "Install system fs image" ~/log/build-user-$project.log; then
#   mv out/target/product/helios/boot.img ~/daily_build/$project/user/
#   mv out/target/product/helios/dt.img ~/daily_build/$project/user/
#   mv out/target/product/helios/system.img ~/daily_build/$project/user/
#   mv out/target/product/helios/vendor.img ~/daily_build/$project/user/
#   echo "${project} user build finished at : (Success)" >> ~/FinishedTime.txt
#   msg="${project} user Build Success !"
#   mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
# else
#   echo "${project} user build finished at : (Failed)" >> ~/FinishedTime.txt
#   msg="${project} user Build Failed !"
#   mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
#   rc=-1
# fi
# date >> ~/FinishedTime.txt

#------------------------ Eng Build ------------------------------------

echo "Building $project eng build..."
./make_install_clean_eng.sh
./buildengall.sh

cp helios-eng.log ~/log/build-eng-$project.log
if grep -q "Install system fs image" ~/log/build-eng-$project.log; then
  mv out/target/product/helios/boot.img ~/daily_build/$project/eng/
  mv out/target/product/helios/dt.img ~/daily_build/$project/eng/
  mv out/target/product/helios/system.img ~/daily_build/$project/eng/
  mv out/target/product/helios/vendor.img ~/daily_build/$project/eng/
  echo "$project eng build finished at : (Success)" >> ~/FinishedTime.txt
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '$project eng Build Success !'
else
  echo "$project eng build finished at : (Failed)" >> ~/FinishedTime.txt
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '$project eng Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime.txt

#==================================================================
#======================== 2_Elektra_10 ============================
#==================================================================

#------------------------ Vars ------------------------------------

project=2_Elektra_10
android_path=LA.UM.8.2/LINUX/android
FILE1=builduserall.sh
FILE2=make_install_clean_user.sh
FILE3=buildengall.sh
FILE4=make_install_clean_eng.sh

#------------------------ Init ------------------------------------

mkdir -p ~/daily_build/$project/user/ ~/daily_build/$project/eng/
cd ~/$project
echo "Start syncing $project ..."
repo sync -f -c --no-tags -j8 2>&1 | tee ~/log/sync-$project.log
echo "$project sync finished at :" >> ~/FinishedTime.txt
date >> ~/FinishedTime.txt
cd $android_path
if ! { [ -f "$FILE1" ] && [ -f "$FILE2" ] && [ -f "$FILE3" ] && [ -f "$FILE4" ]; }; then :
    echo "File missing"
    exit 1
fi
chmod 775 builduserall.sh make_install_clean_user.sh buildengall.sh make_install_clean_eng.sh

#------------------------ User Build ------------------------------------

# echo "Building $project user build..."
# ./make_install_clean_user.sh
# ./builduserall.sh

# cp helios-user.log ~/log/build-user-$project.log
# if grep -q "Install system fs image" ~/log/build-user-$project.log; then
#   mv out/target/product/helios/boot.img ~/daily_build/$project/user/
#   mv out/target/product/helios/dt.img ~/daily_build/$project/user/
#   mv out/target/product/helios/system.img ~/daily_build/$project/user/
#   mv out/target/product/helios/vendor.img ~/daily_build/$project/user/
#   echo "${project} user build finished at : (Success)" >> ~/FinishedTime.txt
#   msg="${project} user Build Success !"
#   mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
# else
#   echo "${project} user build finished at : (Failed)" >> ~/FinishedTime.txt
#   msg="${project} user Build Failed !"
#   mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
#   rc=-1
# fi
# date >> ~/FinishedTime.txt

#------------------------ Eng Build ------------------------------------

echo "Building $project eng build..."
./make_install_clean_eng.sh
./buildengall.sh

cp helios-eng.log ~/log/build-eng-$project.log
if grep -q "Install system fs image" ~/log/build-eng-$project.log; then
  mv out/target/product/helios/boot.img ~/daily_build/$project/eng/
  mv out/target/product/helios/dt.img ~/daily_build/$project/eng/
  mv out/target/product/helios/system.img ~/daily_build/$project/eng/
  mv out/target/product/helios/vendor.img ~/daily_build/$project/eng/
  echo "$project eng build finished at : (Success)" >> ~/FinishedTime.txt
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '$project eng Build Success !'
else
  echo "$project eng build finished at : (Failed)" >> ~/FinishedTime.txt
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '$project eng Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime.txt

#===================================================
#=================== 6_Elektra =====================
#===================================================

cd ~/6_Elektra/

repo sync -f -c --no-tags -j8 &> ~/log/sync-6_Elektra.log
echo "6_Elektra sync finished at :" >> ~/FinishedTime.txt
date >> ~/FinishedTime.txt
cd LA.UM.7.2/LINUX/android

#-----USER BUILD---------------------------------------------------

# ./make_install_clean_user.sh
# ./builduserall.sh

# cp helios-user.log ~/log/build-user-6_Elektra.log
# if grep -q "Install system fs image" ~/log/build-user-6_Elektra.log; then
#   mv out/target/product/helios/boot.img ~/daily_build/6_Elektra/user/
#   mv out/target/product/helios/dt.img ~/daily_build/6_Elektra/user/
#   mv out/target/product/helios/system.img ~/daily_build/6_Elektra/user/
#   mv out/target/product/helios/vendor.img ~/daily_build/6_Elektra/user/
#   echo "6_Elektra user build finished at : (Success)" >> ~/FinishedTime.txt
#   mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra user Build Success !'
# else
#   echo "6_Elektra user build finished at : (Failed)" >> ~/FinishedTime.txt
#   mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra user Build Failed !'
#   rc=-1
# fi
# date >> ~/FinishedTime.txt

#------ENG BUILD---------------------------------------------------

./make_install_clean_eng.sh
./buildengall.sh

cp helios-eng.log ~/log/build-eng-6_Elektra.log
if grep -q "Install system fs image" ~/log/build-eng-6_Elektra.log; then
  mv out/target/product/helios/boot.img ~/daily_build/6_Elektra/eng/
  mv out/target/product/helios/dt.img ~/daily_build/6_Elektra/eng/
  mv out/target/product/helios/system.img ~/daily_build/6_Elektra/eng/
  mv out/target/product/helios/vendor.img ~/daily_build/6_Elektra/eng/
  echo "6_Elektra eng build finished at : (Success)" >> ~/FinishedTime.txt
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra eng Build Success !'
else
  echo "6_Elektra eng build finished at : (Failed)" >> ~/FinishedTime.txt
  mail -s "Build Finished !" lykaios1203@gmail.com <<< '6_Elektra eng Build Failed !'
  rc=-1
fi
date >> ~/FinishedTime.txt


#===================================================
#================= Final_result ====================
#===================================================
sleep 10

if [ "$rc" = "0" ] ; then
  mail -s "Build Finished !" lykaios1203@gmail.com <<< 'All Build Success !'
else
  mail -s "Build Finished !" lykaios1203@gmail.com <<< 'Some Build Failed !'
fi

#===================================================
#===================================================
#===================================================



:'
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

#===================================================
#==================7_Elektra_PRD====================
#===================================================

cd ~/7_Elektra_PRD/

repo sync -f -c --no-tags -j8 &> ~/log/sync-7_Elektra_PRD.log
echo "7_Elektra_PRD sync finished at :" >> ~/FinishedTime
date >> ~/FinishedTime
cd LA.UM.7.2/LINUX/android

#------USER BUILD---------------------------------------------------
./make_install_clean_user.sh
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
./make_install_clean_eng.sh
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

======================================================================
'

