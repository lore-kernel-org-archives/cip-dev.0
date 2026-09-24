Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAB5C9831C
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:45:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5917.1790250340038710448
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:45:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=SkoufsJg;
 spf=pass (domain: renesas.com, ip: 40.107.74.39, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vAblmBN8GIzdOQA2i2UsV3vKPR+76QBTdzQK3tXRdYJda61acGkQCn0SPDAJUol4Zo0eS+vVA+M2k5O9Qeo40oJNC4SQPqp+VlkKeA95qnZAwD+3+S2fVQGpwKSArdXepEQ7PN9CXATsuAMzO05z8kYvol/GaSNjzQFmvrBdvCN3RZtcImn9AZM4MJsR+sepKGUsJJNelCbchAZdDIx3CKbQL1Jj3nruxVRpRYistijSq5dNbYWJoj22Pl7XZeUiKSkV+IxY1T89B9mJcL3seE5jZXSElaUWaxZr0p4DdTVBKeJ3xfgvi2swXZqfxm6yNh0neHSA09quv6oaxuvLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv4XXtkk9HzZSVtUVEq9Y+6rbCuZY0aBmvnxUXwx4Nc=;
 b=dQ3pAYbwAug4qToJrhIzHe9Z8FOlSRCbOrG4x3qTECYRnr9QFqLJdTCQnVJovutXOIBv6Onf7R+d65TAlxO7RzVMvm6CI40tb6rUn5sEk3+qLMVgandhI3LvqLXyERKUGpGNpsXWdMyiFB93am0BbLFSK/8uzkAm6WQXPheVTc3x+8dFlYcm/Jlrxj+FTdmfb9oa6+g+WmX1wAklBeCDdAM9aQB9lS+LbGuWHpEWvZPEP0sAt5B4xMSF/c+BmKvf/8J3eI1Y3GzYVaBAhglUdmrUWFBAqj67hue6VC/tfsbjveQW523J2YzzyaWv/VyIsFB+adpuB+r3TJHNhDeLMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv4XXtkk9HzZSVtUVEq9Y+6rbCuZY0aBmvnxUXwx4Nc=;
 b=SkoufsJgAcyestu9d+Go/fZs8k449mYNEkGQmjw5wsHDD3isN84gFMQuBh1LMwLNBav5qScjsIOJypMgWIfU9NYxlyVKxd/ij5ysAWUMLJ2l9qQ9k4RER2eq7fqwfvdRA6SdiAAqLSrxg5fjh7DkkaH1Y+7RNvdRI6SNeIB9wwk=
Received: from TY4PR01CA0032.jpnprd01.prod.outlook.com (2603:1096:405:2bd::13)
 by TYCPR01MB7219.jpnprd01.prod.outlook.com (2603:1096:400:f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:45:34 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::2) by TY4PR01CA0032.outlook.office365.com
 (2603:1096:405:2bd::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 11:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 11:45:33 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (VNM-5CG30610QM.adwin.renesas.com [10.231.33.39])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 4323730001E9;
	Thu, 24 Sep 2026 20:45:32 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com
Subject: [isar-cip-core][PATCH v4 1/2] Add support for Renesas rzt2h-evk platform
Date: Thu, 24 Sep 2026 18:45:28 +0700
Message-ID: <20260924114529.962-2-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260924114529.962-1-hung.tran.jy@renesas.com>
References: <20260924114529.962-1-hung.tran.jy@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYCPR01MB7219:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d0ae899-bdc6-46ef-a3b8-08df1a31575b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	3+vJxq3yeC1cg6vJmukSvXEPSHjqqGvnlhEtYeFmJWLXqDf+Mgo/KbGWJs6YGB//FBxZlryK9m+cDQgBngtDSd99MejHOryZrxwARCD4w7yVDgFTut0c7xJ/NmE2ah19OTAzuk0AdJnMdUhU7Mjylnie6SPDfRFJ/FlpKRTUVMqkKjREWV7XceNQNUoJ1988a/VT6ShahYztXagQuIZcyqtpLtDA8foKzupyPzoa+6ZH3j7ZMNNW/iznQSav+WZkMUEno3PWAqgcsC4OKPs13QYx12CF85IgCHYOcBlmIm2iTs0ZX7fQaB5J8vYMxqnLKJcQqn1dxLB/v+/5xsrsGEpNypl2OoiVelXe2u1n+3n6Ko7+1+kznRuc6QRjvn+rMHUN6r4SHsAMm05jgWuhw8G6FShuq+YWApgc74zcKmRuKV6pSAeTqc639ynGo2iwehxL5PebaIIoSjQLjHwqBUQIq53kYBnKCgjVEaqDPYJLBrKMdIav8gnF1SyTylsr5DMTYP8XQnDiVbMVzxIUU3CiMIY7AaobV/wbsPj4fg2+VwMIWr/y8JJLXjyXtlhffL28V3jQIcx9xTSwCZA4m87dvvFlaAVV9CQ3f08da3SfNl5cKGy0Nf3Kzx1rQJX42NGm85yLA2rIVMcJf/w3FSIVPzpQW8aCf9ILh/I6QE9zBO/XLQ2cyJSOXCnlOIZ+20KV5hutyGtTLysTr/jf7w==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	xmRYJFJ+Fq9xsmg+KiFvgshesKuek0gKSRtwDl0tRoiDgryF1xtnS4hLW8zjFxqD6YD38yUeQf6ILGnIlMXpOznQawZzvLxKRZHoGD9xWKtPonC53t+FWQtRHym+BBa4Lsx/QXtniuWrLD5KgTDhLKfS6znyz8D2Ecq/fBU9ZzJDownEr7pdMY0l2QszLRjkEKVYPPUJIoItcaISs9w3f/+9qdtivY22xGKQGJV80Iv8zbnfMgvZu34ac+FzfQytlFL3eSah/JlwhLsO2LT/dOX3RS3N3qluxM7hWRG4/nFmv2bkNya+o/qnk5zZ90i042ghC7LXoNaEmqG1Ak/oD39KLoc0VdCm9oQE1NZI8Xm5a+C032sCWfR2D06nQrZz7hpNy5jVHMEt2aDocG99JBhzSoQrAXuV6oawk1SFOG0isIkiE4CRj3Frjp9tUXLa
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:45:33.0744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d0ae899-bdc6-46ef-a3b8-08df1a31575b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7219
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:45:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24334

rzt2h-evk is the new reference platform for CIP project.
It uses Renesas RZ/T2H SoC, based on armv8.2 architecture.
This platform is only supported from CIP Linux 6.12.

The efibootguard.wks file is largely identical to the existing
qemu-arm64-efibootguard configuration and could be reused. However,
it is kept as a separate file to allow future platform-specific
customizations, such as adding bootloader support to enable booting
from an SD card.

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


