Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6462C3DA4A
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:19 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.web11.18707.1742554878709827679
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=p+42cPy6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Njw2e4KpfnqBUyi8v/qRzQFvcoDZoM0cK8IfI/VwIAt6jS3uBl5JIt6/vm0mH7WMiT58SjXFGyOtjr06z4w88PsQSiv5YjLc7qFwQyoPCr71btlDnDjnvZ01+XjuOoIDZ4hDkujMs+8kfwu/UCELoTCEmz1m2dPPko2vQLXsvMCB/1cjsKVMaPYyR4pMVo70OjqfrBtKvODYzcQlqzc0svMOuKCOcnIQmi+aKsiv25BM+FZl3CaLzorSmtvvfi19d/zWGDlj9Q1SH63WhsJGM4aGIAA7s5MnPBtL5bQ2O9sDROY+8nZp415O/2+Rce+eP57xiFdDKLDpC1ctWcWcPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPbGTuEdRTNVwJhVxFodmmLgie0WAFzJWot9r4gyK58=;
 b=lNMzjuaY1EjOI0IE9fO7aKYGH82xx7zH1z2/scpTjsj64m9KOxx6i2QIL/FHrqs+r1lZnsQsLIZFCCtOLzUi3ULQSRkqf1cx+C3ODnS10BhRXg4l+rmYHL4I+zpxqZQs4DsaIGVaLG4Hb1QAFvdcmCCEypKR8EPKo2WVJ+MYLV+ktHGfPoTAdR9PPzQLHDZNxQBuXaQYvcsXNvcpUKTcPy5aln9i9S6NJmjTNEXPKbxh/apUCGWezgc+sp+G7f226NCS/MnAmpDg4BfZX+wNOHbYWAw8Rtd+eWcd+FLM5EBFBLhnPaZ2NtxMPu5MK3kADvbASd0UjEdo/i24yyQqgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPbGTuEdRTNVwJhVxFodmmLgie0WAFzJWot9r4gyK58=;
 b=p+42cPy6Y87fRlEOOW+7I/SiOQzeBRC9ipnGUJ9W+xTjP8BZA39MynmXhVMoV15qiMp3Q9SncBVOgiv8c+RlxWi+HpZpdjWyNbuhB/7dMgdH1xjL2gzfI2nPo+hDm7dQmIOL7AOZ1gdJ7UQWM5eo6eLhz+IPUFnQ9RvKBq/iowA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/21] clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and resets
Date: Fri, 21 Mar 2025 12:00:12 +0100
Message-ID: <20250321110021.3612805-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: ade5c71c-ac24-429d-c105-08dd6867b380
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sbFFMeC86XzLqx3cYiQcXdq0PL0XosVYh61uPn2+jZO5pA/bzQ5Phthwk1ku?=
 =?us-ascii?Q?1UlRxc6rEkpujvD7FaKg2nXWpzsD5VOvKtfA+ccgt10rSOlEZdUwlYBHv6jf?=
 =?us-ascii?Q?xe5brP6HaIobsVtRBan7xSyJkqEfD0EM1UV/FN7k5od/Vm/axVH3B8XWY5bu?=
 =?us-ascii?Q?oZjtyqIsETxLgDVZb5c/NdSkoZWxi5M9N8g4aVRLSWyagSkbVhmLZQB2jIB4?=
 =?us-ascii?Q?KOu4XvZXRISxq9YFwerJ7eyExtgpX1Ik+GN5Orehw72ayPxv38bGDY1/PdfN?=
 =?us-ascii?Q?W5l92R2r+W4IO2g+j9aagNTqAsCAcMEr97Ge+EmNZE7gAC6g0HMSLgz4esm0?=
 =?us-ascii?Q?jk3fhyebW48IdDyMnm8bXRQkC3MpsabpAb8v4F5LsE4oF433HZko2ZVkJV03?=
 =?us-ascii?Q?BYUGm2hXA7c+DCTwhgmIW1DuWlcAE9xBZVFdYqqqaR2iN4VOuFkLpzswqxU1?=
 =?us-ascii?Q?WoOEYEbIyULjvtyCyxFNihzWFAAlnlrUUvngKtUZDCDA4XMfEcJtLNBtbs1x?=
 =?us-ascii?Q?K3+tCk7MonCkitKBAidYGG77A8Hr2xZJE5ErUIYBIRLAOPQ8lW+ySD5xH3HD?=
 =?us-ascii?Q?K/3JOm67P7U6KcWU5SP/6mpnLoNPpoqlTSkG2FDTfRZQXHuyH0Xq939c7Fpn?=
 =?us-ascii?Q?Y0b0bjGlCNsPp0GUYT3FX5qpsViZByaKP6s1uRrnH4GRiI2AkZHa5pYpOrSP?=
 =?us-ascii?Q?TNDhYmrrT1cfkRdW/R2vKfQnY13HadRCQm2pAfNIa2sEQG+z39d6xaosXe5k?=
 =?us-ascii?Q?wNA3ZIrwuYM+4aBLmdoaSPy45+66XZkYY763X1eTi9QlB2FTzkwehkrLFmeo?=
 =?us-ascii?Q?Ys5JL8YiqtAZqyBwE0v3M/Y25pDGI6Q+DBg70UV9xG1abMZdc+UboTgow865?=
 =?us-ascii?Q?A9ihz9MtypuEOJVviRmQXzsKqbgrgeHhtLwsZIn1ovZFQBbCf7jGRe2IxkAJ?=
 =?us-ascii?Q?TOJYz+WxLhjn6HadqtUhiEGTNs2MUE09qoxuCL6c6qClgmKOpyiCVqJDWLsT?=
 =?us-ascii?Q?8AOvXG9mOVTGkzMUECjFX/4CFhqnb5UfTvgiB9lv7ApVDIi1MVcWMc44wpfk?=
 =?us-ascii?Q?KgP2DYhwqarLl9LGmkGl+MIWBMsCIkW0a56HO0hXKkQRp+nffbSqKzjZbQqM?=
 =?us-ascii?Q?F9GonT4Mezfx9F6Xyfr7Fma1zrtxJztQFG+fUT8tH14MMxhPIugJL9wrHNmC?=
 =?us-ascii?Q?Ab8GEIaklP1OnvA26TRV9016UtAF7aPmxyxUhIGBQdrTgxXEJcU5tlZ6eORV?=
 =?us-ascii?Q?jGqx4rXX2Mcw3tk5Uut0p6zNvCSwKXSASvnNv7Nf9iQ1+iwSjqTmDv/cUg6l?=
 =?us-ascii?Q?WEiayeqop95HSQJ7obNI3DydMBY8Y5hCUnyrpCtDjgpYN0tTbLO42NUh79qI?=
 =?us-ascii?Q?4atJ9frlFuHl9Z1KExi1T8h2E96YIxfrlfECo4IsIw/P1WZW96A/kgZfYgWW?=
 =?us-ascii?Q?/4UGvvJLhsTxU+DEI9no30yjPDffJS0C?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wcb9yqGS+MwvEvuSJo5OBtxfjzb6mV0qpqXiw5bN+N2FRjDXpieAm9pg0ys4?=
 =?us-ascii?Q?O94QzgmUGK/tVN6RYfrNxcE7zH+ZHIhRXQDEZfAwkVdb583YyLP672PKzSFF?=
 =?us-ascii?Q?njh1uOflIkmEiY+h0tlnj2fTmCDAYPDrs9uMp+/MjOTSe128ElilH56kUmBT?=
 =?us-ascii?Q?gebqsTu1gm3dc9HxFuor/YEWyObYSESejQ6oxrYqAvCDH8XK36zaghTzYwdw?=
 =?us-ascii?Q?xWNDqM1hN9w8JhIzZeSI7uhGwMMG4z0SNPw+kDGNLqgW13rK2R9Xm9RpJODe?=
 =?us-ascii?Q?O/t5mqyCSEatqArYZiM7Ha0SnxZsMSKCsFDnHQ1FXcA/8x9SQTI2wCT4yPGs?=
 =?us-ascii?Q?RoRgjy2v3P9tOllP6+jcR8+HmrECjoA+59LN8usHpCUGW2P00egHCy7WN8pS?=
 =?us-ascii?Q?5Pip1gvAmub88I4AFCWaBEiDcHfZ7Oj0eMsYKiXFdyzDdWv+aF6RIM2C6yOr?=
 =?us-ascii?Q?jfHt+CKBLVFvuKo8o2Fo8rkG/PX8/tsVCIy3WgPsG6qLCfL+D0Vu/j9D8rwQ?=
 =?us-ascii?Q?JhElVk1htoXKpS0WrZP3U5g7pr/Vbut4VDCz1EFpnQxqTtd7fe4idBBUfDv9?=
 =?us-ascii?Q?j1yMgavaxM4HOQzjGFWnr5LlNSTXoeYUBJHYqI4fiW3zr7lRRC/bZ2TUAnIT?=
 =?us-ascii?Q?+tZlylwzawx8RyL45na72cadeBJppdvVBSaATLLXyRoRmNzOGcIveqxQsv7n?=
 =?us-ascii?Q?AaPvJloJ2gdhf7m1Za1Jz6mBlijzzxOglGDcVTZOA1eGFaOxumZBOIAsIwee?=
 =?us-ascii?Q?/wsClv+38mGMhBL9l7pPH4OKfr1ZnN1HtZa4rwEZiO6dqEz4EWj9zX/Y6XtU?=
 =?us-ascii?Q?WCpqoQ86KzfYSN9B62YRM4Wz0TQykAlbNVSl+HpM9akwzJVP+4IyJBCveja5?=
 =?us-ascii?Q?WAyJbXqY4uNB9of0X+uBvvDdJP5HTW5AgZXHH9gbPhUqC3VyhOB03oD3kaRi?=
 =?us-ascii?Q?SKKGMYgJYpOmqT88WVuP2zfbbUKiqCBr/y2ezTF23Ee3TjuJe5l6QkzIsTai?=
 =?us-ascii?Q?kcWUbkWAdD71kGHGlavhdXfbLRZ8HFsMYs/lC48mTxcmBCu99hAzLrpShSUF?=
 =?us-ascii?Q?lbfA011bk50aicaYdotCrhU5dShfkjP6MBJwBlXsrjcgMtP7RvwuuQ+PDSQG?=
 =?us-ascii?Q?LCzs+PK/nS5v59BQKJlIg/n4udFWNzRoSzzG6jGQBZ8IQglqs18PmKC71pIk?=
 =?us-ascii?Q?Qn//2HOxshnSusHk04Ce8TpG1UxanPp21Es/bfiH27XUG9tEc3NAOnIKdmyQ?=
 =?us-ascii?Q?JrS5ice1eKxuF/Su0MhSQmoExZWL89+YfS0w2S9Ty+wCVnCnOaRMdj4pTPUK?=
 =?us-ascii?Q?uaQNcR9A7Oj+E+4vipoPuBWDXxf5G42M61mtzqnw87zno6Nr3ATd+SLVQWsg?=
 =?us-ascii?Q?wyU7Q7MtglNBj/YeOlOugkawt3iljYQPgu3pxz9FG49e0poHmvizOfRjBjXR?=
 =?us-ascii?Q?exZydPf3m2LuzsRrGjdUVAV5FlqggDkaw3CE4RIhrfj3DKU13++UHgxKIDAz?=
 =?us-ascii?Q?bPGOliDj7RpZFtT/PxQ3BEu4LzushQDykfOaUrJIFG2i5RVQx8cGL3+A0Dtz?=
 =?us-ascii?Q?LRPakfpnHhnsAOU+R41VWDyLVRb+vSeGMlyFdpjs81V2JcEG2GDPxmSpJfh5?=
 =?us-ascii?Q?yCYzjWE4mlTjzECU6Z0es6c=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade5c71c-ac24-429d-c105-08dd6867b380
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:16.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A1kWqUY8+KANWmTUpVagUHRUimP0CzCgGZu1d+PA9xdGIEm8nGstCNXqHgCj+TXYG9J16B7uaypWJZt7zPxC83uNqQ0bJmZKI1XvAa8uQhFciBnGUQf9YteZy9rdJkxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18319

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ee47b94102d2eaed23ac60910003cd0f3fade13c upstream.

Add support for the PLLVDO clock and its related CRU clocks and reset
entries in the r9a09g057 CPG driver. Introduce `CLK_PLLVDO` and associated
clocks like `CLK_PLLVDO_CRU0`, `CLK_PLLVDO_CRU1`, `CLK_PLLVDO_CRU2`, and
`CLK_PLLVDO_CRU3`, along with their corresponding dividers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241202203916.48668-3-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 45 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  6 ++++
 2 files changed, 51 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 7c4507fd34e6..5aa9710aa402 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -28,6 +28,7 @@ enum clk_ids {
 	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
+	CLK_PLLVDO,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
@@ -35,7 +36,13 @@ enum clk_ids {
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
+	CLK_PLLDTY_DIV16,
+	CLK_PLLVDO_CRU0,
+	CLK_PLLVDO_CRU1,
+	CLK_PLLVDO_CRU2,
+	CLK_PLLVDO_CRU3,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -49,6 +56,12 @@ static const struct clk_div_table dtable_1_8[] =3D {
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
@@ -69,6 +82,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
+	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
@@ -78,7 +92,14 @@ static const struct cpg_core_clk r9a09g057_core_clks[] _=
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
+	DEF_DDIV(".pllvdo_cru1", CLK_PLLVDO_CRU1, CLK_PLLVDO, CDDIV4_DIVCTL0, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_cru2", CLK_PLLVDO_CRU2, CLK_PLLVDO, CDDIV4_DIVCTL1, dta=
ble_2_4),
+	DEF_DDIV(".pllvdo_cru3", CLK_PLLVDO_CRU3, CLK_PLLVDO, CDDIV4_DIVCTL2, dta=
ble_2_4),
=20
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
@@ -133,6 +154,18 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
 	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12),
 	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13),
 	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14),
+	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18),
+	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19),
+	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20),
+	DEF_MOD("cru_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 5, 6, 21),
+	DEF_MOD_NO_PM("cru_1_vclk",		CLK_PLLVDO_CRU1, 13, 6, 6, 22),
+	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23),
+	DEF_MOD("cru_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 8, 6, 24),
+	DEF_MOD_NO_PM("cru_2_vclk",		CLK_PLLVDO_CRU2, 13, 9, 6, 25),
+	DEF_MOD("cru_2_pclk",			CLK_PLLDTY_DIV16, 13, 10, 6, 26),
+	DEF_MOD("cru_3_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 11, 6, 27),
+	DEF_MOD_NO_PM("cru_3_vclk",		CLK_PLLVDO_CRU3, 13, 12, 6, 28),
+	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
@@ -162,6 +195,18 @@ static const struct rzv2h_reset r9a09g057_resets[] __i=
nitconst =3D {
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
+	DEF_RST(12, 5, 5, 22),		/* CRU_0_PRESETN */
+	DEF_RST(12, 6, 5, 23),		/* CRU_0_ARESETN */
+	DEF_RST(12, 7, 5, 24),		/* CRU_0_S_RESETN */
+	DEF_RST(12, 8, 5, 25),		/* CRU_1_PRESETN */
+	DEF_RST(12, 9, 5, 26),		/* CRU_1_ARESETN */
+	DEF_RST(12, 10, 5, 27),		/* CRU_1_S_RESETN */
+	DEF_RST(12, 11, 5, 28),		/* CRU_2_PRESETN */
+	DEF_RST(12, 12, 5, 29),		/* CRU_2_ARESETN */
+	DEF_RST(12, 13, 5, 30),		/* CRU_2_S_RESETN */
+	DEF_RST(12, 14, 5, 31),		/* CRU_3_PRESETN */
+	DEF_RST(12, 15, 6, 0),		/* CRU_3_ARESETN */
+	DEF_RST(13, 0, 6, 1),		/* CRU_3_S_RESETN */
 };
=20
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst =3D {
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 0723df4c1134..ed8d2cad3260 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -33,12 +33,18 @@ struct ddiv {
=20
 #define CPG_CDDIV0		(0x400)
 #define CPG_CDDIV1		(0x404)
+#define CPG_CDDIV3		(0x40C)
+#define CPG_CDDIV4		(0x410)
=20
 #define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
 #define CDDIV1_DIVCTL0	DDIV_PACK(CPG_CDDIV1, 0, 2, 4)
 #define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
 #define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
 #define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
+#define CDDIV3_DIVCTL3	DDIV_PACK(CPG_CDDIV3, 12, 1, 15)
+#define CDDIV4_DIVCTL0	DDIV_PACK(CPG_CDDIV4, 0, 1, 16)
+#define CDDIV4_DIVCTL1	DDIV_PACK(CPG_CDDIV4, 4, 1, 17)
+#define CDDIV4_DIVCTL2	DDIV_PACK(CPG_CDDIV4, 8, 1, 18)
=20
 /**
  * Definitions of CPG Core Clocks
--=20
2.43.0


