# Normal build steps
. build/envsetup.sh
# RBE
#. /tmp/ci/rbe
#export NINJA_REMOTE_NUM_JOBS=150
#export RBE_CXX_LINKS_EXEC_STRATEGY=local
#export RBE_METALAVA_EXEC_STRATEGY=local
#export RBE_LOG_LEVEL=debug
#export USE_CCACHE=0
lunch lineage_lavender-userdebug

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export TARGET_KERNEL_VERSION=4.4
#export USE_CCACHE=0

build_gapps=0
export GAPPS=false


exp_gapps() {
export GAPPS=true
}

compile_plox () {
make bacon -j16

# 5min break for quick fix
if [ -e "/tmp/rom/out/error.log" ] && [ ! -e out/target/product/*/*.zip ]; then
push_log
tg "- Push your fix asap...!"
sleep 5m
git -C device/xiaomi/sdm660-common pull -r
git -C device/xiaomi/lavender pull -r
git -C device/qcom/sepolicy-legacy-um pull -r
make bacon -j16
fi
# again
if [ -e "/tmp/rom/out/error.log" ] && [ ! -e out/target/product/*/*.zip ]; then
push_log
tg "- Push your fix asap...!"
sleep 5m
git -C device/xiaomi/sdm660-common pull -r
git -C device/xiaomi/lavender pull -r
git -C device/qcom/sepolicy-legacy-um pull -r
make bacon -j16
fi

# KSU bc -_-
if [ -e "/tmp/rom/out/error.log" ] && [ ! -e out/target/product/*/*.zip ] && [ $(cat /tmp/rom/out/error.log | grep -o -e 'KernelSU' -e 'FAILED: ' | head -n 1) ]; then
make bacon -j16
fi
}
