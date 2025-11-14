Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44037CE7A8C
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:05:38 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com (PH7PR06CU001.outbound.protection.outlook.com [52.101.201.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14172.1763111128509108119
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:05:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=JtyCOnQt;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.201.13, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UkLeC0bbStl1IoNPxnXsD/MWgRAcCNMTv+BqVqjPJ+YJdlLb6i44L763Sr5BVQ0+qAvC8EQgnsCe8Qm20nnujRwwqkEMhFS9sjt4M0EqLznmXJsQ1snAA6RoMQF5+KA+uE6JYHK844NT4/ctzTjr/pXvAljG6RItbnPYlJTFNqMreCcztpCKcd9Z3U0UPxSRdUXxbM0CVGxsUQfhAFc8bSwQ0S4M4Nb0juXRF1/XSHWiSXs51SFTgi8l4WpDPGDVOZ6bFtO8ZZtyBHwm3CPsSzlETfjVvbTiHNs9ViiNXs8HMVo13b4P/cCU0nXT4Frf8Fq42OrO0ObUqM54J97uHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjfNVYi4RNXMS39zXdYAeQJSOvLD7CwO45EmEYTWxLI=;
 b=wG+1ao5KK+F2Z7n2iwzWAj3vLZieMbARK37n1SOzXJimq/tgHisohEdAUeQ599QyDVSbRG/EfDQnwftA8rLL4+V2TH2/hFG44a1Xh6defLRGJcaCjqzg27veODhNqlPtQki+fQpHyo56Au8vbWzFPkkYAIbsucr2IfeCm2R2x/P/J/IWTr7iaZM6NQR9yrIqaSAh8KbwfDaNa8cPrJYROOLhGJbk4m3jqjbLQR8qy2Ud5RmLOW0lnRBYqgjVsFgkqWG2ylvF+RX9IJ+G3Ucwe+4vEU10UqVljJ3zTOEL3SPw2ylc7HlhWepwk50LoP3g5XunSyEj5ZU7XrQlalgAiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfNVYi4RNXMS39zXdYAeQJSOvLD7CwO45EmEYTWxLI=;
 b=JtyCOnQtrkTLiZ0QcC8tDR2TF0Ixp081j5Aho4np+j1GJl4zUI8ypa3kuEW5G+VPg8Fd2BxWrd/bwvMFux+XVETcbc8MU5/8JvDHr50T+DQNx0fYEO5+K0GSKe2WhR+CId1WWlatCO5x7/jBkqoP5N1TI0i4rp44RBb2dH4nfRw=
Received: from CH2PR07CA0048.namprd07.prod.outlook.com (2603:10b6:610:5b::22)
 by SA6PR10MB8182.namprd10.prod.outlook.com (2603:10b6:806:43d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:05:26 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:5b:cafe::a8) by CH2PR07CA0048.outlook.office365.com
 (2603:10b6:610:5b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 09:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Fri, 14 Nov 2025 09:05:25 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:22 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:21 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:05:21 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE95E1O1718804;
	Fri, 14 Nov 2025 03:05:20 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v5 3/4] Kconfig: Improve modeling of Security features availability
Date: Fri, 14 Nov 2025 14:35:08 +0530
Message-ID: <20251114090509.2935933-4-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114090509.2935933-1-s-adivi@ti.com>
References: <20251114090509.2935933-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA6PR10MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 414c40b9-5b2a-45d9-8345-08de235cf32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pYGf/zWWp1CMuwHXxcHURSpjq302hgtp21VMGGF0iD2FJkGmFysV/iGBbk6F?=
 =?us-ascii?Q?eCafdYNS0c1XjKiVt9FSG7va4yOSuH0pglLKUJKB178/K86M3ExDcLdGTfPT?=
 =?us-ascii?Q?PGrA7Z2XOo+OAahdOdAk2si3rt25zhFbT/sE5nxcwyvglFN5aXkq29jV5YN+?=
 =?us-ascii?Q?vmY05nVubzP6pmQaq+oYwsgg8jFVbmrwk3WHRSiSKHOpvhy1vsFY5O+bEycs?=
 =?us-ascii?Q?/T2mhXoLobn1zfNK6UG2X3UBIqnKRql2RpO0P4CDOjrKpBBKWTiy2PWqriR8?=
 =?us-ascii?Q?ugbOgArCDSz4MDAPYPa/360qxZ6VoEQsAqB7rFxIV2/4j8uwlXUwSgEcc9AT?=
 =?us-ascii?Q?GYXRCzbof494lP6+sYHCctbiMs+lnAATX0igrdG7H6Ar9uHGfi68vdnPS5AQ?=
 =?us-ascii?Q?kre/VMCw8l99gQQovoPBg+lBNwUQLHKP08WKr7c31+GLQDnMB7ubpqcprQi0?=
 =?us-ascii?Q?QEdLPB/ZRJIgDAxgSCHAQ02wTWpX5/8lpUcD90YRcsIzUv+9j0ltajGl82jV?=
 =?us-ascii?Q?v/kOoYidmBYVsqMTy+hZsZRI/Pn9r8qTliFNt/Ajb6052ZKgMxDJBfes+RaO?=
 =?us-ascii?Q?NK23JTmb9dsUkFVeFucUx1D3PyH8KyIaEvw47eCgm4B7MOc7cQjzT8P1tkTc?=
 =?us-ascii?Q?+Mt6qqWxvaqFnP91hytFs2fbtkaCiSFbtc4eWjM/HReK+42B7px3+kKCqvNk?=
 =?us-ascii?Q?KQiT9ZssfJGLvZH5IhHmihWaqaHnzKI7on3W8KJl0TmtmC355QccE7N3FOae?=
 =?us-ascii?Q?Yazpsy+TBsjXzzT0n03Hz5+ln4NghCUXwadkwV3g/OrP0UB5I03ovcd+Eu4L?=
 =?us-ascii?Q?qkAjNCBJ5X1AsNaWvcD1KZcFJcaVBbFPZ+JH24iTKOXuPDkTIYXDp6+anBW+?=
 =?us-ascii?Q?/J2C7vm0FOmbMqK0Au1h89bR5ySJ/yT+bzQKrszWnuVnHz8UzOXlCoUW1twp?=
 =?us-ascii?Q?b4DKw4QEzU9c8Hpgp2eg8o7XDKnccfEj6Q06UrBJMVz1Aae1TCiJVIb4hvwF?=
 =?us-ascii?Q?4CbyuQNKhm6ejWmpmCofUq3VZ65iX8u4ruNGDHqcXXQNaeZx5hrB14aRmqSR?=
 =?us-ascii?Q?tQBszFtMtMNLDGC0dRuwd518idnMxtcZH8lyolbd3p9pWCbHG07/M81kOdOZ?=
 =?us-ascii?Q?BQVNfdyZ4ky39/chMyfGhJO8ChKgQ52KvJ+j9pDDIG5GNRxCniuw3AcKsEvF?=
 =?us-ascii?Q?8Kc0qvhH+0/bcT+aXeXBF3AsDaXl/HEVOKFAjXNVuG1wGAqUeOyT0zX3FXTj?=
 =?us-ascii?Q?wSYjt1OjMDFSSkWnl2neG5AThhxL+vJI/RXENZ2a8WQ9WrYYQFG59w/4Vbrb?=
 =?us-ascii?Q?XMIRJSJF1hMessTnQFwre+1K39nvO3xW4Hw9H87AEg/Ud9xgnsh+TzdZVpHw?=
 =?us-ascii?Q?qSNPFvAga1z/Rxb2xQA8R1fjAlfHU8/WijWslyJa3KL9U+zJcLAfacENICAq?=
 =?us-ascii?Q?ZtCsNHphql4DWDFgKVOown13tBfVeb9biQAT/LHwW4w63Sc1VRGsKQpOrCyO?=
 =?us-ascii?Q?oPp1/J+oDT4eLYDKa1I5Js1elPP0ItcxWk3A+DqZn82q+mEOIA4wJQ/hG9nX?=
 =?us-ascii?Q?IXhkebUGt70yWzz+wr8=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:25.5888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414c40b9-5b2a-45d9-8345-08de235cf32b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8182
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20539

Model SECURE_BOOT, DATA_ENCRYPTION & FULL_ENCRYPTION via bools that the
targets can select just like SWUpdate.

Also update the IMAGE_SECURITY to depend on these selected bools instead
of targets.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index 48c0e51..d322a94 100644
--- a/Kconfig
+++ b/Kconfig
@@ -40,6 +40,12 @@ config HAS_EFIVARS
 config HAS_OPTEE
 	bool
=20
+config HAS_SECURE_BOOT
+	bool
+
+config HAS_DISK_ENCRYPTION
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
@@ -49,18 +55,24 @@ config TARGET_QEMU_AMD64
 	select ARCH_AMD64
 	select HAS_SWUPDATE
 	select HAS_EFIVARS
+	select HAS_SECURE_BOOT
+	select HAS_DISK_ENCRYPTION
=20
 config TARGET_X86_UEFI
 	bool "Generic x86 machine booting via UEFI"
 	select ARCH_AMD64
 	select HAS_SWUPDATE
 	select HAS_EFIVARS
+	select HAS_SECURE_BOOT
+	select HAS_DISK_ENCRYPTION
=20
 config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 (aarch64)"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
 	select HAS_OPTEE if KERNEL_6_12
+	select HAS_SECURE_BOOT
+	select HAS_DISK_ENCRYPTION
=20
 config TARGET_HIHOPE_RZG2M
 	bool "HopeRun HiHope-RZ/G2M"
@@ -71,6 +83,8 @@ config TARGET_QEMU_ARM
 	bool "QEMU ARM (armhf)"
 	select ARCH_ARM
 	select HAS_SWUPDATE
+	select HAS_SECURE_BOOT
+	select HAS_DISK_ENCRYPTION
=20
 config TARGET_BBB
 	bool "BeagleBone Black"
@@ -240,7 +254,7 @@ config IMAGE_SECURITY
 	select IMAGE_SWUPDATE
 	select IMAGE_SECURE_BOOT
 	select IMAGE_DATA_ENCRYPTION
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_SWUPDATE && HAS_SECURE_BOOT && HAS_DISK_ENCRYPTION
 	help
 	  This enables security, encryption, secureboot and swupdate for IEC 6244=
3-4-2.
=20
@@ -283,7 +297,7 @@ config KAS_INCLUDE_EROFS
=20
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_SECURE_BOOT
=20
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
@@ -296,13 +310,13 @@ config KAS_INCLUDE_DELTA_UPDATE
=20
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_DISK_ENCRYPTION
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
=20
 config IMAGE_FULL_ENCRYPTION
 	bool "Encrypt rootfs and data partitions"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_DISK_ENCRYPTION
 	select IMAGE_DATA_ENCRYPTION
 	help
 	  This enables LUKS encryption for all non-boot partitions on first boot.
--=20
2.34.1


