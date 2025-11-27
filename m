Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3403D10375
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 06:37:54 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com (CY3PR05CU001.outbound.protection.outlook.com [40.93.201.16])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12804.1764225472592824840
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Nov 2025 22:37:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=B5LVgvV3;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.93.201.16, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLSsgv2HHcHJG/7u7gARo08e+iiPgNdOu4QaY97q/V7Gc5IKKD6aXmxXbSK6aeEkmyF0il7ucTBbrHmkpPOfhhrMUl7UgwBXP7L9oxJvxR0aqsgXRW+96mYYtppxW6dg4M321YyG/hlp49y8sw+SJrerx4u9qMDhCV5TiWbCnP+wg44nuyCAfj3kknAwjoDvslzt3qMC+Zc+ov/x/oSU0+ltGGw/thjN6G+8Mudj/tOaA32VSmfRK8uP4DPGTq2MFoU0TL4y9Qgff9BZEpJ4pmuXpKiGiZbOIrSkDNQ/T7Cnra3BWMt38JYWieUivzoagnW1HXkZmwgZ0lCJ7cTCSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdEKkEb0TgbWCZguYZYbG2s5rLbbbz/PNpnxi9Ke2+M=;
 b=QtnTT109euw4ewzUhUvcziDU6ptbhiLMmHOPajHO52LWVNIeMS4f87tPmThVBzQW533ITL6jlWDsrcIM2+sH//OqjXMsVg1yyZSUXDRsYfkMXkfmuqVP9R6XzvRgroAZMA6d4XcbKMykGwNmq1AgaWhPgL3Dak7iG2+x+HZjjO54L++Qwx2RxoYA1hZMp6xbCla1ZI9HiuUBwfMbmWmxwK6cnfHxIlTeQlS0z6BMzDT915usuuk3XFQbAVnE2vHklr7FkS6N4k3LNBpMkK+zZrrqoBQY4iQPPnjuIoC7Zd0pNMkKLQPb+MWHOcLtca6DiaKn0nd6f0KAj2woSsU5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdEKkEb0TgbWCZguYZYbG2s5rLbbbz/PNpnxi9Ke2+M=;
 b=B5LVgvV331ZrgksOahadMZVLwHYAXFD8+cytbdmSYgsu0yhC3vd8ZYpz+lJgyzvRQNkCZkG8A+vJB2zm/MkHo+Bh45RlUuwic3XmkFQqdw3nfe7p0SqJouMsSxyL+M16lOiAytgdILFSmYmmmhseeNjIdoePffYs8y6y/hxtiJU=
Received: from BYAPR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:e0::41)
 by IA1PR10MB6878.namprd10.prod.outlook.com (2603:10b6:208:422::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Thu, 27 Nov
 2025 06:37:49 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:e0:cafe::de) by BYAPR05CA0100.outlook.office365.com
 (2603:10b6:a03:e0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Thu,
 27 Nov 2025 06:37:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 06:37:48 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 00:37:43 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 00:37:43 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 27 Nov 2025 00:37:43 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AR6bfat2498845;
	Thu, 27 Nov 2025 00:37:42 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
	<vigneshr@ti.com>
Subject: [cip-dev][isar-cip-core][PATCH 1/2] ti-am62px-sk: Enable TEE_SUPPLICANT_IN_USERLAND
Date: Thu, 27 Nov 2025 12:07:37 +0530
Message-ID: <20251127063738.435868-1-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|IA1PR10MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc728d7-e52c-4dc8-e0bb-08de2d7f7b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0CkRH6M87mQTuoFELTuQWUGKJH0RgLZouZU3SRZs3sa3H8Y27e73fBgmyQ7b?=
 =?us-ascii?Q?+OBEZZsd9qhICHGShJtHWeICvmr5whg9TvLU4OaZDcVWWnJyE1prk4aVC0vo?=
 =?us-ascii?Q?Hkh+XLPqbJMaAMgiqSIBCIvnuLiGcdxUzNdfyca72RtWVKDeqs5zhEOd9VyX?=
 =?us-ascii?Q?KMNNcdTx7tUFsyxX0o7q71uTfqd+HNEM4S9B1aRP3UuNBtxBLOdEzjNReBcA?=
 =?us-ascii?Q?h3M+qGR69+JQNL1IBfy5yU11O4QjbbEGUYqt+sESxoMgsuid4icHIvyYmy5f?=
 =?us-ascii?Q?HXW5/SbbN3gMcKxNF0Ag/hmUXyhi9391K3ejxigwDJAgx6WzImANVLyhl8pb?=
 =?us-ascii?Q?3U7quiGL7BiT75ReQQH4j276CIr2jh74qcQSYxDGh2IIUjorN+zJHYqTcrim?=
 =?us-ascii?Q?tQdNOmW4VPJ+/JJcgfOOuYivZEAq1fqwKQqGjc2SMdMp/Ry4RuaOCuXst0Pg?=
 =?us-ascii?Q?JD7Xkhz+4yJAU81FvOPwDRnmVJRoThPKaveQ0AA+ztxUs+uwrLOjxo3qqz2q?=
 =?us-ascii?Q?PTAm2Yz3i47ygYbtglu6m6pWl9NXPJ3Vh2JfFi5vm1H9gjL8XU8/2M8qEQ20?=
 =?us-ascii?Q?9gmPk8tHaN7YRW5Wj8CahmfcedJZRuTNdnE2bPT3r/tvYbMxrDjsPJzO3moM?=
 =?us-ascii?Q?+xYGhzF/Haoul0VQeRpHt1Yn9TfZ8ds1HQ2tanr3J9WCHF/0diRn5XnOm3oW?=
 =?us-ascii?Q?Bm96M8pBa/vbP9xW+J4fDvK9rM1OrTo5GphPEGi52exw6UWKhspGIuUhejl1?=
 =?us-ascii?Q?i7BHhrf582Lq8re++POmmFYg2ZT6ptQgT8QAvK1T8sVFYWieP6dz2p+MgLOw?=
 =?us-ascii?Q?BWpKUhJn2RkXK9Wyg+uEVNtlwe/qwb7XRWV2RjIOD9g73qKeBayFWjaeseGl?=
 =?us-ascii?Q?KKwhTFfv/XUUzaOcml42dpA8oolkTD7CFTz0ovBJJKj5saDoXFRfxcV0OB6A?=
 =?us-ascii?Q?bungko/rsvm2ZdaQSqOor8WBiSKcQa9fm5roGkilzQPZZdnvzRp+31wAGmix?=
 =?us-ascii?Q?Eq0n4HrUIwLdf5e4WBFjfo/GHZ/7HMh8ylzADui5gDetQ2OxJyyVhq88M2Ic?=
 =?us-ascii?Q?9ANMi0KNH1stdt/CK2KubVo/GEFysaRDB0nZBytlL6PDcfHHpuKOtXYVY2gj?=
 =?us-ascii?Q?qI/haCpbIgLjYgSxnsfQ+pn2cc7C3h+VmNGnn2Rvxzn5/z1jbip2kBn8MpFJ?=
 =?us-ascii?Q?dsPXeLsjNZnRsEyJ9DS0dDskDS19fuZykxJ45ursfZmDfeDAdsCUcPIWSX/k?=
 =?us-ascii?Q?XRUI8mvJfh6sQAueQD4wU/Rr9YjgGn4tUNC6uHtUWtblPFfY9eKQo+DUplQX?=
 =?us-ascii?Q?lesJITE12QoCvAIr+Cg6n51cBfQYZIieUT/2Aztd6SRusl00sLSt6oMWCyKU?=
 =?us-ascii?Q?cOa90AoHXjOmeZfcufyMgq+yruSZFU8p3SzNpzU1zmSqrqS4A3dhD6uR2tmD?=
 =?us-ascii?Q?SntkMF4gUKs9CyBzgTPUtDQXPcG0qkCQfsOolkJkCA4SpixrKtklAELc8IoT?=
 =?us-ascii?Q?u1TGEqYnXKqVtd+kUu7IXG06jN1kZxQteJ2GUgkMc5+vCh5f0WvJgGCu9Xgb?=
 =?us-ascii?Q?OdMTLjDa6O9IHTQkkzo=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 06:37:48.2336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc728d7-e52c-4dc8-e0bb-08de2d7f7b25
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6878
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Nov 2025 06:37:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20735

TI AM62Px SK platform only supports 6.12 kernel and it does support
fTPM. For initramfs-tee-ftpm-hook to actually install local-top scripts
into the initramfs, need to set TEE_SUPPLICANT_IN_USERLAND.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 conf/machine/ti-am62px-sk.conf | 1 +
 1 file changed, 1 insertion(+)

diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.con=
f
index beabac9..31fa93b 100644
--- a/conf/machine/ti-am62px-sk.conf
+++ b/conf/machine/ti-am62px-sk.conf
@@ -24,4 +24,5 @@ IMAGE_BOOT_FILES =3D " \
=20
 USE_CIP_KERNEL_CONFIG =3D "1"
=20
+TEE_SUPPLICANT_IN_USERLAND =3D "1"
 WDOG_TIMEOUT =3D "0"
--=20
2.34.1


