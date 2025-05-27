# Normal build steps
. build/envsetup.sh
# RBE
#. /tmp/ci/rbe
#export NINJA_REMOTE_NUM_JOBS=150
#export RBE_CXX_LINKS_EXEC_STRATEGY=local
#export RBE_METALAVA_EXEC_STRATEGY=local
#export RBE_LOG_LEVEL=debug
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache
env | grep RBE
lunch xdroid_lavender-userdebug

build_gapps=0

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export WITH_GMS=false
export USE_CCACHE=1
export CCACHE_DIR=/tmp/ccache

exp_gapps () {
export USE_GAPPS=false
}

compile_plox () {
make xd -j16
# 10min break for quick fix
if [ -e "/tmp/rom/out/error.log" ] && [ ! -e out/target/product/*/*.zip ]; then
sleep 10m
git -C device/xiaomi/sdm660-common pull -r
git -C device/xiaomi/lavender pull -r
make xd -j16
fi
# KSU bc -_-
if [ -e "/tmp/rom/out/error.log" ] && [ ! -e out/target/product/*/*.zip ] && [ $(cat /tmp/rom/out/error.log | grep -o -e 'KernelSU' -e 'FAILED: ' | head -n 1) ]; then
make xd -j16
fi
}
