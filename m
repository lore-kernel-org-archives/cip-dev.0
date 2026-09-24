Return-Path: <hung.tran.jy@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB43C9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:45:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5963.1790250340747120461
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:45:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=b9nD8Hdo;
 spf=pass (domain: renesas.com, ip: 52.101.125.12, mailfrom: hung.tran.jy@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GDkgbMueY+oOUrAWHtA7RdJvNFepQ3TvSFAgdtpROagGjqCoXY0aUK5S36T8HSXzZvcDsicSVqhw8/GOKGqXUJDWH8l8yW2MPVT6mJqBNV/L5RYPqYDzEMQmqCCBMmieEfZxCqnW1byWdX40mQ3/SxDkw5D4tYMjvcxv6lOiQcNqnbV9VHA1dEKNiXweNf0HOqWC9mfhR33PUts+aVDGFwDG23AXZZaH0hV1qq/1mYKCxIHAuJs/pAGgdjLHkwbkZLFZ+ugUqACIdaVfxE3mOnaGDTIIAqKnarxp3wVk+BRTm/E0vxtbgXE3nQUx6Fo5wzFIBfENdAAjobn5pKavDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miJpIVp70dfnyEg3LguObNPxba8feg2dgwAhnUMU6gM=;
 b=d7ZJDss3NoBZUwN4Ieu2j+RU2WrNkArwM/i1y+UdUHsX6f39Q2MftOEDJ4NGer2vp5EklntNRTF752LLwytwvtvQ/4SQxuem2cO+DJNhwcglQU0RkK1yXtqtebrw9L87sFTt+AhYH95ZqvMRlQb4CDeSgrjCrHefoRrrex4UyUYs1PYfDnYkJicQjA6gK7V1b/ysEbqD/YU0NhU4vwjKXvuFBZvcQFG6gXOOjR6OrUgJBNeEgQy+PitzEZnf+Zuw1PI6ca0MyTpPUg1Db10gugNnrZUeEq6m7oYXV/tjJujm4RITQ7Ad0Mjz+G4bDcq2yJWXQZW3G8pHcfOrdbRLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miJpIVp70dfnyEg3LguObNPxba8feg2dgwAhnUMU6gM=;
 b=b9nD8HdofAx1bz3EhgAVsxxGPDfebWR/NsGQK96GRwXzjmqBRczyCPDR1a/K/SInxyPqRwteM6eySewI3TNajbsSSvWzt4XT/VbwvCzHomUYD1K3akUlvnFmB6l2zKdKEGQ8PsgR89L1NjFnqgBPXKSCFhNTS9wdUhjw8dHhzUg=
Received: from TY4PR01CA0037.jpnprd01.prod.outlook.com (2603:1096:405:2bd::10)
 by TY4PR01MB13959.jpnprd01.prod.outlook.com (2603:1096:405:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:45:34 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2bd:cafe::96) by TY4PR01CA0037.outlook.office365.com
 (2603:1096:405:2bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 11:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 11:45:34 +0000
Received: from VNM-5CG30610QM.adwin.renesas.com (VNM-5CG30610QM.adwin.renesas.com [10.231.33.39])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 4A6FA30001E7;
	Thu, 24 Sep 2026 20:45:33 +0900 (JST)
From: Hung Tran <hung.tran.jy@renesas.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com
Subject: [isar-cip-core][PATCH v4 2/2] ci: Add rzt2h-evk build target
Date: Thu, 24 Sep 2026 18:45:29 +0700
Message-ID: <20260924114529.962-3-hung.tran.jy@renesas.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260924114529.962-1-hung.tran.jy@renesas.com>
References: <20260924114529.962-1-hung.tran.jy@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TY4PR01MB13959:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 51e17df3-5b5d-44af-0413-08df1a3157ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	22MYIztIEUGTVqvuJrO3gPtSG/FIUN3kVkVNbxMu5/eXpVsI9+6gUUlcvItYJyfWR/5FQMnCdM+OWeVV8Kl7INitOrm6NvifAwIJgIbYmThM2+znVsDKB0UQ/fxUKY21phGuwY8nJwEpAkd+vKaIZcKfgfdCqwMV4wYr3g/JTPPz7w45rfxg5omyONxdIY2Ui6IlI0vGB1D47cexpyWgjHQb+KwcsILNVn0FuZMs4hto11hdjPy0R8E0kDetvbHC0tB5rAHd9jUCNrY0Vo0QO04ANMOV26rjdX/9YusXaVPwR0syM6oRxQpfbKZevTLzRFaEB55sP0k8g+NS13I3NPFs2/lWF7Ss++b52bvWbimlmT0kDCpZ1IXFs6RkBf7ZKCbv2D1OSzinw0K1tn4VSq16FXcHNlS7zucyMQHKyXr0a38oofQLrvsaqpLg0n0DIfixINacCx6Rda6B3ERoljGVMOsIoqQc+ijMpACy5NGTaarclPhY8iQOXXsXPNh12rkzrroGLQYIEJ3XVcBkwtHqnxBOy21LZoZHz2yN2CfsGLpiNdYr38RQJY8iyOlSL0btcAi+crSYSAOXhSOZXQ0IXMjxoxODDvBA5F261EdQ/sMGPRPPW4d/JaI3012ewf7XUQc2iN7nBLhyTv4eALG7yPUujcwBgGVgFanhRPOLNFwRwEVDM2vAT5BNMhIconqgyUp+6GPCJ7LI00EoaA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	T4XxregAMHDSXfo2+LCADykwctJYS0UbVGipjL7ko6L9rZzRCgXWRN6j7Q1vVJ1EH9sNSXRrU4vMSIBwh4EtD62gize5wWiBnvxylvwYRukCKCHDJjW/LlgsxfAMnkAvA/FZjhHL9FcnB3jgfb6Axmn0zto1iRirpG8e1w3UbRonYtn23TXxvuvO9QotuKbElNsp+p86HashAJ0b/HtMnkmo7oFeh7US2VlmROkVzWNeiiVGQWlgGuXv7a+4jaW16tT1BGwKxHOOT76NzspYLAW5KQDnywmxhma6sLTfZEBpTHuLwcQRANzobnv03ZjmY1g0gOnyDucUTso2eidcS82dFRsfuk3lzakgE9ongX/AJKnqJ0Re8wgvBr+uj5e/1Oa/I+lT9KYhRIrr2oJ4Oy3NiosusPO8t29UAxFs/KRS0jIhHC2fEwXs2tnPDQZJ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:45:34.1460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e17df3-5b5d-44af-0413-08df1a3157ff
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13959
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:45:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24335

Signed-off-by: Hung Tran <hung.tran.jy@renesas.com>
---
 .gitlab-ci.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 5a20ad6..57fd01e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -122,6 +122,13 @@ build:hihope-rzg2m-base:
     target: hihope-rzg2m
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
=20
+build:rzt2h-evk-base:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+
 build:qemu-amd64-base:
   extends:
     - .build_base
@@ -196,6 +203,14 @@ build:hihope-rzg2m-test:
     extension: test
     dtb: r8a774a1-hihope-rzg2m-ex.dtb
=20
+build:rzt2h-evk-test:
+  extends:
+    - .build_base
+  variables:
+    target: rzt2h-evk
+    extension: test
+    dtb: r9a09g077m44-rzt2h-evk.dtb
+
 build:qemu-amd64-test-nokernel:
   extends:
     - .build_base
--=20
2.37.1


