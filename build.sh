# Normal build steps
. build/envsetup.sh
lunch lineage_lavender-userdebug

build_gapps=1

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export WITH_GMS=true

exp_gapps () {
export WITH_GMS=false
}

compile_plox () {
mka bacon -j17
}
