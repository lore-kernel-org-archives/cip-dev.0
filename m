From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Wed, 6 Nov 2019 15:38:05 +0000
Subject: [cip-dev] [isar-cip-core PATCH 3/4] hihope-rzg2m: Add board
 support
In-Reply-To: <20191106124439.10532-4-Quirin.Gylstorff@siemens.com>
References: <20191106124439.10532-1-Quirin.Gylstorff@siemens.com>
	<20191106124439.10532-4-Quirin.Gylstorff@siemens.com>
Message-ID: <TYAPR01MB2285255EF4A6521577D5F789B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Quirin,

Thank you for the patch.

> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> project.org> On Behalf Of Q. Gylstorff
> Sent: 06 November 2019 12:45
> 
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> The hihope-rzg2m is a ARM64 reference platform for the CIP project.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  board-rzg2m.yml                               |  16 +
>  conf/machine/hihope-rzg2m.conf                |  17 +
>  .../linux/files/hihope-rzg2m_defconfig        | 330 ++++++++++++++++++
>  wic/hihope-rzg2m.wks                          |  15 +
>  4 files changed, 378 insertions(+)
>  create mode 100644 board-rzg2m.yml
>  create mode 100644 conf/machine/hihope-rzg2m.conf
>  create mode 100644 recipes-kernel/linux/files/hihope-rzg2m_defconfig
>  create mode 100644 wic/hihope-rzg2m.wks
> 
> diff --git a/board-rzg2m.yml b/board-rzg2m.yml
> new file mode 100644
> index 0000000..f68c7b8
> --- /dev/null
> +++ b/board-rzg2m.yml
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 8
> +
> +machine: hihope-rzg2m
> +target: cip-core-image
> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
> rzg2m.conf
> new file mode 100644
> index 0000000..5c456c7
> --- /dev/null
> +++ b/conf/machine/hihope-rzg2m.conf
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +
> +IMAGE_TYPE ?= "wic-img"
> +
> +DTB_FILE = "r8a774a1-hihope-rzg2m.dtb"

Should be r8a774a1-hihope-rzg2m-ex.dtb. The 'ex' is the sub-board that adds Ethernet/PCIe/CAN etc.

> +IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
> diff --git a/recipes-kernel/linux/files/hihope-rzg2m_defconfig b/recipes-
> kernel/linux/files/hihope-rzg2m_defconfig
> new file mode 100644
> index 0000000..f35793c
> --- /dev/null
> +++ b/recipes-kernel/linux/files/hihope-rzg2m_defconfig

Just to check, where did you copy this config from?

Is there a way that the configuration could be taken directly from cip-kernel-config[0] rather than creating a copy that will need separate maintenance here?
I ask because there is currently a merge request open[1] that will update renesas_defconfig.

[0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.19.y-cip/arm64/renesas_defconfig
[1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/merge_requests/15

Kind regards, Chris


> @@ -0,0 +1,330 @@
> +CONFIG_SYSVIPC=y
> +CONFIG_POSIX_MQUEUE=y
> +CONFIG_AUDIT=y
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_PREEMPT=y
> +CONFIG_IRQ_TIME_ACCOUNTING=y
> +CONFIG_BSD_PROCESS_ACCT=y
> +CONFIG_BSD_PROCESS_ACCT_V3=y
> +CONFIG_TASKSTATS=y
> +CONFIG_TASK_DELAY_ACCT=y
> +CONFIG_TASK_XACCT=y
> +CONFIG_TASK_IO_ACCOUNTING=y
> +CONFIG_IKCONFIG=y
> +CONFIG_IKCONFIG_PROC=y
> +CONFIG_MEMCG=y
> +CONFIG_MEMCG_SWAP=y
> +CONFIG_BLK_CGROUP=y
> +CONFIG_CGROUP_PIDS=y
> +CONFIG_CGROUP_HUGETLB=y
> +CONFIG_CPUSETS=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_CGROUP_PERF=y
> +CONFIG_USER_NS=y
> +CONFIG_SCHED_AUTOGROUP=y
> +CONFIG_BLK_DEV_INITRD=y
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_PROFILING=y
> +CONFIG_ARCH_RENESAS=y
> +CONFIG_ARCH_R8A774A1=y
> +CONFIG_ARCH_R8A774C0=y
> +CONFIG_PCI=y
> +CONFIG_PCIEPORTBUS=y
> +CONFIG_HOTPLUG_PCI_PCIE=y
> +CONFIG_PCI_IOV=y
> +CONFIG_HOTPLUG_PCI=y
> +CONFIG_PCIE_RCAR=y
> +CONFIG_PCI_HOST_GENERIC=y
> +# CONFIG_CAVIUM_ERRATUM_22375 is not set
> +# CONFIG_CAVIUM_ERRATUM_23154 is not set
> +# CONFIG_CAVIUM_ERRATUM_27456 is not set
> +# CONFIG_CAVIUM_ERRATUM_30115 is not set
> +# CONFIG_QCOM_FALKOR_ERRATUM_1003 is not set
> +# CONFIG_QCOM_FALKOR_ERRATUM_1009 is not set
> +# CONFIG_QCOM_QDF2400_ERRATUM_0065 is not set
> +# CONFIG_SOCIONEXT_SYNQUACER_PREITS is not set
> +# CONFIG_HISILICON_ERRATUM_161600802 is not set
> +CONFIG_ARM64_VA_BITS_48=y
> +CONFIG_SCHED_MC=y
> +CONFIG_NR_CPUS=8
> +CONFIG_SECCOMP=y
> +CONFIG_KEXEC=y
> +CONFIG_CRASH_DUMP=y
> +CONFIG_XEN=y
> +# CONFIG_ARM64_LSE_ATOMICS is not set
> +# CONFIG_ARM64_RAS_EXTN is not set
> +CONFIG_COMPAT=y
> +CONFIG_HIBERNATION=y
> +CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> +CONFIG_CPU_IDLE=y
> +CONFIG_ARM_CPUIDLE=y
> +CONFIG_CPU_FREQ=y
> +CONFIG_CPUFREQ_DT=y
> +# CONFIG_DMIID is not set
> +CONFIG_VIRTUALIZATION=y
> +CONFIG_KVM=y
> +CONFIG_ARM64_CRYPTO=y
> +CONFIG_CRYPTO_SHA1_ARM64_CE=y
> +CONFIG_CRYPTO_SHA2_ARM64_CE=y
> +CONFIG_CRYPTO_GHASH_ARM64_CE=y
> +CONFIG_CRYPTO_AES_ARM64_CE_CCM=y
> +CONFIG_CRYPTO_AES_ARM64_CE_BLK=y
> +CONFIG_JUMP_LABEL=y
> +CONFIG_BLK_DEV_INTEGRITY=y
> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +CONFIG_KSM=y
> +CONFIG_TRANSPARENT_HUGEPAGE=y
> +CONFIG_CMA=y
> +CONFIG_NET=y
> +CONFIG_PACKET=y
> +CONFIG_UNIX=y
> +CONFIG_INET=y
> +CONFIG_IP_MULTICAST=y
> +CONFIG_IP_PNP=y
> +CONFIG_IP_PNP_DHCP=y
> +CONFIG_IP_PNP_BOOTP=y
> +# CONFIG_IPV6 is not set
> +CONFIG_NETFILTER=y
> +CONFIG_CAN=y
> +CONFIG_CAN_RCAR=y
> +CONFIG_CAN_RCAR_CANFD=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_DMA_CMA=y
> +CONFIG_CMA_SIZE_MBYTES=128
> +CONFIG_CMA_ALIGNMENT=9
> +CONFIG_MTD=y
> +CONFIG_MTD_BLOCK=y
> +CONFIG_MTD_SPI_NOR=y
> +CONFIG_BLK_DEV_LOOP=y
> +CONFIG_VIRTIO_BLK=y
> +CONFIG_SRAM=y
> +# CONFIG_SCSI_PROC_FS is not set
> +CONFIG_BLK_DEV_SD=y
> +CONFIG_SCSI_SAS_LIBSAS=y
> +CONFIG_SCSI_SAS_ATA=y
> +CONFIG_ATA=y
> +# CONFIG_SATA_PMP is not set
> +CONFIG_SATA_RCAR=y
> +CONFIG_NETDEVICES=y
> +CONFIG_TUN=y
> +CONFIG_VIRTIO_NET=y
> +# CONFIG_CAVIUM_PTP is not set
> +CONFIG_RAVB=y
> +CONFIG_MDIO_BUS_MUX_MMIOREG=y
> +CONFIG_MICREL_PHY=y
> +CONFIG_REALTEK_PHY=y
> +# CONFIG_WLAN is not set
> +CONFIG_INPUT_MATRIXKMAP=y
> +CONFIG_INPUT_EVDEV=y
> +# CONFIG_KEYBOARD_ATKBD is not set
> +CONFIG_KEYBOARD_GPIO=y
> +# CONFIG_MOUSE_PS2 is not set
> +CONFIG_INPUT_MISC=y
> +# CONFIG_SERIO is not set
> +CONFIG_SERIAL_SH_SCI=y
> +CONFIG_VIRTIO_CONSOLE=y
> +# CONFIG_HW_RANDOM is not set
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_MUX_PCA954x=y
> +CONFIG_I2C_DESIGNWARE_PLATFORM=y
> +CONFIG_I2C_SH_MOBILE=y
> +CONFIG_I2C_RCAR=y
> +CONFIG_SPI=y
> +CONFIG_SPI_SH_MSIOF=y
> +CONFIG_SPI_SPIDEV=y
> +CONFIG_SPMI=y
> +CONFIG_PINCTRL_SINGLE=y
> +CONFIG_GPIO_GENERIC_PLATFORM=y
> +CONFIG_GPIO_RCAR=y
> +CONFIG_GPIO_PCA953X=y
> +CONFIG_GPIO_BD9571MWV=y
> +CONFIG_THERMAL=y
> +CONFIG_THERMAL_GOV_POWER_ALLOCATOR=y
> +CONFIG_CPU_THERMAL=y
> +CONFIG_THERMAL_EMULATION=y
> +CONFIG_RCAR_THERMAL=y
> +CONFIG_RCAR_GEN3_THERMAL=y
> +CONFIG_WATCHDOG=y
> +CONFIG_RENESAS_WDT=y
> +CONFIG_MFD_BD9571MWV=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_BD9571MWV=y
> +CONFIG_REGULATOR_GPIO=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_SDR_SUPPORT=y
> +CONFIG_MEDIA_CONTROLLER=y
> +CONFIG_VIDEO_V4L2_SUBDEV_API=y
> +CONFIG_V4L_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_RCAR_CSI2=y
> +CONFIG_VIDEO_RCAR_VIN=y
> +CONFIG_V4L_MEM2MEM_DRIVERS=y
> +CONFIG_VIDEO_RENESAS_FDP1=y
> +CONFIG_VIDEO_RENESAS_FCP=y
> +CONFIG_VIDEO_RENESAS_VSP1=y
> +CONFIG_SDR_PLATFORM_DRIVERS=y
> +CONFIG_VIDEO_RCAR_DRIF=y
> +# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
> +CONFIG_VIDEO_ADV748X=y
> +# CONFIG_MEDIA_TUNER_SIMPLE is not set
> +# CONFIG_MEDIA_TUNER_TDA18250 is not set
> +# CONFIG_MEDIA_TUNER_TDA8290 is not set
> +# CONFIG_MEDIA_TUNER_TDA827X is not set
> +# CONFIG_MEDIA_TUNER_TDA18271 is not set
> +# CONFIG_MEDIA_TUNER_TDA9887 is not set
> +# CONFIG_MEDIA_TUNER_TEA5761 is not set
> +# CONFIG_MEDIA_TUNER_TEA5767 is not set
> +# CONFIG_MEDIA_TUNER_MSI001 is not set
> +# CONFIG_MEDIA_TUNER_MT20XX is not set
> +# CONFIG_MEDIA_TUNER_MT2060 is not set
> +# CONFIG_MEDIA_TUNER_MT2063 is not set
> +# CONFIG_MEDIA_TUNER_MT2266 is not set
> +# CONFIG_MEDIA_TUNER_MT2131 is not set
> +# CONFIG_MEDIA_TUNER_QT1010 is not set
> +# CONFIG_MEDIA_TUNER_XC2028 is not set
> +# CONFIG_MEDIA_TUNER_XC5000 is not set
> +# CONFIG_MEDIA_TUNER_XC4000 is not set
> +# CONFIG_MEDIA_TUNER_MXL5005S is not set
> +# CONFIG_MEDIA_TUNER_MXL5007T is not set
> +# CONFIG_MEDIA_TUNER_MC44S803 is not set
> +# CONFIG_MEDIA_TUNER_MAX2165 is not set
> +# CONFIG_MEDIA_TUNER_TDA18218 is not set
> +# CONFIG_MEDIA_TUNER_FC0011 is not set
> +# CONFIG_MEDIA_TUNER_FC0012 is not set
> +# CONFIG_MEDIA_TUNER_FC0013 is not set
> +# CONFIG_MEDIA_TUNER_TDA18212 is not set
> +# CONFIG_MEDIA_TUNER_E4000 is not set
> +# CONFIG_MEDIA_TUNER_FC2580 is not set
> +# CONFIG_MEDIA_TUNER_M88RS6000T is not set
> +# CONFIG_MEDIA_TUNER_TUA9001 is not set
> +# CONFIG_MEDIA_TUNER_SI2157 is not set
> +# CONFIG_MEDIA_TUNER_IT913X is not set
> +# CONFIG_MEDIA_TUNER_R820T is not set
> +# CONFIG_MEDIA_TUNER_MXL301RF is not set
> +# CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
> +# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
> +CONFIG_DRM=y
> +CONFIG_DRM_I2C_NXP_TDA998X=y
> +CONFIG_DRM_RCAR_DU=y
> +CONFIG_DRM_RCAR_DW_HDMI=y
> +CONFIG_DRM_RCAR_LVDS=y
> +CONFIG_DRM_DUMB_VGA_DAC=y
> +CONFIG_DRM_THINE_THC63LVD1024=y
> +CONFIG_DRM_DW_HDMI_AHB_AUDIO=y
> +CONFIG_DRM_DW_HDMI_I2S_AUDIO=y
> +CONFIG_DRM_DW_HDMI_CEC=y
> +CONFIG_FB_MODE_HELPERS=y
> +CONFIG_BACKLIGHT_LCD_SUPPORT=y
> +# CONFIG_LCD_CLASS_DEVICE is not set
> +# CONFIG_BACKLIGHT_GENERIC is not set
> +CONFIG_BACKLIGHT_PWM=y
> +CONFIG_LOGO=y
> +# CONFIG_LOGO_LINUX_MONO is not set
> +# CONFIG_LOGO_LINUX_VGA16 is not set
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +# CONFIG_SND_SPI is not set
> +# CONFIG_SND_USB is not set
> +CONFIG_SND_SOC=y
> +CONFIG_SND_SOC_RCAR=y
> +CONFIG_SND_SOC_AK4613=y
> +CONFIG_SND_SOC_PCM3168A_I2C=y
> +CONFIG_SND_SIMPLE_CARD=y
> +CONFIG_SND_SIMPLE_SCU_CARD=y
> +CONFIG_SND_AUDIO_GRAPH_CARD=y
> +CONFIG_USB=y
> +CONFIG_USB_OTG=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_PLATFORM=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_ROOT_HUB_TT=y
> +CONFIG_USB_EHCI_HCD_PLATFORM=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_HCD_PLATFORM=y
> +CONFIG_USB_RENESAS_USBHS_HCD=y
> +CONFIG_USB_RENESAS_USBHS=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_HSIC_USB3503=y
> +CONFIG_NOP_USB_XCEIV=y
> +CONFIG_USB_ULPI=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_RENESAS_USBHS_UDC=y
> +CONFIG_USB_RENESAS_USB3=y
> +CONFIG_USB_SNP_UDC_PLAT=y
> +CONFIG_USB_BDC_UDC=y
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHI=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_PWM=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
> +CONFIG_LEDS_TRIGGER_CPU=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
> +CONFIG_EDAC=y
> +CONFIG_RTC_CLASS=y
> +CONFIG_RTC_DRV_RX8581=y
> +CONFIG_DMADEVICES=y
> +CONFIG_RCAR_DMAC=y
> +CONFIG_RENESAS_USB_DMAC=y
> +CONFIG_VFIO=y
> +CONFIG_VFIO_PCI=y
> +CONFIG_VIRTIO_PCI=y
> +CONFIG_VIRTIO_BALLOON=y
> +CONFIG_VIRTIO_MMIO=y
> +CONFIG_CHROME_PLATFORMS=y
> +CONFIG_COMMON_CLK_CS2000_CP=y
> +# CONFIG_COMMON_CLK_XGENE is not set
> +CONFIG_COMMON_CLK_VC5=y
> +CONFIG_CLK_RCAR_USB2_CLOCK_SEL=y
> +CONFIG_HWSPINLOCK=y
> +# CONFIG_FSL_ERRATUM_A008585 is not set
> +# CONFIG_HISILICON_ERRATUM_161010101 is not set
> +# CONFIG_ARM64_ERRATUM_858921 is not set
> +CONFIG_MAILBOX=y
> +CONFIG_IOMMU_IO_PGTABLE_LPAE=y
> +CONFIG_EXTCON_USB_GPIO=y
> +CONFIG_IIO=y
> +CONFIG_MAX9611=y
> +CONFIG_PWM=y
> +CONFIG_PWM_RCAR=y
> +CONFIG_RESET_CONTROLLER=y
> +CONFIG_PHY_RCAR_GEN3_PCIE=y
> +CONFIG_PHY_RCAR_GEN3_USB2=y
> +CONFIG_PHY_RCAR_GEN3_USB3=y
> +CONFIG_TEE=y
> +CONFIG_OPTEE=y
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_FANOTIFY=y
> +CONFIG_QUOTA=y
> +CONFIG_AUTOFS4_FS=y
> +CONFIG_VFAT_FS=y
> +CONFIG_TMPFS=y
> +CONFIG_HUGETLBFS=y
> +CONFIG_CONFIGFS_FS=y
> +CONFIG_SQUASHFS=y
> +CONFIG_NFS_FS=y
> +CONFIG_NFS_V4=y
> +CONFIG_NFS_V4_1=y
> +CONFIG_NFS_V4_2=y
> +CONFIG_ROOT_NFS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_CRYPTO_ANSI_CPRNG=y
> +# CONFIG_CRYPTO_DEV_VIRTIO is not set
> +CONFIG_CRYPTO_DEV_CCREE=y
> +CONFIG_PRINTK_TIME=y
> +CONFIG_MAGIC_SYSRQ=y
> +CONFIG_DEBUG_KERNEL=y
> +# CONFIG_SCHED_DEBUG is not set
> +# CONFIG_DEBUG_PREEMPT is not set
> +CONFIG_PROVE_LOCKING=y
> +# CONFIG_FTRACE is not set
> diff --git a/wic/hihope-rzg2m.wks b/wic/hihope-rzg2m.wks
> new file mode 100644
> index 0000000..c0a9f77
> --- /dev/null
> +++ b/wic/hihope-rzg2m.wks
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2019
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label
> boot --align 1 --size 32M --extra-space 0
> +
> +# Rootfs partition
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align 1024 --
> size 2G --active
> --
> 2.20.1
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
