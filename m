Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E3BCCFA1E
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:45:40 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com (CH4PR04CU002.outbound.protection.outlook.com [40.107.201.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22076.1762879536275703238
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 08:45:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=aciMrZar;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.201.62, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYG5XiDrfkY0aqC3xAwEBYRAQaYeeMAgHx+qlrc1l0yVVDDr91+o+0e4vR0uR7e3/ZeS1hIxAgwXH0rntoQyEivH81C+Se21ZKipTCNLz1XIFffkbzSx0GqCY9E3FGe9C07iMi+pv7sE9t4rQBVWUw3Uak80ae+Yg65QYi34i/jUvFV3lk4ZCgQEj08vWo+884uo+yre2VV4ccQyX1okSfgoeaEdceHMjheKIA/7W+76ADaKaFd8WViLfMfEk5ZdMpHdw6La/XTPOZdEx5JYF/LiXB1EUdNK2UjTJKanrGFA4vyQfDOot2gUKk0aAxPnGEHO+4aq0QdUxc7HG4BZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZwPhA0XXpY9VOwt4kuFTVCL8fHFzyaj9vmGrcA8+aY=;
 b=Rr6EyHNo7mfdetje6YStp8wPGkA+kaedh7+KoXP7TpEtITZdJigQ0pLvr2wZnLumrbYQ/HapY4Mg2CeIrSN3E/M7mNxwnNRGXh5EiwPwY93PbDr0BfhbZrY8S0eGXT0wMiyGWUdD5a+uRt3JHyUte3duI9w995nnpVs9rix0s9luyPnUVdKuVTHGyVG296zBc7aeriUjNBDcwO49Mo5NeVokNnbKj3ekj9l2Vtd/4gwUJ5vLGY7+LCFdtvYbtNEINcOPfwgA6J9o7rj2augQcVT4WErF/ONvnB+LIV+VJ1oaLFbY8Dc5OMs9daZnDKLkqRPw0KNqrjrfEVOIIuGgaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZwPhA0XXpY9VOwt4kuFTVCL8fHFzyaj9vmGrcA8+aY=;
 b=aciMrZarMKx54WeH3hVGAshODp0MQlDPzxvArRaYKlsDb8ol5QUR6DL1nh/HNG04FQVeVP8HJgEmLB1XbzFlNCPJm2v0gfruslN+6DHYSHdOh8jQxX0CjOMxHmZt+yJHmoXN1oHuX7Cw3JTCw9rwkQnSkuDamGp7epgCfkeEoaM=
Received: from BL1P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::13)
 by SN7PR10MB6361.namprd10.prod.outlook.com (2603:10b6:806:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:45:32 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::e6) by BL1P221CA0025.outlook.office365.com
 (2603:10b6:208:2c5::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 16:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:45:30 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:25 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:45:25 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGjH9F1255613;
	Tue, 11 Nov 2025 10:45:24 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 3/5] Kconfig: Improve modeling of Security features availability
Date: Tue, 11 Nov 2025 22:15:06 +0530
Message-ID: <20251111164508.1707234-4-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111164508.1707234-1-s-adivi@ti.com>
References: <20251111164508.1707234-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|SN7PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b6d41e-03db-4da0-f945-08de2141b9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yuY/5UqqEQBRhzp3Llt4RMLWx0lqB9Q8soWPBdmvLw+hKuzTsK4D1IbSmBi3?=
 =?us-ascii?Q?+uhJVHg6LQNFV2V/mQtMbaLNbJYp1qgISlwaykea2dCoT9i2hk48hSXfbdC8?=
 =?us-ascii?Q?ZVk2Q75zSC6PT4tKMKgCiWB1vBsOFy0AqMr6oqvvHVyCjk2tfdM5MRldynit?=
 =?us-ascii?Q?mp/rsq9P8XDn+o2QH3sJShCLUOMwx38vdcbNv129c+vFioTqlNj/69oodxBE?=
 =?us-ascii?Q?kkbLKV9z3POZSVAriMTUXWtovi7TfxKjrSeK6NLitYf98dPrBukWhCnvxJN9?=
 =?us-ascii?Q?Vx+hxgTMzOw+LbnrqmmQNm8v3CN4m/j/h1Nf+KlVGfvOu+KkocL2jzF/1Zz5?=
 =?us-ascii?Q?Cz5McBSrR/gPLoRZ5zRjaRoYvXOH9CAr6T/McIz6r18oSappSNdkfDsvD+jo?=
 =?us-ascii?Q?9rafItBSE02dBuZJomdYzXqdZdTF6R8c2DIjbUlosnzXF/Ecs1M+PzPSj03q?=
 =?us-ascii?Q?vvUvPsjzRYhBzPj0kSvD6U1mYKT2yLqoWz9KP6ydW2SxClUW2TZ0I7J29xpM?=
 =?us-ascii?Q?El2u5BxudgDRAX0nND5oE4R1iTsAS5G6KJezxzB3cPtCSyjYKH07UPC9+63r?=
 =?us-ascii?Q?cKic+4FURDfmmwaP4IJHv94vPnlllHjRE4kEI0/7zIHAMKM7S+NDD9s18X7D?=
 =?us-ascii?Q?bNOW/lG7JVHn6xRq2iSVl4dDkc5mQOH3aw/0OhuppD7ky7kAH5f6gd4DIfXQ?=
 =?us-ascii?Q?PfJ8481zZlxxhgIrMpTaY5Nn5tA0drPbLcL1ysMkFNYbIQcJaPLwjbisuqOw?=
 =?us-ascii?Q?BLIvosdAVzBplLQK6bFNFwrg7zWMxuzn2KWJJhKUBDfNakyz+8yM4aQM8Iud?=
 =?us-ascii?Q?6ooy8Gp5uQ+AgpiTTB3iQlGewRDxne1AN6GqS9VQzuISKjrjbF9eh+ub0wW0?=
 =?us-ascii?Q?NnKlTSu2xuiQ/HncNrIuXrblGv8fzoacbSS07ltSEOc4J3w+sMAJKh2YVTUk?=
 =?us-ascii?Q?UUN/MSapz4++iaeoU4QKKbN5p/RjHvnfI3aZU02wl2tmw5ZV0I3qF/sBIbg+?=
 =?us-ascii?Q?cQldntfJlNMNTIHsO71htqQhmuISBfGeSS+pzqRsp1czmlmAU2RUTM7If5op?=
 =?us-ascii?Q?bZTAL0zsKbM2+bDuAPOrVFHEb4TkntMLLRjZ83qGT/i7Ka6v554SVmopYQsC?=
 =?us-ascii?Q?+jnM7QvwlntRva8hB0ldagZuGpdizFHU8PSehQz8ZOFJkk2tFC1R7hyhJa+I?=
 =?us-ascii?Q?sLTWUOg5kUCThohezoy9BAbYdbpiMSDTRQTZPX2W7t7uRw4r/jwQAGMCLbOh?=
 =?us-ascii?Q?G6TZAAbtSlYxdfRJIdwRCf3y8o65HOEW1AfLE4CHWcHugPucoGeyPKnw72ux?=
 =?us-ascii?Q?K5Nc6cKBZSOjK7G1qzlatg2XG/F4+gNFMhMsVCjhpfib5r5fbc5NtUYAN9HQ?=
 =?us-ascii?Q?yQKvvofzipuhy590bvuPBS+CIgcOuRn/bkVHyGihj/0ffaHvqZuGSVwvNN8q?=
 =?us-ascii?Q?rqOg8ZJa+QBZauZFSHv/DRljAsm2lX9VckYi05MCw1EdmOsrh3yhmE/2GNOF?=
 =?us-ascii?Q?UjpkwDqV5GBWU2Y3XFZoKDAq+v1xsGRx8yt8wmlzpG68H2g22VlIO9TOXBTh?=
 =?us-ascii?Q?4/iL0e/sK/IHPRNEkjw=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:45:30.9681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b6d41e-03db-4da0-f945-08de2141b9ff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6361
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 16:45:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20499

Model SECURE_BOOT, DATA_ENCRYPTION & FULL_ENCRYPTION via bools that the
targets can select just like SWUpdate.

Also update the IMAGE_SECURITY to depend on these selected bools instead
of targets.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/Kconfig b/Kconfig
index a6af745..adacf6a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -40,6 +40,15 @@ config HAS_EFIVARS
 config HAS_OPTEE
 	bool
=20
+config HAS_SECURE_BOOT
+	bool
+
+config HAS_DATA_ENCRYPTION
+	bool
+
+config HAS_FULL_ENCRYPTION
+	bool
+
 choice
 	prompt "Target board"
 	default TARGET_QEMU_AMD64
@@ -49,18 +58,28 @@ config TARGET_QEMU_AMD64
 	select ARCH_AMD64
 	select HAS_SWUPDATE
 	select HAS_EFIVARS
+	select HAS_SECURE_BOOT
+	select HAS_DATA_ENCRYPTION
+	select HAS_FULL_ENCRYPTION
=20
 config TARGET_X86_UEFI
 	bool "Generic x86 machine booting via UEFI"
 	select ARCH_AMD64
 	select HAS_SWUPDATE
 	select HAS_EFIVARS
+	select HAS_SECURE_BOOT
+	select HAS_DATA_ENCRYPTION
+	select HAS_FULL_ENCRYPTION
+
=20
 config TARGET_QEMU_ARM64
 	bool "QEMU ARM64 (aarch64)"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
 	select HAS_OPTEE if KERNEL_6_12
+	select HAS_SECURE_BOOT
+	select HAS_DATA_ENCRYPTION
+	select HAS_FULL_ENCRYPTION
=20
 config TARGET_HIHOPE_RZG2M
 	bool "HopeRun HiHope-RZ/G2M"
@@ -71,6 +90,9 @@ config TARGET_QEMU_ARM
 	bool "QEMU ARM (armhf)"
 	select ARCH_ARM
 	select HAS_SWUPDATE
+	select HAS_SECURE_BOOT
+	select HAS_DATA_ENCRYPTION
+	select HAS_FULL_ENCRYPTION
=20
 config TARGET_BBB
 	bool "BeagleBone Black"
@@ -238,7 +260,7 @@ config IMAGE_SECURITY
 	select IMAGE_SWUPDATE
 	select IMAGE_SECURE_BOOT
 	select IMAGE_DATA_ENCRYPTION
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_SWUPDATE && HAS_SECURE_BOOT && HAS_DATA_ENCRYPTION
 	help
 	  This enables security, encryption, secureboot and swupdate for IEC 6244=
3-4-2.
=20
@@ -281,7 +303,7 @@ config KAS_INCLUDE_EROFS
=20
 config IMAGE_SECURE_BOOT
 	bool "Secure boot support"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_SECURE_BOOT
=20
 config KAS_INCLUDE_SWUPDATE_SECBOOT
 	string
@@ -294,13 +316,13 @@ config KAS_INCLUDE_DELTA_UPDATE
=20
 config IMAGE_DATA_ENCRYPTION
 	bool "Encrypt data partitions on first boot"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_DATA_ENCRYPTION
 	help
 	  This enables LUKS encryption for the partitions /var and /home.
=20
 config IMAGE_FULL_ENCRYPTION
 	bool "Encrypt rootfs and data partitions"
-	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || T=
ARGET_X86_UEFI
+	depends on HAS_FULL_ENCRYPTION
 	select IMAGE_DATA_ENCRYPTION
 	help
 	  This enables LUKS encryption for all non-boot partitions on first boot.
--=20
2.34.1


