Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12C3C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 09:10:42 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16659.1782810636975374890
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 02:10:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=BxVhb5m4;
 spf=pass (domain: renesas.com, ip: 52.101.125.45, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uYy3ZJt2yfyUeoKsBCk4bChdhEAZ5f8MAplV866d0PfeM35Cp9XFe75W0mf/3B2wmrml1zKTkgKvVA8cnT4TnQ3I7Xik9uJ+gZjUbUozgfaYMCRnr7Iu0mY9ja/c8R7fC+Mtx/uHRzxZzYpeINf5ZvTeAYuV+YLWxLErDMPcdXrCPfGjuJDS2lYuT8WKTb8ypmF4aZ3LpXsDxsuSv0djvCb/9qLRcXznHlArv9Lgkkj4Oa6kYz2AqW3rJH4jiAgtNZC/2WG5s3Dkmz7B5PhLYsOhm5iK4p94xyiFO8APRyBxBFu+akivGzAq6wegNrTebLUFlMOPbXzbS3pzWSq02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbk6VAd5Tbfeh7r9P9hORTFsMFeVa3cHs7XM2BCy4xc=;
 b=XAP2pWGee6C0gnw9fkpQga0M4/Hi8/ErJiZSIFk4uFZRbieZTqqU/oJuNUz3hwmsCohlRxsFnKih1fNeB3gdFkdqj0EmiReGpWHai8NPqIU18cAL8zRcei+/0HY3WroYf99OAweYJgZ5dK5f5w+dARg43+HVzRp9nXwgUqYmEHPhUMecG6eJG3mtNFCKU+hS265+o1fAT5qh3J6uCEP/Sgu82RUjL1ibQrHlY7qplylZOgVv1gfgJAmXpKpDcr/nJ3sH0N/2s6Zf509cF3P/2Dnzyk4/TvOKiTtCFnFvYnQabAkfUg36ItAEIjQ5Mh6SFlmluzQ2XFpkarutne8xKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbk6VAd5Tbfeh7r9P9hORTFsMFeVa3cHs7XM2BCy4xc=;
 b=BxVhb5m46/D+e+zv2553NDG9+S/eihz42dx9GaW0Ge5VQRLtvQjDcO1A95PlH4cO8JbX3LDrYUbfBvw3YdwDhEL8TIemk0ppmh96PBtgXSGeR7MhEfPCfa/CfkrxyYfb7X83qDQOeXLUkQVoGUl26IznbOs60dPPRJ0gt3k0YNU=
Received: from TYCP286CA0293.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::11)
 by TYCPR01MB8251.jpnprd01.prod.outlook.com (2603:1096:400:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Tue, 30 Jun
 2026 09:10:31 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8:cafe::3f) by TYCP286CA0293.outlook.office365.com
 (2603:1096:400:3c8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 09:10:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Tue, 30 Jun 2026 09:10:30 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id B22443009BAA;
	Tue, 30 Jun 2026 18:10:29 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: Hung Tran <hung.tran.jy@renesas.com>
Subject: [isar-cip-core][PATCH] Add support for Renesas rzt2h-evk platform
Date: Tue, 30 Jun 2026 15:57:44 +0700
Message-ID: <20260630085743.2655-1-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|TYCPR01MB8251:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2eaf3e3c-5781-49f0-6f81-08ded6876ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	V78M8mK6n53P6ywlQ9+J+Iy/C1vyj3JrQu6tswzY0wwIJORtrssmtOTBiTWU+Hqx+Tyye/Slpqx+jihlK5yfiK7iE6YEIuDy2xTvhv0pzPyvYnXMe+oRqByR6vyzT8zXC+aICw9GiYeR7t56ejdhppU/cN3q85ryozHJ9szuWxwQfyXRSOghOM6kbxYiCcvAKsVgVG/ynw4lCkHpCP4HBGJaXLHzBrj2EF7yLnGw++P5BEjGYHI4qcfnGe8/NJLWsoeGkXjn/DKHOODk3HjSc1Scr/2yjfaAKNmx/zka8Arc+Ivzbdaf1K2cpcXCqnPsEcffd4XosnbOnqGfOuuiIpN5/UCbAHtyKgwf8C0S1IX7Ma0Tn/Yk/gUo5EFEFOwWU3v1vpc7iyq+/n8opeV1y+ms8cwj8Xa7+AHnslGT8LIi1lkYy6U32vO9eOriyZPxsXj0IYh7P8thIinK+v+DVh9IE6FRm16n6RunJ+h6oABU15RuhnOEZMFgsu1QVesjsWUt1+Ulv24yTCF9OhDBtQGKLcI3uBn9kaCWsbX7fT1AeVkEW1wLUkYjliqfpdcx/py05HdupVd4rrG6qgbBvt2xEkVVJqEsXMw4qSrHJW5vdnlmjZrvz4+tq9S0UQJ8VCbmz093PcZuvCmFNi1GJbQKj2JHg5xc7PgAmzYq81OAWzjtuNXT1TmvF6WJ1hvHdztWGSK82XUS6D327SDiUQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	gBXIq/bVCjgaSW23/rizAZBJOj5D8aOAv4RHF4MkbXkCKTPO19GO6Ju3iGkv0459h1PFik2/O/DTNPdSchOoEOxD5NB92qAfbvajPw+VL2NlWEQZVjm55xDTfjtHKB97Z7nNwZEYPd13DaRwUtxVHIAFqZTMtGRGuLIr3e0JtkjZQHU0vwvdW/Gx1ohEei0S55oCD+5f6vGFJ54zS7oLUQfQULuCJfjv6zjP1zhLvAxex4X3w8bEGPObFXoNTLHEw8mUgGdSHT5gloSmHXFKf7ptR3lM14mba5gyrqlyuy6KPdifQFs3v6SwvL7wPr+3oZ+V4C4fQ9M7eVrr0nwCNJze+cJjgNLsQILHuksy8wsEUuSfaGOS5Zno2D3e0bidowmV37+521vl5K+B3sIR3arabFlFk2MBKPJKz/d6MwRhLqb2zI3m7q5gSiebFi2i
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 09:10:30.2078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eaf3e3c-5781-49f0-6f81-08ded6876ee4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8251
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 09:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23321

rzt2h-evk is the new reference platform for CIP project.
It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
This platform is only supported from CIP Linux 6.12.

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 Kconfig                           | 14 ++++++++++----
 conf/machine/rzt2h-evk.conf       | 18 ++++++++++++++++++
 kas/board/rzt2h-evk.yml           | 15 +++++++++++++++
 wic/rzt2h-evk-efibootguard.wks.in | 14 ++++++++++++++
 wic/rzt2h-evk.wks                 | 17 +++++++++++++++++
 5 files changed, 74 insertions(+), 4 deletions(-)
 create mode 100644 conf/machine/rzt2h-evk.conf
 create mode 100644 kas/board/rzt2h-evk.yml
 create mode 100644 wic/rzt2h-evk-efibootguard.wks.in
 create mode 100644 wic/rzt2h-evk.wks

diff --git a/Kconfig b/Kconfig
index 44f2337..879a31d 100644
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
@@ -144,21 +150,21 @@ choice
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
 	depends on !ARCH_ARM64 && !ARCH_RISCV64
-	depends on !TARGET_TI_AM62PX_SK
+	depends on !TARGET_TI_AM62PX_SK && !TARGET_RZT2H
 	depends on !DEBIAN_TRIXIE
=20
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
2.34.1


