Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F0EC54EE9
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 14:04:10 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.52])
 by mx.groups.io with SMTP id smtpd.web11.4957.1663077840377968032
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Sep 2022 07:04:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QtmmZ94e;
 spf=pass (domain: siemens.com, ip: 40.107.8.52,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mly7dC1n+423hQm9ArPe38M9al92R41+pAIFHCIf2XK9khJ44pXGDXpEN2CI1eKnz4493UCYctIvx4FMN+5lq+/49AsK+Mcj8yof+ZOJskk6kYesX7R5NkIdCcvo7qLz//QML03pivF+KuqKh4jDIMZlkWVEqmExJo/BtpmXmm3oe9F0eJT0d6ctDWodVrphpuLjtqJODA7PJMnnCB0l3XnnlpOIvSI2BdGdcgYFTtgbyBFj3IBr99fcjVoDslcmoBrELNOEPdNDKQgdIqQEQyuU8m6EFRlsnFYCEkc3L06gMcMlrgpin92j3Gv4LPJsxhrOYzw1sWZ8i8BT5xJLyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ24iwsxv7XX4uQJcH9NFY9mwGdwgWln3w7PBJrut+0=;
 b=DAAnHpkoMhPhL63E71oZzAj+g1CE1ihl//Th8m+/ogLGi9jqsqzlDBUH7KHIuhf1U7QhJZvV4ReUIiYsFNPrJyDNJ7ZlFKq8b+8B5YCtrO7LxbUc4+gndlnaj/pRQe30XSkQLK8lDYJSVNsLdgDya4ZJelcVgcBBYQAwx4eHah7k2ZUYM0Ci5s9NHPDt31eDJW9V01hC9YJBuX4ReaZr1Nu6YKszNmRqrYLTPlv2I+HRFB2O5Hn1+3VUmd0reaqNLjgTFdPKdxdTJCt6/dSpghz+GQIJBs540utFQIMNIQaKF/Dnnajzv13bxJ5xcz8Zz5F7L0+Z0VncBomC4c/fiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ24iwsxv7XX4uQJcH9NFY9mwGdwgWln3w7PBJrut+0=;
 b=QtmmZ94eBDYFCRy0oDhWrmQkqHVLQFleyxuogvqNbQawkQz/9HkJlBqnSqC522nuXaLVlki+aKIQPth65TZKXDMzomhMOVSQQq2mtM43rS9cXm52rb3nHTMCSiKt0/IXLrjR/RAyWQa7MPPb8dYNAU8Z+7NCoYIL8962s27k+fOsqZ8fRNcp5HfSnmmBY/6yt5hB4a8Mx1iBYAiHflGxsLEouIHlAWoKb3C3E6Tsr6jGTrEOTj05BMi6GaOJiCP8xRpe/ui1tmud1HGDsgV04G96A/Gavn3Nxc7Sq42Avk0e01MHmwI3WPQQKiebwhflGvxnXav674B7MznNtXxN0A==
Received: from DU2P251CA0021.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::24)
 by AM0PR10MB3507.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 13 Sep
 2022 14:03:57 +0000
Received: from DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::26) by DU2P251CA0021.outlook.office365.com
 (2603:10a6:10:230::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22 via Frontend
 Transport; Tue, 13 Sep 2022 14:03:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT046.mail.protection.outlook.com (10.152.5.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 14:03:57 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 13 Sep 2022 16:03:56 +0200
Received: from [139.22.106.123] (139.22.106.123) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 13 Sep 2022 16:03:56 +0200
Message-ID: <b044a9ff-7a51-7a6f-d9cb-5aa6fa01d5f5@siemens.com>
Date: Tue, 13 Sep 2022 15:03:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH v2] linux-cip: Update to 4.19.255-cip79,
 5.10.140-cip16[-rt6]
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.123]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.051700-8.000000
X-TMASE-MatchedRID: FMbbA5BboXpDc43EsKhhKjOhQ0C0WOxyHY/bzRmIaZH27WtDgGBc8k16
	N0DD9tffB/FMznsE8cN+Nx1ftYxL8P07BTfxvPlGeGb4ODe8nsKhznSgFQVXH54CIKY/Hg3AtOt
	1ofVlaoLWRN8STJpl3PoLR4+zsDTtGM6W3U+LnneTwFZbd/LudUvVij2iK2hNmB2TmwrUvK2Vbi
	W1moA01Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.051700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3E13D665CB672FA612CFEC6083DEEDDEF70055BC435D642F43FD1BD8CEE4A6B02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT046:EE_|AM0PR10MB3507:EE_
X-MS-Office365-Filtering-Correlation-Id: 1398ceb5-0f56-4aee-2996-08da9590cce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OjR667aosZG5mmKVks5ctJOIxI5tFHI4hiFrN1i01OzLiQa4xSzxxlXUuRKnslIGBRztnqeLzuw56Y6xVvxarlVVbWVa2zBLKGzh4GwYj1t35yQD9odQbBI0UFZmxY+H/sCj1aPCK1zUVpbRWUgLjEJDNI6sQU9Qrw8069ca3IxlPtqej/v0f5wlpABLA7DbQ3Frhva77PRHwG6xblH1m6O9Zyl40dIWLIzKmKDA+dUgRTcKfVfNaQNhg6+GgKUIf6aueNfvuaNb//yuIgk+a/07BOJvziyGnwxaT6XQBuv4QSHQ7v6rzNvw3QziK/PRD4QzjYNRMpZMSJkmTOqFdEsXbBqXAcW9msUJDqoxq7ZJ7HP5/A2PgewwGk2RAZUE8ctePlXNmjtARiJreA5yfwDCfUg+REaB5C1Rf41sCWTP4+fOAxbwZ+JDy9BduPnBqasF5UNgUBg/DVdXGkj6iy4jdAfI93mVpSmgyETxt2QVZxox/FBXUEPb4rTeKkqUpYBRbMAUJd5zwcdVhUKjdAGagFK9jR5TjbGhrdi5fcTwgWfGg7NmaZDTcouiExvRDnNSX+urTbP3QSAvzyXEAQVsIspjqTCjSc9Q9nKt6CogghI6UmcbirgyVnWTygyXykboXCx1jPMDdJnr5qRW1STQurMcbQh37L4oShS3mzkGV70IoziX4fWyVJ+TjgmwOxXJpjrS1o/is2XSnfiTwohFj7HF5fnOxHx7qr8MmDMI6/r1yyZlcem4SfFcSduwHDPortEkrtzR25/U1p/J4SrPG4xTr8ivzzsfevQevN3NmoOdJNmBKju9CXNnbZOacVS5XzGAIY53ZX+Esib0Vg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(956004)(356005)(186003)(44832011)(86362001)(8676002)(31686004)(82740400003)(16526019)(8936002)(47076005)(7636003)(36756003)(82310400005)(2906002)(70586007)(26005)(31696002)(41300700001)(316002)(478600001)(7596003)(83380400001)(2616005)(5660300002)(16576012)(82960400001)(40460700003)(36860700001)(6916009)(336012)(40480700001)(70206006)(6706004)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 14:03:57.1012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1398ceb5-0f56-4aee-2996-08da9590cce5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT046.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3507
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Sep 2022 14:04:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9492

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix typo in a download sha

 ...5.10.131-cip13-rt5.bb => linux-cip-rt_5.10.140-cip16-rt6.bb} | 2 +-
 ...{linux-cip_4.19.255-cip79.bb => linux-cip_4.19.257-cip81.bb} | 2 +-
 ...{linux-cip_5.10.136-cip14.bb => linux-cip_5.10.140-cip16.bb} | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_5.10.131-cip13-rt5.bb => linux-cip-rt_5.10.140-cip16-rt6.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_4.19.255-cip79.bb => linux-cip_4.19.257-cip81.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.136-cip14.bb => linux-cip_5.10.140-cip16.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.131-cip13-rt5.bb b/recipes-kernel/linux/linux-cip-rt_5.10.140-cip16-rt6.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip-rt_5.10.131-cip13-rt5.bb
rename to recipes-kernel/linux/linux-cip-rt_5.10.140-cip16-rt6.bb
index 8c82e7e..fc895db 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.131-cip13-rt5.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.140-cip16-rt6.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "fc5ba1290c6ebeab65ad3783d3a0c65e2bb866c58905f2e627da04dff25166b3"
+SRC_URI[sha256sum] = "a59d2994a826c0a1a62e8631f482c6caa98faf87355d7b47868ce7ce17c2e9ce"
diff --git a/recipes-kernel/linux/linux-cip_4.19.255-cip79.bb b/recipes-kernel/linux/linux-cip_4.19.257-cip81.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.255-cip79.bb
rename to recipes-kernel/linux/linux-cip_4.19.257-cip81.bb
index 7d1e634..1067672 100644
--- a/recipes-kernel/linux/linux-cip_4.19.255-cip79.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.257-cip81.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "5e96607abd43e0e9e5935068f684b47fbb3101f913a85812ccbb326b27ff369c"
+SRC_URI[sha256sum] = "9337fca3b8f981bd26884a3fd1035296ce5db8b458c776b73114e3e476423737"
diff --git a/recipes-kernel/linux/linux-cip_5.10.136-cip14.bb b/recipes-kernel/linux/linux-cip_5.10.140-cip16.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.136-cip14.bb
rename to recipes-kernel/linux/linux-cip_5.10.140-cip16.bb
index 3114365..9ed9ea6 100644
--- a/recipes-kernel/linux/linux-cip_5.10.136-cip14.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.140-cip16.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "27dc2d0b877582b1d8e83c071029b26752d8a9cab2033ec7fef0c68b6bb9b4fa"
+SRC_URI[sha256sum] = "0bc556457854220e82e6e4f738ddccf92875817f28a0d0643d005fa9038935d0"
-- 
2.35.3

