# Normal build steps
. build/envsetup.sh
lunch voltage_lavender-userdebug

build_gapps=0

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
if [ $K19 == 1 ]; then
export TARGET_KERNEL_VERSION=4.19
elif [ $K19 == 0 ]; then
export TARGET_KERNEL_VERSION=4.4
fi
export PRODUCT_DEFAULT_DEV_CERTIFICATE=vendor/lineage-priv/keys/releasekey
export WITH_GMS=false

exp_gapps () {
export USE_GAPPS=false
}

compile_plox () {
#ls out/target/product/lavender/system.img || make systemimage -j10
#m api-stubs-docs -j7 || tg "api-stubs-docs failed"
#tg "Started api-stubs-docs compilation"
#m api-stubs-docs-non-updatable -j7 || tg "api-stubs-docs-non-updatable failed"
#m system-api-stubs-docs -j7 || tg "system-api-stubs-docs failed"
#m system-api-stubs-docs-non-updatable -j7 || tg "system-api-stubs-docs-non-updatable failed"
#m test-api-stubs-docs-non-updatable -j7 || tg "test-api-stubs-docs failed"
#m test-api-stubs-docs -j7 || tg "test-api-stubs-docs failed"
#m module-lib-api -j7 || tg "module-lib-api failed"
#m module-lib-api-stubs-docs-non-updatable -j7 || tg "module-lib-api-stubs-docs-non-updatable failed"
#m module-lib-api-stubs-docs -j 7 || tg "module-lib-api-stubs-docs failed"
#m hwbinder-stubs-docs -j 7 || tg "hwbinder-stubs-docs failed"
#tg "Now starting actual build"
m bacon -j16
}
