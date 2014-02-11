
MultiROM
========

This manifest is for building MultiROM for the Asus TF300T.

    repo init -u git://github.com/f69m/android -b multirom-tf300t
    repo sync
    source build/envsetup.sh
    lunch mrom_tf300t-userdebug
    make -j4 multirom_zip

