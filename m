Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2674C83F04
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.14])
 by mx.groups.io with SMTP id smtpd.web10.20544.1751452657313289270
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HLYabAhL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq1uOtc3ue0vEflUbnnCDvuEix+ZmoTMGCp0ynVfSjESACl7UttHbE9H3bcK2SnKbtuX/FEZkNbAfW849y/8NVEdtlR6ICYs+YlpE+FIwivOM8Jbjt3AZP+WIbtU1SsfSXhh/24GOyaaSUM/LFtGLYtM8U6pzkrhjKiS+y/5uXNGYM1OQuWlZegYyIT1CYnBbO4/xLfKy1hqYKtA7tzTiyPnOzJjDD+kqZCYcv0h4NZsplpqRJDrQaqTxnkhGPc4qHrB/uydRdTZZVc/TBuzgzYtApBC5e1hb3t+hMYz8m6d5g/jC/6QAHG9Yv1QRP7qFvMhSxRrdHXexsyvdVHdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S314am/H92fEIpWYJ1WDuZsq/3mGQrGStUTcxm7enn8=;
 b=qap7ky45HA03Ru8biN7aWxbnQQkl2LZZqcXjUu0tqnE+6S3lsK8qsUV8HVxFRi52WDOY34i5IAyAeYwXAnIQ5LCNsaACXaMfc6qQXGX5ChRhhKX3Jw0Sz7EEO6IBJNHyueT6Engx8kwMaj1GlB0PS3IPWlTZp2f1mJ98U63i/k1qmnsLACblwM11w0kfwjapxDcUiAcYhndr1XltZrN8KhsYQLxeM7oupcLsRnxfRaS//RH0BM9qQ7pRxnuXKtqamW48jSJugi1fSH3NcVLA5yP/IOOliu2vjFvRvP9uAA1gY0VQI9XilyX7pVBG7zMaEsn6rIHLhwxXCwjIKSwIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S314am/H92fEIpWYJ1WDuZsq/3mGQrGStUTcxm7enn8=;
 b=HLYabAhLJJA/p0wpH6XkbGmLY23trUMTrpT2lyXhJ5cHbO25FNtRDVn26eSELGgECvFpa5fDS0KJoKeXttDPkjlZHWNVbbsavp45oIZU2R8M9ArUd8kMFAuxkD6S0Fv3nppo+77ZzgHdAhHkdBgtmblXBWLXMIJffr3etsnViJI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13822.jpnprd01.prod.outlook.com (2603:1096:405:1fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 10:37:35 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 02/12] clk: renesas: r9a09g047: Add CRU0 clocks and resets
Date: Wed,  2 Jul 2025 12:37:00 +0200
Message-ID: <20250702103710.117760-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13822:EE_
X-MS-Office365-Filtering-Correlation-Id: 70b29951-0a53-4161-4bc5-08ddb9547551
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rXpLc6CJpQw+X8IGv8uEBq0z8ZP8ibBItgOK3eG7AVI4lksBTUI91bF+7T2K?=
 =?us-ascii?Q?VLqPdLk7KOPROSW8tgstoDoCG7vQgQl5FO8wGYUXLYYUW4LzF0TbTOf1QpMQ?=
 =?us-ascii?Q?y6bWSgCUrRoeeY7Z5jMBejh0ccR9pUwM3eoXmjsE52hixaurscpoE2kYRd3B?=
 =?us-ascii?Q?H8966TM50OIH2pIDenzP9HsfGQkbC1h3hyr8aVGWqonedP5d7DK+SpP1JA/W?=
 =?us-ascii?Q?3vvTOSelN9ucqfqMzngKh7O4ghJtbaLuDyL9ZURmIVymZirNUlhcyxgKfPDM?=
 =?us-ascii?Q?4EV/eEhjgZUdIn+sSaUYShtVzqaoZHrAjpM31H1S0vAdwF7g0+AOX0YiwMDp?=
 =?us-ascii?Q?id8WjFUQHUh2AU9C17VJnnL1qHU8N9EJKUJdudxhp0DmeJ3gt9UFVGRCbuX7?=
 =?us-ascii?Q?u0Wiax+3FL17FyZc52QBvnwevZPS+bdWITQFcA4qv3uwbtHpBLwzlWZ5mzBL?=
 =?us-ascii?Q?bsO3X5JXeyKd3Z1V+pumKznUedM6QVW8ah/f5sOb1hKG8+hVik3v9jgHvYID?=
 =?us-ascii?Q?ACPmlPg6M3R1/F8UAnIuePFPryXceNTzmlIlSHxJuVbBfHvUMGGZstP6QBL0?=
 =?us-ascii?Q?XjwqFo/x3woJcGFs/rr7Cnws7ZlG6+CKEjyxQfxar6FN1k75o55F/tkE0OKB?=
 =?us-ascii?Q?VdDMlk6OeFW1+qByk/xDuxWEjTMbKSGBwApF174ctZ4z2yFddC+BNOJGfq8e?=
 =?us-ascii?Q?1ahHQ1qRQ2cCnk0QOyEEsEfNcJGPPVkeBOBDy33u6BNcQaoKM9mqUGBVXUS3?=
 =?us-ascii?Q?zxmW3uGRIWTHWafDV2MORVYP5YWmFaYXr9EZ9L3BDPkxyv9HyNwCIHGDZmp7?=
 =?us-ascii?Q?UI32nq2VTiXro1RYeOZBbVGcmlPpwqoWiCbUquiPduFlYr3fzYBCZRTyOtXU?=
 =?us-ascii?Q?/SUAQol8QX75g776NRbwhU96ci7H+wXkRtAR+34xbC8EQCf4/o5rjeaMax65?=
 =?us-ascii?Q?78Y/WkeUZE5r15SWdPr3dMCnULNgOFB2TAYaSL8Z8JJlUo738o71Ey1kLigP?=
 =?us-ascii?Q?0flgZVEj8rxBHOJCLbFPdSP1KUbyeABRps/KP0iD/7lEWS8aLZmpRReFqwPS?=
 =?us-ascii?Q?QIW8igA5ZgjclvBFtBJ/4HJ4Nh/0k7iYVbbsCc3YmHiwtkNOHimOa3fKz3KR?=
 =?us-ascii?Q?Og4UL9VggUoLQ7/b1P/sPYq1EODFsGOHku4dR90fnXylFuqszOlPPKzh0G58?=
 =?us-ascii?Q?0tTP1uTfKLECXRPO01hhsMcOYWJv96/eZxWjg9gdMGXq9eV58NonV2kykDSh?=
 =?us-ascii?Q?I+c+L2/Gk2MjZ3QA+WU2Vs1yisqYvff/JeHju7wmf982zCH/FJ+9B9lYJ91q?=
 =?us-ascii?Q?9sn/9etfRPOnmbrWQn/+91uFxJQq3U9OpnyUzOLTkGIjC1Xxe4oiiE78/YVF?=
 =?us-ascii?Q?+cZTnwdeaShIkpdXlY3TIoC+C48Qs9nP54cjbhv0Y0YsdY0IPoyvozp1L5/9?=
 =?us-ascii?Q?R4mSda4c6im/J9Xf4pIRmRAXf/GH4fAGcx3Gc5Vu8ens+eKxKZYgr81haZ8V?=
 =?us-ascii?Q?JL8BgVXuNVnuyGw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4dDqzQGHeG8p/mau/wIXRrjGVyAytyv6mFIDkmbCM3hHIHMME2+/vweR8evl?=
 =?us-ascii?Q?67yUkDJYMYOxiev6IoxjYF3c1sbTl+ctWR9eC3s6hsph4sUL/UyxsqRTtbqx?=
 =?us-ascii?Q?y39m8GcHbTOX92/QgmswatxwzuPgKAcqwtWyydI0JFsHpECv8wFA5wXBlcLk?=
 =?us-ascii?Q?SHTo4Qb3Smzpveuze+IH7RlN0veVcMAZMYKs5v63TV1la0eia4JYY6mbCZ5n?=
 =?us-ascii?Q?minAeMgG7qkmZuKeFM5Kl1zAfC+K7fMqm9w3c5bye7N/+EaK5JnbtVuGzS4v?=
 =?us-ascii?Q?vRZYUGsRzVs8CpIOyVwHs2zRTxVkbxRY0q0Z0jZf0yT2Viy9htYiLm+uLjAD?=
 =?us-ascii?Q?BnNFE3YmRjjf838wLvyBPF1F2zLKOcwLChMzp0TEPOF0/4Mvo9uRPvVRw+4r?=
 =?us-ascii?Q?MziebNUWNTBWDoLwdth8bb6Trf+d9p4bMqiX56zZrhlRtAkcItiWN+EtpmG9?=
 =?us-ascii?Q?FCTS4Q3YurnWUmRShCaQkI7U4fWa9vCVJV9VoXl6McTzKXJCfxzTAQyVD5HN?=
 =?us-ascii?Q?1wdza3I59zv2uV9mkqVVdXgcqZKu+qQSJBHyV8q1cWXuPGM3wIdbYW2nIBDv?=
 =?us-ascii?Q?UuE8mcZnfxmmoRKEEdqyRTMOh40ZVpHkAvyxniiWXFAO4PzKb/d/xfUF5dsd?=
 =?us-ascii?Q?V8VfTzmXMZOMiuntkj9Nti7SyM24uXq3FCW4SSdB1JInRjOSwhZEetlrHa7/?=
 =?us-ascii?Q?KSWTt5+tidQtvDVYp63tBtF/hE8gIwF8DbkncJ6w3f2KtxBga4H3p+upL0p4?=
 =?us-ascii?Q?alQ8zTTW/wHhkiDMEJgz+wDKm6F6k6jHCLBXegoxy0rkJEAPWVrGKjfAcEvx?=
 =?us-ascii?Q?3YxSPz0Pc07Rp3xFl4hzJ864wYLH4Rh/GI4I0bquSgxel+PcMz/5ZJpPu2KZ?=
 =?us-ascii?Q?J26/dieW0QemsQqDH2RcOgE7+U0TbAe/XUyF/ih6oZ4npqpaq0wdBdY9PySE?=
 =?us-ascii?Q?YG7NvswwUP9Xgf24Ic05ugXM47ujq9lkUvNoeAgD2h+oxANtpKfQQtHzUi7O?=
 =?us-ascii?Q?7rPblo46JhTthkrnHBZF78wHKS8qa6BaXFZiuoPl0ghCCReW3EAv27DxUY39?=
 =?us-ascii?Q?R0jWB1xPU0ebpY/LuQV2LODjbCmHykJPlDM+pDbYPs1iYZ3KOsP8zVXYxY/u?=
 =?us-ascii?Q?nBvvkUEUWupwsjAK3KKlOr2vxGYjWk+nn+CqyFP3/z1sfxJVyhbtLQ56iw94?=
 =?us-ascii?Q?xJpxTdAozmbaItYpv5T11EOQLyv7aaMipQ7InmqoEpRGRqAEiGx2vRkMC9DL?=
 =?us-ascii?Q?yvf0VJOE4mci3pqGisjGxPLMd6Voij5vcgdg0dMRQHktuT4GMr8YFjM9CtJd?=
 =?us-ascii?Q?G3u9ud2EVeHTm+VuYIzsG479JzUEuWu0IQZRx1/mjwmWh/yzrrpAjAsa8FkE?=
 =?us-ascii?Q?6PGOYFKQiof3GO7+xMoOFUtJL9mzgUyof3KVuk/EZ2hDwtH5tGQDfnbwLLox?=
 =?us-ascii?Q?5nkF1A+rBOTFntNneYmlkw16XQD471a/Qt4xqlI/3+KIEynNrALoJL4n2OSG?=
 =?us-ascii?Q?GIaJnH2uLNNrotLPiUvp1VzUKZXpjk+MHNPrLujvfS7LyQz9VMQ4CBihV8x1?=
 =?us-ascii?Q?XC3+xYal2CCSrPj4ZbX5PKTp2pMPWbT74VlsEeiCvD+CvnauWugxC8SVgzAy?=
 =?us-ascii?Q?7zr95dxCoD99xqP98OGrY+0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b29951-0a53-4161-4bc5-08ddb9547551
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:35.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2CClVG3hL1fzvBar5/C+x5A52bTKYX3O+tpzcbuwv3V9FEK/rgnAMN7TeHZVD8h0fHlhlaEKxHWd4dLamNd4lKIqw/y7zJThW1fYGUxbf7ByGOsDEcMKj+AfeNpPBll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13822
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19300

From: Tommaso Merciai <tomm.merciai@gmail.com>

commit 037800c252d9c470b74d76aa23475d41e238251f upstream.

Add support for CRU0 clocks and resets along with the corresponding
divider.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250210114540.524790-2-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 51fd24c20ed5..5d02031219d8 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -28,6 +28,7 @@ enum clk_ids {
 	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
+	CLK_PLLVDO,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
@@ -35,7 +36,10 @@ enum clk_ids {
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
+	CLK_PLLDTY_DIV16,
+	CLK_PLLVDO_CRU0,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -49,6 +53,12 @@ static const struct clk_div_table dtable_1_8[] =3D {
 	{0, 0},
 };
=20
+static const struct clk_div_table dtable_2_4[] =3D {
+	{0, 2},
+	{1, 4},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_2_64[] =3D {
 	{0, 2},
 	{1, 4},
@@ -69,6 +79,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
@@ -78,7 +89,11 @@ static const struct cpg_core_clk r9a09g047_core_clks[] _=
_initconst =3D {
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
+
+	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G047_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
@@ -154,6 +169,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(8, BIT(4))),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
 						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
+						BUS_MSTOP(9, BIT(4))),
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -177,6 +198,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
+	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
+	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


