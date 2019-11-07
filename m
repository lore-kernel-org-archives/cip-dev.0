From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Thu, 7 Nov 2019 02:29:37 +0000
Subject: [cip-dev] [isar-cip-core PATCH 3/4] hihope-rzg2m: Add board
 support
In-Reply-To: <66a2849e-bbf8-7e67-0da3-490b052f18cb@siemens.com>
References: <20191106124439.10532-1-Quirin.Gylstorff@siemens.com>
	<20191106124439.10532-4-Quirin.Gylstorff@siemens.com>
	<TYAPR01MB2285255EF4A6521577D5F789B7790@TYAPR01MB2285.jpnprd01.prod.outlook.com>
	<66a2849e-bbf8-7e67-0da3-490b052f18cb@siemens.com>
Message-ID: <TYAPR01MB4286445DBFE0BE6FD3D9CC49E1780@TYAPR01MB4286.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Quirin,

> I will look into it using the cip-kernel-config instead of using copies
> in isar.

Are you planning to "fetch" required config(s) for each target from cip-kernel-config?
or, keep copies of the configs in isar-cip-core then synchronize them at the specific point?

Deby also has its own kernel configs (arm64 defconfig + Tiny hihope-rzg2m.config)
for HiHope RZG2M:
https://gitlab.com/cip-project/cip-core/deby/blob/cip-core-buster/meta-hihope-rzg2m/recipes-kernel/linux/linux-base_git.bbappend
but they also should be replaced by the common kernel configs in CIP.
As the first step, I would provide configs by the same way as isar-cip-core.

Best regards,
Kazu


> On 11/6/19 4:38 PM, Chris Paterson wrote:
> > Hello Quirin,
> >
> > Thank you for the patch.
> >
> >> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-
> >> project.org> On Behalf Of Q. Gylstorff
> >> Sent: 06 November 2019 12:45
> >>
> >> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >>
> >> The hihope-rzg2m is a ARM64 reference platform for the CIP project.
> >>
> >> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >> ---
> >>   board-rzg2m.yml                               |  16 +
> >>   conf/machine/hihope-rzg2m.conf                |  17 +
> >>   .../linux/files/hihope-rzg2m_defconfig        | 330 ++++++++++++++++++
> >>   wic/hihope-rzg2m.wks                          |  15 +
> >>   4 files changed, 378 insertions(+)
> >>   create mode 100644 board-rzg2m.yml
> >>   create mode 100644 conf/machine/hihope-rzg2m.conf
> >>   create mode 100644 recipes-kernel/linux/files/hihope-rzg2m_defconfig
> >>   create mode 100644 wic/hihope-rzg2m.wks
> >>
> >> diff --git a/board-rzg2m.yml b/board-rzg2m.yml
> >> new file mode 100644
> >> index 0000000..f68c7b8
> >> --- /dev/null
> >> +++ b/board-rzg2m.yml
> >> @@ -0,0 +1,16 @@
> >> +#
> >> +# CIP Core, generic profile
> >> +#
> >> +# Copyright (c) Siemens AG, 2019
> >> +#
> >> +# Authors:
> >> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >> +#
> >> +# SPDX-License-Identifier: MIT
> >> +#
> >> +
> >> +header:
> >> +  version: 8
> >> +
> >> +machine: hihope-rzg2m
> >> +target: cip-core-image
> >> diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-
> >> rzg2m.conf
> >> new file mode 100644
> >> index 0000000..5c456c7
> >> --- /dev/null
> >> +++ b/conf/machine/hihope-rzg2m.conf
> >> @@ -0,0 +1,17 @@
> >> +#
> >> +# CIP Core, generic profile
> >> +#
> >> +# Copyright (c) Siemens AG, 2019
> >> +#
> >> +# Authors:
> >> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> >> +#
> >> +# SPDX-License-Identifier: MIT
> >> +#
> >> +
> >> +DISTRO_ARCH = "arm64"
> >> +
> >> +IMAGE_TYPE ?= "wic-img"
> >> +
> >> +DTB_FILE = "r8a774a1-hihope-rzg2m.dtb"
> >
> > Should be r8a774a1-hihope-rzg2m-ex.dtb. The 'ex' is the sub-board that adds Ethernet/PCIe/CAN etc.
> 
> OK, I will change both occurences and post a version 2.
> >
> >> +IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
> >> diff --git a/recipes-kernel/linux/files/hihope-rzg2m_defconfig b/recipes-
> >> kernel/linux/files/hihope-rzg2m_defconfig
> >> new file mode 100644
> >> index 0000000..f35793c
> >> --- /dev/null
> >> +++ b/recipes-kernel/linux/files/hihope-rzg2m_defconfig
> >
> > Just to check, where did you copy this config from?
> 
> I used [0] as base.
> >
> > Is there a way that the configuration could be taken directly from cip-kernel-config[0] rather than creating a copy
> that will need separate maintenance here?
> > I ask because there is currently a merge request open[1] that will update renesas_defconfig.
> >
> > [0] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/blob/master/4.19.y-cip/arm64/renesas_defconfig
> > [1] https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/merge_requests/15
> >
> I will look into it using the cip-kernel-config instead of using copies
> in isar.
> 
> 
> Quirin
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
