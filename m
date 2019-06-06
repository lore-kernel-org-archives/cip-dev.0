From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu,  6 Jun 2019 16:48:29 +0900
Subject: [cip-dev] [next] iwg20m: add support for this board
In-Reply-To: <20190606074829.8104-1-daniel.sangorrin@toshiba.co.jp>
References: <20190606074829.8104-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190606074829.8104-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch adds support for the iwg20m board to isar-cip-core.

- Kernel version notes

This board is only supported by the 4.4 kernel. For that
reason, the preferred version is set to 4.4 and the user
doesn't need to specify :opt-4.4.yml

- U-boot notes

The u-boot version shipped with the board is rather
old (2013.01) and comes without distro boot support.
We could try building it with CONFIG_CMD_SOURCE to use
a boot.scr script. However, the build gave several
errors probably caused by incompatibilities with
modern compilers. Additionally, u-boot resides
on an SPI device and any failures while updating
it will brick the board. For all these reasons,
this patch relies on the u-boot shipped with the
board completely. The user needs to setup some
additional u-boot environment variables as described
in doc/README_iwg20m.md

- Kernel configuration notes

The configuration is based on the kernel's
shmobile_defconfig. Then it adds some
configuration bits for booting on an SDCard with
EXT4, booting from a ramdisk, and running Systemd.

- Bmap notes

The document doc/README_iwg20m.md uses bmaptool to
flash the image onto an SDCard. This functionality
is not yet available on the ISAR version used by
isar-cip-core. For now, you can either backport the
bmap patch [1] or use dd as explained in the README.

[1] https://lists.cip-project.org/pipermail/cip-dev/2019-June/002430.html

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>

sdf

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 board-iwg20m.yml                            |  16 ++
 conf/machine/iwg20m.conf                    |  24 ++
 doc/README_iwg20m.md                        |  49 ++++
 recipes-kernel/linux/files/iwg20m_defconfig | 275 ++++++++++++++++++++
 wic/iwg20m.wks                              |  18 ++
 5 files changed, 382 insertions(+)
 create mode 100644 board-iwg20m.yml
 create mode 100644 conf/machine/iwg20m.conf
 create mode 100644 doc/README_iwg20m.md
 create mode 100644 recipes-kernel/linux/files/iwg20m_defconfig
 create mode 100644 wic/iwg20m.wks

diff --git a/board-iwg20m.yml b/board-iwg20m.yml
new file mode 100644
index 0000000..fbb2a2e
--- /dev/null
+++ b/board-iwg20m.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba corp., 2019
+#
+# Authors:
+#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+machine: iwg20m
+target: cip-core-image
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
new file mode 100644
index 0000000..2f91771
--- /dev/null
+++ b/conf/machine/iwg20m.conf
@@ -0,0 +1,24 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba corp. 2019
+#
+# SPDX-License-Identifier: MIT
+#
+DISTRO_ARCH = "armhf"
+
+# see wic/iwg20m.wks
+IMAGE_TYPE = "wic-img"
+
+# sets serial login getty
+MACHINE_SERIAL = "ttySC0"
+BAUDRATE_TTY = "115200"
+
+# kernel version
+PREFERRED_VERSION_linux-cip ?= "4.4.%"
+PREFERRED_VERSION_linux-cip-rt ?= "4.4.%"
+
+# Boot partition files
+DTB_FILE = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
+KERNEL_IMAGE="zImage"
+IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
diff --git a/doc/README_iwg20m.md b/doc/README_iwg20m.md
new file mode 100644
index 0000000..25fdf72
--- /dev/null
+++ b/doc/README_iwg20m.md
@@ -0,0 +1,49 @@
+# ISAR CIP Core: Instructions for the Renesas IWG20M board
+
+Version: 20190606
+Copyright: Toshiba corp.
+
+## Build the CIP Core image
+
+Use [kas-docker](https://github.com/siemens/kas/blob/master/kas-docker) to build the image. Currently this board is only supported by the CIP kernel version `4.4.y`.
+
+```
+$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
+$ cd isar-cip-core
+$ wget https://raw.githubusercontent.com/siemens/kas/master/kas-docker
+$ chmod a+x kas-docker
+$ ./kas-docker --isar build kas.yml:board-iwg20m.yml
+```
+
+After the build is finished, insert a micro SDCard and flash the image with `bmaptool` (a better `dd`). Make sure you substitute `/dev/sdX` by the device file corresponding to your SDCard.
+
+```
+$ sudo apt install bmap-tools
+$ sudo bmaptool copy --bmap build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img.bmap build/tmp/deploy/images/iwg20m/cip-core-image-cip-core-iwg20m.wic.img /dev/sdX
+```
+
+[Note] the bmap file will only be created on newer versions of ISAR. If the bmap file was not created then use `dd`.
+
+## U-boot settings
+
+
+In order to boot from the micro SDCard, we need to set some environment variables on u-boot. Insert the card on the microSD slot (on the upper hardware module), and a USB-serial cable to the USB Debug port (on the lower hardware module). Open a serial terminal (here we use `picocom`), and then switch on the board and enter the u-boot interactive command line to set the environment variables.
+
+```
+$ picocom -b 115200 /dev/ttyUSB0
+iWave-G20M > setenv bootargs_msd 'setenv bootargs ${bootargs_base} root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait'
+iWave-G20M > setenv bootcmd_msd 'run bootargs_msd;run fdt_check;mmc dev 1;fatload mmc 1 ${loadaddr} zImage;fatload mmc 1 ${fdt_addr} r8a7743-iwg20d-q7-dbcm-ca.dtb;bootz ${loadaddr} - ${fdt_addr}'
+iWave-G20M > saveenv
+```
+
+Note that `mmcblk0p2` represents the SDCard when running the CIP kernel 4.4. Once the environment variables are setup, you can boot from the SDCard as follows
+
+```
+iWave-G20M > run bootcmd_msd
+```
+
+Finally, to make that persistent set the `bootcmd` variable.
+
+```
+iWave-G20M > setenv bootcmd 'run bootcmd_msd'
+```
diff --git a/recipes-kernel/linux/files/iwg20m_defconfig b/recipes-kernel/linux/files/iwg20m_defconfig
new file mode 100644
index 0000000..7fb16de
--- /dev/null
+++ b/recipes-kernel/linux/files/iwg20m_defconfig
@@ -0,0 +1,275 @@
+
+# systemd configs
+CONFIG_DEVTMPFS=y
+CONFIG_CGROUPS=y
+CONFIG_INOTIFY_USER=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EPOLL=y
+CONFIG_NET=y
+CONFIG_SYSFS=y
+CONFIG_PROC_FS=y
+CONFIG_FHANDLE=y
+CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_CRYPTO_HMAC=y
+CONFIG_CRYPTO_SHA256=y
+CONFIG_SYSFS_DEPRECATED=n
+CONFIG_UEVENT_HELPER_PATH=""
+CONFIG_FW_LOADER_USER_HELPER=n
+CONFIG_DMIID=y
+CONFIG_BLK_DEV_BSG=y
+CONFIG_NET_NS=y
+CONFIG_USER_NS=y
+CONFIG_IPV6=y
+CONFIG_AUTOFS_FS=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+#CONFIG_REISERFS_FS_POSIX_ACL=y
+#CONFIG_JFS_POSIX_ACL=y
+#CONFIG_XFS_POSIX_ACL=y
+#CONFIG_BTRFS_FS_POSIX_ACL=y
+#CONFIG_F2FS_FS_POSIX_ACL=y
+CONFIG_FS_POSIX_ACL=y
+CONFIG_TMPFS_POSIX_ACL=y
+#CONFIG_JFFS2_FS_POSIX_ACL=y
+#CONFIG_CEPH_FS_POSIX_ACL=y
+#CONFIG_9P_FS_POSIX_ACL=y
+CONFIG_SECCOMP=Y
+CONFIG_SECCOMP_FILTER=y
+CONFIG_CHECKPOINT_RESTORE=y
+CONFIG_CGROUP_SCHED=y
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_CFS_BANDWIDTH=y
+CONFIG_CGROUP_BPF=y
+CONFIG_RT_GROUP_SCHED=n
+
+# to boot from the SD Card
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT2=y
+
+# to boot from an initramfs
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=4
+CONFIG_BLK_DEV_RAM_SIZE=250000
+
+# shmobile_defconfig
+CONFIG_SYSVIPC=y
+CONFIG_NO_HZ=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=16
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_EMBEDDED=y
+CONFIG_PERF_EVENTS=y
+CONFIG_SLAB=y
+CONFIG_ARCH_SHMOBILE_MULTI=y
+CONFIG_ARCH_EMEV2=y
+CONFIG_ARCH_R7S72100=y
+CONFIG_ARCH_R8A73A4=y
+CONFIG_ARCH_R8A7740=y
+CONFIG_ARCH_R8A7743=y
+CONFIG_ARCH_R8A7745=y
+CONFIG_ARCH_R8A77470=y
+CONFIG_ARCH_R8A7778=y
+CONFIG_ARCH_R8A7779=y
+CONFIG_ARCH_R8A7790=y
+CONFIG_ARCH_R8A7791=y
+CONFIG_ARCH_R8A7793=y
+CONFIG_ARCH_R8A7794=y
+CONFIG_ARCH_SH73A0=y
+CONFIG_CPU_BPREDICT_DISABLE=y
+CONFIG_PL310_ERRATA_588369=y
+CONFIG_ARM_ERRATA_754322=y
+CONFIG_PCI=y
+CONFIG_PCI_RCAR_GEN2=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
+CONFIG_SMP=y
+CONFIG_SCHED_MC=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
+CONFIG_NR_CPUS=8
+CONFIG_AEABI=y
+CONFIG_HIGHMEM=y
+CONFIG_CMA=y
+CONFIG_ZBOOT_ROM_TEXT=0x0
+CONFIG_ZBOOT_ROM_BSS=0x0
+CONFIG_ARM_APPENDED_DTB=y
+CONFIG_KEXEC=y
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_STAT_DETAILS=y
+CONFIG_CPU_FREQ_GOV_POWERSAVE=y
+CONFIG_CPU_FREQ_GOV_USERSPACE=y
+CONFIG_CPU_FREQ_GOV_ONDEMAND=y
+CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
+CONFIG_CPUFREQ_DT=y
+CONFIG_VFP=y
+CONFIG_NEON=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_CAN=y
+CONFIG_CAN_RCAR=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_DMA_CMA=y
+CONFIG_CMA_SIZE_MBYTES=64
+CONFIG_SIMPLE_PM_BUS=y
+CONFIG_MTD=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_SPI_NOR=y
+CONFIG_EEPROM_AT24=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_ATA=y
+CONFIG_SATA_RCAR=y
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_SH_ETH=y
+CONFIG_RAVB=y
+# CONFIG_NET_VENDOR_SEEQ is not set
+CONFIG_SMSC911X=y
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+CONFIG_SMSC_PHY=y
+CONFIG_MICREL_PHY=y
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+CONFIG_INPUT_EVDEV=y
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_INPUT_MOUSE is not set
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_ST1232=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_ADXL34X=y
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EM=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_SERIAL_SH_SCI_NR_UARTS=20
+CONFIG_SERIAL_SH_SCI_CONSOLE=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_GPIO=y
+CONFIG_I2C_RIIC=y
+CONFIG_I2C_SH_MOBILE=y
+CONFIG_I2C_RCAR=y
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
+CONFIG_SPI_SH_MSIOF=y
+CONFIG_SPI_SH_HSPI=y
+CONFIG_GPIO_EM=y
+CONFIG_GPIO_RCAR=y
+CONFIG_GPIO_PCF857X=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_RMOBILE=y
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_CPU_THERMAL=y
+CONFIG_RCAR_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=y
+CONFIG_RENESAS_WDT=y
+CONFIG_MFD_AS3711=y
+CONFIG_MFD_DA9063=y
+CONFIG_REGULATOR_FIXED_VOLTAGE=y
+CONFIG_REGULATOR_AS3711=y
+CONFIG_REGULATOR_DA9210=y
+CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX8973=y
+CONFIG_MEDIA_SUPPORT=y
+CONFIG_MEDIA_CAMERA_SUPPORT=y
+CONFIG_MEDIA_CONTROLLER=y
+CONFIG_VIDEO_V4L2_SUBDEV_API=y
+CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_SOC_CAMERA=y
+CONFIG_SOC_CAMERA_PLATFORM=y
+CONFIG_VIDEO_RCAR_VIN=y
+CONFIG_V4L_MEM2MEM_DRIVERS=y
+CONFIG_VIDEO_RENESAS_VSP1=y
+# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
+CONFIG_VIDEO_ADV7180=y
+CONFIG_VIDEO_ML86V7667=y
+CONFIG_DRM=y
+CONFIG_DRM_I2C_ADV7511=y
+CONFIG_DRM_RCAR_DU=y
+CONFIG_DRM_RCAR_HDMI=y
+CONFIG_DRM_RCAR_LVDS=y
+CONFIG_FB_SH_MOBILE_LCDC=y
+CONFIG_FB_SH_MOBILE_MERAM=y
+# CONFIG_LCD_CLASS_DEVICE is not set
+# CONFIG_BACKLIGHT_GENERIC is not set
+CONFIG_BACKLIGHT_PWM=y
+CONFIG_BACKLIGHT_AS3711=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_SH4_FSI=y
+CONFIG_SND_SOC_RCAR=y
+CONFIG_SND_SOC_RSRC_CARD=y
+CONFIG_SND_SOC_AK4642=y
+CONFIG_SND_SOC_SGTL5000=y
+CONFIG_SND_SOC_WM8978=y
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_RCAR=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_R8A66597_HCD=y
+CONFIG_USB_RENESAS_USBHS=y
+CONFIG_USB_RCAR_PHY=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_RENESAS_USBHS_UDC=y
+CONFIG_USB_ETH=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHI=y
+CONFIG_MMC_SH_MMCIF=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_RS5C372=y
+CONFIG_RTC_DRV_BQ32K=y
+CONFIG_RTC_DRV_S35390A=y
+CONFIG_RTC_DRV_RX8581=y
+CONFIG_DMADEVICES=y
+CONFIG_SH_DMAE=y
+CONFIG_RCAR_DMAC=y
+CONFIG_RENESAS_USB_DMAC=y
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_AK8975=y
+CONFIG_PWM=y
+CONFIG_PWM_RCAR=y
+CONFIG_PWM_RENESAS_TPU=y
+CONFIG_GENERIC_PHY=y
+CONFIG_PHY_RCAR_GEN2=y
+# CONFIG_DNOTIFY is not set
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_TMPFS=y
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_ROOT_NFS=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+# CONFIG_ARM_UNWIND is not set
diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
new file mode 100644
index 0000000..14bf8b0
--- /dev/null
+++ b/wic/iwg20m.wks
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba corp., 2019
+#
+# Authors:
+#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# [Note] u-boot runs from an SPI memory device
+
+# SDCard Boot partition (copies files in IMAGE_BOOT_FILES: zImage and device tree)
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label boot --align 1 --size 32M --extra-space 0
+
+# Rootfs partition
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --size 2G --active
-- 
2.17.1
