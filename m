Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17034CCFA1E
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 16:45:50 +0000 (UTC)
Received: from CH5PR02CU005.outbound.protection.outlook.com (CH5PR02CU005.outbound.protection.outlook.com [40.107.200.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.22186.1762879540213381984
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 08:45:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=e4m7v75H;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 40.107.200.0, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TqkluiP0lHmludPUPMMIZi3eXzyyd/szjYor8162BY0IA/kw1pHfHs3guV+4txf8zcpz6fA7JnA3BfbY8MvE8esXApsnMrfRC3zq07zsG5UtqArYbHSUKqGrmgM8XcKIW/4cG/xrKJ8Djb6ju62LcPbQMjCHM7EpGkRIIEElDT6E+r186tmCtvG7tj2i81j4t44oyl/zvEs4mYmiwqoR6a785xo5Mhqp0oG2E5tWdAFrzToJ8PSI8CuzOgWkAX/ATurw+gUl+5u+Yi2SjS7tBfWJiS8/9eRMuqbd1sA8sqcx9UZ0IXQyZBLyhz+W5GoAVU8rvQ3ZlG61M2fmURfA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZgZB3PuO+4AZ0BJtYRLQGZ8xws9HQEIAEY0XqJgBUo=;
 b=M1Yg5RwUapx6T15wWwzuJ2JCvz3VQCt+mJdKlp1JIixQdqUiGWbLTNXYb8x7Yvz9Jj3GG2ViC8W+7MfyUZPUEyjOMbXjJwQ/BFLmBu9LDeqBYemISN8Rw7+fItwEi8+3sUTppmSRVESWZEsrQ2qZ3oxRKIVrayU7+2GAsGplzEBGoBMGwiOAvPApE1MMz7XkTK4I+7G+6mp6hhBX+czTsLjav04P2vVKTEpcrD0Iu692ZpM0sfc6FyTbRGN0jIF/OnUWIHF4d4eUaiIaQ4JwgZeqyE45E+T0wXdpoQ7wmkgvnZuSJTLBy8BHRLcf8B3zNgPwocHcA4kR4KV7/bvytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZgZB3PuO+4AZ0BJtYRLQGZ8xws9HQEIAEY0XqJgBUo=;
 b=e4m7v75HRoQuwjaVrcUBk3ulXGe1O4gxUGactqC1n9G1LcO9szfCNmzrYjPOvHW7rEWgGPhBHpNIttnGvpHkOjD6XlfAyYeaL///QpaaOPsTTzyArBqOstJ+qneHTOfj+kmJeJ2S9lqMhgySyrURRVzxRFJ7ND1l4reFDeS+I/g=
Received: from MN2PR12CA0017.namprd12.prod.outlook.com (2603:10b6:208:a8::30)
 by SJ0PR10MB6431.namprd10.prod.outlook.com (2603:10b6:a03:486::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 16:45:36 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:a8:cafe::9) by MN2PR12CA0017.outlook.office365.com
 (2603:10b6:208:a8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 16:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 16:45:34 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:27 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 10:45:26 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 10:45:26 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABGjH9G1255613;
	Tue, 11 Nov 2025 10:45:25 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v3 4/5] ti-am62px-sk: Add support for secureboot
Date: Tue, 11 Nov 2025 22:15:07 +0530
Message-ID: <20251111164508.1707234-5-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111164508.1707234-1-s-adivi@ti.com>
References: <20251111164508.1707234-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ0PR10MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6604a26f-f9cc-45d0-e6e0-08de2141bc03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ufT0+5UjbM3SL0rvHGHQK+1m5WeISmKCa7PvEJ4U0rJliIn8TVEzKX4qIQV8?=
 =?us-ascii?Q?9/7KR9LWVqDbQ3Ml0WDx6ZpGq4b72SfnCDOixIHSWvGgko6otwlj/RW8yzhM?=
 =?us-ascii?Q?10ZlfB3GT1XLoQJ6wtOFbRfWwsqaJOxFc/kDVKgcNLcsll9Y/2LIeLYSLBBu?=
 =?us-ascii?Q?a49475bubFqv4T1FKWwx2or5V2QNf3+uUVls7rGOGd6o6VDit12w6BirNHVp?=
 =?us-ascii?Q?OgycS7UqXYCa8+07hjAbDJcS4YymF5Dpz3uWx3jDf6kyb2Y+ED5lCnvgJONj?=
 =?us-ascii?Q?O/7bWQSXoxspbwu4VqTW2wuvdzNEwv3SWTapf9D2aMRb2N/Uq4putKeXnhGs?=
 =?us-ascii?Q?jk85IgNhbveG8QNjgREbPXYqLr5f7yyevJPfOborT/UU68/hy78+6/pyNZRS?=
 =?us-ascii?Q?kaq6kA+BeukttOGzWnGa/rClZMS7rTiaYXTO0tWiuyrIZcBrAdSa9nTKhW6X?=
 =?us-ascii?Q?YADk5Cv7i2uyUT7OrCHVMBH/z3Z+pkuO1uxBef3gG8G7gwPJBHBI290pNGbS?=
 =?us-ascii?Q?mTWFYbLlfJzlcOpRj54zVadrrrvqciavMNfm68A3Fpn6pS5jb8ifQ5y55OWH?=
 =?us-ascii?Q?VBfyhX0MFbWDPO3AJeqZyLsN2cOKgqPTvR7zvl83P6v7shmMjlcwnRPBZarV?=
 =?us-ascii?Q?7kA7W/n/OasrGJEbas6kfrAs5DP4iVb/vPvDuOChFce0wbrKlqtJ4vZN5gYM?=
 =?us-ascii?Q?Ew3s0Am/SI8c8RfwkmGrwaYhiTrMgxgoJaar5EOOH5qqWnBoPWOO607kwQWQ?=
 =?us-ascii?Q?6+DVZoNhN0Y7/w8qO9rgiB+hCsB72Z/A7UuuRdGisQg7kIJZdyMcIQ5hERKu?=
 =?us-ascii?Q?H/8/jMONu62+HMrNgQVdE7k9dPkpVmbZVpJdjJRnCRY4hXm9l+wKuKb201B0?=
 =?us-ascii?Q?Twx+ER3on4EiyjOYIPbzkDzMWUF4MjFcYSI02vstC5oAUSvWleLnqLFnd4Is?=
 =?us-ascii?Q?YcA+Ph1J0i4L7K7yaMQmz1NTDmRMbHI5DjwAIzqWzshxA7qrPneip3OA0BY2?=
 =?us-ascii?Q?eNNITReLy+qrZFyrqm3B4tz65kKcEn8G26xRicoG2+TsbXm5T63PrbX0ahzU?=
 =?us-ascii?Q?0jS6E8GZpx6H0DF353UiW5Zt/4kyTN7S4p/AUZd9XOhUVJWdxsuWKYnixThr?=
 =?us-ascii?Q?6LkyQlVXvOfPsrVCg6d7BjqgabWBpmwfFWdf4WbW5HKGUaGyHuYooZ1FgP8F?=
 =?us-ascii?Q?TTTrmsfI4oTweAf85lP1zjetLpVDEBd2HQjUuWA1ZnsQ8se1WFRqXJTq9O2m?=
 =?us-ascii?Q?lvqGV4nC+5az8aFYPPcWcfZPcI4O9igqqfhKcAEf4hiojRVwc+1GQq2mej+e?=
 =?us-ascii?Q?S2I2bzKEisQE0C2aEYaEMiJqEFKa7N9yQ4+9o5PuJS6MdPRUlNQCjN1ffRhe?=
 =?us-ascii?Q?rYHAvED0pcEyYF4JricgRgdLEpNWq++pWJQmTA9PNgdXMm6bJIFYKpg/mVMz?=
 =?us-ascii?Q?duW9YY5YZr3R5cR7TBZaujYw+EqNOtZet77A2DwUhhDvBWRFdxBHC3kzNtKZ?=
 =?us-ascii?Q?bN97B4D7sopJRD/Eq3pcJWbywiqHyN5hK1lJ8J4OsPPB2uh8sun4IRTtxqJx?=
 =?us-ascii?Q?cRARpYvn2G8vXPPhN3E=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 16:45:34.3356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6604a26f-f9cc-45d0-e6e0-08de2141bc03
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6431
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 16:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20501

- Update u-boot rules to prepare secureboot vars
- Add wks file for use with secureboot
- Update Kconfig to enable secureboot

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 Kconfig                                       |  1 +
 recipes-bsp/u-boot/files/rules-ti.tmpl        | 16 +++++++++++++
 ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in

diff --git a/Kconfig b/Kconfig
index adacf6a..3fd1efe 100644
--- a/Kconfig
+++ b/Kconfig
@@ -112,6 +112,7 @@ config TARGET_TI_AM62PX_SK
 	bool "Texas Instruments AM62Px SK"
 	select ARCH_ARM64
 	select HAS_SWUPDATE
+	select HAS_SECURE_BOOT
=20
 endchoice
=20
diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/fi=
les/rules-ti.tmpl
index 58e954f..26665eb 100644
--- a/recipes-bsp/u-boot/files/rules-ti.tmpl
+++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
@@ -12,6 +12,22 @@ SET_CROSS_BUILD_TOOLS=3DCROSS_BUILD_TOOLS=3Dy
 endif
=20
 override_dh_auto_build:
+	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
+		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out sec=
ure-boot.der -outform der; \
+		rm -f secure-boot.esl; \
+		\
+		if [ -x /usr/bin/efisecdb ]; then \
+			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der =
-o secure-boot.esl; \
+		else \
+			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
+		fi; \
+		\
+		rm -f ubootefi.var; \
+		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
+		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
+		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
+	fi
+
 	$(MAKE) $(PARALLEL_MAKE) ARCH=3Darm ${U_BOOT_R5_CONFIG}
 	$(MAKE) $(PARALLEL_MAKE) ARCH=3Darm CROSS_COMPILE=3Darm-linux-gnueabihf- =
BINMAN_INDIRS=3D${BINMAN_INDIRS}
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


