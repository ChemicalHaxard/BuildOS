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

get_system () {
tg "System.img Build Succeed!"
7za a -tzip ${rom_name}-${branch_name}_system.zip out/target/product/lavender/system.img
upload *_system.zip
}

get_product () {
tg "Product.img Build Succeed!"
7za a -tzip ${rom_name}-${branch_name}_product.zip out/target/product/lavender/product.img
upload *_product.zip
}

get_system_ext () {
tg "System_ext.img Build Succeed!"
7za a -tzip ${rom_name}-${branch_name}_system_ext.zip out/target/product/lavender/system_ext.img
upload *_system_ext.zip
}

get_vendor () {
tg "Vendor.img Build Succeed!"
7za a -tzip ${rom_name}-${branch_name}_vendor.zip out/target/product/lavender/vendor.img
upload *_vendor.zip
}

get_odm () {
tg "odm.img Build Succeed!"
7za a -tzip ${rom_name}-${branch_name}_odm.zip out/target/product/lavender/odm.img
upload *_odm.zip
}

get_boot () {
tg "Boot.img Build Succeed!"
7za a -tzip ${rom_name}-${branch_name}_boot.zip out/target/product/lavender/boot.img
upload *_boot.zip
}


compile_plox () {
# part 1
#tg "System.img buid started!"
#ls out/target/product/lavender/system.img && get_system || make systemimage -j16 && get_system

#tg "Product.img buid started!"
#ls out/target/product/lavender/product.img && get_product || make productimage -j16 && get_product

tg "System_ext.img buid started!"
ls out/target/product/lavender/system_ext.img && get_system_ext || make systemextimage -j16 && get_system_ext

# part2
tg "Vendor.img buid started!"
ls out/target/product/lavender/vendor.img && get_vendor || make vendorimage -j16 && get_vendor

#tg "odm.img buid started!"
#ls out/target/product/lavender/odm.img && get_odm || make odmimage -j16 && get_odm

tg "Boot.img buid started!"
ls out/target/product/lavender/boot.img && get_boot || make bootimage -j16 && get_boot

exit 0
#m bacon -j16
}
