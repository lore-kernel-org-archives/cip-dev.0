Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF61C43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 08:39:22 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16334.1782808752530043315
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 01:39:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=W5szn06o;
 spf=pass (domain: renesas.com, ip: 52.101.125.60, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJKIwvIZWe/Oi7HEY1DDZLOyhhnbhW25LzcTspsdbtU7NlWYbEEJXOW3fdFsL+taXRHBRPs3NbguCxopFd3mwLlOKDqBFdIbKwMBAYOHUD+UnaZNxqfN2Q983A9a6Ou3mK2eaMO7VxEH9YPrWRKWvffXcRTH0N8R1l+Qnjs+KwZo90nURMsJ9EHOAdzqAAdHbt7MoOeXTD6cdcbMBJbneyKPGPnjxb00svZkXx8j0efB5y2lrGsxqMdMZEzFX7+J4q/5e8FmNMnxXp4wpdtvk8QmT6VgJ/3Buf92VyRSTv7r7wxRZMNYqN0zZWmkeG7h3Wf+XaQyl1fA4g1Jyk7SIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbk6VAd5Tbfeh7r9P9hORTFsMFeVa3cHs7XM2BCy4xc=;
 b=Zc7DpK1Ja0pEpuYEh5Usqh1lhMdDwyzqk1yENv8Ew2tnrKn/yf+QZrE2ifFLSsLeDgFrmHYqcvJK6KRD8IYn4dg4frUHLt9cjREtqiftd9q/+ul/+taK3oPcX7TIPy0RStlweX5JJQ4abOXlfTUvQvLS0pGC7f95AQaMAubP304oAzZsOEGoP0L6xRV5A6Xd3qdT32lS0Y2cpkcUGEI3BX0XL6Bg5ny5fWoscH1fAsFpPbtKKWj5H4gn69vBFXhMhSaflne+sB3V9zUD15sQZssZ0NGYD2UM0Gh+ekN4jSmYT15OvwWzgB/AoM1Hk/XMzavYAq3u7TsGoTirFQcFdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbk6VAd5Tbfeh7r9P9hORTFsMFeVa3cHs7XM2BCy4xc=;
 b=W5szn06oZatbs9hRI7zHsHEtIPvcr9lVj4P/KLJdCvTxYo0X/0ueLOm8wZ5OL/hEUsTQdHo5l2/w2vrnPf512qOANRJJY5f5NSYnYiTm5oHxhXxkvX540oTMKCr7I0YQc0ekRKfqZI7QYw1vVfr/tsf1olEX7ad0Wlgkd+mfB8o=
Received: from TY6P286CA0002.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b8::16)
 by TYTPR01MB11089.jpnprd01.prod.outlook.com (2603:1096:400:3a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 08:39:04 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8:cafe::7d) by TY6P286CA0002.outlook.office365.com
 (2603:1096:405:3b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 08:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Tue, 30 Jun 2026 08:39:03 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (unknown [10.231.33.39])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F338D3000425;
	Tue, 30 Jun 2026 17:39:02 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: Hung Tran <hung.tran.jy@renesas.com>
Subject: [PATCH] Add support for Renesas rzt2h-evk platform
Date: Tue, 30 Jun 2026 15:38:24 +0700
Message-ID: <20260630083824.2536-1-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYTPR01MB11089:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 003894ca-64e4-4fe1-fcf0-08ded6830a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	w9Z9qLYfKplJqTshfeDaA6qKhQUznnttTmGtDnXQbAVA30n1TW/8QLggFTB0cowdTNLPQusb3ECGeYiJsh3SjI8Yamg96/Jd2MHTByQ5+AqSmOrwGfY3LKmtX/czATVkAJ4r2fG2l3B/3jhYWMF0atPWSWNEc4TW2WZTFLZXPfeZ6cVkn5USVzfW9IrCSGjbBzJhI2nVPfZBoKAG0K+z2Q3GDd5IXgHGDM50Qf54a+++vKKNltNOidIpUMgG33d93D2pPRIkm6KOaWXIhHPTRZdA+NedOqB36OU5D+8NF1AbLJKCC6u1Y0j2Xo2NK+ZzlSF87CIle+cCh+Id13HP82VhsXwrdJdCsSrTymFixlBtFdimfIAso0in3ypGr7/xjP15b0X0xizSX6RwvZap0bWZRB95xn7+gYvFksTGssWhyXbEJhwDskUFGNoAZY9lQyMUT5Yq0pui6KS03XkHOnvLlrRjo+0yvUc04K3qIec5QCuFR0lSnPy1S7e80tpo66Z3w6HzacT/1uGr1js6/szfSThwfb9HBbhPHI6T6ZJSvpR5Dqk3+hg7yT69Hko1SJs+XFq0yihztWxDW8PaXgoPxHv5i7bNSUzvUKmh+sZoUv/3pCWlfBUYDm3uKe85/b0z3JVqQ6tMyZbETmNjEdEuIVRijre2XX2UXQqrs1Mrb+IMpGflMd0L3DgOnDWroSyeHxJ6LlJYEozEeXjqYg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(11063799006)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	tTxrZSbGgvvuHL91ZF5ij+9IQnQl0aRO5cPSvrnuQFy14YUEdjcBPYkPnpNWMV57UNxrGRjObiHtWMr6AFr2n8347XYxZPuipECqC6bsRtrWVkRP0XNtquMKf/yk1OVO656Zn2JtvSZK1nLB4LAUoEn1eEo6g41EQmKn5lZHRBmoVQuIvXUnOzKJYIP3s5WGbxB/5O9sA9cP891HKArItnumlNosvOTgB+Sy94L0HunHWQPxDKpdHSVVFbfFHnVEvWphFsiqFugVZ2vJTRQzjyfmzivoxU83z4kTo7jn3d6Zg5VNQx7ioHCo3pkXBIapVXcgw6AfCoeTZcmTygKijphlK7XlGAwEp8cHYiPoEANXYlQYUctNuljZqXyZmzHX5iIb6+qeVYfL22sk9qXfTHcVnuzqRIjRdKOHCF/AGP7Xaetdj3jKVSpnintBhcWS
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 08:39:03.4755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003894ca-64e4-4fe1-fcf0-08ded6830a4f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11089
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 08:39:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23320

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


