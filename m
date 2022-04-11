Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD92FC35294
	for <webhook@archiver.kernel.org>; Tue, 12 Apr 2022 16:46:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.71])
 by mx.groups.io with SMTP id smtpd.web11.695.1649700620207975655
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Apr 2022 11:10:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Nktmdga5;
 spf=pass (domain: siemens.com, ip: 40.107.22.71,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FQoID51r2s978z7ryF8xCiKO9EVobL+FG67PZF/8qE5LrkqwVNS+uW5eLpFPemJaAw3a8TO9+A/MCGRim1ojzLVNSOY3JZcevrMLnw34hDUmk+gGU314OH+3PCHgglWmxSZKCG6sCDPPEi8rAYsikISc4s1pvxVOgDOXHSgaNBPDQaAd6ojV9NCfhq9E1OeKq/1qxxrIImPAoG7zKVtjeNLxEy0mXme5ZS0oDrf2RROieRcSi3hJ3nalsrod/lJeXFK+Vggnxo5ESKAcOLaO8G5fFuBbhysjEPiunas+9pkdUt5qgYu+F/3JFgDD7Y9vodUnPr3mDoRiXKdZallgrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WySxG6+lCXDHO05Bqki3k2HpID7WTguSki1VrY7/hBg=;
 b=NoLUEuJb983dHEtQWuooUHtGlTiPImThiepLTqFLUvCiw7QQWz8UC40jjYPE2cPZKrtRbvZOerY8H+57VtssnK8+v1umjPBUW2DXp8rxw/qDvfY8gFi1FxR96O6iErQ060qLXdam3W366Ita7XZLa4xAhe/8s2gBIbb9EBJpqt+UfiP/+UygLHXwkVH7mgkRN3P7LaK9sgC+JSwHLJNP2XbbWBUigDURx+KjhMdYNyQsd6r18/hLhEgv+RaVR04q95GTe6jj8asaMxVrLw/a6r1wuXv4Xs4iQVNp59g2QQcJ5abqhgOkItZG7ZlZfxZsjBQ+nq0fStSBnK1y1QUoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WySxG6+lCXDHO05Bqki3k2HpID7WTguSki1VrY7/hBg=;
 b=Nktmdga5yiJQfy57bmm0lM4qx4yeobU6yRmWRrdV6gHoZUb3Dw6drm3T6RdgxppfM2ffcbQu3SJPuLPNYXXulH+mfV1Ltnnmx3/r2mxbC41P/we15/rv+RCD31dj4a+SippRBS8LtpQx9ytB1utkmihhCSOFrvdH2Z5YIw/3ww2C0RPOjSqZGnla1Wv2+Il/N5VkpN3VV9iS/1bvhi3LZqNoOv1/A+2eLU01mQVp0A3jZUvzZohRuBCedgMKIeWbtOg0LhqQK/VXG17lGBmuBbW1SL5JWSurP1OE9FgG74VFY+wB9PSG7/fw4u2wkbVUs4Lzfc+zaSvGG+qbqEgYQw==
Received: from AS9PR04CA0035.eurprd04.prod.outlook.com (2603:10a6:20b:46a::18)
 by DU0PR10MB6082.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 11 Apr
 2022 18:10:17 +0000
Received: from VE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:46a:cafe::5c) by AS9PR04CA0035.outlook.office365.com
 (2603:10a6:20b:46a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 18:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT051.mail.protection.outlook.com (10.152.3.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 18:10:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Apr 2022 20:10:15 +0200
Received: from [167.87.0.22] (167.87.0.22) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 20:10:15 +0200
Message-ID: <9a02a7bd-3208-d405-1dc6-7f6497325c71@siemens.com>
Date: Mon, 11 Apr 2022 20:10:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] linux-cip: Update to 4.4.302-cip69, 4.19.235-cip70 and
 5.10.106-cip4
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.22]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.031500-8.000000
X-TMASE-MatchedRID: adP96OFoHORDc43EsKhhKtJNcD3tbqTzR9fQDKDdQ3cBnSWdyp4eoUoh
	bZMxFXE631GU/N5W5BDg6pBZBTcH69/K5k+qLCYLxz9ySqeeOzEdYTfgzQY7zt0KiTeJteVBfS0
	Ip2eEHny+qryzYw2E8Jkw8KdMzN86KrauXd3MZDVu+ygwcebhiBoRbdawR9Hw29HTXUaPXpY5ar
	r8jlDFXB0Glg9tvlUL
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.031500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3AB219620BB99CE1A47BCD3C9C8D807E51B2365B80BFCEE067A3DBF145E0F4F62000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b54f99-053a-4885-1419-08da1be687f2
X-MS-TrafficTypeDiagnostic: DU0PR10MB6082:EE_
X-Microsoft-Antispam-PRVS: 
	<DU0PR10MB60820289F77746608F1968ED95EA9@DU0PR10MB6082.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gIfZh+VeSR0BFysO3Cc+r+LevVNi3qQp/Xk/88v5VUBQuhi7A+ys3siurh7O/heYemMvkMuat1JEvqmunlV7Nxo5Uv59Qsd4sllaXabC6OvaRtsiNa7DRpa2opl2ufR6vWz5rihEMQxYisZVCVCkEtg0R0m3o5tI40jgDzAtUm0D5u+kLegI7MqwWnTjmCeKzXrMpf8cj/87MghftaPToUcJhU21lkkDKERShp12Li1Ay/Je/HIV5bow7SIE8UI1OvMTt+kHTNE4kyh3jzw2fCAun8td3Kodh0vGHUwaRm0Ogagsn+fzTNVn+aQdrn2V7KqaYy5gOYHsbwPkAPCCOrNU722ZhX69TIMKa+UqyCvIHnEK6endDn4cXpWZ55Tl7p4OKoOx0kCBg8tQACoodkKDpuYTEedIOlkd0NZ9VNvPh3rF5buEiw84zITUUGvCH+vCtnAgVn1hr3llUA2D9so+aUOi2S28cfSrIMhQwbJi4V0uePQz8sGqzZP/D8iQXiYoKhSYVXbgODyI2hFVmwV/+PaJBqzbx6sfIwiLCpu/vMBha24LVCzJctWfrx5DjEncl0xqY3alNWLa7K13QrEfkPEY1JDb7+/z4FnkNPGWIgI87OXBVTkWremwZLKbGcVuZ2Kl1LfevEs7te27fBvE5jqVrf83I9+vNXy0TOBbOa/Orywip97hw5aShEC4FHwf77yD6T5iTnQxaq6nXdNT+v32pPKykyU74ZTcwwcor5Q6LtTFF5Y19/6JjgM7hSwIvbN+vtX74ehG07y8Mw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(70586007)(70206006)(508600001)(86362001)(31696002)(8676002)(316002)(6706004)(336012)(16576012)(2616005)(83380400001)(956004)(47076005)(6916009)(26005)(186003)(16526019)(31686004)(82310400005)(82960400001)(40460700003)(44832011)(356005)(2906002)(81166007)(36860700001)(36756003)(5660300002)(8936002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 18:10:16.3019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 09b54f99-053a-4885-1419-08da1be687f2
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6082
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Apr 2022 16:46:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8031

From: Jan Kiszka <jan.kiszka@siemens.com>

This also fixes the misnamed 4.19 recipe that got broken with
d8705169c831.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Supersedes "linux-cip: Fix 4.19.233-cip69 kernel recipe".

 .../{linux-cip_4.19.233-cip69 => linux-cip_4.19.235-cip70.bb}   | 2 +-
 .../{linux-cip_4.4.302-cip68.bb => linux-cip_4.4.302-cip69.bb}  | 2 +-
 .../{linux-cip_5.10.104-cip3.bb => linux-cip_5.10.106-cip4.bb}  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.233-cip69 => linux-cip_4.19.235-cip70.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.4.302-cip68.bb => linux-cip_4.4.302-cip69.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.104-cip3.bb => linux-cip_5.10.106-cip4.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.233-cip69 b/recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.233-cip69
rename to recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
index fcf621e..eaad5e8 100644
--- a/recipes-kernel/linux/linux-cip_4.19.233-cip69
+++ b/recipes-kernel/linux/linux-cip_4.19.235-cip70.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "cfb579d34e8de9129312426bab3b955bf7ea542156ea4d69748577869abf18cd"
+SRC_URI[sha256sum] = "b3bcb1ffd82c2ccdcb96aba55bdc46c72db12b6b5442591f804c8e298ad405c4"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip68.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
rename to recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
index 160b7ed..8948786 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip68.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "d49e1fd2df419279a8595db6e68311cbb91399a92e6d71672543c4eb2088b317"
+SRC_URI[sha256sum] = "70d09ed7c9dcbd227e1c77964a0a912c21253cdbf6130cefe1db7cc7b30e59f0"
diff --git a/recipes-kernel/linux/linux-cip_5.10.104-cip3.bb b/recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.104-cip3.bb
rename to recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
index 2c23c6f..2f52cdb 100644
--- a/recipes-kernel/linux/linux-cip_5.10.104-cip3.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.106-cip4.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "7c2a9b0d7450f57909e4531b6c4fdc395c865140005596e0e87c9669047b3cb0"
+SRC_URI[sha256sum] = "512787b7f75b25e2c7f64978957bb2e6613e7c9edccc6d677ddd256109244d25"
-- 
2.34.1

