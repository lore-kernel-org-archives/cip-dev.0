Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B95C433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 06:42:14 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.58])
 by mx.groups.io with SMTP id smtpd.web08.48109.1638772933229044695
 for <cip-dev@lists.cip-project.org>;
 Sun, 05 Dec 2021 22:42:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=KV7E8Ddw;
 spf=pass (domain: siemens.com, ip: 40.107.8.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuL6UQbx9j3Q5JyUKW6E2pEYZAHUVwE/68F1qHFxcrIANuJEiRGhuHbvBmymII4jZMnDjVgcFjUFR7RdCD2CBnl9U1TPOT6Xi3XSbNX0zN5/w7n29ly3iOD7vUIX4PjRfB27ke+wjzXpOF+AS8tlnEfQOMIwAKdPv+4UJP8Hofy5EjTHdnpyc2qrfHRnsTALkPNpxzmLo/qLLuyOHWG2aCfKKXznWCUxRyk/Yp8gm13sXlE0oi9Uu2Jy0Cbn3UFBz1HvUVpa/0b+ePEepRG+NvgXMZX/AAfWNJXxfzax8SW0xtp1F6sU1+hKMURisQl2tuVIeR/zPCBXCwy/0z8Qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf+1CddfSDjWJqFr3szKZ2L6e8qKpcdbrzpiZffcwlY=;
 b=K109RSBR3Yh1l4jilJhDoHnyeREgx/ZlcS89RH+lIgrkM2vGiQCHKS2IOil+NDzaxDkIE2HcM13zG8YTwLInWSQBfp+kl1RjJ3jqAj8emP45pla1jMkF+cW2b4fOg8h2pR5vhGGqUR3lYGXfVNb8p66/7ik/vA8xn6icd+XJbs9Ex2j/oskdf+U4zmBZcou5DD7wzxX6O3gJ5rW9kHmj06dr4YO/YxXEUNcQl7Ahow6aw3zTRPrScHSdGTAE6RlyC9Yp2Lw3n4bDbxamwBIdEBkbyTG0mtzTVnlbkYmkHVt9weSnxT5iU7jdSvTy09IMg7gaYDFZ/dJy9sCraH9HYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf+1CddfSDjWJqFr3szKZ2L6e8qKpcdbrzpiZffcwlY=;
 b=KV7E8DdwBsGaB8N20HztD+xxwbUENBST7DAEHaLAMbLwuCIYTrRZGFmMXCeqE5XX2nNGnX1JKorODstv8hKmnGOY5SEZj63VrDbAlS59jQYmpqxKdgEFqYlYzh0KNBY4hfZqEim0XGInkf11slS8Uiw2TthSDiTtdAfD388zzUV3fDVeBluqW9cevqWyhV+dbcfYwX8+3aXVHg+QZD4yPbFmVu9BjCHFdqoxjGv7I9AjM8Ll+cJ25TNQAWXVUJA10FrwI4RtBWP4ARCL01SgjvxufNNOWOGThBWpnS1RtDKn2AZgI5nPv3BcUd7MqvZKX5+mFEJCmXPt3r+aoXEkaQ==
Received: from SV0P279CA0037.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::6) by
 VI1PR10MB2752.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e7::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.16; Mon, 6 Dec 2021 06:41:48 +0000
Received: from HE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::a8) by SV0P279CA0037.outlook.office365.com
 (2603:10a6:f10:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend
 Transport; Mon, 6 Dec 2021 06:41:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT037.mail.protection.outlook.com (10.152.1.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 06:41:47 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Dec 2021 07:41:46 +0100
Received: from md1f2u6c.ad001.siemens.net (139.22.134.173) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Dec 2021 07:41:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 1/2] Add kas option to selection 4.19
 explicitly
Date: Mon, 6 Dec 2021 07:41:36 +0100
Message-ID: 
 <324d5cb55674ab805ae4f190d339824439a54a5f.1638772896.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638772896.git.jan.kiszka@siemens.com>
References: <cover.1638772896.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [139.22.134.173]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d41519be-5118-4049-f420-08d9b88379b8
X-MS-TrafficTypeDiagnostic: VI1PR10MB2752:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB27526D5889C4287D001A02F0956D9@VI1PR10MB2752.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yiKgyLStFPqnYbmhIEqZSANvPBxME+8gm7CzoZZzW4fFMvCYP0pxu6mjdAalusZ0vDpx8+L9SJOuNdplez65vuiaLjAUCaikbR8/fKT2FLe87u/cQqssZ98ZrTTrVHQGkdPVWo530Q6JfFfxIO+apKgzFAeGV4vaPVv7U1Xd5h1frVK356q//vMy8Yno+ew/ALcmISyqPkEN/2KTWqdoa3wzm4gYlVAQS7RW3iftJwPrCU5m/DYsRgpnddpwkYyl4YjkAi3nyRW2o/y0BDa36YR6oPuHK+mhfE0ti3Jye/xTlGUABJvYk4oQy4Y7xDQL1x0zyU7VkjIX25fYXrY0yPr00MP0Df3G1pkdmahKi4a9A8H5wFQ+qrPMu5oA7SskKrdrl0e2nmPeNoijtoGGsgVXcKIn4as637nT+Q/5B5qlfTdbqjj65tUu7hZ+iucEJMRpxneT9kggq9T9abKMJ8Sx44+0WNI/aMVbwinUXo9bRkxH7YeJtx+ySZZFKmfhaPxOAAWiVP2QJH7DUzhuJh9k8aQLJaSiH+XRhq2rrU36ArDzvjIzn3X4YarsT2HwUzMOfHKWa4ILq66c50LWOzYmlKyhyykcfRTB2kyfAEfJ8A+xCHBMEsdutAsDlnPBDeFi8bLenSTodEyQqISphyi1RhNuRUSKDFSYGjD3U7p9FcqmzDsAcSx/ycGsqzuKp3Ku7HAXUAaD07fQgsMpsyID/Bcil83ENVnwQ/bUOUmR8bOEtZJUC4VpNR/5jzsdYn7kY6B6ok63/F2iAwmXDNHfqSZMsrzugitQLdJx6BA=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(82960400001)(36860700001)(82310400004)(36756003)(81166007)(86362001)(356005)(5660300002)(47076005)(26005)(316002)(2906002)(16526019)(186003)(44832011)(83380400001)(508600001)(8936002)(336012)(6666004)(70206006)(70586007)(8676002)(956004)(2616005)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 06:41:47.1178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d41519be-5118-4049-f420-08d9b88379b8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT037.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2752
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 06:42:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7066

From: Jan Kiszka <jan.kiszka@siemens.com>

The distro configs provide a default choice of the kernel version.
Therefore, we cannot rely on 4.19 being chosen when not providing any
kas option file.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig          |  4 ++--
 kas/opt/4.19.yml | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 kas/opt/4.19.yml

diff --git a/Kconfig b/Kconfig
index e5ce257..ca67f30 100644
--- a/Kconfig
+++ b/Kconfig
@@ -61,8 +61,8 @@ endchoice
=20
 config KAS_INCLUDE_KERNEL
 	string
-	default "kas/opt/4.4.yml"
-	depends on KERNEL_4_4
+	default "kas/opt/4.4.yml" if KERNEL_4_4
+	default "kas/opt/4.19.yml" if KERNEL_4_19
=20
 config KERNEL_RT
 	bool "Real-time CIP kernel"
diff --git a/kas/opt/4.19.yml b/kas/opt/4.19.yml
new file mode 100644
index 0000000..5ff1683
--- /dev/null
+++ b/kas/opt/4.19.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+local_conf_header:
+  kernel-version: |
+    PREFERRED_VERSION_linux-cip =3D "4.19.%"
+    PREFERRED_VERSION_linux-cip-rt =3D "4.19.%"
--=20
2.31.1


