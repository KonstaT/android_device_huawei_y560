LineageOS 14.1 device configuration for [Huawei Y5](http://konstakang.com/devices/y560/CM14.1).

How to build:
-------------

Initialize repo:

    repo init -u git://github.com/LineageOS/android.git -b cm-14.1
    curl --create-dirs -L -o .repo/local_manifests/manifest_huawei_y560.xml -O -L https://raw.githubusercontent.com/legaCyMod/android_local_manifest/cm-14.1/manifest_huawei_y560.xml
    repo sync

Compile:

    . build/envsetup.sh
    brunch y560
