# Normal build steps
. build/envsetup.sh
# RBE
. /tmp/ci/rbe
#export NINJA_REMOTE_NUM_JOBS=150
export RBE_CXX_LINKS_EXEC_STRATEGY=local
export RBE_METALAVA_EXEC_STRATEGY=local
export RBE_LOG_LEVEL=debug
export USE_CCACHE=0
env | grep RBE
lunch lineage_lavender-userdebug

build_gapps=0

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export PRODUCT_DEFAULT_DEV_CERTIFICATE=vendor/lineage-priv/keys/releasekey
export WITH_GMS=false
export USE_CCACHE=0

exp_gapps () {
export USE_GAPPS=false
}

exp_out () {
tg "Cook SystemUI" && m SystemUI || tg "build failed"
tg "SystemUI build completed!
Total out size: $(du -sh /tmp/rom/out | cut -d - -f 1 | cut -d / -f 1)"

tg "Cook Settings" && m Settings || tg "build failed"
tg "Settings build completed!
Total out size: $(du -sh /tmp/rom/out | cut -d - -f 1 | cut -d / -f 1)"

tg "Cook framework-res" && m framework-res || tg "build failed"
tg "framework-res build completed!
Total out size: $(du -sh /tmp/rom/out | cut -d - -f 1 | cut -d / -f 1)"

tg "Cook surfaceflinger" && m surfaceflinger || tg "build failed"
tg "surfaceflinger build completed!
Total out size: $(du -sh /tmp/rom/out | cut -d - -f 1 | cut -d / -f 1)"

tg "Cook libart" && m libart || tg "build failed"
tg "libart build completed!
#Total out size: $(du -sh /tmp/rom/out | cut -d - -f 1 | cut -d / -f 1)"

rm -rf out/t*/p*/lavender
tg "Out size after cleanup: $(du -sh /tmp/rom/out | cut -d - -f 1 | cut -d / -f 1)"

# Enable ccache upload only on S and C builds
# compress in with pigz in a single zip.
com out 1

# mai acc for uploads
login_main

echo "• Uploading OUT On Github Release •"
7za a -tzip -v2000m -mx=0 ${rom_name}-${branch_name}_out.zip out.tar.gz
for i in /tmp/rom/${rom_name}-${branch_name}_out.zip.*; do
   upload_ccache $i
done
tg "$rom_name OUT was uploaded successfully!
Total Size: $(ls -sh ${PWD}/out.tar.gz | cut -d - -f 1 | cut -d / -f 1)
Time Took: $(($SECONDS / 60)) minute(s) and $(($SECONDS % 60)) second(s).
Status: $progress"

#cleanup
rm -rf out.tar.gz ${rom_name}-${branch_name}_out.zip.*
}

compile_plox () {
#ls out/target/product/lavender/system.img || make systemimage -j10

#exp_out
#rm -rf /tmp/cache

m bacon -j16

# KSU bc -_-
if [ -e "/tmp/rom/out/error.log" ] && [ ! -e out/target/product/*/*.zip ] && [ $(cat /tmp/rom/out/error.log | grep -o -e 'KernelSU' -e 'FAILED: ' | head -n 1) ]; then
m bacon -j16
fi
}
