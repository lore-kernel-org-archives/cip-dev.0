Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B7BCD5BB9
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:14:57 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20435.1763028889675729315
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:14:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=nrl8Z2Rj;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.200.0, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO8ROax3bDAP+9KMGsx/sQb9W2aKF4HRW8Mrqly05OWPEr8eGwTi67jo2YT1GcG6lShGj5c7cQIEx1nmOTc7ASXSFT/gU4jwY5IP+JgT8oH+b87/Jx2jFh7Fnx6gzi0WQNWciLDlANf3UibLuId6AcHCOQCKjijds7qfVeW9hkeSOVZUIUBMKR/eb3D3x78SXLYjPX1Y8A6wZQfgY3CtiguY2SBpQHnLcWzAOUSUzwXZQht86QuoXDuun2xVstOEOEhTMHcWcLWo5y28UPJ+GPfRxxDa3zd3vsiiA5vvHHxR3/cBqTaf/dneuHTAn8+STGxENuOs21TEx/m+IJw+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zfoauEJH5T8kRpnwIgIpX5/4gmKcyhLZXYz8ae0afts=;
 b=xtPTVaLSzvJ7rX2E8ivkOcLZCjX1MI/OjJgxCRwccdaPtFqw3MhPmcx8fg4WkwTIHZ1YgCJfmZopGykS6rB8yfoTJAdFWaQL/R4+SwuRS3uBHXLMjuVFBxQ7+/CXPm4gwCXka7QMr3qpVj1u0Tep3pdNm8o2zNzV3+CH4nNt1hQmsVkNdm0NpAwcynnqPwAoiuVhZP0vYQl1CBtOr4pMoo4HYNznyQuIrl11uPixxsVJBcjITBHWbLZ+eMNkQv6YKoZmyrHdbl0q0jeNgM5do7JZG4yUd3cKy0x6d5lW01w0WnqTntQG4sqhfj+aUF7VNGfBU3uMgrmp+Ga0ztFQsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zfoauEJH5T8kRpnwIgIpX5/4gmKcyhLZXYz8ae0afts=;
 b=nrl8Z2Rj5124V5SO9B/kzOL9jX7bBQLKENQNnFAaNSh13hw458I16w+dICq651QbMKz/m7uzI7onip66ABPpGYpksxBedLjwSy1zGEMUToolrYuAygnSVQde17dp554fzKhEsrbfbQhcMbbURTpY9IeeoLe+ML3HjV7Ie62TRsM=
Received: from MN0PR02CA0014.namprd02.prod.outlook.com (2603:10b6:208:530::19)
 by MW6PR10MB7615.namprd10.prod.outlook.com (2603:10b6:303:23f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 10:14:46 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::ba) by MN0PR02CA0014.outlook.office365.com
 (2603:10b6:208:530::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:14:43 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:36 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 04:14:36 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADAES1T058943;
	Thu, 13 Nov 2025 04:14:35 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 4/5] ti-am62px-sk: Add support for secureboot
Date: Thu, 13 Nov 2025 15:44:24 +0530
Message-ID: <20251113101425.1177129-5-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113101425.1177129-1-s-adivi@ti.com>
References: <20251113101425.1177129-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|MW6PR10MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e85a4bc-be80-4c8e-581d-08de229d774d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?REmge2lRvAX3ot0woeWNmjD5ik3ACjCPRsA59S5JetFGQC5np8rEddh1N6zJ?=
 =?us-ascii?Q?VMDjot4rhAJ6OUi6C27qRszaLW6cBiHI2dXy/oe5rGfnGcnvRWuYIwUESUHK?=
 =?us-ascii?Q?oCTd4iB1B5a4x6aKRsJUMQYIRdCR8l+TF+XP2JOa8cz31U3lI+sYxTcl130C?=
 =?us-ascii?Q?JwaOZNx66crZ2QUYAzIpPtO72sJ4HsqRVIWEb3pO8hLmL8hJoLywdM6zJqNi?=
 =?us-ascii?Q?PTJk4CY5b/Jto8wI4XkvapAPdod3qi40RJO5WOkLlhMR4rOes5QY0/Ols2HF?=
 =?us-ascii?Q?w3s89tX8/zYIXX0eyhNgcpYSKtDKCOREYgz/CGwI8QdFWtGQyBHrhcp7Ln8y?=
 =?us-ascii?Q?xe2kCDJ59BCBwVMalIMW0iwcKz4Ps2ZezCjKIV2JbrTkpKj3zCZ+0hTKUaHb?=
 =?us-ascii?Q?1D2RqKbLdc4YDSc1OuNe5t87eCGhM6xstBgiZBdawdQF4BpNPnAPIn0JugAm?=
 =?us-ascii?Q?SUenXu5MTvlyg6exchFlNGQxmkOnev4HsXjL11NnqcVa10/3Bt+k57rqv93k?=
 =?us-ascii?Q?mASbLWUlET+0J7GdLNOZiEVsMH4KOEUL6JLEpzTbrroLMm8T8f+WRUPvktyH?=
 =?us-ascii?Q?ybSbK2frH/mBe9+/aM/kj5C28wO8ylEMM+zStlvQeLJWGNuMO0J5S1m2O1M3?=
 =?us-ascii?Q?6UiTDqqInMCLJD7UpfZQ64zvuWOzvXwBe+OhunqPdtcz5V/OtRDdF3WyW/86?=
 =?us-ascii?Q?tN2H/LSwLba/YZeThNj3LxXwW7JbVG1Xie1Fo8IggRnWRJOdEM9RTcwRHtT1?=
 =?us-ascii?Q?sq+Teqyx+piEga1Z1EdrdwOejSzHGQon6++iko4CzU7fqCWfdD6grEmYVwQM?=
 =?us-ascii?Q?OZs7lrxpcNlJFWcNoyGd4DiVKx68i5niC2vlJvu1TfinU3yHWoTUeaCMYzI+?=
 =?us-ascii?Q?ZnE+tyL+KKS9xzYRHmNkNDo9ivbJGQgdYYGJDh8wKC7ScuKH1QZMqLKKt02W?=
 =?us-ascii?Q?F8gRHjCsb42i/6Jjy4vlz1jLJII8Kopr3eI35pxxLrR7uTUsjT5QVWlyNyOT?=
 =?us-ascii?Q?BdXpJF04YJUiM8vQ3hTyii6EW1ykTKZGiQ8KsbR93lbPlfOlHgX+hLOXTr4g?=
 =?us-ascii?Q?4+/lKh19ug1Rdhm7cyeLnWQsk0p0eossMqM3E6hhAgfu1Dilc++VxfEr1uLc?=
 =?us-ascii?Q?W84c1/QR4/Yw+dibB8qq/S/9PVFbxBsNqoYSHpqimgK+06j/PGLSvZmG8Td8?=
 =?us-ascii?Q?e06uMJSLbdLDCmoXSExc8U+cSwJ4Kn+tGCMtHocgEKirzCyIdOLp94cLQauP?=
 =?us-ascii?Q?/origarOIhZUOxjpvnh3OyDB1paXB0EdfBZGBOtozSUuGP2+f+CsKVr+PkuU?=
 =?us-ascii?Q?ziZ3OuH2XaVOYagamP+gg8OH8Zwb5CMgVCJ7sRVNZIdIvJduQam5luedJMS4?=
 =?us-ascii?Q?EHAsLksZmToPm837ZfR3f8MkH9sRDxhhL//jGtsxXYeedylrs7qJ/bwbYhNB?=
 =?us-ascii?Q?cEQB5MhQM/J1FgSLeRPEACfVIYVW2Ugwhq9uEOlxkNbDXW2v01rcPfFrXqdH?=
 =?us-ascii?Q?/tJEmx58Snu0OxLTIUsviNlmWp1qxkra+vdCVi6g/i19QTC72DNMWt6YvvtV?=
 =?us-ascii?Q?FeWi3F4Wco/U8K8t3B0=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:14:43.8788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e85a4bc-be80-4c8e-581d-08de229d774d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:14:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20527

- Add wks file for use with secureboot
- Update Kconfig to enable secureboot

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  1 +
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in

diff --git a/Kconfig b/Kconfig
index d322a94..c02ac94 100644
--- a/Kconfig
+++ b/Kconfig
@@ -104,6 +104,7 @@ config TARGET_TI_AM62PX_SK
 	bool "Texas Instruments AM62Px SK"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
+	select HAS_SECURE_BOOT
=20
 endchoice
=20
diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62p=
x-sk-efibootguard-secureboot.wks.in
new file mode 100644
index 0000000..52fcb09
--- /dev/null
+++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
@@ -0,0 +1,23 @@
+#
+# Copyright (c) Texas Instruments Incorporated, 2025
+#
+# Authors:
+#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+# Boot partition containing Bootloader binaries
+part /boot/firmware --source bootimg-partition --fstype=3Dvfat --label fir=
mware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 =
--use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
+
+include ebg-signed-sysparts.inc
+
+# ABROOTFS partitions
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.verity" --a=
lign 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC6=
3DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name system=
b
+
+# var and optional home are extra partitions
+part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 512M --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4=
261fa32d9
+${WIC_HOME_PARTITION}
+
+bootloader --ptable gpt --source hybrid-boot --timeout=3D0 --append "rootw=
ait rw console=3DttyS2,115200n8"
--=20
2.34.1


