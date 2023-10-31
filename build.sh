# Normal build steps
. build/envsetup.sh
lunch nad_lavender-user

# export variable here
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export USE_GAPPS=true

build_gapps=1

exp_gapps () {
export USE_GAPPS=false
}

compile_plox () {
make nad -j$(nproc --all)
}
