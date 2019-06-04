From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Tue, 4 Jun 2019 07:05:01 +0000
Subject: [cip-dev] [isar-cip-core] iwg20m: temporary patch for review
In-Reply-To: <20190604061412.8886-1-daniel.sangorrin@toshiba.co.jp>
References: <20190604061412.8886-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <TYAPR01MB2285186B782CB310BB133B42B7150@TYAPR01MB2285.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Daniel,

Thank you for your patch.

> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> project.org> On Behalf Of Daniel Sangorrin
> Sent: 04 June 2019 07:14
> 
> Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> ---
>  board-iwg20m.yml                            |  16 ++
>  conf/machine/iwg20m.conf                    |  19 ++
>  recipes-kernel/linux/files/iwg20m_defconfig | 230
> ++++++++++++++++++++
>  wic/iwg20m.wks                              |  20 ++
>  4 files changed, 285 insertions(+)
>  create mode 100644 board-iwg20m.yml
>  create mode 100644 conf/machine/iwg20m.conf
>  create mode 100644 recipes-kernel/linux/files/iwg20m_defconfig
>  create mode 100644 wic/iwg20m.wks
> 

<snip>

> diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
> new file mode 100644
> index 0000000..3bc0c9a
> --- /dev/null
> +++ b/conf/machine/iwg20m.conf
> @@ -0,0 +1,19 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba corp. 2019
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +DISTRO_ARCH = "armhf"
> +
> +# see wic/iwg20m.wks
> +IMAGE_TYPE = "wic-img"
> +
> +# sets serial login getty
> +MACHINE_SERIAL = "ttySC0"
> +BAUDRATE_TTY = "115200"
> +
> +# Boot partition files
> +DTB_FILE = "r8a7743-iwg20d-q7.dtb"

I wonder if it is better to use r8a7743-iwg20d-q7-dbcm-ca.dtb instead. This does the same as r8a7743-iwg20d-q7.dtb but also enables the add-on board that comes with most iwg20d kits.
The add-on board adds HDMI output, CAN bus and various SCIF interfaces.

<snip>

> diff --git a/wic/iwg20m.wks b/wic/iwg20m.wks
> new file mode 100644
> index 0000000..8e43229
> --- /dev/null
> +++ b/wic/iwg20m.wks
> @@ -0,0 +1,20 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba corp., 2019
> +#
> +# Authors:
> +#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# [Note] u-boot is in an SPI flash memory and needs a JTAG debugger to re-
> flash

It is also possible to write to the SPI from Linux, but having JTAG as backup is recommended as there is no backup SPI if the write goes wrong.

Kind regards, Chris

> +
> +# SDCard Boot partition (copies files in IMAGE_BOOT_FILES)
> +part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --label
> boot --align 1 --size 32M --extra-space 0
> +
> +# Rootfs partition
> +part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align
> 1024 --size 2G --active
> +
> +bootloader --append "rootwait console=ttySC0,115200"
> --
> 2.17.1
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
