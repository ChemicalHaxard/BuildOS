# Normal build steps
. build/envsetup.sh
lunch aospa_lavender-user

build_gapps=0

# export variable here
export TZ=Asia/Kolkata
#export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
if [ $K19 == 1 ]; then
export TARGET_KERNEL_VERSION=4.19
elif [ $K19 == 0 ]; then
export TARGET_KERNEL_VERSION=4.4
fi
#export PRODUCT_DEFAULT_DEV_CERTIFICATE=vendor/lineage-priv/keys/releasekey
export WITH_GMS=false

exp_gapps () {
export USE_GAPPS=false
}

compile_plox () {
#ls out/target/product/lavender/system.img || make systemimage -j10
#m bacon -j16
./r* lavender -t user -j8
}
