Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC92C43334
	for <webhook@archiver.kernel.org>; Wed,  6 Jul 2022 09:28:52 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.73])
 by mx.groups.io with SMTP id smtpd.web11.4108.1657099723254159948
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jul 2022 02:28:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AxVZSYWC;
 spf=pass (domain: siemens.com, ip: 40.107.1.73,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RC03Ew/hlHMAbCrHXi8TRLUUu0VDkr/CJJh5J+1TlddpNVapkIOrBmM3dirlJLcmgoPv9WQpAaUHTJbRFvwnR1mQ9yxDER0VBePAQkcYLoAMiqZTtaHQPOgDtoe4mgMgqS+Kf4gXi2kgOn1w92xCNHZ+ZpW9szEp4fFqt84+6Xi/GXVfANtnwUITxGdz7P1WcBTOeAB2EsTqPS913f7+CRCXVvs7B2NeKOcWR+5fNal8nTyKW5jpIDSRSf9C6Vb8M2pTmciw9KT0XBplbJhfR7dgcvw5GgVnQs2p8ACk2B2UZ+h3L8P2mdsNkVX0OSHDRVHlyeVbQW7+J7YwxUo8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26CbIG83pPueSYdokqFWl5ykGOXMLCfILRsIyexkg8Q=;
 b=VtrT63DIcvLfQB/Ib9BgLn0c/c5nIersuR0iH4RLkDMu0og+CbMKibqMTG6ofYd09fm4anuFSnhgn0F+gNc9l7acph93do2fyRj8jcI5eEmNx9/kPhAHoxG5N1E7PQHcg145gW/mRajlZPYhv4wdAB4izJ6ulZVQP6NkjlyuudzThOMsM/06AUbJEzhPtG1WUacbN0ufDYfPN1+p8lh43QsSTU+QF6IQWgiCzI1bPCZCxCZn9xbsWxtq12NII+SZt7cixKdNDDzY6cdBT0FBi/ikxD8reCpj5LAGf07y2a8si/sgApltu4/ygPuQ2LnZrqYpqLm22UML9m2YIes7ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26CbIG83pPueSYdokqFWl5ykGOXMLCfILRsIyexkg8Q=;
 b=AxVZSYWCy8cLppOIn8ut5LdDDjHeh8LjoIVsF4VzqQp16CsWSQylnAv/7ZsHiSq8cNDkBj6j0dZ1/KkwvuxQ/TbUVsqHqzn73+R5hnZaqXWFYjxR8Z7UCZGwzaxRfWAoVlcrCdGArYpgl0hKgvliS9RXWjfE9bYg0P+S3N6f5r3J5d3lc2Z2NOW/piuO5xHEQiyYshd8c2MTbLAEJHjcx/1yLcm+9Ut0iq3GhcWoen0nG99ffddC/NP54XfVfpQYR6GmdwqHPj5NqQ1gJrfWUOYVw2eYeCpBSqKFQnFY5T+ziSNsC6wrHwc8xGPrV73jMzF90K58BSiUCvraXyMgLw==
Received: from SV0P279CA0072.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::23)
 by AS1PR10MB5143.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Wed, 6 Jul
 2022 09:28:39 +0000
Received: from HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::17) by SV0P279CA0072.outlook.office365.com
 (2603:10a6:f10:14::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 6 Jul 2022 09:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT076.mail.protection.outlook.com (10.152.0.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 09:28:38 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:28:38 +0200
Received: from [139.22.133.252] (139.22.133.252) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 6 Jul 2022 11:28:38 +0200
Message-ID: <c1b77aac-e419-b552-0704-513c1df46daf@siemens.com>
Date: Wed, 6 Jul 2022 11:28:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH isar-cip-core] linux-cip: Switch to kernel.org for fetching
 tarballs
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.252]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.176800-8.000000
X-TMASE-MatchedRID: U35I6fnBuskBdsNTuH+3zdC9u7DLUj3+wlFkYQpzvO2sxwwrc2bx2YVQ
	55H8w+7mY4zJvUjGrxVyKMxmuvaJna3aC25avUuaUlYqnfctydHrzu1A2Hl7rGsi7j4330UR+Kg
	iyLtJrSDA5gKtRJGKWmluU0XZ+bozyHf253PlRIVXOLTjXPci/0wwU9WaIzF/3QqJN4m15UF9LQ
	inZ4QefL6qvLNjDYTwmTDwp0zM3zoqtq5d3cxkNXJbgjM0aC1AiiONDyR+ZEyfT47Gu4RYeP1BP
	Temz0/nuT/yUEvlv1k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.176800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 BCF7B251FF2E26E798EC1F6C708E2E607A34E9853DD87E49B61ACF7283E6C9552000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f4d4f6a-679d-4225-5d79-08da5f31e8cc
X-MS-TrafficTypeDiagnostic: AS1PR10MB5143:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MLFdkfeTvZUbM2Cbbiz27+zp1WDpkPSrIXzlcF3HyihBU0A5xKVz86HX6fkwtMSDASWihCal2dJ+aEsxSYf0gee8AWL10fWjioGYSt85rpQitSRdely/pal87O59y50/OVk91cjbDz71VITs/pBad46Qnbemq+XRg9mmlTQkoDuOQXn4AM6sjQHCInkWyVI6AzfjmSIl3rqeuYp5el5ToRcbfo5Xynep44HWGlOR7/vMX8X7Hied0A8ZIQzMzLYezjCwXsChv9woBI4bvUkvj3RcKB3Ba6u9nUITfAJ4yFs0ARsOcPPO9KEDIj6Ft96Buy1eOqUB+rpgl6E+NbuJM8IGYyi8xywlTwb2hFtXaaM3Wa+IxMT6JXnL+KeNpGpX90ce8+sThsfJH8rapj9B5VF3lu3vN2BPoOGs99pgtpwWf61Lcp7GBz9RP9lf3oXOUrOrdcmkXNw38h7hh27u9s3KPGNRFWFVTs41PymxdkMK0O9n3novyu9MPFrp6lJykGl87OdmRo6jxQx6pUdmbj8fNJk1QYgQH259ZXlM2pQEKgEqnagYzQE/E540EJrYufkxSNmFIOIIr0gH9sEoV7BmdQWMxaRX+ODX7Zd5KWHzYQ10KPnThqfoKvPjz0K0+LYEB5pjltkgXpPy91D6eiqh0YRIUXMvJn7SgfCZxS4TbYCOFrBbv1uw9q/wrbJ0ZLAF5KeThI8YeBH8wKGdNBv4VDPqDJ6VjDotaNEXEJt0Um/G+HXy4anWyzGivj7v4Ty8HwQYHUSkfa3tc82wLi80ojIc1Jq6UIiyHG1JzM41TD2acMvNdjb5EO1DMbOebRHP1929ErBlCrvyRd/z9yN1wMspv1OrNtQ9Z55bAauGi9jXyUIi21Jzq8IxZf26MemrxopZWDAavGp9OTPYCssQReeysuBoEPIMDTiWedwoXyPeTCGSnlHjC5+euJLR
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(966005)(478600001)(26005)(41300700001)(186003)(16526019)(956004)(2616005)(83380400001)(336012)(47076005)(5660300002)(2906002)(82310400005)(40480700001)(44832011)(40460700003)(16576012)(6706004)(36756003)(316002)(8936002)(8676002)(70206006)(70586007)(6916009)(31696002)(31686004)(82960400001)(7636003)(86362001)(7596003)(82740400003)(356005)(36860700001)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 09:28:38.9152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9f4d4f6a-679d-4225-5d79-08da5f31e8cc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT076.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5143
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Jul 2022 09:28:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8699

From: Jan Kiszka <jan.kiszka@siemens.com>

gitlab.com turned out to be too unreliable for fetching on-the-fly
generated kernel tarballs in CI. Let's hope kernel.org will do better.

Checksums need to be adjusted as the base path in the tarballs differ.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc                | 4 ++--
 recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb | 2 +-
 recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb  | 2 +-
 recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb   | 2 +-
 recipes-kernel/linux/linux-cip_4.19.249-cip76.bb         | 2 +-
 recipes-kernel/linux/linux-cip_4.4.302-cip69.bb          | 2 +-
 recipes-kernel/linux/linux-cip_5.10.126-cip11.bb         | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 0e36bd5..c12a60f 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -16,7 +16,7 @@ KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 require recipes-kernel/linux/linux-custom.inc
 
 SRC_URI += " \
-    https://gitlab.com/cip-project/cip-kernel/linux-cip/-/archive/v${PV}/linux-cip-v${PV}.tar.gz \
+    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
     "
 
 SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-config.git;protocol=https;destsuffix=cip-kernel-config;name=cip-kernel-config" \
@@ -27,4 +27,4 @@ SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
 SRCREV_cip-kernel-config ?= "a8d04df6595344091eee2b242c3a0f5e108f966c"
 
-S = "${WORKDIR}/linux-cip-v${PV}"
+S = "${WORKDIR}/linux-cip-${PV}"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb b/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
index 7f89253..0fbf34a 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.245-cip74-rt25.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "436c7578711e67332c7a569fd5966c69e41d872a89faab211fd6b00fe2077b5b"
+SRC_URI[sha256sum] = "a14a5230356d334a2f06bdd2fed731956d3f6492e085c75dbebc7c4f7b5da1d8"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
index c36c51d..ddce99a 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip69-rt39.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "b5f267fa436e5d5e729f1febb741171cb1df5a576400d06999202f733d8e67ed"
+SRC_URI[sha256sum] = "5cbddbd7780739f7af91545691ffaa07a436dab4a0e8380a5e2b9b31e883071f"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb b/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
index fe20915..3105f43 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.109-cip5-rt4.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "ca42d37fa68769259a065d766ed266b7e0ac97b018febbec2ce71db7e19f968a"
+SRC_URI[sha256sum] = "71fba4ed5cb48fa7869e9fe271b68b77fed26775ce5cf2f50891aa8f71c388b3"
diff --git a/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb b/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
index e061644..a5b240e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.249-cip76.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "2dd59ffb3557580f9fae93952206880f1248ad3bd239983a71c0f7113f31880e"
+SRC_URI[sha256sum] = "7068eae8ea25eaded7891e14019e0c1d1fdaf8bb0abe77d42205b34fa059a157"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
index 8948786..2ae0b52 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip69.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "70d09ed7c9dcbd227e1c77964a0a912c21253cdbf6130cefe1db7cc7b30e59f0"
+SRC_URI[sha256sum] = "3acecb8f9ee4d9fba58d4a4cf4a2114018f030865f55b65cbc8e385ad04e691e"
diff --git a/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb b/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
index ac4f620..a59333b 100644
--- a/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.126-cip11.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "2b0742b538bd993538a73905100bcbba3f48b4259773a119a7c0fdb2cff5a0fb"
+SRC_URI[sha256sum] = "fa6b05e52b095ff29c08bbb2cd9d40fc4aedc69e9abf295fc303d30bdce51caf"
-- 
2.35.3

