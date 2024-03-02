#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67108864:644137caa630aa73d7b9200019eee922c534a545; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):67108864:6cb50330dfe884128e2851e3e3f3e649004f7339 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):67108864:644137caa630aa73d7b9200019eee922c534a545 && \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  /vendor/bin/log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi


