#!/bin/bash
#
#==================================================================
#======================== Global_Vars =============================
#==================================================================

rc=0
Daily_build_dir=~/Daily_build
Log_dir=~/Log
rm -rf $Log_dir
FILE1=builduserall.sh
FILE2=make_install_clean_user.sh
FILE3=buildengall.sh
FILE4=make_install_clean_eng.sh
FinalReport=~/FinalReport.txt
rm -f $FinalReport

#==================================================================
#======================== Functions ===============================
#==================================================================


#------------------------ InitChecking ----------------------------

InitChecking(){
  mkdir -p $Daily_build_dir/$project/user/ $Daily_build_dir/$project/eng/ $Log_dir
  cd ~/$project
  echo "Start syncing $project ..."
  repo sync -f -c --no-tags -j8 2>&1 | tee $Log_dir/sync-$project.log
  echo "$project sync finished at :" >> $FinalReport
  date >> $FinalReport
  cd $android_path
  if ! { [ -f "$FILE1" ] && [ -f "$FILE2" ] && [ -f "$FILE3" ] && [ -f "$FILE4" ]; }; then :
      echo "File missing"
      exit 1
  fi
  chmod 775 builduserall.sh make_install_clean_user.sh buildengall.sh make_install_clean_eng.sh
}


#------------------------ User Build ------------------------------

UserBuild(){
  echo "Building $project user build..."
  ./make_install_clean_user.sh
  ./builduserall.sh

  cp helios-user.log $Log_dir/build-user-$project.log
  if grep -q "Install system fs image" $Log_dir/build-user-$project.log; then
    mv out/target/product/helios/boot.img $Daily_build_dir/$project/user/
    mv out/target/product/helios/dt.img $Daily_build_dir/$project/user/
    mv out/target/product/helios/system.img $Daily_build_dir/$project/user/
    mv out/target/product/helios/vendor.img $Daily_build_dir/$project/user/
    echo "${project} user build finished at : (Success)" >> $FinalReport
    msg="${project} user Build Success !"
    mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
  else
    echo "${project} user build finished at : (Failed)" >> $FinalReport
    msg="${project} user Build Failed !"
    mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
    rc=-1
  fi
  date >> $FinalReport
}

#------------------------ Eng Build -------------------------------

EngBuild(){
  echo "Building $project eng build..."
  ./make_install_clean_eng.sh
  ./buildengall.sh

  cp helios-eng.log $Log_dir/build-eng-$project.log
  if grep -q "Install system fs image" $Log_dir/build-eng-$project.log; then
    mv out/target/product/helios/boot.img $Daily_build_dir/$project/eng/
    mv out/target/product/helios/dt.img $Daily_build_dir/$project/eng/
    mv out/target/product/helios/system.img $Daily_build_dir/$project/eng/
    mv out/target/product/helios/vendor.img $Daily_build_dir/$project/eng/
    echo "$project eng build finished at : (Success)" >> $FinalReport
    msg="${project} eng Build Success !"
    mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
  else
    echo "$project eng build finished at : (Failed)" >> $FinalReport
    msg="${project} eng Build Failed !"
    mail -s "Build Finished !" lykaios1203@gmail.com <<< $msg
    rc=-1
  fi
  date >> $FinalReport
}

#//////////////////////////////////////////////////////////////////
#//////////////////////////////////////////////////////////////////
#//////////////////////////////////////////////////////////////////

#==================================================================
#======================== 3_SDM660_10_PRD =========================
#==================================================================

project=3_SDM660_10_PRD
android_path=LA.UM.8.2/LINUX/android
InitChecking
EngBuild

#==================================================================
#======================== 2_Elektra_10 ============================
#==================================================================

project=2_Elektra_10
android_path=LA.UM.8.2/LINUX/android
InitChecking
EngBuild

#==================================================================
#========================= 4_Elektra =============================
#==================================================================

project=4_Elektra
android_path=LA.UM.7.2/LINUX/android
InitChecking
EngBuild

#==================================================================
#======================== Final_result ============================
#==================================================================
sleep 10

if [ "$rc" = "0" ] ; then
  mail -s "Build Finished !" lykaios1203@gmail.com <<< 'All Build Success !'
else
  mail -s "Build Finished !" lykaios1203@gmail.com <<< 'Some Build Failed !'
fi