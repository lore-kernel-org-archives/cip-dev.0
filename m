Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFD5CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:45:50 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com (MW6PR02CU001.outbound.protection.outlook.com [52.101.48.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22193.1762879547240516191
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 08:45:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=lMDFeAMH;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.48.51, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfGfLWidPcr5eff0wfsWrXEcap/Me6C2AAE5t7ZwsjF4MDgB6PrkhdTE6GpxAgvmlyn2hg+YoJ5zrBNi3bLF6WeGLV+dCBkGrv8qtenCiSMOA5SS6n7kyCS7ABYquYU+Z4/sCenD/Y/OwGFpPj426GlCV+IEUCk3xy5exOtng8Z56RpETloaOX5b/g0rYwmtICCChl7j6+zLU21/1FiIoI2F+KWqGyegGkCgOKVRvHbeM3rE9Q0kGpUbI2ZsSg6fKNL0NGoHtu4P/uOcc7jIwsZ75GfrvLjlifxHZhtS8Z6mLbC0hCwD8ksvXr3NbepMSindiksCa+YNeBznXsUgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dro/jWsuR0bxyt5i+DuRr/K2C43dm5ImyTJpYjHzn4w=;
 b=rqzvlqokSWsTVNUq/oNSRvJx/9pJteCy8bMrGYaeIoMl72ryAMHitIP2MhDp82UVmFkHmV4bbWM1/w/M8VYGM0eFeGsxkvTdkPvx6EzkzZzI9aqSsj0iuzMittavU5oVledatgG54P8JO5iZsHiAuU8hlazctUhAiYZsgKGC7+jHwU3JlqBREX69nPHvEFWYViWuXK/divWDZ11pzIk7OLsKrb5LTUMjv/mF0s+68kc5hd0lGEArHhPcAVGg+QIFXp70Ls+M2gkm/Q5h+DaQirYievQa3UBJfkq9wYeziH9IKW1U3Gng1LOYNrXa2icmDzcG+MfwmfMc5vS6R8odiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dro/jWsuR0bxyt5i+DuRr/K2C43dm5ImyTJpYjHzn4w=;
 b=lMDFeAMH4CnteR0iZinuY43qddpbgyChAt/GrfPUL1+mi1H70g6yw/R8FRe/y3+IB3L0DEGhqaXYinem1x4I54qBj3YI3VY5zhwW1Gzubi/ln2NbuWZyxBA3E7sQyzMI2y2GZxIkVR5zUcNOCkb8ReB2ZEKj2Gdi2Q8Y+sQvUz0=
Received: from PH8PR07CA0009.namprd07.prod.outlook.com (2603:10b6:510:2cd::27)
 by DM3PPF2867093BF.namprd10.prod.outlook.com (2603:10b6:f:fc00::c13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 16:45:28 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:510:2cd:cafe::8) by PH8PR07CA0009.outlook.office365.com
 (2603:10b6:510:2cd::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 16:45:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:45:27 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:22 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:22 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:45:22 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGjH9D1255613;
	Tue, 11 Nov 2025 10:45:21 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 1/5] Add support for TI AM62Px SK platform
Date: Tue, 11 Nov 2025 22:15:04 +0530
Message-ID: <20251111164508.1707234-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111164508.1707234-1-s-adivi@ti.com>
References: <20251111164508.1707234-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM3PPF2867093BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef63448-a94d-42f4-68fe-08de2141b7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?56rxX7qfBQwLKekyaPPsdRk/6nB6JTKN2a6ZakY2awPThJOo8EJog4yIlj1f?=
 =?us-ascii?Q?VHkxPsm0zyAZCYk8syZ35CxHCsQqmDDJlsUcYtTdPa9c9/mszMZ+leDeGyaC?=
 =?us-ascii?Q?Qr7YTDnLxqbY8Y5997DSeJoXk5yFeveCOZzaYHwZQ2be2PJz79iF1XShb1Lb?=
 =?us-ascii?Q?7qXwzO57it1MLgxHgXu044OMoZTVmwHcU0dytxMlYE7m5YNuKRdDHQCRqhkZ?=
 =?us-ascii?Q?Q6yAWANasGhOu0YTDCBkA9Jt32u+SFg6oGFn7T8cII+PWs5W2NE0TSdeJA4Y?=
 =?us-ascii?Q?TL98qVEUmItxutZ4BLD9pulpdbBpxYLr+HTYzSnLOCm77evfi9Ea69mJbo6S?=
 =?us-ascii?Q?OWhbhiXIibm+Kz1SZna9m/FnuZ7+7LXgE2817ixmPY9fqzJx+NrQaSeLM2In?=
 =?us-ascii?Q?0K4l15ROc1IO8Oay3NwvUicHLWLJ/fyiM1bGUVarcY5cLM1stYRrj/JzbzJ9?=
 =?us-ascii?Q?Ot88Mj76C7P2rLdbm6AUnzQ/GDOUj/OEhH4fvJST6mSywLh12BZ6Vs8iJC0m?=
 =?us-ascii?Q?u4Rx47Vpqpp0WzD8Lcxm/IRFkBG/4764vM6cBvVoDIwkiq48zkVnOapwYsIl?=
 =?us-ascii?Q?CETulVUGFu4/4RRiaqYdCdpo/yDGpE8ZWUyyyLO5peW7+fCTqgwMVXNMhgtS?=
 =?us-ascii?Q?bIOVdWVixELg0Ured8C+NcLfzkGq5NX6KJyeyD/gp6qeEBnE52Ngo+CypCLs?=
 =?us-ascii?Q?z9kbl4QAkXVtjTxRLV902kyitm82CTGcC564kGRRu7XpZ705xuv3WGwdW6eg?=
 =?us-ascii?Q?RtupkAJqZVI73hd4D7hKi9MlddmAm8c+rVtyj8e0VXJVLEmOYXnic+/PqM5c?=
 =?us-ascii?Q?8U6r57SwqVEOoPl3wecnwA3r4Xi9XOz/NC+yfp2KUpEnROrzzrpyCiaFo/1B?=
 =?us-ascii?Q?FW2qJExKlmxsayqUzQeB0TrHShrBy5SA+yVK+e0KI5nBR5Z9GAal1SoDrXW/?=
 =?us-ascii?Q?Q97xASugEIczihGoq2JG8SleVhnjQpOGtQ0CNqn38/lnLOVkXBiEe4Z0gtQV?=
 =?us-ascii?Q?ifx3hFvwA8UAD+XgdGnMnodgmPTyoi9McrUKkweCBtNP6WwVDDJaiqeCupsA?=
 =?us-ascii?Q?/5zFDHMzloA1/YL4cox+hz9Y5aWitA0DgSKXqTdzz7QNxechkJdmMrkjN/M1?=
 =?us-ascii?Q?2N908VXevCjkRj/b4tD1UtI7ssWX+ekkyyoDIdN/2O0zWB+BR3Qu6RL1gtx5?=
 =?us-ascii?Q?NrPL87U9YbgyitQ9VHVuwDYrFyOKkZ4M7jgrF+1aRTTQKqRRWQahSWE6Z/8m?=
 =?us-ascii?Q?zydvN1yBwfpIo4TkAd2JtPtokqBz1BooH3ssRRPLKA1Nj3dsrLXsbdKjjREh?=
 =?us-ascii?Q?GJJhlVspgx5wnlV1ZjHRnlHlRvy2N7tUZfNC4c52j5Gweq+Ftn4VuQ6jWmCB?=
 =?us-ascii?Q?hcmtZv61mjj0bIQS0cX2ETDBtJ30fGCDbnH3oOlg6ERsrMKoonhwOQA2biBb?=
 =?us-ascii?Q?x6tn4CU1TmZEjv8ARnubbQyPTb7CC9HzAzbap+5vGuBecymjJNCd9ba1XisX?=
 =?us-ascii?Q?hhyPBkre/9TK9IkfW8wmxmr93O650LaJJ3gY?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:45:27.0605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef63448-a94d-42f4-68fe-08de2141b7a8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF2867093BF
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 16:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20502

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
 Kconfig                                       | 11 ++-
 conf/machine/ti-am62px-sk.conf                | 32 +++++++++
 kas/board/ti-am62px-sk.yml                    | 13 ++++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 11 +++
 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 30 ++++++++
 .../trusted-firmware-a-ti-k3_2.13.bb          | 22 ++++++
 ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++
 recipes-bsp/u-boot/files/rules-ti.tmpl        | 33 +++++++++
 .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 69 +++++++++++++++++++
 wic/ti-am62px-sk.wks                          | 15 ++++
 10 files changed, 272 insertions(+), 2 deletions(-)
 create mode 100644 conf/machine/ti-am62px-sk.conf
 create mode 100644 kas/board/ti-am62px-sk.yml
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3=
_2.13.bb
 create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-s=
upport-for-K3-devic.patch
 create mode 100644 recipes-bsp/u-boot/files/rules-ti.tmpl
 create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
 create mode 100644 wic/ti-am62px-sk.wks

diff --git a/Kconfig b/Kconfig
index 68773bc..0930f7f 100644
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
@@ -107,17 +112,19 @@ choice
=20
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
-	depends on !ARCH_ARM64 && !ARCH_RISCV64
+	depends on !ARCH_ARM64 && !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
=20
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
-	depends on !ARCH_RISCV64
+	depends on !ARCH_RISCV64 && !TARGET_TI_AM62PX_SK
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
index 0000000..6e59250
--- /dev/null
+++ b/conf/machine/ti-am62px-sk.conf
@@ -0,0 +1,32 @@
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
+WKS_FILE ?=3D "ti-am62px-sk.wks"
+
+IMAGER_INSTALL:wic +=3D "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk=
"
+IMAGER_BUILD_DEPS +=3D "u-boot-ti-am62px-sk"
+
+IMAGE_INSTALL +=3D "u-boot-script"
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
+
+PREFERRED_PROVIDER_u-boot-${MACHINE} =3D "u-boot-ti-am62px-sk"
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
diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/fi=
les/rules-ti.tmpl
new file mode 100644
index 0000000..58e954f
--- /dev/null
+++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
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
+	$(MAKE) $(PARALLEL_MAKE) ARCH=3Darm ${U_BOOT_R5_CONFIG}
+	$(MAKE) $(PARALLEL_MAKE) ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- =
BINMAN_INDIRS=3D${BINMAN_INDIRS}
+
+	$(MAKE) $(PARALLEL_MAKE) ${U_BOOT_A53_CONFIG}
+	$(MAKE) $(PARALLEL_MAKE) BL31=3D/usr/lib/trusted-firmware-a/ti-k3/bl31.bi=
n \
+		TEE=3D/usr/lib/optee-os/ti-k3/tee-raw.bin BINMAN_INDIRS=3D${BINMAN_INDIR=
S}
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
index 0000000..bac1413
--- /dev/null
+++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
@@ -0,0 +1,69 @@
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
+	file://rules-ti.tmpl \
+	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
+	"
+
+SRC_URI[am62p-dm.sha256sum] =3D "7251394068d287ec81cb0f005a734de3bb7bb695d=
9dbcc3903ea83dda2182efc"
+SRC_URI[am62p-sysfw-cert-hs-fs.sha256sum] =3D "fe36da7923ac6fa52eea5e601fb=
4321299df5e639d9dd66b41b6825bc1d9d539"
+SRC_URI[am62p-sysfw-enc-hs-fs.sha256sum] =3D "4db6ed096fd5077023f292841a64=
aedb3a4ff8408d1160fb10a7aa0355d06e56"
+SRC_URI[am62p-sysfw-stub-cert.sha256sum] =3D "22b58a07429da5ae0b0cd126d4ec=
0f429ee687429251f4fcfe9a2f5bb3e74b5d"
+SRC_URI[am62p-sysfw-stub-enc.sha256sum] =3D "2cb73e5c9acf985325f40f1615290=
6c9a2057f41ffb7903a981a34f7b2aaf524"
+SRC_URI[am62p-sysfw-cert-hs.sha256sum] =3D "dfb1c90110155328bc19d9ecdbfacc=
5a899d4cce8378f8eb8f27877c9fda1fdc"
+SRC_URI[am62p-sysfw-enc-hs.sha256sum] =3D "4d5216f8187441ef8af00ae7e79113d=
36964221a3a19a026aeec09e20a290931"
+
+S =3D "${WORKDIR}/u-boot-${PV}"
+TI_LINUX_FIRMWARE =3D "${S}/ti-linux-firmware"
+BINMAN_INDIRS =3D "./ti-linux-firmware"
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
+}
+
+TEMPLATE_VARS +=3D "BINMAN_INDIRS U_BOOT_R5_CONFIG U_BOOT_A53_CONFIG"
+
+python do_transform_template:prepend() {
+    import shutil
+    import os
+
+    src =3D os.path.join(d.getVar('WORKDIR'), 'rules-ti.tmpl')
+    dst =3D os.path.join(d.getVar('WORKDIR'), 'debian/rules.tmpl')
+    shutil.copyfile(src, dst)
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


