Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E3BC433EF
	for <webhook@archiver.kernel.org>; Tue, 15 Feb 2022 09:43:00 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.78])
 by mx.groups.io with SMTP id smtpd.web09.7649.1644918177768062023
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Feb 2022 01:42:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t+EKLitR;
 spf=pass (domain: siemens.com, ip: 40.107.7.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1DGeIEu7SPo0YP0g79F3J59eqbG+yzUsUNCcN9AMv/SBP5GD1zUayX85N2lSzqMVSxXCQpNydKeJIMWXbrgMIs7yPXSFjTbYV/5s8nQCczUXbFbtLjdAzDEfLgpiVNVyP8LiaNbAvvYC44MBzVp+8pxE2ILzXjZZ+n0+SJa6TtIcf6/BexkYiNrCqlZCLS1QO4/Eo0wdon8DFPuYdwiDZqNtjpR/cNvDmLzh8pETM2tNCsyLin16uHgpVoFPkyhI4alXJtbgS4S/DQvkeFXvV+NKyfZaZJQGQI/GpV8i1hM/8jVN5zvkmAX9M5D9JSd6iHqpI8Y9REc531xaMP4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTDuJAITpp1TiO7MsjH7SeU4DsW5KqD1oxGaidgMKDc=;
 b=BQn61Xordfxzeh6359QuEpYSygS2uPPQ1N/15aIKlIHpf0jbbPUD6PQQjS8jFPhb9qwNvT4PGVFZBpe6vofJ45B1LK7Kw4AI24wUYs5oF157NrhVXGiYIdqf9oaj8u+IcCFyOk8AzviuIqNQPJzjpZnrJ4a0RXlZZ3tMvtRLWslAV7ejy/HBfsygUxb4ltduC3mXOgg9Xy8mOMzH3jPSVqsMMmXnbshLTV7YrPedgkeyMskID90ranQ7h7h3w0Kl9SpteCPBAQdJo7XwkcD0cunSwexwRX0k51gpa2EmeX+cyuaFpg26blfXu8onEPL8WP42V13oVfuyPffd59S8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTDuJAITpp1TiO7MsjH7SeU4DsW5KqD1oxGaidgMKDc=;
 b=t+EKLitRtNy1l8KipTsl0VGIXOIiUGGLBkM2Er2IeahJm3qXpXT/CHn52cXAcFbdAM9opWSdNhXA2ouS8xr7gjGc9ypl+2+o6o/TO3S93mSDFNE8xTjCvkv57l/j7+/NNq18L2nIWxRfBPJcLdIiLaB5ZMT3IUGoSdaUVdM0JZNrrk2C9CvSZVah4/KxFvjRO/9enXTDOD+aFLKLGBkkAneutKPO504wWzKJnEGiSCSK8qNHP/azHm1ctQygbr590kO1w4xNCsYVWk+UqUC2cmTLbTXB4w0hWVfe7drF66mG0Ztdkn5QS+hiSRKcDvPl6V97Z4lNq356s2/KyeGCNg==
Received: from DB6PR0301CA0092.eurprd03.prod.outlook.com (2603:10a6:6:30::39)
 by VI1PR10MB3343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 09:42:54 +0000
Received: from DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:6:30:cafe::d2) by DB6PR0301CA0092.outlook.office365.com
 (2603:10a6:6:30::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 09:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT060.mail.protection.outlook.com (10.152.5.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 09:42:53 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 15 Feb 2022 10:42:53 +0100
Received: from [167.87.0.44] (167.87.0.44) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 15 Feb
 2022 10:42:52 +0100
Message-ID: <5141b524-6143-cf5e-2954-68b12c6c88e9@siemens.com>
Date: Tue, 15 Feb 2022 10:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Set default rt-kernel version for bullseye to
 5.10
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.44]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36e3cb26-9964-4abc-5c7d-08d9f06789e3
X-MS-TrafficTypeDiagnostic: VI1PR10MB3343:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB3343D09A0E95383E9C2BDEBB95349@VI1PR10MB3343.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3+Wv2VDaKwHkVBeUqpyWxG0Z7mpddNV9h/hwIyCLtCizDpVtELRntfjHBYxOuzJjvi2rSYxti4gvxCj8H70WX0yuy8ihB9WOu0fS++SophDLE7PYvCuhFs+WGwXKZe11qfJkmKFgJvmrjN7OCb/yPpKX2fhzHFlC8AwJaRLFzcNJxttrbYpwSwefX1T/WwEFjq1tdyZxtYYKlHteJYz6t8PjQLZp99fgxfQ0O8wIf1iKsuwDViiCDxOh5LAT739oys6eJgRY0oK2r7N0ode/vONmDrDoDUtjVSl9n6fj2MghC7lSCW6KeDxTX3LgZek8UecEzt2YGWz1PsLMBPhYy4zYVK0ZKfOssHe69XQEbj+pFDqHqpHeddDIc2fsh+becW6TqBHLk5RwlrdN6YSdbjWoxaMXxWg9Kznb3MvnwJfkhQQnoKOYu1wzWcvJFpWPwsNXLn5+OB/zfM76z7NBTitDkkYc4kVRsnFKU9x7ix0KxooCcwiwvar57OBBLdaFNcNLLAVe4IIeHJtJCLhdDfl7cozFj0wGYHB1m+4Ul9xkPazuS8XMisbdFmaNaT70o98UKhag1nUo0bEIaNFGclfvvCe+unsLBpikUGLZscIRbSVjoO9wR/fFr1Cl7iWkhwfv7SF36f5u9O4o+ejyKjAh/XkWnGCmyxz53SOhqJTdDZoVmj0tEnjgoA8O+CAQzJbnRvWz7Dei51dQk5JfCEKVYNoOQPrTDW9flCralTmW9RlxqxomlhK0bLV2N3pGfbrP2YWEdtHNGOgKit8eBw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(82310400004)(86362001)(5660300002)(8936002)(70206006)(70586007)(8676002)(36860700001)(83380400001)(956004)(2616005)(16526019)(186003)(40460700003)(336012)(31696002)(26005)(44832011)(2906002)(4744005)(16576012)(356005)(6916009)(316002)(81166007)(36756003)(31686004)(6706004)(508600001)(82960400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 09:42:53.4531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 36e3cb26-9964-4abc-5c7d-08d9f06789e3
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT060.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3343
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Feb 2022 09:43:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7609

From: Jan Kiszka <jan.kiszka@siemens.com>

We have a release - and a recipe for it since a37064660730.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 conf/distro/cip-core-bullseye.conf | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/conf/distro/cip-core-bullseye.conf b/conf/distro/cip-core-bullseye.conf
index a0790d5..3a0550c 100644
--- a/conf/distro/cip-core-bullseye.conf
+++ b/conf/distro/cip-core-bullseye.conf
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require conf/distro/debian-bullseye.conf
 require cip-core-common.inc
 
 PREFERRED_VERSION_linux-cip ?= "5.10.%"
-PREFERRED_VERSION_linux-cip-rt ?= "4.19.%"
+PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
-- 
2.34.1

