Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC9C43219
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 20:57:04 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.58])
 by mx.groups.io with SMTP id smtpd.web12.173.1649969595709735452
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Apr 2022 13:53:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HS1jEsVu;
 spf=pass (domain: siemens.com, ip: 40.107.7.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHl1Bxfacnbg+ElNbfveVzc+NHe1d9gCoAB/H0EdypWDe0JRaLk5LfmIhBQkfuIOdtQPHrzz4/f09Z7Szblb5y2bWXW2HaunESsXAqebl4KXtouWz0qhOA6iCsi77Euk/1Otr8AJYn+JtbSxiHj1ZXsEobDL+c32X5OPHSQ3yghom1qXlYQSj/PEUhSdeRVvB0k84n/WaOg/fGPMrGNdl1NSB9WobneHSBPsk4eAddYJYeS/TBfHnwiNzLv6j3ph4EeVkkamhdx5kqJ0F19MploMasHmVSooR/F+EPJ5zBR7S3w7WSaioO+Mvev83X8SYm23b2gFmgDSkRZMquu3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N2+/Q4aEw2I4uNlk5ELwTiwjyBUTVhBfjlyaPpoCR0=;
 b=QaFtb4Fs+pWHchh7zYoFZUHc9VE+gJLDN49tk6DHLGcczCtPDKb89IPTNB3pkXDkInHkEJYT+0wOEWRZs4X8pBUddk0PGiChUXVgfst8Nn2bHC3to9VlvqWzkeSpAQNqSNNMjFPq+n1/++VvQaIm4QGFtEEuvyE1FDp1wEL+lBfZJeqjScnPCGljlVHYW7YHiYSOuaVruk9fxbVdj7hlPeKW8GMNBD6raUy+cOjfQu2SfnstBauh//POBKg4obgtlVd+7V9gnPNXe9/GgG4ALZ/fGZXId7uZINkxeRSfJgwl6XBpea18HhfqGpEfWI2xZeS77qUP2OQnbcNN07Lz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N2+/Q4aEw2I4uNlk5ELwTiwjyBUTVhBfjlyaPpoCR0=;
 b=HS1jEsVulBNm7p/Yx47INBTHSK95NPIHpQZg6yGfgEcbYiIOek/M4gwQp3VMG+pWCt81N9lz6knRP70rucWl3fl3EGW56a++LlmCZS6NVVCv2qiRTvFTXANHm52dgSCBBYmFyKjlPvuvbDalEW/ajh3j8adcc1TgxmElmTc8+eecvkuMTk1rmeADmqDHrX7uqnCbl/xP0XQmwwL1D1PBtxa6MFZyMMu/pzugIUS7bNJgUKHLIYZk0jyMqof0Wi7nMIKYdfduv1qbOHttt4kxPw7KiQSmXw+NA4+sINjK9wzplc/j4v0Vk1XR4Oo/y1/qutTGbdJ0N5PrcMYqhwoNDA==
Received: from OL1P279CA0003.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::8) by
 AM5PR10MB1698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1c::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Thu, 14 Apr 2022 20:53:12 +0000
Received: from HE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::25) by OL1P279CA0003.outlook.office365.com
 (2603:10a6:e10:12::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Thu, 14 Apr 2022 20:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT105.mail.protection.outlook.com (10.152.0.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Thu, 14 Apr 2022 20:53:11 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 22:53:10 +0200
Received: from [167.87.72.32] (167.87.72.32) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 14 Apr
 2022 22:53:10 +0200
Message-ID: <1c904138-cc44-2bce-4764-e46f143d1e18@siemens.com>
Date: Thu, 14 Apr 2022 22:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] shtab: Truly fix cross-build
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.32]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.610300-8.000000
X-TMASE-MatchedRID: zBNhNLzH/WPYd95zD4odNYkJigH4azA4LGmmJTL2jhwD2WXLXdz+AX0t
	CKdnhB58vqq8s2MNhPDFsa+Yz2ePk1BIVsvVu9ABIAcCikR3vq8NCXyzNUW5JbGHrMwuOiEVlXc
	vy92M1bXee0zlLVmFLyO61IFSdeou
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.610300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3ED2E366E18D46A966EE48AF556CA9AD263CA1A7A2F9CA7354C06FBAC01CF69B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf717206-1e36-4501-eeb4-08da1e58c985
X-MS-TrafficTypeDiagnostic: AM5PR10MB1698:EE_
X-Microsoft-Antispam-PRVS: 
	<AM5PR10MB16988240C264D58A79BE15D495EF9@AM5PR10MB1698.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	10LH8hmD/p4unNrZmYZaa+W+5FzrcsiTH0wbWA3oqQV/8cCPmIHmV4iZF7x4xwo7lyorLheJE93FNOytHbbpDdbnNSPosiS7/3xhvvnfF9bUS3/dpn95iYgK/0iaV43cnCpnq7oD15nuy93a58gaPSzP3OTW7DCJwREYf81MmYUgY5BMlOfCzkT4wnwgj4wxHpb9QpgxM3m3hRx7Xfic9RZl6CbHK4FIKlRFF4BtaRW2TppArugTVbNHVn2f2uC7AZ0aVCUHHEcFFNJR1Qc6TRe+smzX4KzvFTbBQTsmsrAXCJiqNW6phbY3lWucHHE3X56kRlFjepOEDOMNYbZJGbw7oWLTMhAJJv1JGqrK+Vxhz2taH5ZaNOB8ptVdCGWVfsX2cGevWMqhpi0dCxiLidX4uFZ2DT2PJK2/SJdDdFwiiyBVVsUR4d+y03k37wo64a7gmTy4L0Tgjh5PxHpvkYgZD9rRXtXOsXIv3jW+sEkJGC3PQBFLsEl9lUg7tSvEjVTIhfaZMzAY65u6UpEbBQkUNO+Oqq4oU3ltkiCaJ1rl1NYmMd3x6jDxxuxy/2CDU/Kl0QXraClYYM79RFMDKzihghJjFIufEi2aVPM0xQTyrCHur4HOeYElldaGrWRJUNIpQo0ZAkqUP4BGoMw49mH9QuA/Ye50ppu6FFgen9kBiljXXIRYtuDigzgs+6SsJbBuEjRy8ApFnwzACNDOJQ3DcHlrJu2CCDkpJqiR4yjsPO+jCV+Uo0XdO7xw93mmSzoOkP24ecGjdqRgw0UODQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(82960400001)(31686004)(26005)(2906002)(86362001)(36756003)(36860700001)(356005)(70206006)(498600001)(70586007)(8676002)(82310400005)(44832011)(83380400001)(5660300002)(6916009)(8936002)(6706004)(16576012)(81166007)(186003)(956004)(16526019)(47076005)(336012)(4744005)(31696002)(2616005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 20:53:11.2362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bf717206-1e36-4501-eeb4-08da1e58c985
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT105.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1698
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Apr 2022 20:57:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8098

From: Jan Kiszka <jan.kiszka@siemens.com>

The python3-all dependency must be broken up into libpython3-all-dev and
python3-all-dev:any so that other packages can still install native
python into the (up to now) shared buildchroot-host.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-python/shtab/python3-shtab_1.4.2.bb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/recipes-python/shtab/python3-shtab_1.4.2.bb b/recipes-python/shtab/python3-shtab_1.4.2.bb
index ce83d6b..d03e694 100644
--- a/recipes-python/shtab/python3-shtab_1.4.2.bb
+++ b/recipes-python/shtab/python3-shtab_1.4.2.bb
@@ -22,7 +22,8 @@ S = "${WORKDIR}/shtab-${PV}"
 
 DEBIAN_BUILD_DEPENDS = " \
     dh-python, \
-    python3-all, \
+    libpython3-all-dev, \
+    python3-all-dev:any, \
     python3-setuptools, \
     python3-setuptools-scm:native, \
     "
-- 
2.34.1

