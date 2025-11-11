Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D5CCFA1A
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:45:40 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22073.1762879533102198764
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 08:45:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=a58OPesJ;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.193.20, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHVN37sWte0XX2ROO2R/f1ZE6WPE6/zDWet+Cy8q8365DQ8vU2gY0ksXKN34PAMN7NnNNia2Xk2OwSPpQS7y24TEONwPCvVYCTtM8zkWBdCqYKDxkAtpCh2XWivJEN7HQUXqX10PGIEcU84FowJAQ2duZgvNFCTOgau+9GIHrzzvqJjr5UAiG6Y71f02hfeOTWgLpO9RPRsg1eX3YX3OWtSULQh3uTYLCwJJ6gEkjaz5ioOQhfibFn00HoD0QCmghDMNiqs5v//s+xWtJjyaod0u6afgDLIYvABchKPQQLmUcDGk8k+B2ofNXF2+0GhrevpHUz2p+GG5eUfq3+GZ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQzw0VMAS35dXBMeWZV5bmHcwOPsBpmbPbXxMz6Ltws=;
 b=OKnFknPQDE9DmVG0mM0zyLjQR0/BdOSu0jxQ3siUgr/8gvZk2LfI33Yz+MchWJk9hsVI4P7grjBEH+l5miDraTc41KG9lIDOSErtMLkWDPmKgfSQXWtE/IlilFyAkK1WxP16wGGH8TttZ9/NGHZInmX0usMc0giU+sW+KLd7kowL5ObHyHscjhWmWXWayB+ZMum4qK6Lm7XCyzIFr399rn1VUrMKh/h80kDipLoql+l8fZxu4WEhPAOkNDoqleurbVFpbCDRxbjYw3AJGNegkgDFhY9VPlFVPpO8x9gFmp3B7UoNV2w+agfvyH5GEwW9CKrI+VodefkI+nmHm2TgIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQzw0VMAS35dXBMeWZV5bmHcwOPsBpmbPbXxMz6Ltws=;
 b=a58OPesJ7XPt3Ps+TgMEwmcoB0Y2l5kzFFgV1COyVPBa8hY9QKMWx2qymuqv/PF+kwOmBr3d2pf03vlQ2JJhADfPu9nBg7+ZZcJaxLhA/iBQAynvHq2leYueA61T3pmJR3C8NNEUNwKzJC83NoFBoQkU4Q/EFhUO+O7xHjvIJf4=
Received: from SJ0PR13CA0081.namprd13.prod.outlook.com (2603:10b6:a03:2c4::26)
 by DM3PPF1BD38130F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c0e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 16:45:30 +0000
Received: from MWH0EPF000A6733.namprd04.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::41) by SJ0PR13CA0081.outlook.office365.com
 (2603:10b6:a03:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Tue,
 11 Nov 2025 16:45:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 MWH0EPF000A6733.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:45:28 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:23 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:23 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:45:23 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGjH9E1255613;
	Tue, 11 Nov 2025 10:45:22 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 2/5] ti-am62px-sk: Enable SWUpdate support
Date: Tue, 11 Nov 2025 22:15:05 +0530
Message-ID: <20251111164508.1707234-3-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111164508.1707234-1-s-adivi@ti.com>
References: <20251111164508.1707234-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6733:EE_|DM3PPF1BD38130F:EE_
X-MS-Office365-Filtering-Correlation-Id: b690803d-34f4-4ed0-8d59-08de2141b880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DYir8qLW3AMFXBfAOpJz85Qus6SGfsCKgRXmYOOwaP5yUlKP82SrrGw0lmCP?=
 =?us-ascii?Q?N7SmdMkoMiVtz7NAyK3ZYxfcyjQbRZJ80LmqPSE+7sWs7UFqywVDo814Vi8H?=
 =?us-ascii?Q?VfW9y9mohcp6BfjUY1bGRU6d5qailoAg3SlVfWKzRY+1vjv9mBns6YxuxySe?=
 =?us-ascii?Q?9ZFfdZEbD+JCwTyY5suoYAlgEFmFYv3W/t8dWzMq5WrsAHjFrFXPn1EUFOR1?=
 =?us-ascii?Q?IQL6bF7HU/pxq9jxUvqB6x3okoHyvQHdK0sBz6YNqSMEw/8cOu/OCrHkiv0J?=
 =?us-ascii?Q?YOlvNKv/J6TMRIngpOUAUjJjW/wylsATbOOj0xPJS45Hjnm2QSP5am8C82nF?=
 =?us-ascii?Q?jFQjmlpIu7wowm73U0YRbquDHFUThIjxiHZflMegZAd5obQhxWfJbKPUf3iz?=
 =?us-ascii?Q?MZ9g9cqqmyfQB5+FS1SUxyyvKevsKbq52hp/71P40pWyt7q86tgbMOgfQbBb?=
 =?us-ascii?Q?hRxiMAfZ/RFj+yMDLbj/J6bJYdNKKyxGFMYNDLRyoJ2IyxSj6JawEzTD/BPK?=
 =?us-ascii?Q?RFqNXD0gFNh4bJlrxfwjxNei4AJssRmc1YE7J5Awj47HF7+a7PWpUM3Si5lG?=
 =?us-ascii?Q?mgEMGB/+9mbsljiNrCa3PBInhSqCwOJWB7LN4If+DLCHeAf3Cv3FV1tMKbJd?=
 =?us-ascii?Q?FS2T9Ky1QDgPkJKTKUJx6hb1fRedGj64JkV81mTlWOAI/8Z961nQd7GGH+EG?=
 =?us-ascii?Q?zKIIp4saLXd0r9HWmFlme23eNsDQjgCGk4af0ECkn2kLKfBlcSlksV1e5qps?=
 =?us-ascii?Q?GgzTvGAlJ9LHSdvqpPx3egeho89h64NKk4XYrRePeNFFedKDIxK8Rm5bjUJn?=
 =?us-ascii?Q?3kuuNIlfGveJZLcpenalMBcLbNwe1o5X8IOoDvS9DQJ4A4qfWa9GuxroyhV8?=
 =?us-ascii?Q?4S6wq4UtS/lRbZ0+9HNRJvPqOFqhLcZWUv4Z8AcQf/Denkl6VmWlp64fBq7r?=
 =?us-ascii?Q?EE4pywfjYQ/s01UXW6O8SgDnSYcd4CtrUEbLk7X4jQawPDdN2sw6p6FNSZYs?=
 =?us-ascii?Q?o0PSStcIsP7KltTQl+0wXUZypmo5BV19ZrdG5aaxiqKZ0I9gqHiLXlXh9sr3?=
 =?us-ascii?Q?8WBudvfsHD/rPil5UAW8rbAQUy0uKbH5ZKlCJXHPDcxjFgY6blxF2EyDq+LT?=
 =?us-ascii?Q?9J19WPU6NFQbylLQ8gxeCQ8EDHyuXwnRJSLD0WzskRlVoyynAWYho2zfXWFD?=
 =?us-ascii?Q?KwlR5D63ZAfxByAiB3Fr37QZXOCXIQ99SpEe8ISvJ7OUh6sUfwjG1GsUDKD2?=
 =?us-ascii?Q?Tjk0fSmUWx/u3wf+XgADhWbcwms1/PWZ17In7NqmFUuGSiFdm+dpbDcD+UGP?=
 =?us-ascii?Q?46W9tCgRfNJz5oOuKlDzeQRyY2ODeQKqNFBLII/XQCGUrB0ESgYKZikzjVXV?=
 =?us-ascii?Q?Oj607bIPuFVQGlbHZQXb8NchJ/OV3hl/iuEKwZ3QQfK2KWgc/Slw6rYgMFDL?=
 =?us-ascii?Q?axk8uAw1Y/3FhAuplWpzzJrSMa8bkfjqewQu7t+pUFUVOjhZzKHbH04eYDe+?=
 =?us-ascii?Q?Rh1oyrGdv+DoG1s7vevKjGzVU108Q0JYS126SGlc2bKvglVKDk3z5aLmQift?=
 =?us-ascii?Q?P2KLJN32xnI20oErHUk=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:45:28.4428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b690803d-34f4-4ed0-8d59-08de2141b880
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	MWH0EPF000A6733.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1BD38130F
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 16:45:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20498

- Update Kconfig file to enable SWUpdate for TI AM62Px SK platform
- Add wks file for use with SWUpdate

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                              |  1 +
 wic/ti-am62px-sk-efibootguard.wks.in | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 wic/ti-am62px-sk-efibootguard.wks.in

diff --git a/Kconfig b/Kconfig
index 0930f7f..a6af745 100644
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


