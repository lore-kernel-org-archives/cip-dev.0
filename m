Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A18ACFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 07:42:28 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com (CY7PR03CU001.outbound.protection.outlook.com [40.93.198.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2708.1764661341593097262
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 23:42:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=TShvF+3X;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.93.198.53, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHF2rGOBgejpzMhFeNGg+ugOv3ZyrV72ztKQBhWFPv0YGmtjvTRlOM594qBi/95+MYpeZMeF5DKPg4H79OGMqjXdD7r8v/LO+MJlW/UYMrMm+4WLE9bhpdIxQgJeyxaRq7PlYzdkdApHcdp6gxeBeARFaRWz3zu07oosLl/VxiQ4XEDFzQHBkpvIXNhvUX2sndxZ3rIYsYubCfIB3n/adZp9UnOefslviwXiCRC6dMx5zwA4ia1GegsRZgWeB+PQfu61BFiIVg+kEuiax2uE8J7KJFCa1v0AuhYzrSbMsJTCehUP/bPYnQr26bnyNvkQzGYvJsy6woNI5pFJq4qQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U8FVsC3uifXDPXrtQOsKE7CtYeVfndwnDVN7O6ODCek=;
 b=SW2fAJaufrSEHELAHVBm0BgYf3a090sFXtBvgjBuLc8J9oaWSVufhyhmCCWZjbpKpJhCQav6aWVcbLXZ7z0aAHJz8huEbeiM4jw5dmpu6WRLwxszXABuv6ir/dCTyzrun3RaiXpDZEhzmTLI0rCpji7xmbs8eGB/7U8crTm+Ygf8kmcFnwto5akakLTwLT0wE8kf54BHCNIjito5jcoUz/q7inVC5l2TrIq9wm+DN0ptd8FPcYrCAXq0ozd5E9Engr79pXKIhdchN0fiBnPHqJTW7zmhyO4bKhMNoJuqWSxpkzOXQLy2SSp84fd+W2to4Qlt16TIoMYN1drQfQytdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U8FVsC3uifXDPXrtQOsKE7CtYeVfndwnDVN7O6ODCek=;
 b=TShvF+3XALVvn6k5FyasTUjU5FhJeXRhz91iV2zPM7bMcLgUq1dUcoLEk/k3PRdQ4HAQSZ0djHX16sx12r2rXD/k10CriVDyQjxn8aUPlVs3OZfSkOC2mhjPd9/ag/uCiTeHh5Bb37N5Ll5ddI7fgalGCFfzOEP5f0g6ThnJqYc=
Received: from BL1PR13CA0260.namprd13.prod.outlook.com (2603:10b6:208:2ba::25)
 by DS0PR10MB8079.namprd10.prod.outlook.com (2603:10b6:8:1f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 07:42:15 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:208:2ba:cafe::85) by BL1PR13CA0260.outlook.office365.com
 (2603:10b6:208:2ba::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Tue, 2
 Dec 2025 07:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Tue, 2 Dec 2025 07:42:12 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 01:42:09 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 2 Dec
 2025 01:42:08 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 2 Dec 2025 01:42:09 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B27g7nl1854266;
	Tue, 2 Dec 2025 01:42:07 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
	<vigneshr@ti.com>
Subject: [cip-dev][isar-cip-core][PATCH v2] u-boot-ti-am62px-sk: ti-extra.cfg: Remove redundant configs
Date: Tue, 2 Dec 2025 13:11:59 +0530
Message-ID: <20251202074159.480744-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|DS0PR10MB8079:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b860ad-43ac-420b-a7a2-08de31764ec1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?40UpHLoawqHmREgoXx0vkTWikqGyrSuf4xvPPybOUkGPvke1O2YDxY1ZdC7E?=
 =?us-ascii?Q?TPVDBz1ZzHh9vKVoYJiyH/l5I9QDamrM9vPPDo11xWBxUYu6qmAqHvZlNpCS?=
 =?us-ascii?Q?dRWZx1Kx2tsbs88uqTLn43iY7YRxgVLGSA1tGsSx8q8vtKvFPM55q38IcqfA?=
 =?us-ascii?Q?gbCnAultyiW++7/gzwDAA/m0YDeq6Q+Xe89FA9jgfoKFd6TBDQFm7hNTNyeb?=
 =?us-ascii?Q?tJ24sWg/GTHhvaAStgU+r95kDT/LubJQvQyQK9ajo1+VM4eW7mFDjjmhdMla?=
 =?us-ascii?Q?pxBfdG1381Wd++Lil/nxVLMBjykvl7pPhZzTDJZe5fNvwCDaMq149GfSlDKS?=
 =?us-ascii?Q?4HKZAhVLeb0h3Fl4QmoXMEkguIDMZl40YPhhEoiCkzQqgqGwKqw3hQb3B/jo?=
 =?us-ascii?Q?qwUTURVSAaq9YWANzIm3lSnyY9kk1BGX6bqsW+x/9Pv1fuCt2FmoILI3Um2+?=
 =?us-ascii?Q?MDKew7E0KmRvYEEUf6Uq1ND/g/IkMv3CZCd5ocXWPML0GO8an0ifVN954qgM?=
 =?us-ascii?Q?0VH2oD6qCMYEXB/xibv8nd/4sYD4Q7cDHLHbywMCE+zk4ZByYxChfcAaUKs0?=
 =?us-ascii?Q?63S/8SDkWzs9eGNX/nXpRXCKSALe8ZtTciOzELrDS0fV6sOFI4HQym+Jm4lE?=
 =?us-ascii?Q?UEWpbP6ep6R0oYeLCmzsJ3OfL4GhTyHTRVoGn6e7fGxpZn7zei7pciQsdNRv?=
 =?us-ascii?Q?cTustUISMDo2bAOB/voQCd3QDQdmNHo/Bb6N9YukEw0dCLRoIBCSK8YxjcHg?=
 =?us-ascii?Q?aMNa48l0uYVeZFwu2KJPToUkcdlz153ap2tNLWs7mIZGiyayxEN58nZTmb0r?=
 =?us-ascii?Q?5qWIiWVY3MHvZcbMagVcBeHPJAX6PF9u6tgL2eRbZ3kSTNOOaYH9ASXmIGLU?=
 =?us-ascii?Q?JikEiWVoll2VrLebDCgcPUkts10/hy4cWm5D95XzWWANWprn7wQQzWDWNAAw?=
 =?us-ascii?Q?3iH9I4owigNCWmUqs9mo3VuwnB2xwfiMWTfugH9G4oeMPYkPInd6+RkdqhML?=
 =?us-ascii?Q?YvSZ/5z82nevdBci42oddtEW4RtmLR/r0PlA7RUkiH4LoyuCys+aX5zjWCI0?=
 =?us-ascii?Q?A/FFdOQHG4rt78sD9TfjsQ9z4RFMClzfKhyhCydq+5nsKmpsmpKgI5KTnlrr?=
 =?us-ascii?Q?YbZ/GQ3NxDXYgU3Rijh1NP583nJWq9a8m4iPCt6bBCkZul2f+bgtxas8wwPp?=
 =?us-ascii?Q?KqJD21n5AHEZN5ZOCSmjzgq/Gt+m003/Y4sdcsSrIOPPilCfIzG88vWzkdGS?=
 =?us-ascii?Q?+HbTX9hpuSKtBCuN6TO5O7jR4z40jUo2dWEdse6Zy4UZTR66UwsQQkJh+MyD?=
 =?us-ascii?Q?gVC5Aq8ubU54qWJ6xPBdp12ocEp/LHmt3+/+oBCy68LcFCpnSCezpwMccorD?=
 =?us-ascii?Q?Wq1NwqZZjwcR7eKthSI4D4hEJ13WoXAAbITkJGVlc/YZGJXdfoiKH+/IsQbJ?=
 =?us-ascii?Q?uwVgw6jGI9CtfQU6SwsCAuWeMiwUMnr179z7Be/1xSjOmwrT5BYe7TlXtK5a?=
 =?us-ascii?Q?aZJzhkQBgMGX3sCexTyBW01y2U0VzS7hP9WV?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:42:12.9186
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b860ad-43ac-420b-a7a2-08de31764ec1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8079
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 07:42:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20786

TEE, OPTEE, CMD_OPTEE_RPMB and EFI_MM_COMM_TEE are enabled in
ftpm-stmm.cfg and it is always included for TI AM62Px builds. So remove
it from ti-extra.cfg.

The BOOTCOMMAND is stale which was initially used for testing purposes.
pairing with RPMB is not recommended in production environments and also
CFG_RPMB_WRITE_KEY=3Dy is not set so this doesn't get triggered. Remove
it.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
Changes in v2:
- Write detailed commit msg
Link to v1: https://lore.kernel.org/cip-dev/20251127063738.435868-2-s-adivi=
@ti.com/#t

 recipes-bsp/u-boot/files/ti-extra.cfg | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/recipes-bsp/u-boot/files/ti-extra.cfg b/recipes-bsp/u-boot/fil=
es/ti-extra.cfg
index faff390..c10d046 100644
--- a/recipes-bsp/u-boot/files/ti-extra.cfg
+++ b/recipes-bsp/u-boot/files/ti-extra.cfg
@@ -1,19 +1,14 @@
 ### FTPM + RPMB + StandaloneMM setup
-CONFIG_TEE=3Dy
-CONFIG_OPTEE=3Dy
 CONFIG_OPTEE_SERVICE_DISCOVERY=3Dy
 CONFIG_TPM=3Dy
 CONFIG_TPM_V2=3Dy
 CONFIG_CMD_TPM=3Dy
 CONFIG_TPM2_FTPM_TEE=3Dy
-CONFIG_CMD_OPTEE_RPMB=3Dy
 CONFIG_SUPPORT_EMMC_RPMB=3Dy
-CONFIG_EFI_MM_COMM_TEE=3Dy
 CONFIG_MEASURED_BOOT=3Dy
 CONFIG_CMD_NVEDIT_EFI=3Dy
 CONFIG_CMD_MMC_RPMB=3Dy
 CONFIG_EFI_TCG2_PROTOCOL=3Dn
-CONFIG_BOOTCOMMAND=3D"setenv pair_rpmb_key 'setenv -e -nv -bs -rt pairing =
1; setenv -e pairing'; run pair_rpmb_key; bootefi bootmgr"
=20
 # workaround for v2025.07
 CONFIG_USB_STORAGE=3Dy
--=20
2.34.1


