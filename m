Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514ECCE7A97
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:05:38 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14177.1763111131678074521
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:05:31 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=nrnlztpI;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.193.24, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9SnhYc9vzC0NYw5B/IOeshMFg3SD6LyVRuvofyL2CuIOhNtsCTqvdkLmQe2qSlHMUL7BwpzgRE+JIiScK6581goo37qP+u45Q83obhxwp+jpm8u9Bf6AiSx3w4jlf43MnTykV/oiBsAtRB4RkV70fp55AOHeYoLw4y8w7Ysz04T6xkvRBSs3Ev+qU43fZuo/n6YZT+UHCLbQ5Q04mCNBa8XW7/ED1B7Hw7Ctv2xjL9SttNJ95LJylBZsPDjKNaQJCxwIPgScwpVcwKqIiuy1SJPcUfyJZVY0Usdwaha+qVyktF4otKpXQ/UoXNFAVoBwWNz/isfQv7NCXw3aoWJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAlD/B5sPecqFaeycRBdcBEJ0i8VurjVjYOc1QbWskQ=;
 b=nM/IBI7zp/2vdCAaPJ39hP05xJNl5Xuwy6+jam4jXsGBRKKfKMOGIcKxxNMZrVmF2fYm/gSmAc1pUJBfyeOFz0dbA5Y1i4JkU+yuejgiqoSUYyOWAtpMsXiq8C2SQ3HdbdzNkYmYlOja+s7POFcDfWOQIsPOT115cCUrmuFGtb0BSn3+HUwGa/pqIdZ3qdB7ANk/YZoEEfKzlmIXzmxAiQfYIfcxxGAmgyKkSloEpsyhop1CsUp3IgiKPaKGBKrBzijTnebtUOnjsv748Y861RypDzJs2D/6kczr8/sEWBK1Zw+O2wghknyEpm4I1O4l9RU6JL0l2NRPH3kSaBQ+xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAlD/B5sPecqFaeycRBdcBEJ0i8VurjVjYOc1QbWskQ=;
 b=nrnlztpI++2tu/1MpV1W9+8QgXebF8JGLbh7ZZ/swC6DCdTvG/QR7wBDrUYlsSfnXXOW0R/pngZaNUy5N07WoLfiaJeXaS29KIQwgbynB2Is8e/WWt1ODcpoIDLIo+n/KhSBUk+ax5KCzJH95rwMfk2yI0I2AYadLYi6n6h+07g=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by SN7PR10MB6408.namprd10.prod.outlook.com (2603:10b6:806:268::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:05:28 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:334:cafe::4e) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Fri,
 14 Nov 2025 09:05:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:05:27 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:18 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:05:18 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE95E1M1718804;
	Fri, 14 Nov 2025 03:05:17 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v5 1/4] Add support for TI AM62Px SK platform
Date: Fri, 14 Nov 2025 14:35:06 +0530
Message-ID: <20251114090509.2935933-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114090509.2935933-1-s-adivi@ti.com>
References: <20251114090509.2935933-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SN7PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 44424e10-41c1-415f-b62f-08de235cf44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?B72nblgpqC0X1mXDqYE2SEiZPptIu/+2hdKoDGSqH00jdFW6Or9UvbaLvfWx?=
 =?us-ascii?Q?PjTp7/E8A8Rhx6QkCNL/SaEdldUy5vnm0uywQiiJDUsJfQ1yTerTvkG9baND?=
 =?us-ascii?Q?XTpkUQ98DlHChR9Jgf3vh2SQu+gDymxE3w46fjl58sHq9RJ8S33Hjo0Sfp3d?=
 =?us-ascii?Q?HMMAJtDYnakk0P0eouVdCqLStUpqEuq+UtxpYf5oVBPpxfc0/3ruQgR4Lyta?=
 =?us-ascii?Q?rYdSnBiUoZ1o9KHAhT/KYCvJqYmtvFlH1Xk89CQNR/82SHqn5pL0APxSnbod?=
 =?us-ascii?Q?VC5K+DUTIseIMuiq9FUjFGdXYgrtLvrkKQRzeHBcojzNrJPgxRzB0fpUWREd?=
 =?us-ascii?Q?xPED7BsJEcxd825Hfpr+rGKd2nTxgsvlQtEx23FTNFL7NjRXK4F5PBJ5gY9w?=
 =?us-ascii?Q?JdldA8ikdoaVylEVDhN1fwjNWYb3MTEQ4htBW+rNaYTU6GyQPkPU1HtIaCKn?=
 =?us-ascii?Q?bMeea81djp0yeOqiPK8vZuj6NY+dNB345Qnf/I6QpJxLblK4M568bkdE7EB+?=
 =?us-ascii?Q?wh2THC6X7xpLUiz20SAyOEHPKg8FVuIt4lbrF60MJ/hq8MvHaML31thtzHZv?=
 =?us-ascii?Q?MMI2AWWVrqI9L4H+5/2rQT5i+Cif/Z+P+9PESsgtkoNSUXxSYGZDL1/wNZWP?=
 =?us-ascii?Q?kf+m6GarOLeZkLUAVg9jk69jBfaTVgHjWZFg3JR11yoa0wT1Pg7GOH+ga07Z?=
 =?us-ascii?Q?DmogqNncCX7yYbP2KDbl9FtWPSGpGPjWJ/FggtuQrvt0R+Jb3ODstpwX2HZm?=
 =?us-ascii?Q?RhAC9sBg64FREHdZTQ0l2qI/sNMHcEsnWNcGf+s6VYqwXg0fQyVRsRENfUYJ?=
 =?us-ascii?Q?ISivvQTnokEF3azZtPfu2HQyohcFI1myO02ZOVK8JlxHhem88f6Kf2Q4m63K?=
 =?us-ascii?Q?z7qRbwiI7WpFkbl3/orAy37WggeTFAR5/F+v3IySDSWMoX76bfpCjpRofI99?=
 =?us-ascii?Q?hzk2ZEZ8p14Qvuu6cOlCpb7CRONFWYxPpQS9AZYdnK9i11li9UMqutCop4vc?=
 =?us-ascii?Q?WTWsy2FcqxS0XUTUfdaipqO/1nz+Mn1OA3O3msjO509+0byOqRQitYLf6/6O?=
 =?us-ascii?Q?61UZsNHNr1s+/3hB5rywWRqri3b7N3+mDzuTCvjTqwcAVu03S8egXNCtLqM+?=
 =?us-ascii?Q?G8UiXID3Tfdpm6C3/+EI5yUsp64F06ZKHoORJjd5kak+JGEea2zvEPXMazRr?=
 =?us-ascii?Q?w1QFATh074Xd/fd3S2G4345aDnB4xGVDBBBiSztnBojFJPLw0bg2FUEwqBgx?=
 =?us-ascii?Q?xuDchEQdlTJLdD9oyNxCfpQqZC9PcFLl+X0arC4LesdCUOxSY+EP2DaKRKY1?=
 =?us-ascii?Q?eeosNjsWW4tfJvUiEtSQTPSwB6/SaqTidkMbWeYnwhi5E5IqBW9+vq7H91kP?=
 =?us-ascii?Q?NKZtt+eeFF0ktUBHMEh7wM0L24Zl/uT67o8gh52TnIGIeqQ9gW3H01z1Qm+9?=
 =?us-ascii?Q?waVHCj5HAZ+h1hASPRc4UGXU47f9HZAee0M2FzHsjd9/oGfVxcQiZWXnh4Rg?=
 =?us-ascii?Q?EzxkOyqzRNP5VGwFHepMiX0u+3/tHLWW/Jxr?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:27.5135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44424e10-41c1-415f-b62f-08de235cf44b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6408
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20541

- Add machine conf and and kas yml files for TI AM62Px SK
- Add u-boot 2025.07 recipe
- Add patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch to
  enable KASLR support. This is already upstreamed to u-boot at [1].
- Add new recipes for trusted-firmware-a, optee-os
- Update SRCREV for cip-kernel-config to fetch ti_defconfig
- Add wks file for supporting image builds
- Update Kconfig to enable build support

[1]: https://github.com/u-boot/u-boot/commit/7d4136397715d2c08161a32a873c05=
2dd1bb8b6c

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  9 +++
 conf/machine/ti-am62px-sk.conf                | 28 +++++++++
 kas/board/ti-am62px-sk.yml                    | 13 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 11 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 30 ++++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 22 +++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++++
 recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 +++++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 59 +++++++++++++++++++
 wic/ti-am62px-sk.wks                          | 15 +++++
 10 files changed, 258 insertions(+)
 create mode 100644 conf/machine/ti-am62px-sk.conf
 create mode 100644 kas/board/ti-am62px-sk.yml
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3=
_2.13.bb
 create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-s=
upport-for-K3-devic.patch
 create mode 100755 recipes-bsp/u-boot/files/rules-ti-am62px-sk
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
 create mode 100644 wic/ti-am62px-sk.wks

diff --git a/Kconfig b/Kconfig
index 68773bc..9b3c329 100644
--- a/Kconfig
+++ b/Kconfig
@@ -86,6 +86,10 @@ config TARGET_QEMU_RISCV64
 	select ARCH_RISCV64
 	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
=20
+config TARGET_TI_AM62PX_SK
+	bool "Texas Instruments AM62Px SK"
+	select ARCH_ARM64
+
 endchoice
=20
 config KAS_INCLUDE_BOARD
@@ -98,6 +102,7 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/bbb.yml" if TARGET_BBB
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
+	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
=20
 comment "Kernel options"
=20
@@ -108,16 +113,20 @@ choice
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
 	depends on !ARCH_ARM64 && !ARCH_RISCV64
+	depends on !TARGET_TI_AM62PX_SK
=20
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
 	depends on !ARCH_RISCV64
+	depends on !TARGET_TI_AM62PX_SK
=20
 config KERNEL_5_10
 	bool "Kernel 5.10.x-cip"
+	depends on !TARGET_TI_AM62PX_SK
=20
 config KERNEL_6_1
 	bool "Kernel 6.1.x-cip"
+	depends on !TARGET_TI_AM62PX_SK
=20
 config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.con=
f
new file mode 100644
index 0000000..589f071
--- /dev/null
+++ b/conf/machine/ti-am62px-sk.conf
@@ -0,0 +1,28 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH =3D "arm64"
+DTB_FILES =3D "k3-am62p5-sk.dtb"
+
+IMAGE_FSTYPES ?=3D "wic"
+
+IMAGER_INSTALL:wic +=3D "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk=
"
+IMAGER_BUILD_DEPS +=3D "u-boot-ti-am62px-sk"
+
+IMAGE_PREINSTALL +=3D "firmware-ti-connectivity"
+
+IMAGE_BOOT_FILES =3D " \
+    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
+    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
+    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
+
+USE_CIP_KERNEL_CONFIG =3D "1"
+KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/=
ti_defconfig"
+
+WDOG_TIMEOUT =3D "0"
diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
new file mode 100644
index 0000000..5127218
--- /dev/null
+++ b/kas/board/ti-am62px-sk.yml
@@ -0,0 +1,13 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: ti-am62px-sk
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/opt=
ee-os/optee-os-ti-k3_4.8.0.bb
new file mode 100644
index 0000000..f8cd973
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
@@ -0,0 +1,11 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-bsp/optee-os/optee-os-custom.inc
+require optee-os-ti-k3_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/op=
tee-os/optee-os-ti-k3_4.8.0.inc
new file mode 100644
index 0000000..444f6b3
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
@@ -0,0 +1,30 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SRC_URI +=3D " \
+    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilena=
me=3Doptee-os-${PV}.tar.gz \
+    "
+
+SRC_URI[sha256sum] =3D "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49=
744701918e8b4d"
+
+S =3D "${WORKDIR}/optee_os-${PV}"
+
+OPTEE_NAME =3D "ti-k3"
+OPTEE_PLATFORM =3D "k3-am62px"
+OPTEE_EXTRA_BUILDARGS +=3D " \
+	CFG_ARM64_core=3Dy \
+	CFG_USER_TA_TARGETS=3Dta_arm64 \
+	TEE_IMPL_VERSION=3D${PV} \
+	CFG_TEE_CORE_LOG_LEVEL=3D1 \
+	"
+
+DEBIAN_BUILD_DEPENDS +=3D ", device-tree-compiler, python3-cryptography:na=
tive"
+
+OPTEE_ENABLE_APPS ?=3D "1"
+OVERRIDES .=3D "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPT=
EE_ENABLE_APPS")) else ''}"
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.b=
b b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
new file mode 100644
index 0000000..5b572bf
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
@@ -0,0 +1,22 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
+
+SRC_URI +=3D "https://github.com/ARM-software/arm-trusted-firmware/archive=
/v${PV}.tar.gz;downloadfilename=3Darm-trusted-firmware-${PV}.tar.gz"
+SRC_URI[sha256sum] =3D "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d=
713d4e9d15dcf9"
+
+S =3D "${WORKDIR}/arm-trusted-firmware-${PV}"
+
+TF_A_NAME =3D "ti-k3"
+TF_A_PLATFORM =3D "k3"
+TF_A_EXTRA_BUILDARGS =3D "CFG_ARM64=3Dy TARGET_BOARD=3Dlite SPD=3Dopteed K=
3_PM_SYSTEM_SUSPEND=3D1"
+TF_A_BINARIES =3D "lite/release/bl31.bin"
+
+COMPATIBLE_MACHINE =3D "ti-am62px-sk"
diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-=
for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-=
support-for-K3-devic.patch
new file mode 100644
index 0000000..d831b21
--- /dev/null
+++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-=
devic.patch
@@ -0,0 +1,38 @@
+From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
+From: Gokul Praveen <g-praveen@ti.com>
+Date: Thu, 10 Jul 2025 15:29:22 +0530
+Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
+
+KASLR, or Kernel Address Space Layout Randomization, is a security
+feature in the Linux kernel that randomizes the memory location
+where the kernel is loaded during boot.
+
+OP-TEE RNG is a Random Number Generator (RNG) component within the
+Open Portable Trusted Execution Environment (OP-TEE) which provides
+a random number to U-BOOT and U-BOOT provides this random number
+as seed value to the LINUX kernel for KASLR.
+
+Add KASLR OPTEE RNG support across K3 devices by enabling the required
+configs.
+
+Signed-off-by: Gokul Praveen <g-praveen@ti.com>
+Reviewed-by: Bryan Brattlof <bb@ti.com>
+Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
+---
+ arch/arm/Kconfig | 3 +++
+ 1 file changed, 3 insertions(+)
+
+diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
+index 5872455a0fe5..4e7593616d8a 100644
+--- a/arch/arm/Kconfig
++++ b/arch/arm/Kconfig
+@@ -835,6 +835,9 @@ config ARCH_K3
+ 	select FIT_SIGNATURE if ARM64
+ 	select LTO
+ 	imply TI_SECURE_DEVICE
++	imply DM_RNG if ARM64
++	imply TEE if ARM64
++	imply OPTEE if ARM64
+=20
+ config ARCH_OMAP2PLUS
+ 	bool "TI OMAP2+"
diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-bo=
ot/files/rules-ti-am62px-sk
new file mode 100755
index 0000000..6b9a6b1
--- /dev/null
+++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
@@ -0,0 +1,33 @@
+#!/usr/bin/make -f
+#
+# Debian rules for custom U-Boot build for ti-am62p-sk
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=3D$(DEB_HOST_GNU_TYPE)-
+SET_CROSS_BUILD_TOOLS=3DCROSS_BUILD_TOOLS=3Dy
+endif
+
+override_dh_auto_build:
+	$(MAKE) $(PARALLEL_MAKE) ARCH=3Darm am62px_evm_r5_defconfig
+	$(MAKE) $(PARALLEL_MAKE) ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- =
BINMAN_INDIRS=3D./ti-linux-firmware
+
+	$(MAKE) $(PARALLEL_MAKE) am62px_evm_a53_defconfig
+	$(MAKE) $(PARALLEL_MAKE) BL31=3D/usr/lib/trusted-firmware-a/ti-k3/bl31.bi=
n \
+		TEE=3D/usr/lib/optee-os/ti-k3/tee-raw.bin BINMAN_INDIRS=3D./ti-linux-fir=
mware
+	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
+	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=3D1 tools-only e=
nvtools
+
+override_dh_auto_install:
+	mv tools/env/lib.a tools/env/libubootenv.a
+
+override_dh_auto_test:
+
+override_dh_strip:
+	dh_strip -X libubootenv.a
+
+%:
+	dh $@ --parallel
diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bs=
p/u-boot/u-boot-ti-am62px-sk_2025.07.bb
new file mode 100644
index 0000000..8fecee8
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
@@ -0,0 +1,59 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require u-boot-common-${PV}.inc
+
+TI_FIRMWARE_PV =3D "11.01.16"
+
+SRC_URI +=3D " \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin;downloadfilename=
=3Dti-fs-firmware-am62px-hs-fs-cert.bin;name=3Dam62p-sysfw-cert-hs-fs \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin;downloadfilename=
=3Dti-fs-firmware-am62px-hs-fs-enc.bin;name=3Dam62p-sysfw-enc-hs-fs \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin;downloadfilena=
me=3Dti-fs-stub-firmware-am62px-hs-cert.bin;name=3Dam62p-sysfw-stub-cert \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin;downloadfilenam=
e=3Dti-fs-stub-firmware-am62px-hs-enc.bin;name=3Dam62p-sysfw-stub-enc \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin;downloadfilename=3D=
ti-fs-firmware-am62px-hs-cert.bin;name=3Dam62p-sysfw-cert-hs \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=3Dt=
i-fs-firmware-am62px-hs-enc.bin;name=3Dam62p-sysfw-enc-hs \
+	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_=
FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downlo=
adfilename=3Dipc_echo_testb_mcu1_0_release_strip.xer5f;name=3Dam62p-dm \
+	file://rules-${MACHINE} \
+	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
+	"
+
+SRC_URI[am62p-dm.sha256sum] =3D "85ba372a3c9cd0d09c84f9bbe46a72c7e4d6fdaff=
67df3ee7fbec3996965f044"
+SRC_URI[am62p-sysfw-cert-hs-fs.sha256sum] =3D "7781f2e7cc6741077f502692a93=
f435e7aa185de14d6aa8bb33d4f32f998f47a"
+SRC_URI[am62p-sysfw-enc-hs-fs.sha256sum] =3D "4563a2b22568581e04eeacc468fe=
ef5e204020c0d09a53351fd62d109e72b88f"
+SRC_URI[am62p-sysfw-stub-cert.sha256sum] =3D "dc45dcbc3dec319a9f3400a7051b=
692fe3c5e2369b33a46e8ef8c81419557eaa"
+SRC_URI[am62p-sysfw-stub-enc.sha256sum] =3D "9d6537148e7071f7ffbe33231c2e8=
ba1f17db398dff96c0a423baa8afd9e0bc8"
+SRC_URI[am62p-sysfw-cert-hs.sha256sum] =3D "ec3a7783d7dc6aab1085dfd131cbd0=
8ad5f895b7f22530c90a93333c4cd22603"
+SRC_URI[am62p-sysfw-enc-hs.sha256sum] =3D "4d0ed21a36dd57ada78307506403204=
e179d81dd1f05b3db384d4b24e17c5b9d"
+
+S =3D "${WORKDIR}/u-boot-${PV}"
+TI_LINUX_FIRMWARE =3D "${S}/ti-linux-firmware"
+
+COMPATIBLE_MACHINE =3D "ti-am62px-sk"
+
+U_BOOT_R5_CONFIG =3D "am62px_evm_r5_defconfig"
+U_BOOT_A53_CONFIG =3D "am62px_evm_a53_defconfig"
+U_BOOT_CONFIG =3D "${U_BOOT_A53_CONFIG}"
+
+U_BOOT_BIN_INSTALL =3D "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
+
+DEPENDS +=3D "trusted-firmware-a-ti-k3 optee-os-ti-k3"
+DEBIAN_BUILD_DEPENDS =3D. "gcc-arm-linux-gnueabihf, \
+    libssl-dev:native, libssl-dev, grub-common, \
+    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
+    python3-jsonschema:native, yamllint:native, \
+    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
+
+do_prepare_build:append() {
+    mkdir -p ${TI_LINUX_FIRMWARE}/ti-sysfw
+    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-s=
ysfw
+    mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
+    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIR=
MWARE}/ti-dm/am62pxx
+
+    cp ${WORKDIR}/rules-${MACHINE} ${S}/debian/rules
+}
diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
new file mode 100644
index 0000000..40214a8
--- /dev/null
+++ b/wic/ti-am62px-sk.wks
@@ -0,0 +1,15 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+part /boot/firmware --source bootimg-partition --fstype=3Dvfat --label fir=
mware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 =
--use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+part /boot --source bootimg-efi-isar --sourceparams "loader=3Dsystemd-boot=
" --label efi --part-type EF00 --align 1024 --use-uuid
+
+part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label=
 platform --align 1024 --use-uuid --exclude-path boot/
+
+bootloader --ptable gpt --source hybrid-boot --timeout=3D0 --append "rootw=
ait rw"
--=20
2.34.1


