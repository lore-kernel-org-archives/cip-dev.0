Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005B5C982D9
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:46 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35133.1789636601190404106
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=noa8Bs4w;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.66, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVbuKLn7M43qjB0SeZ1PJXlxYjMCu8rXyYaVfK3jtc21ClKad+I8Cl7DkLwxE8MbE0yyLzn2xxM+/YMSZlRdNcyKzroYehpM8dtJynw2qd/A08mHGh33Nw/3xh0G45K8m8sIoT+m1uHdEx7eiozwQax5B7nXIx6R+9Lncm/eXj7A7zZt8B4ZilqOxmUfPgs3w7OhkHkQaI0k85aqGGyBuLQLCWGSBpLbPNlV/9y6HZhCXlpluSPZ6ATQagf/usX3qXFrn0R0gDp2FlvzMUFo4+mvAjd+yi9U1V21ffczj/+bUrT8B5EQp5q28dXwyVV9O03+VL7gEMB7P9ZArP1KRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EojDCp+VKaQfwVMuP6kupBXYQbf0Jjw8VKFbTwUO8FI=;
 b=Kvi2g4x8K1Asxs50pQZlJfxBF1UyFlnlOjrdj4DouK2XRYdsgiRpoImYc4fWT8Z+IjBP0dbq/XSBwwb8bKalztvX8GaarWGzBPstK2wmRN1cfoXNjvrxqP6rZ6zqVrg+bx/Q4YqiAw/HYESGAmA8j7zRbd8aeTns63p49GAQshZHr7+pRDq/yyw+WxtAMykgsdGEi540tEs3c5nKJk6XuccUFZYS+3TfwlAojSCezjuNJuT5tWC8gqWw4hKRH0NQbbAemU1CkHxuQYi6yJiTd8CjUNcvJ+dvVF05tds1SUKfqmeq/Osqs4wahrbOCyh1HCqvRTb36xvHxlI8IQR6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EojDCp+VKaQfwVMuP6kupBXYQbf0Jjw8VKFbTwUO8FI=;
 b=noa8Bs4w4IVTS4ieJJtuKdDMkgFsWfV4n39pt+ye6Xi3ec6UN+oWCdxRTDxNEiOxhpodGYj368ir9jjzRmqEfsdm62JfaF7i2VrJ2aCI4voPxPe8DltUUwl7LCjdFO9WKgN9Bsn6y2wioBMISA218pIFtM1+sAherM/tmGIqKJY=
Received: from TY4P301CA0017.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2b1::18)
 by OSCPR01MB12535.jpnprd01.prod.outlook.com (2603:1096:604:327::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:16:36 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b1:cafe::6e) by TY4P301CA0017.outlook.office365.com
 (2603:1096:405:2b1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:36 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id EEABF30007C1;
	Thu, 17 Sep 2026 18:16:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/10] clk: renesas: r9a09g056: Add clock and reset entries for RTC
Date: Thu, 17 Sep 2026 10:16:18 +0100
Message-ID: <20260917091621.18551-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|OSCPR01MB12535:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d483cd0-e1ac-4c52-1b9c-08df149c5fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	dLnBZNMispQiAo9iwzq+LjM90rqTU1C1y+PMQPts3RUHd/RjMv4HW1F5K5u0Mop9AvzEvLYRuwmYtOjwDruSZyesuswjw7YysHwJyEUS9kVzfWMGEbczmCrl24vTc78JpkiT9gBFFhmS3pT7vJ6ANrPb2dNaRXadpEC0ykYPimQBV7KT6iAQ3XQe/kaIJM5SrIsgo4dUK7hVH3wU00Pq0Gj8SZLDsQHNIDQ9eJtMaz9U5JulZYZWkYQUG9fYiyaiQBXixOB/819eDC6FjCzx2rRc3smdfzZ20mAQLY8RctfNtppZx3uowpbyt4DhgKztFx06aw+esHLpx/WlGQ3n3qkpPWoYVWguidMAKqOUULo9lmXLLZotJ/SopjBNkOPHAjh3UKxW8OU5ke/HxFKmvgq40WOeuIe6i3FUEsG/w6wah9H0591SGhGjWmsjfoltOp+Xu2l0hnNw7sDdlWhxSzWws+1/s0rS07aulqGM9D6MYtn1iGa/W9W18NYB6dD4lQpzwbxp/72kCPQ3NYqITOpUT8Di36VC6h/MJ7PtfTm4ao3iIP0dsVUANSCsgkCPiuxaGe20JdMqWbYc/IzwGuCtsUM7MPWqNDoC7GD8fZjujgzMtuCePJFJ2Fya737HXfz6Id55o9qvFmQSwbB6YQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	RIM4pLsBZjl08klZd/5Z+I+1dxTDw80yWpl7G/Mw4MMBv9PXEhZ9cENqWMMwtrj4Ph15PHOuA/TVq73ZOQyQ9eOPeiYjWuRZttRWQMZg6at9C2b3E2l/S/I/TkCavDydr7yJqdyRxKrdGqRpyUGVSqwhtoqmDkPG0PrYf3Bdwo7ASCXWlo11vvgM/xn25J7SZ99KLHu5GmcV0qHtJBXO1IMh8kd1xw5olTYT7cL6CkbVMdmQlLjVyQb/ZJV5DVD4AO3NPcN6qNQXlPyKrtqwtVjw2HfhG+jPJtfQPwNIyY/rtcMq5A72EwvLehtdp+OUtrajj+94tmax05qQtZ9hdQFpMTpEgf2d+2EYUPUW9Y58PaWDYqTpe7Gi5KTtpnnps7n41/UonAXZJyvWhIptbT2mgtMxE65Niv1XuVbih3sBjYm4aEwbOfX7h4GRzPYh
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:36.3155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d483cd0-e1ac-4c52-1b9c-08df149c5fbe
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12535
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24215

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

commit c8d5972a25408b1daf73653ccd5207fdfc80c964 upstream.

Add module clock and reset entries for the RTC module on the Renesas
RZ/V2N (R9A09G056) SoC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260125192706.27099-3-ovidiu.panait.rb@rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g056-cpg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g056-cpg.c b/drivers/clk/renesas/r9a0=
9g056-cpg.c
index 197f3392c6ed2..bbaaaf3f9894a 100644
--- a/drivers/clk/renesas/r9a09g056-cpg.c
+++ b/drivers/clk/renesas/r9a09g056-cpg.c
@@ -268,6 +268,8 @@ static const struct rzv2h_mod_clk r9a09g056_mod_clks[] =
__initconst =3D {
 						BUS_MSTOP(5, BIT(13))),
 	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
 						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("rtc_0_clk_rtc",		CLK_PLLCM33_DIV16, 5, 3, 2, 19,
+						BUS_MSTOP(3, BIT(11) | BIT(12))),
 	DEF_MOD("rspi_0_pclk",			CLK_PLLCLN_DIV8, 5, 4, 2, 20,
 						BUS_MSTOP(11, BIT(0))),
 	DEF_MOD("rspi_0_pclk_sfr",		CLK_PLLCLN_DIV8, 5, 5, 2, 21,
@@ -430,6 +432,8 @@ static const struct rzv2h_reset r9a09g056_resets[] __in=
itconst =3D {
 	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
 	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
 	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
+	DEF_RST(7, 9, 3, 10),		/* RTC_0_RST_RTC */
+	DEF_RST(7, 10, 3, 11),		/* RTC_0_RST_RTC_V */
 	DEF_RST(7, 11, 3, 12),		/* RSPI_0_PRESETN */
 	DEF_RST(7, 12, 3, 13),		/* RSPI_0_TRESETN */
 	DEF_RST(7, 13, 3, 14),		/* RSPI_1_PRESETN */
--=20
2.43.0


