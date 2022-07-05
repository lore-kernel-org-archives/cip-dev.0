Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E5AC43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 08:59:46 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.45])
 by mx.groups.io with SMTP id smtpd.web09.82430.1657011578057025700
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 01:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NZiNYNJd;
 spf=pass (domain: siemens.com, ip: 40.107.2.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYwf4upM+mPI5aK2O6jQ6zcdvajEW1UtBxBUVpzqziuWFku5jY5hHmhWRDnSO8jj9PqliZpm1YCrxD1lqEKUpZybYy+nPaAfMqTfB4vfaFSM7Gau2nMATgz1qC3xqmuSz28xI8iXRZdDaqFEJZFNTT/EnsYtH+m8d+bEACTQdcWqANV/+BtAahdvdYxbIM64PSSnJy2knyt7u1rBKRIPcWZXj6j/jPpX7NVUW6zIAEpvnz29QtHXJXSnK6863YpgaXpksGC3ot6CQHH/bkwsuCJR5GggsYvBwlaz+nq1ABPp1fK0Z8SwctBnJ6RQSnDMWdGXaZAKGecoS/QNJAvQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWD7WmoaMSML7FiKvIEK7m4L7L2PBAFtyPh9ankAEMY=;
 b=dbZ6M19tXuSbDQ29OZfWbPPFuyU/4TyOVvQef/xkBeJp2dH3UHXf9rgWs43TdpaHi6Ybp14KfOIzM3UicjhDGFqm6BgHzREnH4qY0PkWvCWSj+0qrZ9cdICyFkaU0m9b/QpenxMfZc/Pxdru2CEAouQwrPnE4CVtaXMx/4Z6u524NBTae0XQ6ZsVH+i6/3i5kwwSYrxzoRD+n1nKQIVs4XpNoc0cftuBKvftv4cCA+jH5aRsmU59u7QvKKgrBMw0GjBlFKPwBnwVZEJzCpzt77OsNwTN7fqLus+2/iCOZXeOa++uwRb69G/Kk925XG3JMdKIou7Fn4dmLED9mUMCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWD7WmoaMSML7FiKvIEK7m4L7L2PBAFtyPh9ankAEMY=;
 b=NZiNYNJd3GtO5mZJ42PY2UCl3vvDHGpIb4sQp7x74cbunVpLnzXz2hFpkHmDYR3ayIdFwr0JLw2LpP8bSee++89f2CH/dx5HMsr+EBredaHWewgpxOvonieC4DY1qgPmY6X9JvIp9OGTwH1BDjsDrd2D3Z4NoF8rFd5DsFj1XWDVc2PA7T7UHWLFuKxrf7KYJIENoJ7W/xXp7O+EeJyWwtWl6WaGu5iVIXQxcgbS17Kkqgt20fpLwF+2oMMM8fEduMx/Mm+J2/mX0FHu3UVndc7dV6RFV6zm4whoHVE6yKMBCg3RBo01HZ9bm02CkWKMYHDHKAuFLD9Js59kPhRH7Q==
Received: from OS6P279CA0039.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::16)
 by DB6PR10MB1685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 08:59:34 +0000
Received: from HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:32:cafe::a6) by OS6P279CA0039.outlook.office365.com
 (2603:10a6:e10:32::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 5 Jul 2022 08:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT062.mail.protection.outlook.com (10.152.1.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 08:59:33 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 10:59:33 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 10:59:32 +0200
Message-ID: <a5538540-c9c4-3633-0d7d-2d20f3f4b3e9@siemens.com>
Date: Tue, 5 Jul 2022 10:59:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH isar-cip-core] linux-cip: Update to 4.19.249-cip76 and
 5.10.126-cip11
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.632800-8.000000
X-TMASE-MatchedRID: G9cENiKYZmdDh46X2zKVIBOqo33PiIGeUYR3k5IGZuY/QdUh6LEl0AEP
	JrYlsf/6tmTuCy5+VUqCyaW+JWkhai++B0pV1xLFeTjw/FyRX6RNfs8n85Te8oMbH85DUZXyGEk
	IgdGU7nX6C0ePs7A07fk39LXMSri65Q54d9pIasyY/ZvMFzySBbdXJ9mO2uMjWViI9FmCf+0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.632800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 E265AD6E2DE521A96BE2D3DA4299B94CD21354DD87587FE68F0C20DDA99E0CAE2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a5a7bf-2a30-4f73-099c-08da5e64ae31
X-MS-TrafficTypeDiagnostic: DB6PR10MB1685:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ogLwX7GKB0jTaFJuLAvh8W2VSkAtoVk8RmmAvAVB/DzBTGGZ83oyypFspazP53r1o6nA4GrQ5QLCQZoO5YvbpGWXM9h60fkOWzA4if5MgKsyo8eOImxRjyq6lX8GT5hxTqqZKqhjHgmcc0F7TRBpvyu0tJyyt7TwlDhOLLhnBfJfhyQMm77yoh2vrt9W1AWlSs1dhgz6ZGOfwzoPfo9vyZRJiuX/Huta00D4XeqrpPz8e3+aWyQUA3gDROGMiynmA5NncgKT23Vu5nLndD8tIqG5pwrtAwaPbOBvUrf0hAanlJAPCYaX74sr9sEYCMrPEvb2NObIaTgInCqdX8JPqxiEjiJyqqAidPpK4Yhyf6bpOk7hz/idxxZ5cj0+WpsvKrfKdXDRHNSne/116LqiJp3mmInNOaf8R4+ECVxUIydVZMruCoZtqwjK5+GcsQ4zDUj59+HaAJQ4RZYRM6ho/ir8IhNewWIn07e9YuNB7XN8OwC/B01ydoQkh6DzVGIsVMlxHcNMbW0gItdfjTd67aI/p1BHf9gvWat0IIWuoxDNZDVdYU7oR0hyXrRAUEUMkcuZa812f3waNi0+I6j6JzNUftc9o8JfxloU0cqsjXJ8HckEF3F8wK0oTE32p8j0KgXXvkeoLXIFeviNioTDCqmLB+iFApVRtAk4hPzyh+TryWvaGk1XeZpLgSZvYUlg+W/D8CIFBhy51E0fWlcV+KHBoC6ZC80m8CbE6ZImL/HpKa/yssAM9b9cpXVoSdkvMfizTA6+rSso5+qklpDiIYT5vuTJx4cQDxaB/yZ0w94/TP5105GE27s8w6PsvMNnv2qIQXlAEkU7+K7hAsx6IP2E4F0E4BCHB3+AGPUy5HQuB3bS8aCc+AD0ykssjVgKUMYWaRdbpEXRWs9Jz1JGUl5CEma836FF0pFM9GGiEe8=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(82960400001)(82740400003)(356005)(47076005)(2906002)(26005)(36860700001)(82310400005)(8676002)(41300700001)(81166007)(70206006)(70586007)(40460700003)(44832011)(83380400001)(8936002)(31696002)(336012)(478600001)(86362001)(5660300002)(16576012)(6916009)(31686004)(316002)(6706004)(40480700001)(956004)(2616005)(16526019)(186003)(36756003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 08:59:33.7755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 76a5a7bf-2a30-4f73-099c-08da5e64ae31
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT062.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1685
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 08:59:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8680

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.19.246-cip75.bb => linux-cip_4.19.249-cip76.bb} | 2 +-
 .../{linux-cip_5.10.121-cip9.bb => linux-cip_5.10.126-cip11.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.246-cip75.bb => linux-cip_4.19.249-cip76.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.121-cip9.bb => linux-cip_5.10.126-cip11.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.246-cip75.bb b/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.246-cip75.bb
rename to recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
index a4ae23e..e061644 100644
--- a/recipes-kernel/linux/linux-cip_4.19.246-cip75.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "bf7c1c6a852ecc3daf6a8de302cc9e456aa05f8a72a34ba1941e43ace10e47c7"
+SRC_URI[sha256sum] = "2dd59ffb3557580f9fae93952206880f1248ad3bd239983a71c0f7113f31880e"
diff --git a/recipes-kernel/linux/linux-cip_5.10.121-cip9.bb b/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.121-cip9.bb
rename to recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
index 0b08d62..ac4f620 100644
--- a/recipes-kernel/linux/linux-cip_5.10.121-cip9.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "0be35d737212ae68cf8dea7c84bfac61f2b98aeec3df6f308692fbdfc80db743"
+SRC_URI[sha256sum] = "2b0742b538bd993538a73905100bcbba3f48b4259773a119a7c0fdb2cff5a0fb"
-- 
2.35.3

