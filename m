Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA51ECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 08:55:20 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.83])
 by mx.groups.io with SMTP id smtpd.web08.22922.1661936118767004038
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 01:55:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=U8AH1zaD;
 spf=pass (domain: siemens.com, ip: 40.107.6.83,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrwBf8Ixy8sJE7lz0nK7g0xQxVRCyLL/SDBqdweRpc+lbZFs7GHNKFSgLKJiYPS+oy4VSIQbhbngVnXm3XB+6wxkYOyPNtLrmSlReYoQPiWw8bwgsQ0ip1xroPy/zwyhdkEC2b5KzF9lLMfl1L0cuWpRb3gBuSuW4YV1tcxZB9TSJLow+4Xp1vkCZWhMORCVhGIY8MOE/biT867Yrtls8ITz1DxN1tn6PmvVg2U2gM0uRhoMAZI/TnPhgwFqqObWUtkCxERvBW33PPxq67mdNzVb9llovoczTpIeEFOCKZInlkU9KhNMZNujA4hC7Bi4zvWLxOu5uzu3jkDCgJpaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6sjb0faM3bPnAISGlWq13dk/sXqSABLkDhlPOAinpK4=;
 b=Xka4SrZk9fmyNDxdeGN6GiSEzGO5FLjctwkw0/RfeGaFwqg6eNKk2J/vtUkc84TegLBI+WJBKNyxGA/hDvHUoN7qM83eHEqS0HnkXF8MN3IV3tIWRd2oe2H4VBzwBkPPHdCn7DoiIk+hHLYbIwKLA25B3jx6e2pxRAHfehh6KDXEGY5TrTlT6PQCatzLY5ud3AWRv80k0ncnXCg1451XaLypuF7WCPKHPJqmPWw6qGvzColv+iLzhd+f1lN+pJgfPTp95E0LfcrNiUrIKrUOr/PtDO8NMuUt9oMtb+AgFkwOLf6INRJRXbf2DH4BlX5gIRc5rPotKPbNO5BSDnbhrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6sjb0faM3bPnAISGlWq13dk/sXqSABLkDhlPOAinpK4=;
 b=U8AH1zaD8DVHl9kgK0o+DpkgoUpdagvIHpRSUjdcYPBFTbGTC/Z9iCSnyBDxxSPXxIUjYIhRfuvd6RullAFSu3C9DXUABQBOqtFt7Jp36eJiI8/3nttCk3DVkjbiHOBCHZoEoWlMbTIOx76d++8H18+npPeIPHXSMKrcaRKX5sO8j8q6plBIf+0FEmgPrDaI1sUG/xcvQS/CS0LQ0ZgwUiNpafIGR12y9VDaSuop51YgVnJUNQwjx7u/Mn42iGx688P2B0M4IGuDjJtVvAB4fQ4yiT3212+yBxnd/LGgM09BQQuwCe+huuwkgeQ6ZiX7Kc2d/XgGQ6fy8C6cnZMaYg==
Received: from OL1P279CA0032.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::19)
 by PR3PR10MB4093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 08:55:15 +0000
Received: from HE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::99) by OL1P279CA0032.outlook.office365.com
 (2603:10a6:e10:13::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Wed, 31 Aug 2022 08:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT086.mail.protection.outlook.com (10.152.1.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Wed, 31 Aug 2022 08:55:14 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 31 Aug 2022 10:55:13 +0200
Received: from [167.87.47.113] (167.87.47.113) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 31 Aug 2022 10:55:13 +0200
Message-ID: <596aa72f-4acf-2300-d353-1ebf31e35d55@siemens.com>
Date: Wed, 31 Aug 2022 10:55:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 4.19.255-cip79 and
 5.10.136-cip14
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.47.113]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--11.632800-8.000000
X-TMASE-MatchedRID: G9cENiKYZmdDh46X2zKVIBOqo33PiIGeUYR3k5IGZuY/QdUh6LEl0AEP
	JrYlsf/6tmTuCy5+VUqCyaW+JWkhai++B0pV1xLFeTjw/FyRX6RNfs8n85Te8oMbH85DUZXyGEk
	IgdGU7nX6C0ePs7A07R/88i/oAaos9kqpKkwrhk8bwLJ6ksopbBqQGSm1qVnEjjXevVsXagk=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.632800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9301DFF7EDBF208DB5FD795677E2E24C3CB48037AF14F9D933BB6BCE94211DB42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b201a9d-d479-4f99-dc4e-08da8b2e8562
X-MS-TrafficTypeDiagnostic: PR3PR10MB4093:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	P1FiFm1E6JbuNh2cnXC04oxI94AlcYsMp2krg4mNPqSoWirtE7KbiccDE8IESswzAju8UXgamzBVxuiGqxN/2Dr3IC41L9KHsxrKTvUQbgmexRVUQihWAt8QkuZN53rQa9P/cWOIXGXU+wEVKxd3kuSdxutWR/Q0EelWvccZWFz5pJtHBzWQSLLVFhIIclTOCjILXpjY0Mvi3lriIno/HUuTSRFMBxnlcWsQTGiSRE3zPZekL0at5ixlzKukiNzMlZVyzUxAyyt04cck/9NK4cVF+76UR5g3YDEmu9ujYmjjjNdPLd0lXupE3XUv39b+x0otFEn4jezo8lSQuqLXcsE6CvFSizXi6CYc6v8fk6n61FHvbXRnwnCjuO21yUPn9MbAyBn/mB8YPG9n9L0tEqi6gs9uguq2wqUDdnYqcINRouElFO9G8941ILicZ/WPMrDlBWxZObq4wnR/DmYEn/O36hYxkYyqZiTD+F+gSJkU3IypemUE5uOhIw9igvEsNuv7oF4mwizSDrEqu5TUj3tWfVngjDiOGlUigY119asK0gWkGUJ5ie04kIkyQiqxoVH2t8/Rvz/ueHw24CbeJk43vzuKEdIx6zaLUV/72BA/F1Q3L68vsd0EoX51WGdqrP1ExOZoz+a85oPAe7Z6VKI+TPBM0ZjWOneSKfmpfzvja+aPsepgaQwhiz/EVOuBA1OsBs5aYv+ZoVDnoCH03gD76ZPN/ZMfUlKB58a00JM1exhsn5sEUNCVteXflyvoisq8NB/TLV8rqsWhLHG5WjumdhiTdySeRT65E68Ojn7943YXuCdMCZ2pe8wWFq5SvmML9Y73UKUnK83xOu6w+XyKwhvVaG383diORb4noPg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(40470700004)(46966006)(16576012)(316002)(47076005)(186003)(83380400001)(336012)(16526019)(6916009)(6706004)(41300700001)(8936002)(2616005)(956004)(44832011)(31686004)(36756003)(2906002)(26005)(5660300002)(82960400001)(356005)(40460700003)(31696002)(86362001)(40480700001)(36860700001)(8676002)(70206006)(70586007)(478600001)(82310400005)(82740400003)(81166007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 08:55:14.7908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1b201a9d-d479-4f99-dc4e-08da8b2e8562
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT086.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 08:55:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9335

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...{linux-cip_4.19.252-cip78.bb => linux-cip_4.19.255-cip79.bb} | 2 +-
 ...{linux-cip_5.10.131-cip13.bb => linux-cip_5.10.136-cip14.bb} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.252-cip78.bb => linux-cip_4.19.255-cip79.bb} (72%)
 rename recipes-kernel/linux/{linux-cip_5.10.131-cip13.bb => linux-cip_5.10.136-cip14.bb} (72%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.252-cip78.bb b/recipes-kernel/linux/linux-cip_4.19.255-cip79.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_4.19.252-cip78.bb
rename to recipes-kernel/linux/linux-cip_4.19.255-cip79.bb
index 326d011..7d1e634 100644
--- a/recipes-kernel/linux/linux-cip_4.19.252-cip78.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.255-cip79.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "a77f4b3f81b76318a3d5a68a034100efae35ccb43e99afc820a8525689040bf4"
+SRC_URI[sha256sum] = "5e96607abd43e0e9e5935068f684b47fbb3101f913a85812ccbb326b27ff369c"
diff --git a/recipes-kernel/linux/linux-cip_5.10.131-cip13.bb b/recipes-kernel/linux/linux-cip_5.10.136-cip14.bb
similarity index 72%
rename from recipes-kernel/linux/linux-cip_5.10.131-cip13.bb
rename to recipes-kernel/linux/linux-cip_5.10.136-cip14.bb
index b2e372f..3114365 100644
--- a/recipes-kernel/linux/linux-cip_5.10.131-cip13.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.136-cip14.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "bbc453c27e4d67d1e07b741505f7012ab6c0f7e17efebf29ffc246b42cb612c7"
+SRC_URI[sha256sum] = "27dc2d0b877582b1d8e83c071029b26752d8a9cab2033ec7fef0c68b6bb9b4fa"
-- 
2.35.3

