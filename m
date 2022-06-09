Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC75FC43334
	for <webhook@archiver.kernel.org>; Thu,  9 Jun 2022 13:53:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.74])
 by mx.groups.io with SMTP id smtpd.web08.13676.1654782773723629055
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jun 2022 06:52:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uoJSEwaF;
 spf=pass (domain: siemens.com, ip: 40.107.21.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USfgN77cYMgzwMD24v3vv0ortkm/R6NcwnQaxSv/iYinTESMmU2kMCGpaTxAwBULPB4QiBs4ayviqrZkR2DhDq/MzVfXw63IeLdFcoK7ZXNXdwXJodHpdoudmnY852RH0wkuU3N3yIMBcnPmknCjI2JrtQAGRM3z3I4dRCbRwl7pY5n6XLMaC0slDAkPdxfvOYF0R+Rw6C6MIJvXqreGv9qLmYyvg6S52TUQ/zRMFPVSuOyok3iGBFekdhhncjVNxDcYc6HYJ0DuPIGQV5LlwLChknnrxp3bdfJXhxxC1Oe4RHuduwm5D0UsqiBREnlvyqTlpxIClja42LigegwVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6fdHlKF5SJlj58fl5SlzwIFtxWBsWr6pwVtu5th8BI=;
 b=N8EpI9lIGj8H2DZQR8FCrf2MIe7HiVujo+DUuXMAF+z9piAPdjYmxa21gq92JHzWnr5LH9c/1UHSs2uMb3ISPZ04Q4lt5ADINSBo4qo1UTnZvsPD5N9ROhQmmapZITz/zaStpekJAIe+TmuUCPjcHQCdZTUkJDhk+fqMWEy58f5JvvGnwonyjtPnitL7eZrhbb6I3h5gTOGyGJkWO/Q3njMZUxP9f7pf9UD1QCT1ljXuQ4q3JzbxyIUqtWdlcCWXLH8v4mAGi1qoCdtBu2PW5qi/bYSlasXD7rpM88CI58MpfLxS7EuqRuKIqCYfApIxWpU+8+T3f3B7g/hE6PHm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6fdHlKF5SJlj58fl5SlzwIFtxWBsWr6pwVtu5th8BI=;
 b=uoJSEwaFj+WYGSyRwyHsy2WqDuZ9ne7Wsa9Ej8mIw1s+/AgSX0w1weBxjcnonpEFuDiiuQEwQ3vJKo/wBO2kUhr6SbbYOIFdyB+cr39OkZKQXv3IZAJWhhJH/tSYutdK3p4bbHyWLzsPdrparEErbxnz+iY91uTjaUVnhPWIrSriX8WwljEhhS8MKLjsuIMme86AFqiqDsa+toRUHokRFWWZGvwsy/GKQk16ahZvimWmxFJ/kBEpWbLthpqZCxr9R8z6t+qXZAGWpHFZksCucV1Lvg+UrHWJm4IVEhZpsVQW85yZMULq1PbAdzHlsAozUvXJ+y9m6+tTZ/PG8MME0A==
Received: from OL1P279CA0060.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::11)
 by DB8PR10MB3354.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Thu, 9 Jun
 2022 13:52:50 +0000
Received: from HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::e9) by OL1P279CA0060.outlook.office365.com
 (2603:10a6:e10:15::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Thu, 9 Jun 2022 13:52:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT014.mail.protection.outlook.com (10.152.0.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Thu, 9 Jun 2022 13:52:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 9 Jun 2022 15:52:49 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Thu, 9 Jun
 2022 15:52:48 +0200
Message-ID: <b1fc51ec-6169-24a1-16aa-a34dc45b41fb@siemens.com>
Date: Thu, 9 Jun 2022 15:52:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.245-cip74-rt25,
 4.4.302-cip69-rt39
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--10.527200-8.000000
X-TMASE-MatchedRID: dh+U1xplaFPS9Lrebk3ayx9K6LGpAwssewL/wS9/asecVWc2a+/ju9XL
	iEcLf+DIbDD7i2QfyEf47Xv617HbR+lhEE2ihF7kSV/SZA89A/54lxq7pFBUUU7yqWc5cVLPQuL
	GuwInWNPBILqohnmeSaPFjJEFr+olA9Mriq0CDAjYh0PvnvUH8H8kY1ZzJWnfxEHRux+uk8h+IC
	quNi0WJHTlkArQVc1fcULuDb6S7VK3lAxxxFAwUV6GgF0ZHgyNftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--10.527200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6BB15D95E664115FB884B7D75BE1E1CF75994F6D27781A05BB2CE8F2E31365382000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9de6d9d8-9018-40ff-3df1-08da4a1f5795
X-MS-TrafficTypeDiagnostic: DB8PR10MB3354:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB335432CAF7C909630F44D84195A79@DB8PR10MB3354.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uXvs1K3bLUCacr6qoI3LxygBmvbrH9p0u00O3fXhjrulwacE/UIl4ROeigmNEwP56pahP1gueUpa1Qtfscj+UoEuFC7OU5dUhyZ3fxwMCwa6520PBBTw+ilqyEb4ZFhA3j3mg/IZmlgt1htAQMB9dwAwgenFf5xVCr3qrR5noPwSCAge8tmMcR/H0+G/qZRSHgXSBH6YS/JLvUtrkWBbQ3omDIq7bLPw4zQ5AfNOdSNNFf8dGeE9RPJninX6fZqBIkVG5Deo+2CXoKoAlQnSlBPzAwbgqLiMlv99wroGT+JfLy0YZGeRukwxnuZhtkH/7d3Gyt7EBacE/rq1Y6xyodtSApAp+XFxNPipMe4CIUDrH3ZHciYu0A1u74G7CdPnK+E2I1HIECVweqSNcjFK5/qYcwObLzn1XHUFbwjiI+4gOlieNk4mJ1dzyXDr1md7OiZlyWy+sHhzIues5hG3TwG16YxeTfZRgmUChE/1eYDYGVlgIHUmxRr5wf7PFSjFuKveQjyohHI4qCC+75EXA5J5ee8Hn3HDe2Hy/kksZV8pGVbYSYYGAFhWdnGQp0D0a51aQYTVwsstBnW3hFsH/eurMyMcPK5mpqkhnMK1A2yjbuwt8eRdyc2MYZ8U81s+A+DOQoC4UNd4Gz+PLYllOk9GescWQbhNrGKEsbyA+9YK7c8lWl7XOZIK3BYMU9oPzfliUDds+OUfybp0BsPqYCd/+7ZsvR+mE+ZzEWGc+ubHL5HQ3pVr4Cbta545+maM3X/FhqJt/DDJGFqwHV+69A==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(82960400001)(508600001)(31696002)(16576012)(47076005)(356005)(26005)(2906002)(86362001)(186003)(81166007)(5660300002)(44832011)(31686004)(36756003)(316002)(2616005)(956004)(16526019)(336012)(8676002)(83380400001)(6706004)(6916009)(36860700001)(70206006)(70586007)(40460700003)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 13:52:49.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9de6d9d8-9018-40ff-3df1-08da4a1f5795
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT014.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3354
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Jun 2022 13:53:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8523

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....233-cip69-rt24.bb => linux-cip-rt_4.19.245-cip74-rt25.bb} | 2 +-
 ...4.302-cip68-rt38.bb => linux-cip-rt_4.4.302-cip69-rt39.bb} | 4 ++--
 ...inux-cip_4.19.242-cip73.bb => linux-cip_4.19.245-cip74.bb} | 2 +-
 ...{linux-cip_5.10.115-cip7.bb => linux-cip_5.10.118-cip8.bb} | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.233-cip69-rt24.bb => linux-cip-rt_4.19.245-cip74-rt25.bb} (72%)
 rename recipes-kernel/linux/{linux-cip-rt_4.4.302-cip68-rt38.bb => linux-cip-rt_4.4.302-cip69-rt39.bb} (60%)
 rename recipes-kernel/linux/{linux-cip_4.19.242-cip73.bb => linux-cip_4.19.245-cip74.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.115-cip7.bb => linux-cip_5.10.118-cip8.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.233-cip69-rt24.bb b/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_4.19.233-cip69-rt24.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
index 6d1a97a..7f89253 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.233-cip69-rt24.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "ba959c6591e114d85a0ae9bfe60d4e4eb4bf1b2b02c3b9f3de2dfc692cca112e"
+SRC_URI[sha256sum] = "436c7578711e67332c7a569fd5966c69e41d872a89faab211fd6b00fe2077b5b"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
rename to recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
index fae4125..c36c51d 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip68-rt38.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019 - 2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "bbcc9af1b08a1285a9fc5ba57cba74dcc9fb6511dd74029576ca82629d04cad7"
+SRC_URI[sha256sum] = "b5f267fa436e5d5e729f1febb741171cb1df5a576400d06999202f733d8e67ed"
diff --git a/recipes-kernel/linux/linux-cip_4.19.242-cip73.bb b/recipes-kernel/linux/linux-cip_4.19.245-cip74.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.242-cip73.bb
rename to recipes-kernel/linux/linux-cip_4.19.245-cip74.bb
index 4ef0089..b0e3c2f 100644
--- a/recipes-kernel/linux/linux-cip_4.19.242-cip73.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.245-cip74.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "899527410a0034f859a3c05aa33d877c70db0b36ef6715c370e800015ea5ff0f"
+SRC_URI[sha256sum] = "a2e05d275f4dbe53d23eb575e30fed6a30f1df8dfd8ae73007c626b41a03fd1c"
diff --git a/recipes-kernel/linux/linux-cip_5.10.115-cip7.bb b/recipes-kernel/linux/linux-cip_5.10.118-cip8.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.115-cip7.bb
rename to recipes-kernel/linux/linux-cip_5.10.118-cip8.bb
index 9828eee..8b3d5e5 100644
--- a/recipes-kernel/linux/linux-cip_5.10.115-cip7.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.118-cip8.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "55efd266d16eea2ef27dceff6088794d94a044a733096c7129848cd2f13c8dfb"
+SRC_URI[sha256sum] = "d44a956544fcedad07f9dd7a9b20dcaf911226f6ef975d31c1b9fffc3b544fc6"
-- 
2.35.3

