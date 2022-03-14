Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AD7C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 19:02:51 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.72])
 by mx.groups.io with SMTP id smtpd.web08.744.1647284570221726843
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Mar 2022 12:02:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LHesjujq;
 spf=pass (domain: siemens.com, ip: 40.107.21.72,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Elf6bwXSzBTGo8N7aDncBotdX2dlOGSlBzKvTecGJd8UkAJrPczSpyfWoN4XTrxX1lpPf7LQ56y7jAIYqiWYapshhU4nvCHim52w8v7TnRxdBdRSO6n+yHRKIPv4LDIPSBOaE3yGUDTSUoUfqp4DZQVwyi6XycTxwLNpMpkGM32+q+aTBeHryABUcm280Xd7OgfCF6NvdzVE62YCMZVIV4QJg9gsfM6TZNacBeizWLCg0uleSHzRcCbLPy1OWIQqX3EAMCXV59xbESR1XVfYYcdEaxXr50+UdX33wTAqYbejWeCcrqjcMC52Rx5T/2h/b55abp0PYGyqA0M8m2PaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXRRWKaFNenesU3xMYRM+uf/3FLxSMKEAKYt3gy4JJc=;
 b=cT5dXyFIZjI4dQB5rRpaq+CJnRlEnC13KfiMO1fyZyDQ6frrwp9f9MofnmD/PVwiNDFRTeWEtbD2aDPgI+bmftVXVHjf2gc8+8wrHuij0WJ8sfYqRoW7ItKUmMciLApnkq4CuGISsSl4r/eEM7lxS3emw3QJ3yADLTuveUD6HqthwFyN9X/gnuCY3gF5kqdcwXDwU0JZdLoqmf4lRGeCZ8Sfc1ZHsvvhwB0RhCJCYivcLUCDDBn+UCc1aFSU0QTHv4s6eGmuXdETsBVo/0zQrAsyNvyUCNvaSu3Dm7ZCRI5509NC3oiukOvroKaVOYwMCOwSo/Blhu0wPp32tUwigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXRRWKaFNenesU3xMYRM+uf/3FLxSMKEAKYt3gy4JJc=;
 b=LHesjujqpq8aGZ85qYEQaAQkQWfgEpVcUf/Wmzmh10h+8jrZLhBXx3J/phqML/ghaxkxfZlch/zcP+npSdmty6627MvZFa2eZA6NkQeytlku9BQgrN1G/oM+9wt7VqA9fEu6EMhOz9YbWSdkF5kcJUvUg8eu6GHxxp03Yqo9rUyTyOETjPii1OOPw9Qnfirp4bTAUOG8soheWH9df+KdK9D5UDmUjw6tGL3O8SdWw4uaFH7TAmRdJc7Mw3Jjxguq+lOFKrFCJX/E6v7SBfbi+isSxJryhAdkRSSUNOc6JzqlZIAkNJwMf9/8ENv//xayrw0s79e5tgkbP/TtxNPm+A==
Received: from DB6PR0501CA0020.eurprd05.prod.outlook.com (2603:10a6:4:8f::30)
 by VI1PR10MB1886.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:38::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Mon, 14 Mar
 2022 19:02:45 +0000
Received: from DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:8f:cafe::56) by DB6PR0501CA0020.outlook.office365.com
 (2603:10a6:4:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Mon, 14 Mar 2022 19:02:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT053.mail.protection.outlook.com (10.152.5.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 19:02:44 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 20:02:44 +0100
Received: from [167.87.72.30] (167.87.72.30) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Mar
 2022 20:02:43 +0100
Message-ID: <c11aa369-ca60-5e22-6a40-22e44a33c345@siemens.com>
Date: Mon, 14 Mar 2022 20:02:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 5.10.104-cip3-rt3
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae43d1c6-21ac-4db7-5ea4-08da05ed38ea
X-MS-TrafficTypeDiagnostic: VI1PR10MB1886:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB18862A12F8217868C35ECC1D950F9@VI1PR10MB1886.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y9eay7gxBm4/ApekL0XpcazrehAVhxlMUGBOgxoQHSkQNGjdy3pPNHt6P3FRss/3D1HHKAba2UR4hZdjuxhm7aFPvQrvM3UTat0VTXrrakEmIWUQ7C7taWKvB4CiXZRBM0A9mC0fL64dq/SBLqBmXYbzAV3x4WK4p8K/vfzTnYixDYHYCGFrjAVxApLQdK8agei+2BUgWx61nlIB5YCpt7CYT/8gK7Vz9uP6FapIsrAX/aW7qwsl29KnAr8+1iP4gf9K0gXDUsK+CD/zjKzG/RY2ZCKq1lFxk0GGn+enjpDf0B/H+vsdqhaT0EdGhbv42Df9MgPG1JfmDzxi7zPhu8B9SQwCn17ENhct/8M228reXavwgSjs8D+I+2vlEYohk3IHaqi1xMRAZWjJY91MV7zHfE93eqH1LxpjnRzsMmjefPPiMa3rJmjGUwBMG7T6bExRoGatdtpJiJ4mt9t8dr+xwwQmRFXFvvC5SEfrPxQejRy2s5fMvFxh8TckkzPMuziCtNdgZFo4U+wg4tM8CNGFMzPUMNzWrLgVMz1zv1ZLwd7E1oiHwqToauI2HAGOf8jcfUadnrQLHZgkbcuYy4Flh1V30UPOuf4bnOdVibgyABP5hj8iCm9sYofSZTbDmAn7tm8DAI4+v9QiReyduwQFvzuT46oucZYe5d+a4qwZ8EYKLm/3VNIuDYMs01qyVkRqr4arlddOlwRAPJkezHeaqXUnxXj3tbotVteTmGftSZu/bwAT51zo8sNA0De5
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(16576012)(83380400001)(2906002)(316002)(6916009)(6706004)(47076005)(31696002)(86362001)(26005)(36860700001)(31686004)(8936002)(336012)(186003)(2616005)(44832011)(40460700003)(16526019)(36756003)(956004)(5660300002)(7596003)(70586007)(356005)(8676002)(82310400004)(508600001)(82960400001)(70206006)(7636003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 19:02:44.5837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ae43d1c6-21ac-4db7-5ea4-08da05ed38ea
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT053.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1886
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 19:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7723

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...t_5.10.100-cip2-rt2.bb => linux-cip-rt_5.10.104-cip3-rt3.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.100-cip2-rt2.bb => linux-cip-rt_5.10.104-cip3-rt3.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb b/recipes-kernel/linux/linux-cip-rt_5.10.104-cip3-rt3.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.104-cip3-rt3.bb
index 96c4d07..7d00418 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.100-cip2-rt2.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.104-cip3-rt3.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "e642fc604b611dc6f3e8382447fb2bc4047d129a14cba3996d34b85e07ae9d3a"
+SRC_URI[sha256sum] = "5455a0270bc098c82ee6a9b759db9fe1fb4f43a5fa9c8275bf129dbe2c38c91c"
-- 
2.34.1

