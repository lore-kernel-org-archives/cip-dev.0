Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48163CD5BB8
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:14:47 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com (BN1PR04CU002.outbound.protection.outlook.com [52.101.56.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20430.1763028883601707809
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:14:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=adPh+Hma;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.56.14, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6CDhq4ikvzPvHSlH6yVpdjkqrZX6JjjJTFvWQ7qkjk6LfDWLgIzukfXwTqdCJ+Qvd0An/i1LM+jinCVPpf2a/0X2BNZloXhRT+qZkGarEKvNVPg8pxlxBthoF7FhFpgnWUehQreiEtGh61Tmla0zcPkw1fbHC4bfHnTKJmIlsjqosJNS6vtKVSigtfddRZo+M2otizKUNoRaSmJUGSYWsIxcRBQAhTtDBgNevEEYsXz6OOKlgJoE0hyoITnzWnNaZcdVn7XlWqFsVNNi4NgL/LWGlFORve9MCRQyK8I9ZF6sTxvpK15FMSx6e/A1JXadXfARdpU0Zl9zR7U3878BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OjfNVYi4RNXMS39zXdYAeQJSOvLD7CwO45EmEYTWxLI=;
 b=vMU/dGqj4pcYOMCwxKS3GGmxGWZGpDNeFp8ROLb3V33P9rWsDxn5p+iYz9im5tCPfKeN51F0st3yq3ouEtmBg0b7oHJQaZQJaI1Gk0lwniLZPLbsBj+jrWMXdsLUSImWo1LNQ/jytGpQUjbyaed1PeO369LlzpHL+blJENIwLqgc1/vkZPbgGPmASSduNHHt0+RIi3wBxnUVjXb4ctiqw5cJjDz+PXc27b1+4IcqanBNDQQ+qaoalYfc64XKTldsxFPSpsUafrOePDt1Tk8J6dkv0n2O0yDVkT9CCVYVs0UkwKiR/EOspIcXZ6ZGQZoHmmdPI2tRFgz/tYR50KGj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjfNVYi4RNXMS39zXdYAeQJSOvLD7CwO45EmEYTWxLI=;
 b=adPh+HmaVNTd0mMU89ubSKYPcRLepkCKNX7L9VUx5KwSdR/IM2byxCScPe8nJRGLs89mN8e0RdRftpojggqhO/MblMZRq8oa7YbTpVBIazp7qJMvg26Xj4DiCKgVXM4TWKgttUwPTFe98BDKN/oxZm+MIuqvui9NWXIPHzIQ5o4=
Received: from CH0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:610:b3::10)
 by BN0PR10MB5112.namprd10.prod.outlook.com (2603:10b6:408:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:14:41 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::58) by CH0PR03CA0035.outlook.office365.com
 (2603:10b6:610:b3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:14:41 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:35 -0600
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:35 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 04:14:35 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADAES1S058943;
	Thu, 13 Nov 2025 04:14:33 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 3/5] Kconfig: Improve modeling of Security features availability
Date: Thu, 13 Nov 2025 15:44:23 +0530
Message-ID: <20251113101425.1177129-4-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113101425.1177129-1-s-adivi@ti.com>
References: <20251113101425.1177129-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|BN0PR10MB5112:EE_
X-MS-Office365-Filtering-Correlation-Id: 02250bff-beba-476a-44fe-08de229d75af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VYy5lyUUek1rSev0FtKW5AuOfPFhFWuPWG4e3FCWN1UfnybpbpFONjL/1v6a?=
 =?us-ascii?Q?4qqRaPjDDMKsofUWUAfrg9aIhAzZ7gLQDPayFOA+q4p6hFyRs9Wy5xKjsAEg?=
 =?us-ascii?Q?0LnBzThnHBA3V4IGgSz+c9GirpoInc/LOE52HNw0TgYL/8tgPHhDpPJ4gNXI?=
 =?us-ascii?Q?3PIRkE7RwKkvEWScaUF3HtalsQeE0G6ENXNqgR4rsQAS/pewqKTn6eu7bKvD?=
 =?us-ascii?Q?moXUIRmNxI86kCYhZeQg28RjkTA+nFekcVoxm+QYh8XhKPrePFluZS1r2lzI?=
 =?us-ascii?Q?uLNs4qKHt+y7A0bNXOWaQYyImBS/8ouQdv/Y6lHo8H91TLtXX/NeLfv9hKYV?=
 =?us-ascii?Q?40N4/M6jRsCDs91hhVfaR/1cAqVy3v2ANWN79Fx9+oZUdOHctjTA5J++Q0c9?=
 =?us-ascii?Q?QdjQyOMJgn/EYrut+UkBmRCmwMM/z4fHu5ygxD5oCmd1shfFOvPmIOQWTVwy?=
 =?us-ascii?Q?ja4aMtXd5Hwhaqtj49AoRseCVCuTAUHqsAPIYTfHBu5c4/G86aGuNIp0CnX8?=
 =?us-ascii?Q?k/Y0XjOkSZ3HDznfMhXiWla/hVv0rvSMTyyCRrGpbc+OZqMUGH9dUhy6eveS?=
 =?us-ascii?Q?e4gDSpiHEGnqq21BV8yMNVhxqO502hfOpnHh1QmC53tbLdlhG+mhCql2p39c?=
 =?us-ascii?Q?iXTn/LXFOWBJLJKQaQMkT/y+c6Bwm9CcsuT1uQyyOAsv2NYh61VY9BnEjm8P?=
 =?us-ascii?Q?7kzD2G9mELuI1xXsaVNRrC/70SfivccJGyvjAsJ16vgn8ggkLjhY+eNO+LLb?=
 =?us-ascii?Q?+xOtRPLlnmjulBXQcrmUaWeZfOAfXNKn5j6eELv0lfsoAmjtd+w1obKihvfs?=
 =?us-ascii?Q?k1Jr/Kd01Jrp+KavIwin8pRPCnNfaEcI5wR5DqOYjXMBvQvJENVN+uD9Sf4O?=
 =?us-ascii?Q?yLzLpcs9pWwRST0cnESudHeMPrEScV+0EEoVrG8v0d27peXjsUJcDNFZMkcU?=
 =?us-ascii?Q?0VolzOg9qzjGSEKpzW+9zHJSXtjdTS/mVCoiNlFsHjKj/3iB7kl5SJTJZYGk?=
 =?us-ascii?Q?kLgsUPexbJjQtU9KGY6lzdP2+lpA0mrrg2z2KYXSkHUGsRpTFXOw7B77irze?=
 =?us-ascii?Q?U7gWrKZvqgYX1Ch3y0zOz4TuvESETSSI3rl9imdRNII6bUsMVEsxQ8AcGHo0?=
 =?us-ascii?Q?7S74ZC2EtvvuIhsvgXqB69PMw73Oz6GBoxbYGmU+LPNIlTMibLq2AxQg7P4R?=
 =?us-ascii?Q?CsS+Mu8R06kLxiOo8wQe5/4P25cwG1/5Ihl/8d3CeKjDA3mxBlT20NrIt6d8?=
 =?us-ascii?Q?KhppxX7/uNUcguNPoa3AQyLJnEJIbfokdlFwEAZCK+VIw4WtvJCRXNfYnhHI?=
 =?us-ascii?Q?9LU81qXEdS/V2ITGPRF/mkE3a6bJWtGpH4WNlu3iRcMIkJ1QvKvj97vAUn55?=
 =?us-ascii?Q?JUQHbI5T3iZ47clhbQCs1z4WgJMuWouTHSmzO9Wli/8lhLsUn0M6HOw734K1?=
 =?us-ascii?Q?vhJ2dQGtv52QXKt18DBK6BlL8FQwfYNGOBozIKqzAxf8lbVDX8IBjk6EV0RC?=
 =?us-ascii?Q?Csr8dV4yCYjexxEbL9Gm+RvzeTO/yKOKZSkVxItlDnNeLCpRRH7r75v9dIMb?=
 =?us-ascii?Q?4uAbLxzlbaGYRgFrE/o=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:14:41.2409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02250bff-beba-476a-44fe-08de229d75af
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5112
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20525

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


