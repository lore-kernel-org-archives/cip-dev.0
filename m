Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383D2C43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 06:58:25 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.89])
 by mx.groups.io with SMTP id smtpd.web12.2967.1655103494600184895
 for <cip-dev@lists.cip-project.org>;
 Sun, 12 Jun 2022 23:58:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ssLjzkTj;
 spf=pass (domain: siemens.com, ip: 40.107.1.89,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQSHElQ9SrOaLBsOgtcO3BQL74YzxYgEAxGlgx70s6MJyTloq3zvUYGD4HtQ4P1QkHgjxBP19RxCNg2Dr3kHOQ25CwGYzWNGIQjWxzy9OcbiGQQZHdUUPnw97kCI9n5xTh1u2/ggqGSWU5Om0yNceiujqYRCz7MM+eELy1zm81c6JsFFPWMkXkLC9SSXzPvSnpMk8UrkDiMwpNBlAiCTBpbZGpSnMnLp8B2WZbdtlWyL+Z3i9MULvKRu0LjZ1tpMo/0glNLtWlLJzE3X1s2npdwAmHMLU8riuE0rfEe324yOMCEDBAt42PeCGF3C7fwxBxNrUnqQLtg+9koDGV4ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIIvhI7/u1HJQxfCZEAgR/K6j1wIwR3gT58pXdsZBMA=;
 b=gV3xy5ZtLEHRY5qnVPnHBcRFRPSls921LmtvwJLGSBpsKUPtQDd+mJDF1aG3/h+JEKM+SHjRXeoh3BMxTBrR7hHjNfRH6FI06kyafiLeKxhUWOQO4ytPfrRWZmYagSG8pQV/caafsVhCrDfKKnE/29NuacJmC78VdxidBZlHtDcVx+RggqDN3BEeg/mbVe+YtIQ0sGE/wJnGnr5hzYUtPQdwZnWCAeWYaxfZB4/zv8DQcAoDeL/loPxoSVI9v0OaZ0OGwCyuKnGCDf45Z4h1gCsTo11uiaatcrMFiWg5pO9NuXOMhd5nX3tAbTEKgI1ERJsq3wNKkm5+s3QnqA3vlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIIvhI7/u1HJQxfCZEAgR/K6j1wIwR3gT58pXdsZBMA=;
 b=ssLjzkTjH65GnneN0/2vv4aVVFumaTFxCodfTjtPUgvtydMfaNnkP4pR5PZlt3HX9pcVTp12X8fnPI+uxlS7Kow5NUzVn4CUki+v+DkA4aTXyOkdo5gWsERkB5tAIfLio8LsFy4UVPzcQxotYGmqG4+mx6CD9RRi6uALUss4lV3CnYkeqJBLKbeLyIbkV+HBE2Xx3rOYQVgihDKTf8L4trm1QqNxxWWHlIXTlhPUVeRtCkjBgc2qN60StUFuyVPb+62KO/CoQ2q8zmRtY9dyCoTqRWGMAym292BpLWoiGYq2ODrbuVVYXU7/LElOXFdEECqM2udTwsqdhVO1/nyBBQ==
Received: from AS9PR06CA0745.eurprd06.prod.outlook.com (2603:10a6:20b:487::33)
 by HE1PR1001MB1274.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:3:f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 06:58:11 +0000
Received: from VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:487:cafe::f2) by AS9PR06CA0745.outlook.office365.com
 (2603:10a6:20b:487::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 06:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT079.mail.protection.outlook.com (10.152.3.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 06:58:10 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 13 Jun 2022 08:58:10 +0200
Received: from [167.87.5.173] (167.87.5.173) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 13 Jun
 2022 08:58:09 +0200
Message-ID: <6d7315d2-e1d8-8f17-018e-9dacfcd45c86@siemens.com>
Date: Mon, 13 Jun 2022 08:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.246-cip75 and
 5.10.121-cip9
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: "A, Srinuvasan" <Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.5.173]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.632800-8.000000
X-TMASE-MatchedRID: FMbbA5BboXpDh46X2zKVIBOqo33PiIGeUYR3k5IGZuY/QdUh6LEl0AEP
	JrYlsf/6tmTuCy5+VUqCyaW+JWkhai++B0pV1xLFtWKNR2epAFaR9GF2J2xqMzl/1fD/GopdnCG
	S1WQEGtCm4/3ODjvukSq2rl3dzGQ1UCh5j5/4rdNdU1ePE9OBINqJVDyNPch86NGNi1mIUs8nFp
	puQRSO9Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.632800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 DB1644AEC468EEB9236734A2410AE95026B7DA6F2FF556E967180DB34C340BF92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd82f3c7-b067-4385-6c85-08da4d0a13d9
X-MS-TrafficTypeDiagnostic: HE1PR1001MB1274:EE_
X-Microsoft-Antispam-PRVS: 
	<HE1PR1001MB1274E9AE9050F733FF0F506795AB9@HE1PR1001MB1274.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OvXIpcxWfN6Mz7ObrNtRF7oKBPkxBPfHQf33RyJB1QYUpoN/O0lvoEOPgA0m+kruZZLwzmmixoJ/M+R3d15O9pIN9lM7uSm/LwVVKZNPLlt58Fwp+2c6B9+Nsi/eFuWKS4QwQ1ZsmL3i9jc7hprOBsuBq+ewFMAWF2hu6n3tepMiZFAh55OXT2V1VaPuReGL2dc9LZSo3BeKBlJsh3Nay6Lg/23Rq6rK25d67N2t4B1mKPq7UFb9RUsYvKdBZVq/AbeIi6KX5aKxJcRFzAWOlYl9CmWG7FFrYcH9XG3tF24256lsA5rzWKjC7N4GvKUmD79ihNog0ZlVgaucwIeePDO1NGlhlT1pQJmdc4bo2sjCqDQWfW5pfag+VvOPbd6x1D6vMcfxllgK2YCrRCSEU0UiwHnmo9krqt8MIfkzfmj6dLhikQgqkgWOY/01T8k+fTNgyXsmpPKGE5D9DpZjpkYg8CzUklR2IXUrdtXexxG581I9R4HTfuUf2c/s4s2bodOx1VB9uzQZLo5ycl9oxYKZ5Zzp8tLHPjPZX8vRPxWa1aCTHNnWH6anojEeIT0pErRbrW9iIyW8uFuWTdx3CNZYC0Ba5TrkbndrJtXxmx2HfMzAqgqTuZ5m0+Fvdh3aAjH2ZpwT+TYtK2Jer1VGtFbZnyEWQEKa0qdh6lISmGOsAssIp6539RSupbRJ2/0eXP/bCBxP34awAjSQ4OyLfBMr1yiL0rN58Vq+92XVf5PldJRPVkVapfIBlnH6xBcQvS2UwlS12+DCx1w8c9jEvg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(86362001)(31686004)(36756003)(82310400005)(8676002)(4326008)(81166007)(16576012)(8936002)(44832011)(36860700001)(5660300002)(82960400001)(6916009)(70586007)(508600001)(2906002)(40460700003)(316002)(6706004)(70206006)(16526019)(47076005)(336012)(956004)(186003)(2616005)(26005)(31696002)(83380400001)(356005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 06:58:10.3905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dd82f3c7-b067-4385-6c85-08da4d0a13d9
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT079.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR1001MB1274
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 06:58:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8546

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.19.245-cip74.bb => linux-cip_4.19.246-cip75.bb} | 2 +-
 .../{linux-cip_5.10.118-cip8.bb => linux-cip_5.10.121-cip9.bb}  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.245-cip74.bb => linux-cip_4.19.246-cip75.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.118-cip8.bb => linux-cip_5.10.121-cip9.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.245-cip74.bb b/recipes-kernel/linux/linux-cip_4.19.246-cip75.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.245-cip74.bb
rename to recipes-kernel/linux/linux-cip_4.19.246-cip75.bb
index b0e3c2f..a4ae23e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.245-cip74.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.246-cip75.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "a2e05d275f4dbe53d23eb575e30fed6a30f1df8dfd8ae73007c626b41a03fd1c"
+SRC_URI[sha256sum] = "bf7c1c6a852ecc3daf6a8de302cc9e456aa05f8a72a34ba1941e43ace10e47c7"
diff --git a/recipes-kernel/linux/linux-cip_5.10.118-cip8.bb b/recipes-kernel/linux/linux-cip_5.10.121-cip9.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.118-cip8.bb
rename to recipes-kernel/linux/linux-cip_5.10.121-cip9.bb
index 8b3d5e5..0b08d62 100644
--- a/recipes-kernel/linux/linux-cip_5.10.118-cip8.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.121-cip9.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "d44a956544fcedad07f9dd7a9b20dcaf911226f6ef975d31c1b9fffc3b544fc6"
+SRC_URI[sha256sum] = "0be35d737212ae68cf8dea7c84bfac61f2b98aeec3df6f308692fbdfc80db743"
-- 
2.35.3

