Return-Path: <s-adivi@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422F9CE7A96
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 09:05:38 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com (CH1PR05CU001.outbound.protection.outlook.com [52.101.193.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.14175.1763111129552286052
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 01:05:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@ti.com header.s=selector1 header.b=e3FLCDlw;
 spf=permerror, err=parse error for token &{10 18 spf.protection.outlook.com}: limit exceeded (domain: ti.com, ip: 52.101.193.46, mailfrom: s-adivi@ti.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg26wXSIIzyELT9HjDkeoG8trkkBvvi6ltFkoyj9AS4AEAJreQujtKMzkWAbsyKFVL/nsXGKn3Va3vogeD7EBmELcKTMlLBJcRWcibNqtkR238mCmin+WWqVDBuDvwOoT6ZKQezbrsnfkMOEUTO/bBcd3ZlR/qbMx1k+qws1X9eThkapc2GtXriItAbO07OaQU5DnKvZLV5hfcBusOEFw9L0Y06XqVEO/j8Q8SnOvCtKC3vQ3dQv5ETQbbUCkRFjf7NCtT9G5tfW48GmvObPOgkTM+V8V+M91ULFY8WVjehKqwGcHesJDNzL3x6XMYWUs2JzFalrpzlCUh7YG7NlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TshyxVXkErwuBCnS76yapft/U7z8nufp6B2AOHyrazQ=;
 b=Q7R+HsCKaNVpfCIhS/Kzih5uTeT8BOMSOs+A5qqg4d3krswt0LSXaPnD2J5wpLSh+XwGnxEvjNfbJr04lj2GJp740YxtjLzHDd1HvFFqrBEgvfJr4GJpKKE1v3CcpdB7oE2lHHl40VUxcZMLSre3LAkco/pUmdGotyCqOo5oVRVG1JA+Ro/ZvY07qUqfbqnmF2wkSC9WhkBDaZYCGJVCv9+TrgTd2cHOxTRNcqRXnSAsAqKZB+KWlY2OENbbcQAVcTYz6ftDf0j91jFBvchBmh6ZJ1WcPGTljfQJeEHI3wy/m6LrY91gjVstyAI9dOs0c00c3oqm3AR20apFJYPvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=siemens.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TshyxVXkErwuBCnS76yapft/U7z8nufp6B2AOHyrazQ=;
 b=e3FLCDlwMRSYqVFUCr/d2qxc3SCVmIeeCZJyaG1+ImcLhLOKWhNjQ49mJz+Ws3lh0K/u2dnWclFmGU6InFM1S24a1NgtOTfR4DT2eNybQcr2yWmSCNWZzG1mK479xgsdmKXFl2rs07oMGs0HekAABbKIJHqBGedsvPAXiZHA5Jw=
Received: from BN9PR03CA0499.namprd03.prod.outlook.com (2603:10b6:408:130::24)
 by BLAPR10MB5106.namprd10.prod.outlook.com (2603:10b6:208:30c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 09:05:26 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::2e) by BN9PR03CA0499.outlook.office365.com
 (2603:10b6:408:130::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 09:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 09:05:25 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:20 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 14 Nov
 2025 03:05:20 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 14 Nov 2025 03:05:20 -0600
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.233.117])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AE95E1N1718804;
	Fri, 14 Nov 2025 03:05:18 -0600
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: <cip-dev@lists.cip-project.org>, <vigneshr@ti.com>,
	<jan.kiszka@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH v5 2/4] ti-am62px-sk: Enable SWUpdate support
Date: Fri, 14 Nov 2025 14:35:07 +0530
Message-ID: <20251114090509.2935933-3-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114090509.2935933-1-s-adivi@ti.com>
References: <20251114090509.2935933-1-s-adivi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|BLAPR10MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a84d677-a566-4e97-3dbd-08de235cf353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?y6XrDSSEKlFi+J+b7/XNF5x3Ozd6QY8rsjUB5HWKeDY1qkZH6tC2a1swI40i?=
 =?us-ascii?Q?kC3bxEsYLHxBlADdkRgiHdXW9cEojFvLsysMR3YqZucnYb0VIVjQvVr41wqu?=
 =?us-ascii?Q?SS5ZGbQzvfTx3JeHd1L5iLgvS5UApODudcHRjcKSvjPNSZYUOM8mMIrUuYbM?=
 =?us-ascii?Q?WSs+q/pj23obG+ftDA7rmfK1v0VEJ49zuoqI4Tslha3i3D+zYE8w/P1VILD9?=
 =?us-ascii?Q?qCI1dsd6pCyLzAr4flQH/AX4IE43Hz60uMxpj/anv6Mnv9te8+/aIpbUvBPw?=
 =?us-ascii?Q?cL5UQBXmKBqmxy2SlOHDEq4iGJZdFzpkfMPz6owy/B7awoYFQef6HCxVwqVZ?=
 =?us-ascii?Q?62nP/LNhydD9PPjp3cjlJD3NBYfUXlsLXvZNlx0J8uS4fdwgVCgOqt8sU4du?=
 =?us-ascii?Q?cWPV+SQ5OHVRW52Z4wtln4QEUtjvTmJmvKipaxv6is+zT+BXCdF/OhPevtpw?=
 =?us-ascii?Q?/W+hCH6m+4I0dOODz6gG9/wrc3F45cBmGwgBb7qZaibo4B2OTPa07pmIYyuc?=
 =?us-ascii?Q?Ueykr54JeMLrlxkKxEXO54ISf27ZmVQNAgHZ0kQx/psNWCXBuz3+Z1mHmoOC?=
 =?us-ascii?Q?4eL/FEBnHijFG3ccqsq0CBqLUJq5IzKJrtV7t1eUa+J6U5o54jidOUp8tVeH?=
 =?us-ascii?Q?1g+mx/8J4I5easxFvfJRFZZYayqdD5SA6N70YN5cu8OOZqKVKxAMSiPzHptM?=
 =?us-ascii?Q?Hh5lTcuELrOdplSWlIBc/0oj1BAQpW4HLlHofoKt9dFaQ1U2b/VD0bduxM21?=
 =?us-ascii?Q?hBUL4WLsJJ9lHPBNaKajCHtzXTUYz6Srn3D0V24HYBchpKTyAKt4bhRmKt8U?=
 =?us-ascii?Q?EabMz8wsAg6Q9OYFwI0ImstX+2CDwHeFAzlNrRJ+inFnqhW6TKfw0g/u3EDM?=
 =?us-ascii?Q?m49A9k4px4XFH3YQ8NMJclb42IvLOdxs7YHZypLuTljV1bFk7h02dq3X7fpB?=
 =?us-ascii?Q?iBVXnd1jPOsg5ikqtLIsBee13W2O/Q9F2cnOYEaanM4RAvg8i64k+KbCqMC/?=
 =?us-ascii?Q?npf/OKWOOvSTu3SdJqM7MpLmPClmnl+w5N/on4Vp/PtjZcImu/OmfFmsWGi/?=
 =?us-ascii?Q?Wh07hl4ArnE5EuUfEDK36z3//zdYxBK4SS85hTD225CIZG6lAZGTnCTkdrxi?=
 =?us-ascii?Q?Xnz+Rx8IRkg1nX9JuvnCz1Doi1Tbuwzg6NlCNkKKsJyqoP9CjewTAihabK/X?=
 =?us-ascii?Q?e/IqIDq4Z93pa3f8I7RLHCRgqp5eGGIeP7QP+yqDYFD2hvAnbnlHrsig42Ag?=
 =?us-ascii?Q?HNPmZmSAVLeK76WlZvYw64h/igv35CEUhckF9pU9jodQ4/6QQB2Pvs/+E3e1?=
 =?us-ascii?Q?UnsbpomGCI4SFVwyIWgZTs+aCMEIlcbGekntrBgL0lO9DNKcAR8DoY7R7PWp?=
 =?us-ascii?Q?Tp65p5XlnBdbZ54xFyhOJnsiHhGLcvRlXPh47ZgFR7pOiPJU7FnHIKC7dVFU?=
 =?us-ascii?Q?0MipoPhXRXURc2HnCbzG3HHFvvpt7QaoMvJXoeFJOQ3JAaQbNv1Q6xGuDNqS?=
 =?us-ascii?Q?eWWk+W/F8372b8MWFpj9IhmwBnMS/iw1IP36aFLJCbJ9CQ/8wge8QT1PpswL?=
 =?us-ascii?Q?OvzGACYw3f9D+4IBf1A=3D?=
X-Forefront-Antispam-Report: 
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:05:25.8285
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a84d677-a566-4e97-3dbd-08de235cf353
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5106
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 09:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20540

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


