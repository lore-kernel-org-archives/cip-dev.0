Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5787.1794388762860141973
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=gYn37kku;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.13, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi/Ctg8J0ooVTn1fPx2IkzJcpxY8oU+2hyJ/5UTb7W9z6ezg3uiUd29UAexeHSMR9JE+3BYkHyUvKhMZTsZDvaVJ0a+kexrb07tcQIGXADRtQuD+XNJeJRpEc1wJJITfjWXkmo4IWl1K0GtIbvz7KxsiNmACSqI+EH0xVUY2tChhNEu4xD7LecficlSD9z4lirr5hGWVy4E/1jGb6uoSLJii7XIvlT/jjvDAY/71dIZwNJ/raqalCwh0GPpu+Pf/HmGF1Cd7CdCdsCK4y5wYCtsIod7yEVwO9gd2SrxLLYb3WpmTPGOE6hpX+7KUMCaJzjUyyA09Vu7e+DWTiQDIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqOqyDRzi/0yPkB+tgKolwIfHjiblYQ9YPBaaZUXMsg=;
 b=SNd6jPaqEG5JmUB+DSulcr/fOQQKHkBQzzH0seWKWcEC37Tgi9H3TbDfqEiw96I2u/hxFXnCY1rsTs+NQbo85+LleIfe86Az7lJ4MmsTqLFndHvTuelV3s5iZgpioObVhpfNnrIvnr5rPswELjh36ta/09dYadumf+fX2qC4c9Wqrn4Vyk2bEqmBdn+/DDFuY7lbYrdgF3v45hBJJ9FoU5oAp4rALcsgXnpK5+P49mzUzVnJyn6tuSellQsqCfHA1DqPhPRVHcG6ru0JPdQiwQ103Ut0PUGhj+8pMDbz/HEFfCt3/2w41r+zLKLRRg/kvz32WlwpnmKRkoRM7+aTnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqOqyDRzi/0yPkB+tgKolwIfHjiblYQ9YPBaaZUXMsg=;
 b=gYn37kkuH2BfPhV5vNyfy/Ch5XW7wio7tbc1Z4n7RaNFkTtWbLFQ8+b6R2dJrKiX25DH9PNUpOXbRqJnmH2Yiu3VpARQFu+/xEZSzMsj53/uqNEo/TCMTk2oPe/CsPS4Cqx7ccbFRagS6IxjSK2vtqfeP2iuFupscSaSE04De60=
Received: from TY4P301CA0012.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:26f::17)
 by TY3PR01MB11475.jpnprd01.prod.outlook.com (2603:1096:400:40d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:18 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26f:cafe::26) by TY4P301CA0012.outlook.office365.com
 (2603:1096:405:26f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:18 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 226FD3001DE8;
	Wed, 11 Nov 2026 18:19:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/21] rtc: Kconfig: Broaden RTC_DRV_RZN1 dependency to ARCH_RENESAS
Date: Wed, 11 Nov 2026 09:18:48 +0000
Message-ID: <20261111091901.41995-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|TY3PR01MB11475:EE_
X-MS-Office365-Filtering-Correlation-Id: f006344b-01b2-4d4a-21c4-08df3fd4dd12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|261009223027099003|10067099003|261028144727099003|261102123227099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LA1radLaJXuGDUiYBQFYsUBg94R5U4RYFfV/2AUl8hP9wnBuInbRJGShIvu2g5fQ2bU8nAClIFrqeZN61RyFbzoNLv462edLaItFVGCUH2Pmgm7qSehJGpfSwQhhlxBs7FOeKvZAqA0yuERJPs/9hcImQxG1LBBnaM3UbSAQcc7E/B1/M5DV1U30WwU+96eHqjD+pLg2x0rnGuV01tLMpECRiviWHy4qNtGxwHTXmrs+i3L9i1uhXuLdzT0QiEqsoLS3M+GQ/2A9IGc9c4xdwvpl/BWnavLjCrjyAD7fPxGl4kOs49GjZfODE1Netjd4U4b9McdEPUIk+Y+NEOmBuLuMrcP1m0EEKh89JxC/I90p+CZXwjLL5Ui2t+QedO0ev9gzAUUG3GZQQW8qN/00uwmzEdrI6DSofur49IE2GOOcWPHgFsWJzCU/TjCLhZoXEQrdlaLgZKwv/O86LQ+lksO1GeBIBFy+n+dgQMit5DO61pvqjDY0XL5W6phpfsmr2v3VguSK59kPVCZ3w8y72pX+mAzzyGIoPEJMHifEqpdmiRQ919qXBlZdoRnqiB1s9qPM02DT6u7VgomTtgy9HtdJVTXUCzcbgBeIK8j5odKCaU7Y3j934+ghD3vdHquclpbLSsPebenQFf5okoPn0vtCKyOWSQwNJ9+z2+v0wKU=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(261009223027099003)(10067099003)(261028144727099003)(261102123227099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VbHMfJL3qe42a1WGYCo4FoZyQJxdbwmcyaoeUFUphqtICMfXHjpuXbjqATmTN3l3w2FAClsQRTcVJym24U761vOAyYoKF+2HTnkjIHSdcgUWQyiAo+l8fyCRAxpDatJ3pQ4jnIztrhR82vgz92qe4/EF4AUvI4rUr5/MFgV//AtA/cIk9RaHXFW1EUXAnHY2tEqL77geASHWpl8d+bUUEFUWkH4ni0OINCuOJnXomCX1uQWiKm7E7VVcGLPk6xJJRlIgsd3vOtCjyc1OGlSaAIkVqsKa2eJx5KJu1kp1GkSAUt5r1I+R+wRUpZeJ49MEtXeYmgnjUFv58qn5gd/N57hjfER8TsjNocof44uDiAZj0E/d5QWoqlTdU1XH/JekS86GnYkv67nTUmp9bz0T2J0QjXGKdpP79TAuFZTX6RVQd9JfSPxn9Gw60A6Nyyxh
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:18.3961
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f006344b-01b2-4d4a-21c4-08df3fd4dd12
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11475
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24749
Content-Type: text/plain; charset="utf-8"

commit 960987abe58d175b94869fb7aca72d7b931b584f upstream.

Replace the ARCH_RZN1 dependency with ARCH_RENESAS for the RTC_DRV_RZN1
config option to make the driver available across both ARM32 and ARM64
Renesas architectures.

The newer RZ/T2H and RZ/N2H ARM64 SoCs integrate a closely related variant
of the RTC IP block found on the RZ/N1 SoCs. Update the build dependency
and expand the Kconfig help text to allow this driver to be selected for
these additional platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Link: https://patch.msgid.link/20260821211032.13554-9-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 5c003c0c2f7af..0cb299cebbd31 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1570,10 +1570,11 @@ config RTC_DRV_RS5C313
=20
 config RTC_DRV_RZN1
 	tristate "Renesas RZ/N1 RTC"
-	depends on ARCH_RZN1 || COMPILE_TEST
+	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	help
-	  If you say yes here you get support for the Renesas RZ/N1 RTC.
+	  If you say yes here you get support for the RTC initially found on
+	  Renesas RZ/N1 SoCs.
=20
 config RTC_DRV_GENERIC
 	tristate "Generic RTC support"
--=20
2.43.0

