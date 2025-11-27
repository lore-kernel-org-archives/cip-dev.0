Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC842D10375
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 06:38:04 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com (SN4PR2101CU001.outbound.protection.outlook.com [40.93.195.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12806.1764225474835541997
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 22:37:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=Pv9V2hvE;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.93.195.25, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNGxxSmsQSY9+0FxJKzEhi99+HQX2/me76+2iL8AhGKRqNOeW3o9RQFB5Ex7IcgVV/CqdYKlr3B1spQKA8k2IvS8eQCHEt7pCcqrWdMj9xgK3t5ZC+/HilrKw8XCs3nxQFZ0y0rjo5KkIwn2AULGXwRopu1OUH0B8gyKDDnPqLQXm5yMBGhaNexfL95bYCSFdW8g3pmAUwXt8LmzybCEB4fBRbAJAgQRpnCxN4BlbDA8dO2bzng2ICMr6PGH/MGV2Kv8uUjmhXP8WLMfWFdEH3sV6k7ub6H2mmz5DYEGjQcYMEK/7K9uSo5/hCihoXSmmFTCa+P7afLHnW4PgAkd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UIV4HVdeXGpirAbcvFfCBowLprt20MJ9GKKKy/Gqj5o=;
 b=IaS3sDuVPW2oQJiqg4Qt2HS37PzSreb8clA4SWXvRv8qz9TCkAeLDAJCDT/fW9uPUGoUGq6ERGAwHieYJ9j2s/Mxm69CWy2tUIZCI9dKRW8xGhcl6UCEJoLl6XaB6eU9ao/VcP4xH1z8bfNjufeOMpvMunPH1YW1mSH7M8m7ktx49E7RSxeqUz/OAvK5miR+9ZA9iJhaTTN/dOJdv9kkfYG2mJM7pHTBPdLKCvqkRgRoeig5xmA36lp38PB6cAuxr8ChCgrMcJqI0M1Vl3FLKntU9l6S+q/hXNSDKDztKx0+C5Y20K4Ekz7xPWuJ/xwDC7eHZPxGBkCj04DGhEOtsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UIV4HVdeXGpirAbcvFfCBowLprt20MJ9GKKKy/Gqj5o=;
 b=Pv9V2hvE2E5fWoW2cM1oCVheQCD0Aao9eh8CNCDIf6BXu0a+M4NAKVNtXz7WxeLBSlev/4XAK4IRub1ZbKmnM3Qb2X9NTO1m5lrkQ+QVf8/2vTj7b+vxF7TQZLOOF9Mdf7HhtnRkrrPqQzXZ2iw7ULvJs1lnIGrpUiui139c4Co=
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by MW5PR10MB5827.namprd10.prod.outlook.com (2603:10b6:303:19c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Thu, 27 Nov
 2025 06:37:52 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::39) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.4 via Frontend Transport; Thu,
 27 Nov 2025 06:37:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 06:37:50 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 00:37:45 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 00:37:45 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 27 Nov 2025 00:37:45 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AR6bfau2498845;
	Thu, 27 Nov 2025 00:37:44 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
	<vigneshr@ti.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] u-boot-ti-am62px-sk: ti-extra.cfg: Remove redundant configs
Date: Thu, 27 Nov 2025 12:07:38 +0530
Message-ID: <20251127063738.435868-2-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251127063738.435868-1-s-adivi@ti.com>
References: <20251127063738.435868-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3270666c-e5ef-42c2-6ffb-08de2d7f7c80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?EFo6y0paOY0bn9EIRQZby2hskoxABzq7IPl337fQFkzfo5PwMfso0tB8vRyy?=
 =?us-ascii?Q?pNiC0ugw5Hw04v5XFeHHzujUVMW7aXGX0/zXub91YdWC/zp4ddkGPqYb67RD?=
 =?us-ascii?Q?MmwTnrAGMnHDZmTXP5DPMaD4jrEcngDqpXhRIb52BDP/7ya6z5FaxPz/E8YT?=
 =?us-ascii?Q?Tp0+11WAL5+NeQWwZxM51KslyJCT/hjQ4VvIfuFIZ6GkCqFsFvzT5jtvSMko?=
 =?us-ascii?Q?qMtOHAootiYDUsXU3wAklbufFfIfj4iYbIiu+LWaG88pIlgNfB3J2qP/Z0UH?=
 =?us-ascii?Q?yRwQ0fALwF8+6fccimLPJrcclnxE2kI4sMN9KXdpKgOxKlzr7/3ZeUQlSq17?=
 =?us-ascii?Q?TN10yi/pxH82+2ZUBPW9AwOT77Uk1lJwLZhsNOZPWETnSW4NKOBs72P3ghnI?=
 =?us-ascii?Q?SnpGwfWbX6bmkcwxcdmGv5I3xpDRVpFvxVaG+XouUW8yz4INdPGXk2Fst8k4?=
 =?us-ascii?Q?DQxx+L8BiFSPT6rs5SdocMCyULwoh/i5UPDpxmGI7m530zrCefTmjiacAFc1?=
 =?us-ascii?Q?YtooSEN05GnDd5JTxDFkLdHhnh/4IXD0o1jcaEHVBhIEq9R4XDxmaXxOVpmK?=
 =?us-ascii?Q?zauURFezd3WHuh2Mwmrzr1A2QVzrYyNj7WdUwaesTcgLPBBnlqFvSdla8Dxs?=
 =?us-ascii?Q?rEtiPlBwHtHnPvHrrOOSweME0hFBBJp9hocOC4t++hzCP7B0IKK5dB6tXHmL?=
 =?us-ascii?Q?ys5tp4yB4G2+knHeE3TXeYZeUQ0D/cVgt4NrATUcdAQWsl1xHfZl4PXK04iM?=
 =?us-ascii?Q?X6qKB2pGfItD1xS5CgOn2ypTwmQqBmMCZCMhWwXO+6aI/HLGTyeLUP3pJhhK?=
 =?us-ascii?Q?Ek3vhJS6NceGLsApNGd+kXSBGcMr2MGgHy8ZB2JL4JA8swg3X4Bu9e3dfREy?=
 =?us-ascii?Q?oL+wIpY5/+IPVdpcQUIR0X2VHwjyF+XJfKpvQBjQHdvnj/2IHScUVtW4nxLM?=
 =?us-ascii?Q?ZuBmPvXV8tA4LjKXNXJ3WbnXLQ5K5V8K0VuSPYSyX902rRbqKsD+7PTB39xI?=
 =?us-ascii?Q?GkWjUYmgE3PUiq77rHqsJCcsoJugowN97dT/JSKacqifZ+GC8bBJdTzGNQaV?=
 =?us-ascii?Q?G3PNbjDtsj+d8xyngujY21kBEpuB0kAs2lZ5QPm8VnfIRi2e79nqlRIp2wFv?=
 =?us-ascii?Q?63aEsnXnRz1Uclrb0ZI47533NyEuBakpBeQIgDwmqSBAA120cuKIjRAvu7tD?=
 =?us-ascii?Q?Fx//o+wbHzm71/gzfYo1BFRi/461mJvknZQ/2ifTOJ3Dl4/0P/ysNzWVL/cV?=
 =?us-ascii?Q?yqca606EmdPUvYoZOadYLI46T8tUpbNOY8ngLm/e45SliF0uoHpeo9LGa/EP?=
 =?us-ascii?Q?qZdAPtRSDF6HRp6w9XUQj/xVrT9V+mEiOf4yfFnjRudDDEhG1W/MrQMvVjqe?=
 =?us-ascii?Q?jLhuEbZBiEejcIrua7K2JtBciE9o1czq/o10ukRPki2OSk8f9ETiXTQOj7Ts?=
 =?us-ascii?Q?EKaMLpXmtKqWULijCAG74LIiMTxa3/5YLSU6fqWZhNTYhRJBS10KgtfOt10u?=
 =?us-ascii?Q?0X97WuFKjwapa8aansnavp/otsc7v+fkrICwJsfPAsx70LJNW350I2S4dwUj?=
 =?us-ascii?Q?X6S1pINGykII9KePZ8g=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:37:50.5343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3270666c-e5ef-42c2-6ffb-08de2d7f7c80
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 06:38:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20736

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
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


