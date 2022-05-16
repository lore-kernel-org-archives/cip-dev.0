Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A903C433F5
	for <webhook@archiver.kernel.org>; Mon, 16 May 2022 06:15:47 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web11.25596.1652681736988169305
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 May 2022 23:15:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xjSTJxPH;
 spf=pass (domain: siemens.com, ip: 40.107.20.61,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kY64+57wL6PcpNFlOjrOwEG6CEa7bbsqw8Bh4wu0os+nNo+tQPlDZIttV7tt54cBtbLwpOFzWxUZN0UwiytJUFtVmbzbRv8jncMchQ9NX+OAtcizdqmlxft/zmpy4DpDXioggyIW6one6L84rD2br4U8qZreCOndsfFmBgok2gVUSJvCIztlpnzjytM7cEYXGUMBUeqKkOfXfbVTgKtr5IGpg/ebvYOlcFViVYB7W8VSHcLNnSt5ITWqCeEGvT5cJDpApQ2/+D/Fk4QiOPubn0EyP8vInILJb1hSj4s6tSeD82S/fM6oxVggsG0NPb8vuIkrNRRrSt1WjphZYCOctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Yu484V8uwKz7ZfNViJiWUP8aHJ9xARLbqprE2V+y3U=;
 b=Zsp3BdaN5IX86LMKSgSCUC78CjnQa8KlkP6NG0aelqtfhc1tIi+Odw7HdZ/2ddK/DpSIBPdI/6KQMoY0Hgejj0UwQH9eGe41ESrHRdjbm2meig+VXYT5ZHa2Z1Sc83uYny53HkjdGcV7hppfQnZXzHaRlfBEmRR8ESGDUu2DsQPLSzNat/CsYaMjSha0Vbocmw/YUKXQcANi8y7XCZ/TewW11cmzq9FTHaZGj4RYf9x1u5OOd0PoffyGb4UAXlHEL+FqLJZfACNXlqbXR0ZCdWVAe/DsE3JeHLqeB3axRaXi6/CoGn/fw5cC8/ECOE0atGMODpxoKD+G7fB15Zm3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Yu484V8uwKz7ZfNViJiWUP8aHJ9xARLbqprE2V+y3U=;
 b=xjSTJxPHwI6SaIsFDzbtfnZvJCJMt/vRN40rBTgbPxXmIVDqDZI2vzZDS17Jlb6eWhlPYThjgfim7FDtQHjE7GhyaALs3tTYHEF18PBPOhMr8LTUOMp92YbOlFliDWUyosWnrH5spFs6EMhe38B1rSaFWtnTKBuVEiH4t9Bvbh6W9oRCPI6AVb3oyBy73PwUjG3tFESJyPnognDQfNCkPPwq7PHjg+Xn/7JwtmBN05CEjs6wuSxqugx7JWHOEpB49byBuoyweF+vc64S/8SUF1PFYtxe608vS/PVUaFf81u11CLYijmqwuxJRYdOfwjQNQq4jYbJr5ALlVTmconH1Q==
Received: from DB7PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:10:52::36)
 by AM6PR10MB2166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Mon, 16 May
 2022 06:15:33 +0000
Received: from DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::22) by DB7PR02CA0023.outlook.office365.com
 (2603:10a6:10:52::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18 via Frontend
 Transport; Mon, 16 May 2022 06:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT096.mail.protection.outlook.com (10.152.5.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Mon, 16 May 2022 06:15:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 16 May 2022 08:15:32 +0200
Received: from [167.87.72.34] (167.87.72.34) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 16 May
 2022 08:15:32 +0200
Message-ID: <0de868e7-ea59-9104-0020-148652639149@siemens.com>
Date: Mon, 16 May 2022 08:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.242-cip73,
 5.10.115-cip7 and 5.10.104-cip3-rt3
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.34]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.471900-8.000000
X-TMASE-MatchedRID: adP96OFoHOTS9Lrebk3ayx9K6LGpAwssewL/wS9/asecVWc2a+/ju9XL
	iEcLf+DIbDD7i2QfyEf47Xv617HbR+lhEE2ihF7k7wRfMl8BEvWtYv/FAmebjp4CIKY/Hg3AtOt
	1ofVlaoLkLicApmKhAVCLB9o7PIpzjoczmuoPCq0xW/3B5WpScnT4XV23GA1zPs292k8kLzNJ+D
	1EUhbEaIfgTNsyjD+B
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.471900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 D63D4272D45D74F7CE4CBD3CA5C439A495F3E79847A8C97269B6C7C24F67E3982000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cadb0b0-46f3-410c-4c46-08da37037c0f
X-MS-TrafficTypeDiagnostic: AM6PR10MB2166:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2166648EB83A2A96ACF404A295CF9@AM6PR10MB2166.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6yEboBmvD9oDedFApuuBaLthNHjk6lvocgX+zmXNZ38OxdbjyZvIHsQzIiPmNgicoNy576vztxC+jX8mHtEHZ6PUIKgdXCedkJxIT/O6LaU6KfNFOXEmXhrnPd3CqKPeANkLCk7Jz91jb/rXognjxNECtWVxh7wpWP48Nb36m6beDH+RAvASwTubuz9J0R3CfCEUa8dGWgh1qqzmFV4tU68+gMxujdJJsv6IN2QnQhnqIpDcXd/uCc0F+0RwwBmgzn5os0oNhMZOQ8w3Vr2Txb2mmsW0gd8aeqzuhq8jf4u9edJfJQ8tCea0Z3qeoQ9RPlWWtoFJFPLJM/sJK1chVishgMvuVs7NXQf3BqeivpBV2sgDOyq2vo4Jlma2uQVH1eG+DAmFfzfHM6sZ2ktUvvp7DhpliC0gzV+iOwp0GWJqyLWdt9+vZjGYJyP3SmPjjh8Jtyzk7DKn2wyXgtEPmeBZp9gWOIIbUV+M2uOzjbgiWgGBVA9VAbSyPX1VJhkHxbM8AWz6nPZ40Xjgg3kfkJ+QkSHyjZK1sDYotVx4mw7GimWTwt8026N32yEXkUi4XcEkNz1bR1mnOs6bD0v1pVmaJreP3vLQwgoZWSlQmZNQPW4rkuXK9zyFuZ7fDCCo0n3y2VaUq/1VzwESxRQZYAJQrbPWfmc3FHn0g3ntCMus5/y6Dq9I5fE/8ypOt5QnQ5hhArvEEW/Jtpi/+KJ93eZEkL/94lywT3EAtcK+k2oTDaYlyoOqTA0vNYcoLDVBNaWMJy0ecOuk0RPMWAQ01g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(36860700001)(81166007)(44832011)(2906002)(86362001)(40460700003)(8936002)(31696002)(82310400005)(82960400001)(70586007)(5660300002)(6706004)(508600001)(70206006)(6916009)(16576012)(356005)(186003)(83380400001)(16526019)(8676002)(956004)(2616005)(336012)(36756003)(31686004)(316002)(47076005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2022 06:15:33.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0cadb0b0-46f3-410c-4c46-08da37037c0f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT096.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2166
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 May 2022 06:15:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8360

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...t_5.10.104-cip3-rt3.bb => linux-cip-rt_5.10.109-cip5-rt4.bb} | 2 +-
 ...{linux-cip_4.19.239-cip72.bb => linux-cip_4.19.242-cip73.bb} | 2 +-
 .../{linux-cip_5.10.112-cip6.bb => linux-cip_5.10.115-cip7.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.104-cip3-rt3.bb => linux-cip-rt_5.10.109-cip5-rt4.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.239-cip72.bb => linux-cip_4.19.242-cip73.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.112-cip6.bb => linux-cip_5.10.115-cip7.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.104-cip3-rt3.bb b/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.104-cip3-rt3.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
index 7d00418..fe20915 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.104-cip3-rt3.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "5455a0270bc098c82ee6a9b759db9fe1fb4f43a5fa9c8275bf129dbe2c38c91c"
+SRC_URI[sha256sum] = "ca42d37fa68769259a065d766ed266b7e0ac97b018febbec2ce71db7e19f968a"
diff --git a/recipes-kernel/linux/linux-cip_4.19.239-cip72.bb b/recipes-kernel/linux/linux-cip_4.19.242-cip73.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
rename to recipes-kernel/linux/linux-cip_4.19.242-cip73.bb
index 718bbfb..4ef0089 100644
--- a/recipes-kernel/linux/linux-cip_4.19.239-cip72.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.242-cip73.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "5f22ea902c89b1cd178706411e48a40613c1db069fa7dc5993b979fd4652c2cd"
+SRC_URI[sha256sum] = "899527410a0034f859a3c05aa33d877c70db0b36ef6715c370e800015ea5ff0f"
diff --git a/recipes-kernel/linux/linux-cip_5.10.112-cip6.bb b/recipes-kernel/linux/linux-cip_5.10.115-cip7.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
rename to recipes-kernel/linux/linux-cip_5.10.115-cip7.bb
index b54dcb5..9828eee 100644
--- a/recipes-kernel/linux/linux-cip_5.10.112-cip6.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.115-cip7.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "aedeaefcb3da02fe6ab36859eb15c2e36844b2a0ea828a902b85037ad145e1ee"
+SRC_URI[sha256sum] = "55efd266d16eea2ef27dceff6088794d94a044a733096c7129848cd2f13c8dfb"
-- 
2.35.3

