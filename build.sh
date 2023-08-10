# Normal build steps
. build/envsetup.sh
lunch derp_lavender-userdebug

#build_gapps=1

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
#export BUILD_BROKEN_DUP_RULES=true
export RELAX_USES_LIBRARY_CHECK=true
#export WITH_GMS=false

exp_gapps() {
export USE_GAPPS=true
export WITH_GMS=true
export WITH_GAPPS=true
export BLISS_BUILD_VARIANT=gapps
export TARGET_USES_MINI_GAPPS=true
}

compile_plox () {
mka derp -j17
}
