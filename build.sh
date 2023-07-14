# Normal build steps
. build/envsetup.sh
lunch lineage_lavender-userdebug

build_gapps=1

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
#export WITH_GMS=false

exp_gapps() {
export TARGET_CORE_GMS_EXTRAS=true
}

compile_plox () {
mka bacon -j17
}
