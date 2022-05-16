Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3EEC433F5
	for <webhook@archiver.kernel.org>; Mon, 16 May 2022 05:12:37 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.45])
 by mx.groups.io with SMTP id smtpd.web11.25248.1652677948629694244
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 May 2022 22:12:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CQld1+0B;
 spf=pass (domain: siemens.com, ip: 40.107.7.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGDb+2M/qLr7M7GmysdF4+rlXbU7wjLfiTpPyGK58w6UdKLrfg11wVtLUA2oi+zl5QD3caJfDRr0SFYvMT/GKlVpKkUQLrlxZv7OhxZfc5aGo5Rnnvt2PBVFBCGuuHADi0QTg9pBBgY8dr5ScHsMB8Z6rG6QNbfq26QlhKzogvN3dgoHkRS8WIfLy1xbzqpiF6ZldotRwQWWxi3GyQcH6NXJilBHdKLdHBUxQIpSxXu7YOa8EY9e+seGitWdne0WrZVf6nRrBAO97lRmlmAtnXxigysNA00GlMLllkqQoAX6chznK0n1DLZ/ll0i6EC0YEC/SbU5d8ZCExv2L9ghLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNAAWLRawVRMWRK7WXQHeUjAE/Wk+3LCxkzhmKqI5Lk=;
 b=oJtuPwTWK6LhzUQLTqL2x4p4UtWz0Q5c9cuDFFZxNEFPZLYOaJulb2M+jq36mDGxvplrHVG5oKwTuR242uletro4Pcj1AtYVxOxxmtd1EQfISdl4BV7Ar1jMD9JUrgu8IHqBUkVPM+UfrsIw++sr7cJ+CIbnX+UmeS//guuM28p3g1yJT4L6eQeIWC1NIMq6chUaHZ2Sw8phroerzkzmKv/YAtmfKZWLJeMvn7Yj924Jhy59r6ADjlCl9k4VAe7gh5fSTkOmIhxw7M/BLOU81ZIC9kEqT1c6PT+WEd4eaoUdJbjEtqsR7ZlpvobE8aL+04lo9weDSipNObWB+YTWKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNAAWLRawVRMWRK7WXQHeUjAE/Wk+3LCxkzhmKqI5Lk=;
 b=CQld1+0Bu5XMS5giZUp5DCK2f90z75MVxLRLSrZkyUdwhOq8YnxS5i+h9UQQl8JasVDOWCvCF9ynWMewBjv75gSMRhqp6aJlrvzDx3hmmy479ZqRoI3WMjRBU0kTHbBPlxXX7/pKULgm49HYmHw1nMPX9sAh8rCn0RhfpKPPgIP+DPgq1+FJFdedyldp5MuzHJMYAfuP5dvtan+rBLmj45HpO+eOh20Fn/3h8hMx623vmjWVogN+7jUhbZaLWs/KkM6SbnQbpAt9iSUmYk/FVCDcCDAV1nUp9LLDPbT/8x2PShP2+PdsD07njh6x2ymkqVo9R6TSx1UJA4tvrMCvgQ==
Received: from AM0PR02CA0098.eurprd02.prod.outlook.com (2603:10a6:208:154::39)
 by AM6PR10MB2375.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:49::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Mon, 16 May
 2022 05:12:25 +0000
Received: from VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:208:154:cafe::ea) by AM0PR02CA0098.outlook.office365.com
 (2603:10a6:208:154::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Mon, 16 May 2022 05:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT040.mail.protection.outlook.com (10.152.3.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 05:12:23 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 07:12:23 +0200
Received: from [167.87.72.34] (167.87.72.34) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 16 May
 2022 07:12:22 +0200
Message-ID: <7b4ebd99-16d3-c873-803a-504f25c4231e@siemens.com>
Date: Mon, 16 May 2022 07:12:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] efibootguard: Consolidate signed bootloader
 partitions in common include
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.34]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.065900-8.000000
X-TMASE-MatchedRID: WBuFVsODQNTs+AkZPUE76vURMQrdgxl4obTqT1yfWBVdLtwHQO6i5pfa
	u+Sc1iUTva4hxzuVF7gu1yMLFpHhOjWAgc88bFJ7+7rgA0QyMKxiWV0DQ85LUg97mDMXdNW3Pxk
	7jhVM+bMzDOuw0CFZEvcwyVYGZr7Ih1wqj9tj1RCsEgiSwMvkKL/QkF0f4TPkcjLMMEdbK+tUjH
	UEf69xHnPoYZUERzUBDMo0XQZly2iFm20ipPFoLhsS7nB3IMv6p01kwAQWU6l85pjA/x1xflo1r
	FkFFs1a6diHyjmZeKSC87HOMUCLAdLOUHG7h3Q0kZOl7WKIImrvXOvQVlExsAtuKBGekqUpI/NG
	Wt0UYPBwEl/k3qz6ouQAhazb7AxGWWOaCi9itq/QOxvYBQrPNuWYygzCOD1n
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.065900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C4CC1DCA766DCE48360C6DA78CC1AB1DD7D3BB6E7CD0EBC270498682A803B0942000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5dffe446-c7aa-4952-d72b-08da36faa988
X-MS-TrafficTypeDiagnostic: AM6PR10MB2375:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2375D8BD03D72338D5DD8F3D95CF9@AM6PR10MB2375.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sGBx7Z/DKIht0Unk5aW7rFJEtSE9U8B7Ote1Ij9d2lEb4NHwms+2a3UVAtBeonFq48qBNOI2r9aiw5g9+60BGLpDOLBIIIocCshkyRHT5dyXbwalWgOuJl55aKilDz1LnCVWeklxJVuroeRvF/k6iwtf9FC6xlNlI5jnKX9opH9khGlVMhzDjMqQl7l5hL1fPACnKqS/k1sFVvtUYKqVBtdxBBJJcTB1XSrRrXoAd9jHwStNz6+7TyWn0ZKDMr3yUoLe0E8QbdHXF4UCNMFMi9eCGPX5Y8Z2hp3dp/SSKm2/9xLBRpWpj4DhNs1TPhlJ0LIhCgbOl6nO9DFOkSBKtMTQVXB9AQtMYIbgOfyfuiQ5/f4R2vLEkVek9Ucyw0pqNTYn4GRyVAtQ7niBZYU7+YQtKp4pOp/sodDBo5rtNgZQoitsTOZqrjA1rZf9BOTxmbKxD2FwAmKiMH8uVtbtrde/WXUcseKtVC6zoymQJoAH0DA8QATzQQh9sY1kiGZQITYNDKdY5eEVWAnqHo9JoY7BMNngYJNHJTlvIsMPOW092VtSO/94bFzo/bcSM+mKdMHdBPaJ3ATmmr5bUTm31R0obNTxoRKW45tlLEyG+GK7JrvIE2opprmtgOkn2FQAlPxOVCgIRNaXRJzjYc/T6KHxh2rE/zoFPIDS9FEJ/jQqJCWCO13eCpStWoY9F6OWskQ9RgomHla1EuqGoA1pXenYetV/ySA1MCLgJq8n2aapa822o4T/5XW/n+GlBVQwgjbnDkC+6TVEW/g1kYG26RJAigwb5GxQuH/EQQEtIWPBEq2Z304THCmlylvEaWNH
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(26005)(16526019)(40460700003)(83380400001)(2906002)(8936002)(336012)(31686004)(86362001)(186003)(81166007)(5660300002)(31696002)(47076005)(508600001)(2616005)(36860700001)(82960400001)(316002)(16576012)(36756003)(6916009)(70206006)(82310400005)(6706004)(70586007)(44832011)(356005)(956004)(403724002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 05:12:23.9833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5dffe446-c7aa-4952-d72b-08da36faa988
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2375
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 May 2022 05:12:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8359

From: Jan Kiszka <jan.kiszka@siemens.com>

Model ebg-signed-sysparts.inc analogously to ebg-sysparts.inc because
both in-tree users share already the configuration and kernel partition
entries, and that is also generally expected from downstream users.

Reported-by: Bao Cheng Su <baocheng.su@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 wic/ebg-signed-bootloader.inc                 | 2 --
 wic/ebg-signed-sysparts.inc                   | 8 ++++++++
 wic/qemu-amd64-efibootguard-secureboot.wks.in | 7 +------
 wic/qemu-arm64-efibootguard-secureboot.wks.in | 7 +------
 4 files changed, 10 insertions(+), 14 deletions(-)
 delete mode 100644 wic/ebg-signed-bootloader.inc
 create mode 100644 wic/ebg-signed-sysparts.inc

diff --git a/wic/ebg-signed-bootloader.inc b/wic/ebg-signed-bootloader.inc
deleted file mode 100644
index 62ebca9..0000000
--- a/wic/ebg-signed-bootloader.inc
+++ /dev/null
@@ -1,2 +0,0 @@
-# EFI partition containing efibootguard bootloader binary
-part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
new file mode 100644
index 0000000..2d4d0e3
--- /dev/null
+++ b/wic/ebg-signed-sysparts.inc
@@ -0,0 +1,8 @@
+# default partition layout EFI Boot Guard usage, signed version
+
+# EFI partition containing efibootguard bootloader binary
+part --source efibootguard-efi  --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh"
+
+# EFI Boot Guard environment/config partitions plus Kernel files
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
+part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
index 4a0e987..e097eac 100644
--- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
@@ -1,9 +1,4 @@
-# EFI partition containing efibootguard bootloader binary
-include ebg-signed-bootloader.inc
-
-# EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
+include ebg-signed-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
index df6a9a1..b3bbed4 100644
--- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
+++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
@@ -1,9 +1,4 @@
-# EFI partition containing efibootguard bootloader binary
-include ebg-signed-bootloader.inc
-
-# EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh"
-part --source efibootguard-boot --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh"
+include ebg-signed-sysparts.inc
 
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
 part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
-- 
2.35.3

