Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AAFC433F5
	for <webhook@archiver.kernel.org>; Thu, 26 May 2022 07:12:31 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.81])
 by mx.groups.io with SMTP id smtpd.web12.16862.1653549148034846981
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 May 2022 00:12:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Kl1/hc9W;
 spf=pass (domain: siemens.com, ip: 40.107.7.81,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2CXYdmwf7LyUZon2H7bO9PFnjhX/t08CS6E1gXcD7JaOqAHz4kvkHWOQ4z76C7putVT4acAbtESXcxsFRQxcV4ApUGUkApg5HubZD4K5PxIfFr0yJN0eZ6YowTsKa9VxzRKt+9nlAcBsbhmRsUYVzdHwPZLnlgeOhd/MWre7ezjKebcxQCOexv4i7rZS5Z9TOUCDPe/vhtkyUxRmneNKTPuDN4WNzdvg9OyL+mgD6piQzbaZdHU9IrIxmdt+lU7EcvUI7TOf/uDc+mZhsSvDUTeQO2LHq6oZaj+30XAR2op5jewOQlGWyanfbjbDg0pod5ShVcAAaM8cCSdXY88lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WyesAYZt1i1bacdUguAGl6l//oBRNuMndfIf1P7yYE=;
 b=AhcITaSS+wnuL/PomF5R4jwzvJFcbWR+Yyf24yXRq9LaQAEd4OHNuJeFX0aJw+zApxvr2Ay05iwI049pP+bQbiwd2qXtMaSpXaFtBBimEPrOVzaoWkdFQxQ+1Y/E1HGUkUWPjleSg33u5Yd0/nShOPBfX8mkmHXCYbKJZOca8AkowLEk2q2gWSD/fTZclfal+uiev7IEIn4KrLAPZirK+Qvas/9hz35xml/9gbCz+o2D7TmejKhWAazMoP7Nep1N3tXfbpLcoT8arlq/YqZQfFCQVL7a9QpknfIVZirIrercIRVy4Y/xtH2JdBMySmMDLofMmPHP8WlpgWDH5GT/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WyesAYZt1i1bacdUguAGl6l//oBRNuMndfIf1P7yYE=;
 b=Kl1/hc9WU+5fTiJuOu8qT4FczfNuQnl1RaJ7DfJfah8r1f5z0n+/HMV+uB8RsFlRYBXOGt+GFEcj3ou58fUVhtgwCaC8U//t2DXy7H1irdB9S/6wdcd9iG1Jv9bV2FMRF3jhL7t9m4Wa8XJS+TPH9/XHWXjDyAzgJ984rIykR15D8oJoKeQafV17nv+lMj1x3K2WFT9CzJkBwXWjd0o7KUhiMKV7voMzT8T5vR41CSJyuBhhC3b8RzHtiNdvU4LISKc8oXXWuBViTF+wq4Ul0r16H1aSZ6RzfxK4Ktqw5pwFKS6d8eJ7VJZlOFEp0SAsOMzGQbW5moboA9x/R0IqfQ==
Received: from DB6PR1001CA0008.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::18)
 by DB7PR10MB2556.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:80::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Thu, 26 May
 2022 07:12:24 +0000
Received: from DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::e9) by DB6PR1001CA0008.outlook.office365.com
 (2603:10a6:4:b7::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 26 May 2022 07:12:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT007.mail.protection.outlook.com (10.152.4.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Thu, 26 May 2022 07:12:23 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 26 May 2022 09:12:23 +0200
Received: from [139.22.142.41] (139.22.142.41) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.24; Thu, 26 May 2022 09:12:22 +0200
Message-ID: <9c68811b-c8df-6f80-d314-b379b131ab8c@siemens.com>
Date: Thu, 26 May 2022 09:12:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Switch to bullseye by default
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.142.41]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.766300-8.000000
X-TMASE-MatchedRID: bXMpGXE7chtgSxxjNvudtu+ydTZkDpix3BPrPGHYpyPDguUBa3ISJWAW
	2j9VWc0llwFBEZ/7LUOCwglX01Zi1sXlPjoEey1ih72wvxnt7XOb6lvlo0eypDhiciQR/+DQq5U
	6sO8HwtMGmHr1eMxt2YB5w6KBECW1rdoLblq9S5oAzLwZoZKu8kCsUNMkpre4bBMSu4v05tMP6O
	WzRxLAkz2mEJylgvfBmcAbB2Azfi315HQdpO+SbcFxQub4lz6uvycUQR1kwKZzEyQF4j0rd0v3H
	gUK4EtR02DA+6J8XN1Ad9sp7/hgklR8a/8cuDFzkZOl7WKIImrvXOvQVlExsAtuKBGekqUpI/NG
	Wt0UYPA/IhBN37AFoG90V+QQid5cw/3t96X5qeP9xUFzbTxuN2do9ryVgx/A
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.766300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5F44CE0DE2BCD39E5ED3950435636888939FBE679454BA0B2279B681EB65B4E42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df359602-5bbe-4fec-9480-08da3ee71517
X-MS-TrafficTypeDiagnostic: DB7PR10MB2556:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB2556FA307E2697072B32D9DB95D99@DB7PR10MB2556.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b9HR3GlWU3GyrueEmUVZ2Py+Fe0MNz02+bZqN+lQEqkqZjQ83YmFAmsqzKVSFdeTWwgmzwUdYgKTF7p0NQemxfS+dMFIaGG2W9mr8Z0v1bL+k6KCgwRZfC/MZCSH1DcD3cGSBchNkQx7LKgcpnAdX9YC3eVW5lISiGh7jfsvAihJUhElE+MJWAwdgcSF4cn5P+JXa6La0iyBXOnSjZSYgmGqhPb7RrxsDWSnucSxs448R+a+Lp4lB2H9gboXMLZgXPl05WbL8KrauNCq9dMOSezNsc4C4S00cBYpO15ldQrUfclqTtIisV1hamsIf1hc7zTZAhqqhKxKXhZST4b7b5H4Jo3UrmmoCHxe00B+N6J38JHWNe0pOTx+fUYZJNytDY75IejgUZfhcLdHRED29TOOsieslUS7uQzkyt8bFmsmCoCpz1+Z7ZFYetSgW03Hn4nMJ/IMn/6CHJKAEuQKx7DgDsYG709pKb+BW0WF8KptcxXAoeWEY0eHp/AKHstBt0e2d65cpvmL7D3PC5MM8a4Qd1viotRKFA39Wmkhb4pLyqjK5p6t1493zq5zt87yC8FOw9slrsG7icmZBi1OZSJMRKmkETXT9XiDQwo1qBX/OMzL6/jk+ZPgPC3I73/uoOJfFcGuqSz6MFEpaM5C5psWcHDRn0DxOtMFqt4du79P6SkzRbTQ+yrZ3Lh65My5z0zah1/z7biMstN9wTcExQFHsJEWVxaU2kguAPEgTH86uT/+2wvZdBtBbXw8k81m/xI3JAVmpO5a84dtJ8MNRQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(186003)(83380400001)(82310400005)(336012)(47076005)(86362001)(26005)(956004)(2616005)(8936002)(5660300002)(36756003)(40460700003)(70206006)(70586007)(31696002)(2906002)(508600001)(44832011)(356005)(81166007)(82960400001)(31686004)(316002)(16576012)(6706004)(8676002)(6916009)(16526019)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 07:12:23.7799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 df359602-5bbe-4fec-9480-08da3ee71517
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT007.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2556
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 May 2022 07:12:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8440

From: Jan Kiszka <jan.kiszka@siemens.com>

For new projects, this is clearly the better choice. So, move our
defaults forward. A separate kas option is introduced to allow explicit
selections without relying on defaults.

CI is kept with its existing focus on buster images. This can be updated
separately later on.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml     |  1 +
 Kconfig            |  3 ++-
 kas-cip.yml        |  4 ++--
 kas/opt/buster.yml | 15 +++++++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)
 create mode 100644 kas/opt/buster.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e2ed919..8545a66 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -35,6 +35,7 @@ default:
     - if [ "${extension}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
     - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi
     - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
+    - if [ "${release}" = "buster" ]; then base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
     - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
diff --git a/Kconfig b/Kconfig
index 651a726..9c89008 100644
--- a/Kconfig
+++ b/Kconfig
@@ -80,7 +80,7 @@ comment "Debian distribution options"
 
 choice
 	prompt "Debian Release"
-	default DEBIAN_BUSTER
+	default DEBIAN_BULLSEYE
 
 config DEBIAN_BUSTER
 	bool "buster (10)"
@@ -92,6 +92,7 @@ endchoice
 
 config KAS_INCLUDE_DEBIAN
 	string
+	default "kas/opt/buster.yml" if DEBIAN_BUSTER
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 
 comment "Image features"
diff --git a/kas-cip.yml b/kas-cip.yml
index fce176b..48de066 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019
+# Copyright (c) Siemens AG, 2019-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -12,7 +12,7 @@
 header:
   version: 10
 
-distro: cip-core-buster
+distro: cip-core-bullseye
 target: cip-core-image
 
 build_system: isar
diff --git a/kas/opt/buster.yml b/kas/opt/buster.yml
new file mode 100644
index 0000000..a762163
--- /dev/null
+++ b/kas/opt/buster.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+distro: cip-core-buster
-- 
2.35.3

