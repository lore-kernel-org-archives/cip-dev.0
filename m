Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F55C44501
	for <webhook@archiver.kernel.org>; Wed, 15 Jul 2026 15:48:37 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.19])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9063.1784130513248036305
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jul 2026 08:48:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=VH6JH0I4;
 spf=pass (domain: renesas.com, ip: 52.101.125.19, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hL9lWY4pEWZCy/R9zRkwB8g6KqdC9gHN/JkptV95G4zuB6hH1u2VUGa4gJG+DHmlOGr3PohMWIXDvZnBH8IINUwXNl9cesvmBRhNLwlIDy1ApKvkpYzH38QK5ymul0p2jwuztVL4iHb/iA6U9NRLj5J2zyBdggThoGFRkZRRiLAEao/zzY2LIxtIFVsh7L8JgZ1Rx55LtNb6Ha4tlwcbden44FPIedC4GPuGFPp98Ok/63G5gh6DER/r0gXzcxujnYBJxsu8AsnyX9K4oP9SByobc8f79E7+rmwAuL+mmj8IbnBlPzWBO8wCcQdm7CEsGpgB4kD98+q7uBN7YR+3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqCKpipzp/VyWhoj+oYe4SNi22YDbA2l0x0nDhdPhIQ=;
 b=fptaiimneFEg4azNL4lhi5FkGaTFDdavSH34r3YWwKk25VQVzt0OGxrXfR7jAqpSXzgjY/SIDbfTKTFEJl2i/Ce9+CtkFMmP9QjjQkIuSI8WAaVKChP1xSlnTmzbpUb8Mkp6hgoyoG0sXY31O+BfMnq41ZMrn91+DJzqb9VpVcnjXRiZIo1N13+nj2V41ocMb8xKiSqeRMQlwj6qbVlS576RRU5LxAcXYL2G2nZA2KP88qEMi8mdrTTaPQnmWQ76+MSI+I3MOS6r4QeEC2KQsH7qt8bjGb1uUWjqtgravOhZbukaAYb9/+EwIsbqbPNRFxYep4UlYhGIszue3V9Z0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqCKpipzp/VyWhoj+oYe4SNi22YDbA2l0x0nDhdPhIQ=;
 b=VH6JH0I4+HYSo8wOo9FCGSZsUNvFIvCX3Mz00qo8l/PAjeJpVFxjmCAHS0JWOP5gGBjOKDUdorut8TxI20NvalG3XrjTP7yM4EZUr8yzSmf4puGKrX7Z42CiidyutldsJMqYx9t573ORMXIYCyNZ8lhvftYL64/SKGHXtqRDN2I=
Received: from OS7PR01CA0004.jpnprd01.prod.outlook.com (2603:1096:604:251::9)
 by TYCPR01MB10020.jpnprd01.prod.outlook.com (2603:1096:400:1e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 11:58:29 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:251:cafe::6d) by OS7PR01CA0004.outlook.office365.com
 (2603:1096:604:251::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 11:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9
 via Frontend Transport; Wed, 15 Jul 2026 11:58:28 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id A14103001292;
	Wed, 15 Jul 2026 20:58:27 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: Hung Tran <hung.tran.jy@renesas.com>
Subject: [isar-cip-core][PATCH v2 1/2] Add support for Renesas rzt2h-evk platform
Date: Wed, 15 Jul 2026 18:58:09 +0700
Message-ID: <20260715115810.2379-2-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260715115810.2379-1-hung.tran.jy@renesas.com>
References: <20260715115810.2379-1-hung.tran.jy@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYCPR01MB10020:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d2ccdfe7-b6b6-4a46-9f0a-08dee268620a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	UYegNzbf2+Ei0HDbce9tFafS7MJXWxr+23tSlhgascEohjdbmJf1//nFhyrLwFZ0UCcn9ShLKUY9QgYM0z1aYPgppleIvN3vQ/9MldU+Bbck87Amv14VJKUBjI7NtgFWD18jZGwegu9B/kfTGklJV8Q3djms0QE0VT3qrR/5S8MP2E2CMBtfSAFn4z61PFKbcmUJUcI5Jtg5CBvWlXNyTxnZ46SsdqBDO4AGc4eiULwHSWTppE4zIaiSJr7bnS0UVqzDhGtUvcJ+R5vvdToR94vDmOPF7RoAl9NMycfSkwZxeFMa4dc0UI5wfgseG2bQxeBTzDwLt2MouCk71vED7t9kmRfUnU5Ew+m8Scr9uifCksvUo8kJu4O5eeVwM6LRKZFCQ11zBKHumLFI4bNV7FFVm0rN+42dBBNF9WENesEvN9WuSDW+tcEPt4w1cUqYB+Wkuxr/ICDN31q/qWon1iqBr5Bn7c27QWY/4lyTkBfUjZZ05FoDah12ToUthCoJ8sZ+vuzq72ZezWCkMSXGDKMgmZlsAMoo02jFWCiJKh5QGQsXxpxUoS7sd4lYEa5plsEULSHeEgB10QGlDMwekwgoX9zEdh2TbtwNDWMZtrp26Ek7Am3vgBt3iDM3dSyMdPJYngAtLswhlaOlCaGc2BEZTUrXiFrThSC1T5rP9RGQtKRSwh08xFNpTl6oHpbDMEYXRXyFz+lWhISrgMFcyw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	e5757LI02bXHtiM+xRx5A2M9Ifal1e0kM6IUpVbhYF4kg1905YpvKjdF2FgOis5CFQtLZboNjOs/UxlOzyFzcSIH8Nb74lai33nzFNueC+r3OLDKmvKBwdolvrO/RbKoZgtkalUiDaNGHWTjsFZRXfGXlECcJ7HxlEK4YrpPaJ8vuOqv0m7ebvRByu1pnw3OaDRLERyLYVNmPcCpElFFQTUb796XitKWixPsDr0U/edICjjv8rB6JdDZiIzkmJsPHhEG7SgxS3zD+1fD5klRKeDTQZ+wIVlYyjwbEYvpsXmFtyvRH2KXlU6WPldwGcZk3CnIyRv/j6Tcckn9X0DVOfDW9y4jUdCtllmSmFjlRPI3X+/TlS98WUSIHJM5hNrRIUq3FGIFFgvD4fYz5EDcT5IIOxiFOj2l7+P18/bYEdWDUP9fT21fldjEUcC6lRG7
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 11:58:28.1890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ccdfe7-b6b6-4a46-9f0a-08dee268620a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10020
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jul 2026 15:48:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23597

rzt2h-evk is the new reference platform for CIP project.
It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
This platform is only supported from CIP Linux 6.12.

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 Kconfig                           | 12 +++++++++---
 conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
 kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
 wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
 wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
 5 files changed, 73 insertions(+), 3 deletions(-)
 create mode 100644 conf/machine/rzt2h-evk.conf
 create mode 100644 kas/board/rzt2h-evk.yml
 create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
 create mode 100644 wic/rzt2h-evk.wks

diff --git a/Kconfig b/Kconfig
index 44f2337..78a91d0 100644
--- a/Kconfig
+++ b/Kconfig
@@ -119,6 +119,11 @@ config TARGET_BEAGLEV_FIRE
 	select ARCH_RISCV64
 	select HAS_SWUPDATE
=20
+config TARGET_RZT2H
+	bool "RZ/T2H EVK"
+	select ARCH_ARM64
+	select HAS_SWUPDATE
+
 endchoice
=20
 config KAS_INCLUDE_BOARD
@@ -134,6 +139,7 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
 	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
 	default "kas/board/beaglev-fire.yml" if TARGET_BEAGLEV_FIRE
+	default "kas/board/rzt2h-evk.yml" if TARGET_RZT2H
=20
 comment "Kernel options"
=20
@@ -150,15 +156,15 @@ config KERNEL_4_4
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
 	depends on !ARCH_RISCV64
-	depends on !TARGET_TI_AM62PX_SK
+	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
=20
 config KERNEL_5_10
 	bool "Kernel 5.10.x-cip"
-	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
+	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE && !TARGET_RZT2H
=20
 config KERNEL_6_1
 	bool "Kernel 6.1.x-cip"
-	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE
+	depends on !TARGET_TI_AM62PX_SK && !TARGET_BEAGLEV_FIRE && !TARGET_RZT2H
=20
 config KERNEL_6_12
 	bool "Kernel 6.12.x-cip"
diff --git a/conf/machine/rzt2h-evk.conf b/conf/machine/rzt2h-evk.conf
new file mode 100644
index 0000000..5cfbfa5
--- /dev/null
+++ b/conf/machine/rzt2h-evk.conf
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) 2026 Renesas Electronics Corporation
+#
+# Authors:
+#  Hung Tran <hung.tran.jy@renesas.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH =3D "arm64"
+
+IMAGE_FSTYPES ?=3D "wic"
+
+USE_CIP_KERNEL_CONFIG =3D "1"
+DTB_FILES =3D "r9a09g077m44-rzt2h-evk.dtb"
+IMAGE_BOOT_FILES =3D "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/kas/board/rzt2h-evk.yml b/kas/board/rzt2h-evk.yml
new file mode 100644
index 0000000..90261dc
--- /dev/null
+++ b/kas/board/rzt2h-evk.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) 2026 Renesas Electronics Corporation
+#
+# Authors:
+#  Hung Tran <hung.tran.jy@renesas.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+machine: rzt2h-evk
diff --git a/wic/rzt2h-evk-efibootguard.wks.in b/wic/rzt2h-evk-efibootguard=
.wks.in
new file mode 100644
index 0000000..ca18bec
--- /dev/null
+++ b/wic/rzt2h-evk-efibootguard.wks.in
@@ -0,0 +1,14 @@
+# Copyright (c) 2026 Renesas Electronics Corporation
+#
+# SPDX-License-Identifier: MIT
+
+include ebg-sysparts.inc
+
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --sourceparams "${ABROOTFS_SOURCEPARAMS_B}" --align 10=
24 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-84=
83-4772-8E79-3D69D8477DE4 --part-name systemb
+
+# var and optional home are extra partitions
+${WIC_HOME_PARTITION}
+${WIC_VAR_PARTITION}
+
+bootloader --ptable gpt
diff --git a/wic/rzt2h-evk.wks b/wic/rzt2h-evk.wks
new file mode 100644
index 0000000..4a4af6c
--- /dev/null
+++ b/wic/rzt2h-evk.wks
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) 2026 Renesas Electronics Corporation
+#
+# Authors:
+#  Hung Tran <hung.tran.jy@renesas.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+part /boot --source bootimg-partition --ondisk mmcblk0 --fstype vfat --lab=
el boot --align 1 --size 32M --extra-space 0 --fsuuid 0x4321dcba --use-uuid
+
+# Rootfs partition
+part / --source rootfs --ondisk mmcblk0 --fstype ext4 --label root --align=
 1024 --size 2G --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --us=
e-uuid
+
+bootloader --ptable gpt
--=20
2.37.1


