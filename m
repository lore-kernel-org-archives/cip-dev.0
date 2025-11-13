Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D48CD5BB3
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 10:14:47 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.7])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20429.1763028882766193238
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 02:14:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=rKaJL+QG;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.193.7, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSVv4N208d4NgAc9B3Q+wz0lFNQk5QVBnGazVNTvGqVnT7Qveonsy5zx4iq+FFVPkO9vssW9FtuUYsuJbEXL6V0Zpxpfj3oTqNpEzSIsG5FHbpMZr2E/5AL9NCTZDN2Z6GGEu3tWncbHFf0KyOvbakuPkPZce0G18HYD1zYdUMM3iyOM/2WQIY0q0FJC6mzVcat3i7F79vP0JWhK+cIQxG2MM5zS2CXOcbEh+YOv19LyewdNnOcSWZeeltjGP1sDy93Yp/JFzzbHv5ZC9NZX02tzcyc/VsiSAoYElxh/2qRfDxqJrqa2FB0eOlK3aBs7hTtKvJG0ga93z8f3RdTn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TshyxVXkErwuBCnS76yapft/U7z8nufp6B2AOHyrazQ=;
 b=AfJuGfKl24ovNRGy25HdawGBB+UiqJrRbIAQifGOKeezH/retKLSY5XXCP+0HAWhC2EdSeOY0DaNGTLvkkDLTlHCxmgrM4UiyI+KWSY4H08xVC6SR2hMix8ySpAGiSt9dFCd+KRhalJU2xiJJz0J671UFLPojqKAdAa6nOBCeZAhtqY2Us7sCpWqt8U6RgUDXgoOy4x+U87VYmNNnWa2WRmhnSNdbg1kDXPBi32JFYJB9So0jQjzHb+V66/KJHyFfwHruwEs1jpAgx0MYCXyp2clbSfloYj6rXMqecdgsAylTHvgQGfjrBE7J6mUiyFkNEZacyT0xPvPSZR06Q8ExA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TshyxVXkErwuBCnS76yapft/U7z8nufp6B2AOHyrazQ=;
 b=rKaJL+QGeaAwGctyPKFZ/ynQ1j2nZxXOS+dGZqpdcBFUo4PSmhTrGD93EQf3UUW7jSiY3V5AbvfMaHTA6JGlg8POZ/I86MQhRnumJoZPaQ18RFMMqkXS8UczdAkHltul7gFFiO7q6Zt7FFuiCPY/wBuFWurh53IS7f37QOLoKI0=
Received: from CH0PR03CA0213.namprd03.prod.outlook.com (2603:10b6:610:e7::8)
 by SA1PR10MB6565.namprd10.prod.outlook.com (2603:10b6:806:2bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 10:14:39 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::3c) by CH0PR03CA0213.outlook.office365.com
 (2603:10b6:610:e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 10:14:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 10:14:37 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:33 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 04:14:33 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 04:14:33 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ADAES1R058943;
	Thu, 13 Nov 2025 04:14:32 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v4 2/5] ti-am62px-sk: Enable SWUpdate support
Date: Thu, 13 Nov 2025 15:44:22 +0530
Message-ID: <20251113101425.1177129-3-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251113101425.1177129-1-s-adivi@ti.com>
References: <20251113101425.1177129-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|SA1PR10MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 983ee790-cd38-4702-e1d5-08de229d737d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?pZEzEXGjnBtd0xaCxGnUqBIkad9n1yIag1f8LaM+KHIiMJGFDSqBkkYc6FZ0?=
 =?us-ascii?Q?9TpxSQaQ55jI2oEmv2/03sA3gRaV9XqPp8rt9bA0s4oMGKlOor3QY9o+t3Np?=
 =?us-ascii?Q?mOeHMo7fyShGOO/MH+mFLQcnlud2bReZejNZv+8UdjUCuY/hPRYqAp1MNuNi?=
 =?us-ascii?Q?vmTx+UxzuXAGOw6Mo1A8obw991czYJAD0GS+XSgE8ax8rw+pDt1t4WGAYcN5?=
 =?us-ascii?Q?wAmcwOqIg3WpTrs3HAZd1Q6JbN2ouYCFDkZpbHCgL548ipx4IqDt2SHVe9JX?=
 =?us-ascii?Q?risMciRCQk0uOGhMKyQPeYhnMqSH6l86tq5oDy41948HvEhOSxY7Xk/gQzAK?=
 =?us-ascii?Q?Fy4yxfiC8uPUprCLe36IbgsWRZa5sKz3XzCE5tkKrNgk54+oOK3DZc8K6fmH?=
 =?us-ascii?Q?fHhe96Ks7fIJYj9ZIMe2+LOCo1Zt5qbxI4fvYJv3DGt+bdyimH41iNlsUqO4?=
 =?us-ascii?Q?B6U0OCCYGNICu0sCBv2PPhKJXIjSz0Vkziwx+jSpqzMFvKamkxkh+RSZQD47?=
 =?us-ascii?Q?FDVdYIdQzO+l/X8HkUozRpQLS2hlG+od5e8YQ7JcXml58tUv1pydCXPvDckO?=
 =?us-ascii?Q?hqxDDyR7WAlRoNRJ2Z47c4udPjvgEKWPLDboCeo8yD5XoJuVsM26Of6ODQRC?=
 =?us-ascii?Q?ZlUdZ6YwouKPPouPSHCnJR+YxuC4sKF5DXUlqzLP/db/jQxCVPAyg0HRP5kH?=
 =?us-ascii?Q?GFKw8gA+RsCilTsK0u3mfZ2UB1xifQHPwTMgKfzgNZU7UxvpA8RiVYJqs+vX?=
 =?us-ascii?Q?bgBR0dsdVkzc7neq94E94H/mNFEvkntfhEFf/O9vpAu9DswFCbd3UwyvL3nl?=
 =?us-ascii?Q?nfumA16sfDc23SDup/xDABnZpdtu9Awylbixt90xs6BxvZUeKnBRv1XtAIDz?=
 =?us-ascii?Q?5GosRXGCPmPLhuriH0xaLyLEgTgW05CQN6hVqPK6tkWONpEXAbTy5T/geyDT?=
 =?us-ascii?Q?XZooONjIuWnKbMYp65vdT8mZSmvtVAaQkpvUXG4kGNS9uezBSOabdSWOnzeC?=
 =?us-ascii?Q?Ry2grpfeQ+RHFmJ8pV4m1UlbJsIftpUVdMRaiXAeJ3fZykwNfCz8Jr21t0Ip?=
 =?us-ascii?Q?iJgiSnSb+tITDQ0ehv7lnPgW4k3kh8Bq2e0ehegAqJfPgQM6RWnXWsTEYdWg?=
 =?us-ascii?Q?sVMxF4jnc2Io4sUHvo73h2TVryIWZ3cPz3Yto8ry1ntKR3nmoaWxm1bvTiaH?=
 =?us-ascii?Q?tfoWs/94gm7k76ylqs1Tg2WNXjL3vn1zCdwAIWvCyg2I1JzYft2r55YEzn03?=
 =?us-ascii?Q?BevgtmGJhfEs0peSVOhEH+BBm17gJItP1Z4i3xtwnQRx97F3xPkMWyEu5m+1?=
 =?us-ascii?Q?kLjVof+xH0bA6gPPQ+oUfJTgSdzBi7gHjKKl4+7d9jK2c7w98lEYIXajyRGt?=
 =?us-ascii?Q?pfUk6TiH/NsEF8tYaO86b1MHg7Qcm2a+tXtDnXAZfRwAxEZmPY6OZ4QaypJT?=
 =?us-ascii?Q?qpxf7pfqeusIQPtUePt0S6QAKI+rBr1YbKk/TOvaijNTAXOAL/ioaKcxBR9S?=
 =?us-ascii?Q?oEL3fPAIKQr+KtG76Ruh07/zg9iJgX6SCEoie0OuQ0hnXgLPd2VLXTFoRq5B?=
 =?us-ascii?Q?PO3/lSRPM7UZJDCf2Cc=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:14:37.5323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 983ee790-cd38-4702-e1d5-08de229d737d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 10:14:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20524

- Update Kconfig file to enable SWUpdate for TI AM62Px SK platform
- Add wks file for use with SWUpdate

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                              |  1 +
 wic/ti-am62px-sk-efibootguard.wks.in | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 9b3c329..48c0e51 100644
--- a/Kconfig
+++ b/Kconfig
@@ -89,6 +89,7 @@ config TARGET_QEMU_RISCV64
 config TARGET_TI_AM62PX_SK
 	bool "Texas Instruments AM62Px SK"
 	select ARCH_ARM64
+	select HAS_SWUPDATE
=20
 endchoice
=20
diff --git a/wic/ti-am62px-sk-efibootguard.wks.in b/wic/ti-am62px-sk-efiboo=
tguard.wks.in
new file mode 100644
index 0000000..100f303
--- /dev/null
+++ b/wic/ti-am62px-sk-efibootguard.wks.in
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
+include ebg-sysparts.inc
+
+# ABROOTFS partitions
+part --source rawcopy --sourceparams "file=3D${IMAGE_FULLNAME}.${RO_ROOTFS=
_TYPE}" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --par=
t-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
+part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_U=
UID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name system=
b
+
+# var and optional home are extra partitions
+part /var --fstype=3Dext4 --label var --align 1024 --fixed-size 512M --fsu=
uid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4=
261fa32d9 --exclude-path boot/
+${WIC_HOME_PARTITION}
+
+bootloader --ptable gpt --source hybrid-boot --timeout=3D0 --append "rootw=
ait rw console=3DttyS2,115200n8"
--=20
2.34.1


