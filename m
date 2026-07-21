Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF73C44529
	for <webhook@archiver.kernel.org>; Tue, 21 Jul 2026 11:48:40 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20735.1784634518637695017
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 04:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=WZOaOUCM;
 spf=pass (domain: renesas.com, ip: 52.101.125.56, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je7bvwJqt33ZjvELZQwG186TGtChY4yQEGuiV7Xyqz3jB+RUfXy7Tren6IhPdRkeYymtMMliDXQ9i4z5Ac79w8R7Wy9fBMBbuKzUALN02QqZxjzL6Lkd4eBuKl1cIOp1UKwAZrpatVg2oWuViWAvQP8OoUBvrHXv+THlU1NutgZFsbLN8L3SyAYzAHSr3YMRVKXMExk8iOcd6yizwoZdo8WKxPrXh74M6HydLEu+fuzWokF/14zrlSpvva5yLj+z1S5jnmmF/mph4rIcX2wLsdlbJgTtdYKsrBB7p85KMpmIu9VIuxxRcZMZPlwyxrwzBHGrwkMTmIEk2HJcakU6/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jni5BJ/RCGe+dw5r1fLwEqJQJ5lhs3iH7KXlyHITihU=;
 b=kCALyZ8Av9V3p9Y4vwasu1KSxHYhGh590w7SYY1IcBpglctZt3fxHO99Q0AwFVAgThl07VWdJwO8JJ5XjHGZLmbXRqQ3PXJMDO3z8aUD4KYD3SfxXRRqy653fCGFc8Yhd7ty3sS9NLzq1vxQNYRmvbVTjouKFlzYnsj/KT3O+BGGousjcnGxMDBA/sNk1Uylckvnhy+3ddI0XuUiX/rqnJWHqBpjg/AEQG7pHGsuUBM7tLFi+6Hyo4p1ylXNX0x6nBdHeyhS34crx5mxjuyVebHKSoft8BANirKtSYHf5wGmLvtGzPMSDPe4ofXzkfRvbTNhEwr7xQYgrWW9X5BV6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jni5BJ/RCGe+dw5r1fLwEqJQJ5lhs3iH7KXlyHITihU=;
 b=WZOaOUCMq2RcZp2PVKS/jrU8eWvqPvDZUkNsura/l7NB/XaS4xhL7KB1HpCfzakMw4AFSgvp2MBOMKvxUUwEeYLPbfrohwWGztdqtSEKJYorekNoBlc/VxsC6YlSEvNzhcBWX49U646DjoFGwdNkH6mlPaySmd17HxrNoE22/JE=
Received: from OS0P286CA0057.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:9f::8) by
 OSZPR01MB9614.jpnprd01.prod.outlook.com (2603:1096:604:1d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 11:48:31 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:9f:cafe::59) by OS0P286CA0057.outlook.office365.com
 (2603:1096:604:9f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 11:48:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Tue, 21 Jul 2026 11:48:30 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F217730014EF
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 20:48:29 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH v3 1/2] Add support for Renesas rzt2h-evk platform
Date: Tue, 21 Jul 2026 18:48:27 +0700
Message-ID: <20260721114828.1390-2-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260721114828.1390-1-hung.tran.jy@renesas.com>
References: <20260721114828.1390-1-hung.tran.jy@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|OSZPR01MB9614:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 22c0dc76-20d4-4777-8363-08dee71dfc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|34070700014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	C1a1m4SYQdyLJ9Kqs83L8Kd7CaNUNgfrt3rftomcJUQt0PcFe3nth2oBETwVBD7vhJ4s88Y4Vy0wypmy/LvSt3uZ4hH2qrSPA/TJH5weDdLT+xD9LSZVFeCd2cHHxLbwJYXh3v1W1R6dqN3IUEM7+7NfaGTvSxXWk1tyXgbjAKqcDGBJsG2ZAeoJ2tIwMgX6/pA3UDyLVgEAREeAfEVHppKEYPv4rcx0xL5cK7RculSTGTsEYXHYT82OaIrs1grRD6YfE2/YfnUPcvXqQi9LVAJhXtHkk3dcHNW12lS28Ze1SbgHh98tsA6wSJZlR9FbuQsY5lpynUEf5Wz54e3HDqVyWQUWvdpRyEGwAn3hQkZ5KOUgtkKsvDzUr4le5mTzZ3edAH3Q3HCk2mxMzNnNUJsSaFBeB6eABLZb/dPApfrFw027eEn53GeBhUa83rofgEuwnPhy59HUO9jRI0ZSLLxVAkIN8NWj50PXCZ/HRVtr7XfO6PE1wGBdOfHhabp7UihErUHFJm78zYnrzf8eKrF/ffeJaoyJFCM7OI4lRTNROnYnAVSGcWwojgo3JVgsf82+5UcnpTA2+/81DPYaeVRW6tQtY0eFZT/kfQ448dJGf1g7uGIRXf7bLIZibqiWD15AkKn7AYE4PakLsLRgJDEps2cY1zoImdiaGlVtmqHSCMU3K0yCBhL7Y+YbHzcqlptugQJhbKgRZUywjbNlGg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(34070700014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	DrPEqNdtUQV66hWwpylZRRgHz3boEGoPdUY9Awg/oqQ5v6HL8lcdNKtwVZ9ZN9d0yWi/Qvrp2dJ1BpngbBUyTWSasbWfWZySPyEq2uyNe1Piwr69VcVS00Y9t39BLZ2CWvEV0W23g4jRK8WRuFafce0uxLSW4ssWbsySEK8oEs/gZ+1UjM5H6tP83qMLO3e+I5P3//zH/qFBeRkKyZkNe8jhsypmji6gjdmLxOWMIiVxhG4Yx+M3Xh0F7qRmr24WqFaXcjdk6gGTmCtm68bxGMyj/lBLeM4eowy7NaQazVVWMHU+/0cy+1YLjCv0DWSPAoQvwbZjkJJS3Qf3xj8EUx0jrQEqveiF0P7h3we5p8EBIj50lFuczZLPBKtAEbpqVbXIn5fbnvEUBu/uGn5Ss7rYrdS05AujsUUgpYayr61T2qG2qR5J+twa7b0EQwIt
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:48:30.4264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c0dc76-20d4-4777-8363-08dee71dfc39
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9614
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2026 11:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23699

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
index 438234c..6894e87 100644
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
@@ -149,15 +155,15 @@ config KERNEL_4_4
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


