Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99952C8303F
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:13 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.64])
 by mx.groups.io with SMTP id smtpd.web11.20550.1751452563685648177
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=f0+EdCPS;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mOxyASuoZaJsKnl2ZBZkI2sjWO4ru9rTDzjyBmFnsHXZBMhFkHyuDA99oTZNggIidhDIiEiVzb3x3bdn3zeXR2T+wuRiT2J1By25IADpdBDCiNCLOdQj5oiJYFuKmk260tKC28IoMJemeS/FYd4T+a4l7I+EhYL6JJ9iGOY0nTpxixhXRYvDutBHfjAp+hwfEBVdsUbjUqXAY0018c9AX6eLHKnrxpRlcR+BpnvhidYikPqDtMukMMMlObvKUA1n0ontlDeCTQZFD4zGtx4WP4OwvT4ASzyP7JFH/tdg+wJgHqRLbWSJ+ZLwPtY/G0YZLMWLj2l10IEHkzWutQR4vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogNMKy6kNQpxZSmdjwsE9rGfX+vTviaiD39zIaz4OM4=;
 b=u93cXbK8n0OVU0l6Y5PS8Od8dpTFHnCQ29fnuYH9enmhlk5pDa167NrKbHsnuB53v27NqcXQnn4F8P0FcIx12UTKN/UoKXvAzu0pPzpLqstl8LjW4QavEToXfhmrlmdsRbcoTFai1lDD+wT7iFAyPVR0VvfvP2NyfzyR21DSX0PaHpUYgME6zppFIJy93dDQHA5CTOPMewSYngDXJEwU+NhFzkf7elubUabSXCpAXZrDyA3UWAS4IQ7z78ATLY7C6RvdOTUUJ6CutRVeeDjQjP6VPtRtIUd7fOpcS89/uii5o6+EUTsr9pnXQGOniy5VxC1sX7H/iOdvKZnXxh8fNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogNMKy6kNQpxZSmdjwsE9rGfX+vTviaiD39zIaz4OM4=;
 b=f0+EdCPSIYiRJ5IlNJFAC4MppU5OI3CI9bnf92Al1+2nf5qOsO3xUXpifIg+VJ7OL77Wch4cYFALUqIKatLuvpKwir5QRXq4U/NWUEWb+yEMAot0K4r9fV7dU2/8rmfzHLZZabkPSNUbjtZ4jE/MJVEgDvvraKYsn5pmHzWOX0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:36:02 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:36:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 05/12] clk: renesas: rzv2h: Refactor PLL configuration handling
Date: Wed,  2 Jul 2025 12:35:18 +0200
Message-ID: <20250702103525.117166-6-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bf257f-fe53-4b23-fc79-08ddb9543d99
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KBza2Wrypl0VUCf4emnI5UqrxZ4rkqLELqvXcAu4+x/rVOrLMTvL5aO5sQIP?=
 =?us-ascii?Q?22wXQJdc6aVHDK/7U/BXTZFY11xAbZEMTPV/W/2upFbGETTblMEs+zskI/Ji?=
 =?us-ascii?Q?HfQLoTqZUXONbJG2Jp25fU5Nnv4b+EkAgUU1wxypaD2AdVEHyrJ7EBPLGaOc?=
 =?us-ascii?Q?N3NWQzt7Yk9M3MEiLdyj2DhwFEUM/uMTVkF2ioSe6sLCxwOCVod7cVrkZYXF?=
 =?us-ascii?Q?1Lukl6+mZ3AezVVJXXzf/l96UApS+usabITS8QHBVhnjPfRkFPfPsnQr6S2g?=
 =?us-ascii?Q?v//yY1ZvdIWwNxnIrJwi8X4cDgupVjqxuB7YYzr7prEkVKVLiAYzhsUcrMrm?=
 =?us-ascii?Q?HibTEpJt1ndRpa5gw3u+0FZKVDZoRINHwlT/lAH2pgxU7SBvv+jJk0jzef88?=
 =?us-ascii?Q?8WnNgvOf6Rqc/fcEdoF6fGlaSEI+AWzvNlYF/jBwmgsik0qPXo9ylqCMP4x6?=
 =?us-ascii?Q?E9N0cGGr8orS06owu8Q4JB6dnz7vLVF57yzEbKLP+Nbm5+1AxFhL4HEVUd+E?=
 =?us-ascii?Q?K5ssmj7vwHUWtqMpUNfjN4AjgVaIz4YsTOpw3N+rqu7KFkFDeOlIBcrM3j0t?=
 =?us-ascii?Q?qoN/3FwsTC0pfJcsYjv4TIKQPh45D51TITH3nXhhyjvn4d+weaR+4YmTZF9j?=
 =?us-ascii?Q?RmBRDTUlkhaRWl4hrdcNUVwFlyy9xBDtk6aeAXuW6gsAgq7RlNobJNAy+xXS?=
 =?us-ascii?Q?ggwp+pJ0EWSCkeG2MiieAmXHWbfvV284HumlC8E0C2hofD3BsZrZzl6lkcf+?=
 =?us-ascii?Q?s1cApHuY9COM08GiadIkaVnY3a8tE8GYUq4oj93TJiI8Hs8DiWSCxzGx5KEO?=
 =?us-ascii?Q?Z4OYKLZZoa0PVnrNuB0LsoH0CVRCV2mvBTs/YKh1FIDBFjyCs5WWfNvfcgjQ?=
 =?us-ascii?Q?SGYlIU3H8Xe4a/mZT9NPcD2K1+zxJN2LtGQByria8VV/33xX/rkQObyEtMz0?=
 =?us-ascii?Q?O5Lmi6n41hTJEBeGUj3Bi6p5cDk0TMvwqqDjz0HHVBAwUQJ+kP1133oPVEM6?=
 =?us-ascii?Q?UdgmoAnzg9XOA13ntZCeHkeu2FG7c0sGr6/xRFh6YsndH3vYwyjMDN/qWo1q?=
 =?us-ascii?Q?4FKzlDB3wDw0vXdC2baijqxj0a+xV9JmETEXPSxWPIa/1fkks8bWZawHkjjg?=
 =?us-ascii?Q?bSuFXHrmb8kaPCyero+04oLF4+0QENBQt5Hh0w+poUyQZ7w+OaoYXKJ7xVh8?=
 =?us-ascii?Q?w5zNHhCnfFzpxmPyUicGyFkGddUUNIYuJruYmMB3R57hdtNifMViTy2VRN4E?=
 =?us-ascii?Q?iJFqDx9mvqobQvA8delbZ/OrxsR0/8Zd3vggKzX3NF06Z9gtBOvjY4AHG04I?=
 =?us-ascii?Q?MJVifGXoNI3cDHflpBOXysGTwP9fhkOkjme2JjMi85++IY8d8T2d7KRJYqy/?=
 =?us-ascii?Q?vM36246ZwfuwdNxWFTA3GCpqYbUV7dEaDKqecw452m0lExsUPNp/zWKs8sfE?=
 =?us-ascii?Q?qfPonPbGtP8PK28UdOfqAhA0Eo32r51Elx5UzUc5dGgS+KcpDHOlI2Z8wJR/?=
 =?us-ascii?Q?LYSjbiILXtxchX0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nuberloKZ5N53pjPQan34e0FJv4jjBxXz/o0Z/FUesU6UV1gou+hqWxbhWdS?=
 =?us-ascii?Q?3smEyOmWCUycAqcNxv9cKi6MFdkRPPHjx5y5euyPDhadGPNZmBRKGGcFynb5?=
 =?us-ascii?Q?odDjTqKQIzBdxX68j0eZ+Uku3QqtdLqHuXv3/r2PUQTNjrvWLZPtbx7X0zp+?=
 =?us-ascii?Q?xGv+jblS/YZuGOlMuBVfafH9RYzSM0oIp30oSuCR6S2TL7Q89aHGiBoLm9uI?=
 =?us-ascii?Q?EPBhTSQxsbKJsGBauDq0wMsL+9Jk6QBuA7qyNGwWCjKPK8COSCEL+dwUsnH4?=
 =?us-ascii?Q?UT+UbKNwGJz2gHGMw6ZF7GEZlLK4lPgl8937VlN3GqaQrOJs2uyRk5xXSzfn?=
 =?us-ascii?Q?+YwO60lBGL1Ua/AJn/Y9PnMvl0ML2C/5a/OhUtRaozsURmTOszJ7BonAE3L7?=
 =?us-ascii?Q?zWg7axbk9yfZF2kAKwqRkN10We9YnQqRngA7vpc1pgmfdDkM16XRNJvjuxSL?=
 =?us-ascii?Q?IBYcgyj28c+wsMTqG77K/ZfT7NoPu1qBs8Fkz4GIeJlv0108PQDZXGn3HlHn?=
 =?us-ascii?Q?kEH83RQ/efEmhUsH/vgMd9kcc1kN4RdObJp6SvUzkhw4YJDM3DYlgHF3v8Le?=
 =?us-ascii?Q?4J+TlEaMP7vK+GAMAOEXmCkzhblSBXStB9UyJs/5F3XCkjmdcGp8YoGmS3Y9?=
 =?us-ascii?Q?YmT4BRuFR5qgeS6dw9fUjWWOPYy2ouU02682bXFDRJOvI/OHHhODPZAM+w8o?=
 =?us-ascii?Q?GBG4yDxRj6RXywctHwR5/BkQ7DCP895Ibb+ht/+grmYwcp2jOT9ohmpmANlV?=
 =?us-ascii?Q?zVCK2GWoH/GRV+zkKwyD/wcO6qHuG4zK1DwLlR2pMSIgnq2Z4Fu7tZkr6OKz?=
 =?us-ascii?Q?WFHrhCCEh4/OkNf7BAJ8GFt+Gc8r7AtR2rZH9VLRCW70TvEiO9J/8J8glRhH?=
 =?us-ascii?Q?9Gzog4tgtWuV6y06txysO0awGt3FKRFN+AQdUfqqcGa7NlSPjNSqHLeB/sUu?=
 =?us-ascii?Q?H5qjhx6J/Zk79aAvA4nYnQM+uyVNQV+8igJuPy2hPZaNFdQjWKfbMDoJRZuj?=
 =?us-ascii?Q?YMHTfaP7wXWnb+mgRg7+jd2gyVKfVBUgget4Qz2ccfUeoGuRqX1myUepABwu?=
 =?us-ascii?Q?yWLaYXZS5viSYCS0r6m7er9SlnzLaPCB37l8j8zIX6SGuEgMQCPQqy/USbrN?=
 =?us-ascii?Q?RfXMza983lVuDfJUVWsPVaCt6ogEdY8K2BGE3ZP/hwe6V5ykwA1Hny+KRnT1?=
 =?us-ascii?Q?AzqTTDwTlmzU8bIu1eRqt5iGAHh5vjAovkbywBs9/egVMfOAlRpnik3i1tOw?=
 =?us-ascii?Q?EGzmSscQrK8VPbwWao1queZ77QRs0/OyU2VzACGepwaDRDnlnM6ooP/wFrQt?=
 =?us-ascii?Q?f4y7ZEJIpRwNz++eq4AVP9hNH5t9ZZ7/v+rqP11R2PNRqXCv/PVJaDYCJFhz?=
 =?us-ascii?Q?CYQTZobEYPIUeToKzoye/hRY6gf42gimtCl7syXXipqdgsKQ01rmhGMg+ImB?=
 =?us-ascii?Q?vXYgPjzdiA9NWtmVuTfKxlyaJuVp0fTDMkYoQ3QD6hv2QVGai7DGiRwqz6Zg?=
 =?us-ascii?Q?en1jGGk8oRDjMTIwTgQye+Lqa5hvyRcsdJoJnyr18UlRQ4IDSvrv7EBzYr/W?=
 =?us-ascii?Q?TgsgVQ5qzD1p9c++6hkPWJFkoLwCjJsf+BwYUExKl/irY7EyOMpSQK8lhRd1?=
 =?us-ascii?Q?ewXaV2FvFLcxYcnE1vKF2yA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bf257f-fe53-4b23-fc79-08ddb9543d99
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:36:02.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JN2P+ub7a5e19qErATzkhMRNtiMNU9Q72aWz7YTwFf8pXZ6WMYABb4U+lDX8HX2yl1ewVKXLoG2nsRZ+5Kbim4CFGKa54IYhhS3Xk/UGyu7J6k8QIX/R6wweBg9cIs8K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19290

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 20fc4ea6d7e379cd492a6fd5c060013a9ebdf3db upstream.

Refactor PLL handling by introducing a `struct pll` to encapsulate PLL
configuration parameters, ensuring consistency with the existing dynamic
divider structure.

Introduce the `PLL_PACK()` macro to simplify PLL structure initialization
and update the `DEF_PLL()` macro to use the new `pll` structure. Modify
relevant clock register functions to utilize the structured PLL data
instead of raw configuration values.

This refactoring improves code readability, maintainability, and
alignment with the existing clock configuration approach.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250309211402.80886-2-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c |  2 +-
 drivers/clk/renesas/r9a09g057-cpg.c |  2 +-
 drivers/clk/renesas/rzv2h-cpg.c     | 13 ++++++++-----
 drivers/clk/renesas/rzv2h-cpg.h     | 30 +++++++++++++++++++++--------
 4 files changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index e9cf4342d0cf..7b9311af603e 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -79,7 +79,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
-	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLLCA55),
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 3705e18f66ad..cd0f3d4d737a 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -81,7 +81,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
-	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLLCA55),
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 1612864732e4..0e21d96ea883 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -44,9 +44,11 @@
 #define CPG_BUS_1_MSTOP		(0xd00)
 #define CPG_BUS_MSTOP(m)	(CPG_BUS_1_MSTOP + ((m) - 1) * 4)
=20
+#define CPG_PLL_CLK1(x)		((x) + 0x004)
 #define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
+#define CPG_PLL_CLK2(x)		((x) + 0x008)
 #define SDIV(val)		FIELD_GET(GENMASK(2, 0), (val))
=20
 #define DDIV_DIVCTL_WEN(shift)		BIT((shift) + 16)
@@ -94,7 +96,7 @@ struct pll_clk {
 	struct rzv2h_cpg_priv *priv;
 	void __iomem *base;
 	struct clk_hw hw;
-	unsigned int conf;
+	struct pll pll;
 	unsigned int type;
 };
=20
@@ -145,14 +147,15 @@ static unsigned long rzv2h_cpg_pll_clk_recalc_rate(st=
ruct clk_hw *hw,
 {
 	struct pll_clk *pll_clk =3D to_pll(hw);
 	struct rzv2h_cpg_priv *priv =3D pll_clk->priv;
+	struct pll pll =3D pll_clk->pll;
 	unsigned int clk1, clk2;
 	u64 rate;
=20
-	if (!PLL_CLK_ACCESS(pll_clk->conf))
+	if (!pll.has_clkn)
 		return 0;
=20
-	clk1 =3D readl(priv->base + PLL_CLK1_OFFSET(pll_clk->conf));
-	clk2 =3D readl(priv->base + PLL_CLK2_OFFSET(pll_clk->conf));
+	clk1 =3D readl(priv->base + CPG_PLL_CLK1(pll.offset));
+	clk2 =3D readl(priv->base + CPG_PLL_CLK2(pll.offset));
=20
 	rate =3D mul_u64_u32_shr(parent_rate, (MDIV(clk1) << 16) + KDIV(clk1),
 			       16 + SDIV(clk2));
@@ -193,7 +196,7 @@ rzv2h_cpg_pll_clk_register(const struct cpg_core_clk *c=
ore,
 	init.num_parents =3D 1;
=20
 	pll_clk->hw.init =3D &init;
-	pll_clk->conf =3D core->cfg.conf;
+	pll_clk->pll =3D core->cfg.pll;
 	pll_clk->base =3D base;
 	pll_clk->priv =3D priv;
 	pll_clk->type =3D core->type;
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index fd8eb985c75b..6811c0332812 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -10,6 +10,25 @@
=20
 #include <linux/bitfield.h>
=20
+/**
+ * struct pll - Structure for PLL configuration
+ *
+ * @offset: STBY register offset
+ * @has_clkn: Flag to indicate if CLK1/2 are accessible or not
+ */
+struct pll {
+	unsigned int offset:9;
+	unsigned int has_clkn:1;
+};
+
+#define PLL_PACK(_offset, _has_clkn) \
+	((struct pll){ \
+		.offset =3D _offset, \
+		.has_clkn =3D _has_clkn \
+	})
+
+#define PLLCA55		PLL_PACK(0x60, 1)
+
 /**
  * struct ddiv - Structure for dynamic switching divider
  *
@@ -72,6 +91,7 @@ struct cpg_core_clk {
 	union {
 		unsigned int conf;
 		struct ddiv ddiv;
+		struct pll pll;
 	} cfg;
 	const struct clk_div_table *dtable;
 	u32 flag;
@@ -85,18 +105,12 @@ enum clk_types {
 	CLK_TYPE_DDIV,		/* Dynamic Switching Divider */
 };
=20
-/* BIT(31) indicates if CLK1/2 are accessible or not */
-#define PLL_CONF(n)		(BIT(31) | ((n) & ~GENMASK(31, 16)))
-#define PLL_CLK_ACCESS(n)	((n) & BIT(31) ? 1 : 0)
-#define PLL_CLK1_OFFSET(n)	((n) & ~GENMASK(31, 16))
-#define PLL_CLK2_OFFSET(n)	(((n) & ~GENMASK(31, 16)) + (0x4))
-
 #define DEF_TYPE(_name, _id, _type...) \
 	{ .name =3D _name, .id =3D _id, .type =3D _type }
 #define DEF_BASE(_name, _id, _type, _parent...) \
 	DEF_TYPE(_name, _id, _type, .parent =3D _parent)
-#define DEF_PLL(_name, _id, _parent, _conf) \
-	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .cfg.conf =3D _co=
nf)
+#define DEF_PLL(_name, _id, _parent, _pll_packed) \
+	DEF_TYPE(_name, _id, CLK_TYPE_PLL, .parent =3D _parent, .cfg.pll =3D _pll=
_packed)
 #define DEF_INPUT(_name, _id) \
 	DEF_TYPE(_name, _id, CLK_TYPE_IN)
 #define DEF_FIXED(_name, _id, _parent, _mult, _div) \
--=20
2.43.0


