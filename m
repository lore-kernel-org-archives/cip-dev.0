Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18A2C6FA82
	for <webhook@archiver.kernel.org>; Tue, 13 Sep 2022 09:28:48 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.81])
 by mx.groups.io with SMTP id smtpd.web11.2627.1663061326535648737
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Sep 2022 02:28:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=olTMblrB;
 spf=pass (domain: siemens.com, ip: 40.107.7.81,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj6SY4g2nku1tN+YXFOGHKWoy70ZML/kzxDYiuVp3VGC4Kunqn0F+J93iXdEliHcVq251J/23mTZZ8X/j8Y7+6ht2lrH2zqh8WCTF15EFxuz7uxXIzoz4MMQ6goErskirbsvQtOSFsn7yBkZd/gaqEB4GArQmr8fMlLkF+kM94BZwXSIVmFLWTPzjeCOhGvRFJ0xRBDu7lf6os54GPysw466+4egkGiXXQsKognHgvJV0TCIQlxKfdyipFf6YM9fa0uec6lOv9Z/q775VNtKT+WubIOe33FYG7F9N5c8pt82xQdAsjXcYhhLtaC0jJKaDX1Ze06KVJXkzDHL/NvIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5uYG0MMrto0SIrRWWXFAFHk45qKELnIyoW+r5DxVO4=;
 b=VxxenFrPn1uvT5uCXskzlcNy8nPervAxCtMoPz6IwjyNuwXItnX7WHbbUFKANhvJTBnfiveaVPYAWSkBXMeJ4rTlFjbnb0anT72sO51FmAeTBmiun8GOri6nqTv9KninoWa5f4G04ZhTbYVqndfOve7RqGs1E5PWCiEp5q8RnfhrX0dhx6gE1X6XFmIxxKD8hVpjbHrarbhMqBu6DuxVfKh+RiUZBt8MX1ZDJW3PNDHSp5Smbj6wuinl/0iDV3/gU3TNhi3d5Khkd8UfoLZQZM22isw/PyeGJ+P/Le0zY0NaPLm28H81Gc5fNa+v/hfdz+mdmNT3PfoKm3RDuDwsXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5uYG0MMrto0SIrRWWXFAFHk45qKELnIyoW+r5DxVO4=;
 b=olTMblrBqDa+h2b0sqHRuLUuRRCIIKO4gWnnUOblbxqCOAiP6UxxvgunXOoiH8wZPOmkWJJDaNHJW7ZNEx5NVi3iZH4chjAKHVRqNe02dvqo90Wqd2UYHz802wHhGEexnxRxpoaLSPDnz0iDO88J8GBtB6Z8rj4jT3Y9rGjEsSvGtAkHHgpEU/YNulugVr2H65GGAyXSsPh8q4L2PXL7r7XmawkMGzDP15oSjPbfKyenj5zsqPOXE5ZcKNuA0RbAQGTGNyvh8mDz85epsq/IWcx6YD6oawVOJYIYU6vD8qQNa9ahF9hxW2BgxgB4vv5/NRe1yILgkDpCWckyLl29Kw==
Received: from GV3P280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::13) by
 AS8PR10MB6508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:566::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 09:28:42 +0000
Received: from HE1EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:9:cafe::fb) by GV3P280CA0050.outlook.office365.com
 (2603:10a6:150:9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Tue, 13 Sep 2022 09:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT028.mail.protection.outlook.com (10.152.0.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 09:28:42 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 13 Sep 2022 11:28:41 +0200
Received: from [139.22.141.223] (139.22.141.223) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 13 Sep 2022 11:28:40 +0200
Message-ID: <b1da967e-da39-2539-26ab-23816892145b@siemens.com>
Date: Tue, 13 Sep 2022 10:28:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.255-cip79,
 5.10.140-cip16[-rt6]
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.141.223]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.471900-8.000000
X-TMASE-MatchedRID: U/YFGnyyT2dDh46X2zKVIBOqo33PiIGeUYR3k5IGZuY/QdUh6LEl0AEP
	JrYlsf/6tmTuCy5+VUqCyaW+JWkhai++B0pV1xLFeTjw/FyRX6RNfs8n85Te8oMbH85DUZXy3Qf
	wsVk0UbtuRXh7bFKB7sZ4Cp/0ZFhEM0vc030Ryzv4abq5LIOXyR22pM8G/4o3aAZk0sEcY14=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.471900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 4F8B49F848EC776DF4EC84EC86B08706BD9DBD0E102442867E72793346F012BB2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT028:EE_|AS8PR10MB6508:EE_
X-MS-Office365-Filtering-Correlation-Id: 521c249f-57fd-473a-0406-08da956a594d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	N0pqj4SBrWLvIksn3Lz4vYYHgVSqhVdwlDQ40l0zLVg2OQ0XoBkOX9dJpC+0t0ms6aNyi7iWGZXVwpw9JGmz8XJ0xAfoqt9/QLS4ryzSrzL+sTIi1+mw61t2u1npCzGn6aefWyYi7qZBYU0eqeUI27bZzaf2L5tPfpUH4o4gdWvI6MgiYfc8UR+J3HnqG6Hm/2zI9vgJ5OcPRFj51ed3EdeHqwMbSPx0OvQoPCbkcJAouq/ZGANBtsgQq/Qs02Vl40NQc8112FdOjgHDVYHSJqiXLqFxiROqVeTnKk470OxQlWFpvqb+rzW/YoY8m42wlj0l8PeIMBLiCrRWFCwODWcOCC6Mxm/gYkwqPSFBL7d20ibydLrw1Fv+RRAEj15kWmz5XNcpr1ds+QXN1A+sJhgMlcBV1TagzP9kG0I5D4wlAAHPv1RzeP0kK7wU1Xgar3TqOrpcNvAz54jM5e/pC49oZN0E/Wo5ESztUeb1CmM7im6baHw55inR4CNTTvOuu9D7AGB9bO1mLwSkMvZn4ueMWX1E3wK8WN5xYu49WSjpz6siZDPzG39eRQgmz86wdTjqfWt7/u/9gzDs2RIdI/jvEs/tS+t8klBLOp3/mHpOyYXFBnVI4+6OE6yke+ictO0TtnFT6xByHkso4TecTKlTu4U8QaINOZzBeExN1GXqWwjiBnsYmRGTfQK5MBKW0a5mMc7y/EUTk5rc+d2HiWBq0kYWhwK5WiQHfHnZUFVo7SUp9O6dI6NEfWKiBlA78bpGb3w0se4h8BFf+z0d10P/K1AmHvJGAF4+ixkM0h7IVNmmtLusxauJp+eAZTPOEDMQSdOVCJKUtvMXoY272rcGxsXigSoYSNbx4GSbzSY=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(82740400003)(70206006)(356005)(70586007)(956004)(186003)(82310400005)(81166007)(478600001)(31696002)(40460700003)(44832011)(2616005)(8936002)(86362001)(36860700001)(16526019)(31686004)(47076005)(82960400001)(41300700001)(26005)(2906002)(16576012)(336012)(83380400001)(6706004)(316002)(8676002)(6916009)(5660300002)(40480700001)(36756003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:28:42.2700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 521c249f-57fd-473a-0406-08da956a594d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6508
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Sep 2022 09:28:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9490

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
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
index 3114365..f8bdc8f 100644
--- a/recipes-kernel/linux/linux-cip_5.10.136-cip14.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.140-cip16.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "27dc2d0b877582b1d8e83c071029b26752d8a9cab2033ec7fef0c68b6bb9b4fa"
+SRC_URI[sha256sum] = "bc556457854220e82e6e4f738ddccf92875817f28a0d0643d005fa9038935d0"
-- 
2.35.3

