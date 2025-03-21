Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB120C3DA4A
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:29 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.65])
 by mx.groups.io with SMTP id smtpd.web10.18699.1742554881827544028
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=itKLm6pA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1y3pT7X6owgTgLmMHyM7uGaXkNPpk4/KIhx4EKKW+Y1WYSLGp2LLeBpHZmw9Tu5y1lfevXoHrlxhgPyNf6Efp+nHhzD3dRVcO+uG00dL//BuAZg8knrg5NQct25taqMsp0+YrFQIoRFo5C6YOU1pXhz05zOHCprowmfU6EwJOCJ9FIlDHED8Monzehj4yOTWApmgYtN4jnY6iUkTE2Fn/XMj+/E/Pbb+M2cTmub8qkhc4mh4I1LMUqNMoMTWpnt8+o+C70QcY4e0kf97lLtx/pbp5FqVd0a/1gDjZw4Bujhs8kuEt+ByZFAgvdrbQXEGNFoRIi6L7FEYIXvCjDcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rlKvRLhMEIfkZ8KzRZzk3762oQuavaFLPgZRd1qOYo=;
 b=PoD409CuwzdbI9k/ew/GJwXoK7kiMdBbblTop79kK1Cd5MJjkoXWpdbX8RJ0CAk590qRNFgcE+PXp/djiceggY3vKXSV2Wo+t7+0nJ4MhVEn4NgRNdsCbNSlSSwjWZZoWLr4GQM+HH47vfrFJ6j4dqd7o5PeKBkYeFOaPgnjF1/BShP6O/roRdKnnAcVKXFa3LhyrHCth07KE72fwUY0eVwuxjx2k808DFi7PMjUjoxuiKdHOd7ydRWOkSpm2Uat6IC9eHkdZOxMh+tEFKLBF+zoRS9wfGm1PfHGhJb7B9Ev+RqGJvEr5UOrUKETUTRmTjaNxKtCMr5GuFQovKy/GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rlKvRLhMEIfkZ8KzRZzk3762oQuavaFLPgZRd1qOYo=;
 b=itKLm6pAZI44fO7jL0sV32kaRGlInv84B3UtRC4wnDdbruyLVxrei78vqiIj2pRzsU82SApYZYMItZH1M9FgxEzc80cxjUnWsgkPv55gxXOvPYB3fJamlFBaobeEV5sWEOnf1gnGLueG3Paubk4kSrAyTbly5l+fTsKqNRKrItk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/21] clk: renesas: rzv2h: Add MSTOP support
Date: Fri, 21 Mar 2025 12:00:13 +0100
Message-ID: <20250321110021.3612805-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: f24206c6-ece3-4b63-0ca0-08dd6867b53d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?39vbO6sskZjr171p+gHffuvjVEpoqvDmHWj+JxEj7ubqud+rWdj7k0b3U/4w?=
 =?us-ascii?Q?ciJ1MNh9GNM5tKyY+E80JAi9OsyqLMkVMDED6zqMAaoUZ0vxtIJQcD+/xvIh?=
 =?us-ascii?Q?DhQpkNZNJOgEStga5Gg2j01dsdjqgb0aAK6Y+DrRX9ji/rNQHITp3J1YsWvb?=
 =?us-ascii?Q?gMPiki/Hduv7ySlgqr90s5RtATPVOho3mO70pldOlboZW3aPDi0KIjJ9sL3g?=
 =?us-ascii?Q?ZioCvw5ivPtSWfqD5dI4v+GPCqRXIXrK4TAP/c20cCtAaSx9lAlAPSWxMobB?=
 =?us-ascii?Q?NBhBMkEZCV4NpfqkUNDtVsSqC7Ycrfk0kJAI/sPs0Qz7Tx8ssmpZjsVxcYd3?=
 =?us-ascii?Q?ZRpsMC6jgCL1WAKA9wxfKbNKxPmXisw+KbTxu+x11GPbUqpovkF5BYMai4RY?=
 =?us-ascii?Q?dSHfwwIv/k86iDbQiDEWzWVhtD4C/HUX8Al07Af1wV/ciJHuPwRYN4X+MInm?=
 =?us-ascii?Q?tUO/hONfgAJ2rOqssSYX4EZuhg6uPIAnzSt5/F2GGhjB+R1oQlfmoVNoHgnP?=
 =?us-ascii?Q?5M9yY8ZpUUa/8BrGvgtJeDoO3Jj+RquqnruziMO3Ghbqrz453LMKbIGdRau6?=
 =?us-ascii?Q?SH0YAJtbfdmeh4r2uQj3UdUTy8mjTI1VKT322DAm1YrdresMVRCPbnea1jz2?=
 =?us-ascii?Q?ZWysWX/w7LcN7E2i/Pgou4v1N332pE6kDjowF8Zp5X+Erc6qZi7ftg9IeEyh?=
 =?us-ascii?Q?qOG4hkAROODSzNF/lvWneWFNJ4zPHMcN/WIil4ftPpsyqlh4CMGAT/s3EEP9?=
 =?us-ascii?Q?F9EI13b3u4xm1ejSOXIxwnALDp2pzI7dWxPqkkI51xpEohgsRACaAf7xTyHX?=
 =?us-ascii?Q?isA1kaL7GUqFNFl25ix1tzHXmVplof3EF//Rn7e/UHcT1eeuesEpVhvcbBY6?=
 =?us-ascii?Q?izcoHY92NCyOba0axNxMnzlWBcAWhVY0hc7Uxfr15JibjkuwXuBYVLAprwcb?=
 =?us-ascii?Q?z5mlLfWyc2Yxd1gNrgnHSGPhwspU8BTWSccYKySdDcww/a0FQzEpHIcK7XfF?=
 =?us-ascii?Q?rRaXnsOFcW0KEiJH27/KmrWVVS9dqS52AORQbeG2yEBWJT1Q4K/Hb5jIBHwv?=
 =?us-ascii?Q?aZI+RGiDSncFV+vW6okRnMsAMn3Y/AO4itjiLr7qI5cjOQAgFAjh4E7PsM2g?=
 =?us-ascii?Q?YXi3DBuABlMpoX78xbIatQzEpmObIEGtI+F8lCoj+9YXvUy37J2K8gd+xJD1?=
 =?us-ascii?Q?Pf+wd/CZVdU5X0FBNkcLSog0ipdfYwm3bdNVW4bcGN180X+0Xa1eArXTr87L?=
 =?us-ascii?Q?1ke9zeu8tvN9n2tlNy6t7UvVjvuuGX3TaJb65fkXGhDfOHL7unIhuZkabdik?=
 =?us-ascii?Q?ZeoP2a3oLPt23N9fKNDzIDNcoxEU5QB36DDMlljE59EhN19349bnIqg5ccHT?=
 =?us-ascii?Q?MsLtkia42fkv70GTEU4qLBMbhvGykGxS1Fi2PmEtO/fCEVi0tldw8RpIh602?=
 =?us-ascii?Q?Jp09ZOijEqHujaus9v3IaL2TEZv5iCcRXkRQ1IyqdlnO/sUcKV2pJA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CBvZW75pXyCmvr3Ku+VFWBD3PI0xJcFqVgQZJWiE6462buYEly7oo7jmms7l?=
 =?us-ascii?Q?neYYZkSSX3J45QOOBeT4BVFuAP0jViEXJCMKPKI2Mw54v47fXYCO+ga0swDx?=
 =?us-ascii?Q?RGwJQPJTIZJfbFGjNdgj52PoxLap7pc2ODAKhn20jrH/MeNYeu52i3guhb0V?=
 =?us-ascii?Q?TzJEME6Bz0hOVLxsH2ePtvP0jfYJ0UufzLx4drUo+329hTdtQZ4vhdyevW02?=
 =?us-ascii?Q?m1aIINt9T5A5+BH357OywKq80QUCTEXrTOSoqv7xxGtcazfcj43Gu7ci4mdJ?=
 =?us-ascii?Q?/B2tJ0PLbAXCnIuxdvi6g4neH8CcVYa+YTEq0n/zlK2O/r9WlLdiBKJXzv5F?=
 =?us-ascii?Q?444wlOtTjdvhBtp2soCzHECD6PHzzdqtkZaxEMf+Pv+33uSSRv4+jrfP6TFZ?=
 =?us-ascii?Q?+FqJlA0t5Qt3OBHAoGGeFXUEWnoFtfnR0xC/yz4bShncy/N/hVO/gBPO1SIg?=
 =?us-ascii?Q?ZeqU1e8JEf/vPQLPiN+ouGNl4YML1wxIqsgImbx3YXiXZBTUvnzjqIqS9BTC?=
 =?us-ascii?Q?HkXNbiwlC8svQHff2KtQiLrGOhb9TPvkZcH8jZa4x5cJJ1VIMWsQLhYXntFS?=
 =?us-ascii?Q?LT2iNs6hhcIyGupN9+XmF2jCcYPIiBCzL73fkgWzauxJEvF4zX4BNa4V34Gs?=
 =?us-ascii?Q?UybPbaSBf3XtSwwcp2LDKH4iHlKPQIXdnD4FV5cBEHaE3zM8d/gelswjX0zL?=
 =?us-ascii?Q?S8y6IJNLb2LhbBxhVIZ4M7JtBL/UUJU2Enp4Q60ytaHcedHrkvOUDcc83WkY?=
 =?us-ascii?Q?XcrSIOzKwaMHRcDim0PxLHuEURzwAC8RMy1qWuy2o6quVTd/ezebz2H/gYRI?=
 =?us-ascii?Q?sdyrqyJg/EGRwk83o9XPzhGMFgx6TvzUCz0CS+UdXcCAjhZF665Za8QlVfOF?=
 =?us-ascii?Q?ASS7hOXwK9geGM2rBwrQIBR8QC0R1SQFIo975pNiH/maT2LEWWig/YajMTsb?=
 =?us-ascii?Q?ENA1F5mYFJQSFDbp3BfTlWyQwmgy619rDrZnCPRp34taOo88dgShcxdd32+X?=
 =?us-ascii?Q?qaD1CJC85Z7KIvX1ODQIyfNsR2FiUmRwmkf+Xh8DKV6F4aGTj01JgWZrV1hI?=
 =?us-ascii?Q?U0YnIRrWYtMptgOD50L6lYyFghzv1cqVKA9GGUHd7UjKSh3hp96IZcsplmS5?=
 =?us-ascii?Q?ILR+CTwkXsLw5IdB7Qpf4G50k7BpBd5J7N6R8d4lmJ3iIV0HYE36nrEuKU9T?=
 =?us-ascii?Q?5YPqP5M8OqcVqhqJsViXUuVjMqX9+SFqBt1Vz45wFB/ckeE54naKfmTMzopv?=
 =?us-ascii?Q?mYzH28QBn9X5wG6pGh3XvVfsvw8/kgQa6XlgmY6jbKEw4LWj8TD0uLJR5+iQ?=
 =?us-ascii?Q?TrXSsPP+BJCf49CfCXHodkrlGSzRvl9xay8dESJz7I+LeBsGVReJIKoywqZm?=
 =?us-ascii?Q?+jXAFgNtL1/91Rck1o++OA9J4ZzLzsx/cm5K52LDPWdeC168/z8v6S+Mu3ci?=
 =?us-ascii?Q?TyKd1Awvr5BWFygGq1F8oNa8Eole1k1B++XatarbvvZUnH/gkYvR0wnv8HnE?=
 =?us-ascii?Q?44JM758ZYu9I4ARq+1M2fc5L5QuMjj1nxWiZ2H5SRbisvDfgyns6J9cXXM0u?=
 =?us-ascii?Q?p4vRSif8QC2I/BOP978TPaD9n60VbGHTIA496GC3fdlwioc7Pg3kNm2OEeeo?=
 =?us-ascii?Q?UxOi3zLLkgqx5+DKztu9mdE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24206c6-ece3-4b63-0ca0-08dd6867b53d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:19.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMjL2ekKeBrT4hUkmsvw7+RS7/iihdLQAabBkbiQY1hhDfnTxyvXcEWi2Skn3rS0iUf0MH/xK6hysUhEyM6RUQkpqUxmdRGU2MxXmxBWkHM2r8z2RXDaSIz0R4z6v6Cg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18320

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9b6e63a777ea5fb85bf24f9cb5ba902eed4f1f2f upstream.

Add MSTOP support to control buses for the individual units on RZ/V2H.
Use per-bit (instead of group-based) configuration and atomic counters,
to ensure precise control over individual MSTOP bits, and to prevent
issues with shared dependencies between module clocks.

Co-developed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Co-developed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241213123550.289193-2-biju.das.jz@bp.renesa=
s.com
Link: https://lore.kernel.org/20250102181839.352599-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Link: https://lore.kernel.org/20250102181839.352599-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Link: https://lore.kernel.org/20250102181839.352599-4-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Link: https://lore.kernel.org/20250102181839.352599-5-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 155 +++++++++++++++++++---------
 drivers/clk/renesas/rzv2h-cpg.c     | 146 ++++++++++++++++++++++----
 drivers/clk/renesas/rzv2h-cpg.h     |  30 ++++--
 3 files changed, 252 insertions(+), 79 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 5aa9710aa402..a45b4020996b 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -115,57 +115,108 @@ static const struct cpg_core_clk r9a09g057_core_clks=
[] __initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
-	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5),
-	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
-	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
-	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
-	DEF_MOD("gtm_3_pclk",			CLK_PLLCLN_DIV16, 4, 6, 2, 6),
-	DEF_MOD("gtm_4_pclk",			CLK_PLLCLN_DIV16, 4, 7, 2, 7),
-	DEF_MOD("gtm_5_pclk",			CLK_PLLCLN_DIV16, 4, 8, 2, 8),
-	DEF_MOD("gtm_6_pclk",			CLK_PLLCLN_DIV16, 4, 9, 2, 9),
-	DEF_MOD("gtm_7_pclk",			CLK_PLLCLN_DIV16, 4, 10, 2, 10),
-	DEF_MOD("wdt_0_clkp",			CLK_PLLCM33_DIV16, 4, 11, 2, 11),
-	DEF_MOD("wdt_0_clk_loco",		CLK_QEXTAL, 4, 12, 2, 12),
-	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13),
-	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14),
-	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15),
-	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16),
-	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17),
-	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18),
-	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15),
-	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19),
-	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20),
-	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21),
-	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22),
-	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23),
-	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24),
-	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25),
-	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26),
-	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27),
-	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3),
-	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4),
-	DEF_MOD("sdhi_0_clk_hs",		CLK_PLLCLN_DIV2, 10, 5, 5, 5),
-	DEF_MOD("sdhi_0_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 6, 5, 6),
-	DEF_MOD("sdhi_1_imclk",			CLK_PLLCLN_DIV8, 10, 7, 5, 7),
-	DEF_MOD("sdhi_1_imclk2",		CLK_PLLCLN_DIV8, 10, 8, 5, 8),
-	DEF_MOD("sdhi_1_clk_hs",		CLK_PLLCLN_DIV2, 10, 9, 5, 9),
-	DEF_MOD("sdhi_1_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 10, 5, 10),
-	DEF_MOD("sdhi_2_imclk",			CLK_PLLCLN_DIV8, 10, 11, 5, 11),
-	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12),
-	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13),
-	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14),
-	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18),
-	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19),
-	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20),
-	DEF_MOD("cru_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 5, 6, 21),
-	DEF_MOD_NO_PM("cru_1_vclk",		CLK_PLLVDO_CRU1, 13, 6, 6, 22),
-	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23),
-	DEF_MOD("cru_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 8, 6, 24),
-	DEF_MOD_NO_PM("cru_2_vclk",		CLK_PLLVDO_CRU2, 13, 9, 6, 25),
-	DEF_MOD("cru_2_pclk",			CLK_PLLDTY_DIV16, 13, 10, 6, 26),
-	DEF_MOD("cru_3_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 11, 6, 27),
-	DEF_MOD_NO_PM("cru_3_vclk",		CLK_PLLVDO_CRU3, 13, 12, 6, 28),
-	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29),
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
+						BUS_MSTOP_NONE),
+	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3,
+						BUS_MSTOP(5, BIT(10))),
+	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4,
+						BUS_MSTOP(5, BIT(11))),
+	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5,
+						BUS_MSTOP(2, BIT(13))),
+	DEF_MOD("gtm_3_pclk",			CLK_PLLCLN_DIV16, 4, 6, 2, 6,
+						BUS_MSTOP(2, BIT(14))),
+	DEF_MOD("gtm_4_pclk",			CLK_PLLCLN_DIV16, 4, 7, 2, 7,
+						BUS_MSTOP(11, BIT(13))),
+	DEF_MOD("gtm_5_pclk",			CLK_PLLCLN_DIV16, 4, 8, 2, 8,
+						BUS_MSTOP(11, BIT(14))),
+	DEF_MOD("gtm_6_pclk",			CLK_PLLCLN_DIV16, 4, 9, 2, 9,
+						BUS_MSTOP(11, BIT(15))),
+	DEF_MOD("gtm_7_pclk",			CLK_PLLCLN_DIV16, 4, 10, 2, 10,
+						BUS_MSTOP(12, BIT(0))),
+	DEF_MOD("wdt_0_clkp",			CLK_PLLCM33_DIV16, 4, 11, 2, 11,
+						BUS_MSTOP(3, BIT(10))),
+	DEF_MOD("wdt_0_clk_loco",		CLK_QEXTAL, 4, 12, 2, 12,
+						BUS_MSTOP(3, BIT(10))),
+	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13,
+						BUS_MSTOP(1, BIT(0))),
+	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14,
+						BUS_MSTOP(1, BIT(0))),
+	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15,
+						BUS_MSTOP(5, BIT(12))),
+	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16,
+						BUS_MSTOP(5, BIT(12))),
+	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17,
+						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18,
+						BUS_MSTOP(5, BIT(13))),
+	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
+						BUS_MSTOP(3, BIT(14))),
+	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19,
+						BUS_MSTOP(3, BIT(13))),
+	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20,
+						BUS_MSTOP(1, BIT(1))),
+	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21,
+						BUS_MSTOP(1, BIT(2))),
+	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22,
+						BUS_MSTOP(1, BIT(3))),
+	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23,
+						BUS_MSTOP(1, BIT(4))),
+	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24,
+						BUS_MSTOP(1, BIT(5))),
+	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25,
+						BUS_MSTOP(1, BIT(6))),
+	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26,
+						BUS_MSTOP(1, BIT(7))),
+	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
+						BUS_MSTOP(1, BIT(8))),
+	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_0_clk_hs",		CLK_PLLCLN_DIV2, 10, 5, 5, 5,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_0_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 6, 5, 6,
+						BUS_MSTOP(8, BIT(2))),
+	DEF_MOD("sdhi_1_imclk",			CLK_PLLCLN_DIV8, 10, 7, 5, 7,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_1_imclk2",		CLK_PLLCLN_DIV8, 10, 8, 5, 8,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_1_clk_hs",		CLK_PLLCLN_DIV2, 10, 9, 5, 9,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_1_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 10, 5, 10,
+						BUS_MSTOP(8, BIT(3))),
+	DEF_MOD("sdhi_2_imclk",			CLK_PLLCLN_DIV8, 10, 11, 5, 11,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14,
+						BUS_MSTOP(8, BIT(4))),
+	DEF_MOD("cru_0_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 2, 6, 18,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD_NO_PM("cru_0_vclk",		CLK_PLLVDO_CRU0, 13, 3, 6, 19,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("cru_0_pclk",			CLK_PLLDTY_DIV16, 13, 4, 6, 20,
+						BUS_MSTOP(9, BIT(4))),
+	DEF_MOD("cru_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 5, 6, 21,
+						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD_NO_PM("cru_1_vclk",		CLK_PLLVDO_CRU1, 13, 6, 6, 22,
+						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD("cru_1_pclk",			CLK_PLLDTY_DIV16, 13, 7, 6, 23,
+						BUS_MSTOP(9, BIT(5))),
+	DEF_MOD("cru_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 8, 6, 24,
+						BUS_MSTOP(9, BIT(6))),
+	DEF_MOD_NO_PM("cru_2_vclk",		CLK_PLLVDO_CRU2, 13, 9, 6, 25,
+						BUS_MSTOP(9, BIT(6))),
+	DEF_MOD("cru_2_pclk",			CLK_PLLDTY_DIV16, 13, 10, 6, 26,
+						BUS_MSTOP(9, BIT(6))),
+	DEF_MOD("cru_3_aclk",			CLK_PLLDTY_ACPU_DIV2, 13, 11, 6, 27,
+						BUS_MSTOP(9, BIT(7))),
+	DEF_MOD_NO_PM("cru_3_vclk",		CLK_PLLVDO_CRU3, 13, 12, 6, 28,
+						BUS_MSTOP(9, BIT(7))),
+	DEF_MOD("cru_3_pclk",			CLK_PLLDTY_DIV16, 13, 13, 6, 29,
+						BUS_MSTOP(9, BIT(7))),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
@@ -224,4 +275,6 @@ const struct rzv2h_cpg_info r9a09g057_cpg_info __initco=
nst =3D {
 	/* Resets */
 	.resets =3D r9a09g057_resets,
 	.num_resets =3D ARRAY_SIZE(r9a09g057_resets),
+
+	.num_mstop_bits =3D 192,
 };
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index bbf0b4ee7b26..6f096abda33c 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -23,6 +23,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/refcount.h>
 #include <linux/reset-controller.h>
=20
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
@@ -40,6 +41,9 @@
 #define GET_RST_OFFSET(x)	(0x900 + ((x) * 4))
 #define GET_RST_MON_OFFSET(x)	(0xA00 + ((x) * 4))
=20
+#define CPG_BUS_1_MSTOP		(0xd00)
+#define CPG_BUS_MSTOP(m)	(CPG_BUS_1_MSTOP + ((m) - 1) * 4)
+
 #define KDIV(val)		((s16)FIELD_GET(GENMASK(31, 16), (val)))
 #define MDIV(val)		FIELD_GET(GENMASK(15, 6), (val))
 #define PDIV(val)		FIELD_GET(GENMASK(5, 0), (val))
@@ -64,6 +68,7 @@
  * @resets: Array of resets
  * @num_resets: Number of Module Resets in info->resets[]
  * @last_dt_core_clk: ID of the last Core Clock exported to DT
+ * @mstop_count: Array of mstop values
  * @rcdev: Reset controller entity
  */
 struct rzv2h_cpg_priv {
@@ -78,6 +83,8 @@ struct rzv2h_cpg_priv {
 	unsigned int num_resets;
 	unsigned int last_dt_core_clk;
=20
+	atomic_t *mstop_count;
+
 	struct reset_controller_dev rcdev;
 };
=20
@@ -97,6 +104,7 @@ struct pll_clk {
  * struct mod_clock - Module clock
  *
  * @priv: CPG private data
+ * @mstop_data: mstop data relating to module clock
  * @hw: handle between common and hardware-specific interfaces
  * @no_pm: flag to indicate PM is not supported
  * @on_index: register offset
@@ -106,6 +114,7 @@ struct pll_clk {
  */
 struct mod_clock {
 	struct rzv2h_cpg_priv *priv;
+	unsigned int mstop_data;
 	struct clk_hw hw;
 	bool no_pm;
 	u8 on_index;
@@ -433,8 +442,71 @@ rzv2h_cpg_register_core_clk(const struct cpg_core_clk =
*core,
 		core->name, PTR_ERR(clk));
 }
=20
+static void rzv2h_mod_clock_mstop_enable(struct rzv2h_cpg_priv *priv,
+					 u32 mstop_data)
+{
+	unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
+	u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
+	unsigned int index =3D (mstop_index - 1) * 16;
+	atomic_t *mstop =3D &priv->mstop_count[index];
+	unsigned long flags;
+	unsigned int i;
+	u32 val =3D 0;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	for_each_set_bit(i, &mstop_mask, 16) {
+		if (!atomic_read(&mstop[i]))
+			val |=3D BIT(i) << 16;
+		atomic_inc(&mstop[i]);
+	}
+	if (val)
+		writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+}
+
+static void rzv2h_mod_clock_mstop_disable(struct rzv2h_cpg_priv *priv,
+					  u32 mstop_data)
+{
+	unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, mstop_data);
+	u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, mstop_data);
+	unsigned int index =3D (mstop_index - 1) * 16;
+	atomic_t *mstop =3D &priv->mstop_count[index];
+	unsigned long flags;
+	unsigned int i;
+	u32 val =3D 0;
+
+	spin_lock_irqsave(&priv->rmw_lock, flags);
+	for_each_set_bit(i, &mstop_mask, 16) {
+		if (!atomic_read(&mstop[i]) ||
+		    atomic_dec_and_test(&mstop[i]))
+			val |=3D BIT(i) << 16 | BIT(i);
+	}
+	if (val)
+		writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
+	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+}
+
+static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
+{
+	struct mod_clock *clock =3D to_mod_clock(hw);
+	struct rzv2h_cpg_priv *priv =3D clock->priv;
+	u32 bitmask;
+	u32 offset;
+
+	if (clock->mon_index >=3D 0) {
+		offset =3D GET_CLK_MON_OFFSET(clock->mon_index);
+		bitmask =3D BIT(clock->mon_bit);
+	} else {
+		offset =3D GET_CLK_ON_OFFSET(clock->on_index);
+		bitmask =3D BIT(clock->on_bit);
+	}
+
+	return readl(priv->base + offset) & bitmask;
+}
+
 static int rzv2h_mod_clock_endisable(struct clk_hw *hw, bool enable)
 {
+	bool enabled =3D rzv2h_mod_clock_is_enabled(hw);
 	struct mod_clock *clock =3D to_mod_clock(hw);
 	unsigned int reg =3D GET_CLK_ON_OFFSET(clock->on_index);
 	struct rzv2h_cpg_priv *priv =3D clock->priv;
@@ -446,11 +518,20 @@ static int rzv2h_mod_clock_endisable(struct clk_hw *h=
w, bool enable)
 	dev_dbg(dev, "CLK_ON 0x%x/%pC %s\n", reg, hw->clk,
 		enable ? "ON" : "OFF");
=20
+	if (enabled =3D=3D enable)
+		return 0;
+
 	value =3D bitmask << 16;
-	if (enable)
+	if (enable) {
 		value |=3D bitmask;
-
-	writel(value, priv->base + reg);
+		writel(value, priv->base + reg);
+		if (clock->mstop_data !=3D BUS_MSTOP_NONE)
+			rzv2h_mod_clock_mstop_enable(priv, clock->mstop_data);
+	} else {
+		if (clock->mstop_data !=3D BUS_MSTOP_NONE)
+			rzv2h_mod_clock_mstop_disable(priv, clock->mstop_data);
+		writel(value, priv->base + reg);
+	}
=20
 	if (!enable || clock->mon_index < 0)
 		return 0;
@@ -476,24 +557,6 @@ static void rzv2h_mod_clock_disable(struct clk_hw *hw)
 	rzv2h_mod_clock_endisable(hw, false);
 }
=20
-static int rzv2h_mod_clock_is_enabled(struct clk_hw *hw)
-{
-	struct mod_clock *clock =3D to_mod_clock(hw);
-	struct rzv2h_cpg_priv *priv =3D clock->priv;
-	u32 bitmask;
-	u32 offset;
-
-	if (clock->mon_index >=3D 0) {
-		offset =3D GET_CLK_MON_OFFSET(clock->mon_index);
-		bitmask =3D BIT(clock->mon_bit);
-	} else {
-		offset =3D GET_CLK_ON_OFFSET(clock->on_index);
-		bitmask =3D BIT(clock->on_bit);
-	}
-
-	return readl(priv->base + offset) & bitmask;
-}
-
 static const struct clk_ops rzv2h_mod_clock_ops =3D {
 	.enable =3D rzv2h_mod_clock_enable,
 	.disable =3D rzv2h_mod_clock_disable,
@@ -546,6 +609,7 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk *=
mod,
 	clock->no_pm =3D mod->no_pm;
 	clock->priv =3D priv;
 	clock->hw.init =3D &init;
+	clock->mstop_data =3D mod->mstop_data;
=20
 	ret =3D devm_clk_hw_register(dev, &clock->hw);
 	if (ret) {
@@ -555,6 +619,41 @@ rzv2h_cpg_register_mod_clk(const struct rzv2h_mod_clk =
*mod,
=20
 	priv->clks[id] =3D clock->hw.clk;
=20
+	/*
+	 * Ensure the module clocks and MSTOP bits are synchronized when they are
+	 * turned ON by the bootloader. Enable MSTOP bits for module clocks that =
were
+	 * turned ON in an earlier boot stage.
+	 */
+	if (clock->mstop_data !=3D BUS_MSTOP_NONE &&
+	    !mod->critical && rzv2h_mod_clock_is_enabled(&clock->hw)) {
+		rzv2h_mod_clock_mstop_enable(priv, clock->mstop_data);
+	} else if (clock->mstop_data !=3D BUS_MSTOP_NONE && mod->critical) {
+		unsigned long mstop_mask =3D FIELD_GET(BUS_MSTOP_BITS_MASK, clock->mstop=
_data);
+		u16 mstop_index =3D FIELD_GET(BUS_MSTOP_IDX_MASK, clock->mstop_data);
+		unsigned int index =3D (mstop_index - 1) * 16;
+		atomic_t *mstop =3D &priv->mstop_count[index];
+		unsigned long flags;
+		unsigned int i;
+		u32 val =3D 0;
+
+		/*
+		 * Critical clocks are turned ON immediately upon registration, and the
+		 * MSTOP counter is updated through the rzv2h_mod_clock_enable() path.
+		 * However, if the critical clocks were already turned ON by the initial
+		 * bootloader, synchronize the atomic counter here and clear the MSTOP b=
it.
+		 */
+		spin_lock_irqsave(&priv->rmw_lock, flags);
+		for_each_set_bit(i, &mstop_mask, 16) {
+			if (atomic_read(&mstop[i]))
+				continue;
+			val |=3D BIT(i) << 16;
+			atomic_inc(&mstop[i]);
+		}
+		if (val)
+			writel(val, priv->base + CPG_BUS_MSTOP(mstop_index));
+		spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	}
+
 	return;
=20
 fail:
@@ -822,6 +921,11 @@ static int __init rzv2h_cpg_probe(struct platform_devi=
ce *pdev)
 	if (!clks)
 		return -ENOMEM;
=20
+	priv->mstop_count =3D devm_kcalloc(dev, info->num_mstop_bits,
+					 sizeof(*priv->mstop_count), GFP_KERNEL);
+	if (!priv->mstop_count)
+		return -ENOMEM;
+
 	priv->resets =3D devm_kmemdup(dev, info->resets, sizeof(*info->resets) *
 				    info->num_resets, GFP_KERNEL);
 	if (!priv->resets)
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index ed8d2cad3260..dcd65e9c09da 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -8,6 +8,8 @@
 #ifndef __RENESAS_RZV2H_CPG_H__
 #define __RENESAS_RZV2H_CPG_H__
=20
+#include <linux/bitfield.h>
+
 /**
  * struct ddiv - Structure for dynamic switching divider
  *
@@ -46,6 +48,12 @@ struct ddiv {
 #define CDDIV4_DIVCTL1	DDIV_PACK(CPG_CDDIV4, 4, 1, 17)
 #define CDDIV4_DIVCTL2	DDIV_PACK(CPG_CDDIV4, 8, 1, 18)
=20
+#define BUS_MSTOP_IDX_MASK	GENMASK(31, 16)
+#define BUS_MSTOP_BITS_MASK	GENMASK(15, 0)
+#define BUS_MSTOP(idx, mask)	(FIELD_PREP_CONST(BUS_MSTOP_IDX_MASK, (idx)) =
| \
+				 FIELD_PREP_CONST(BUS_MSTOP_BITS_MASK, (mask)))
+#define BUS_MSTOP_NONE		GENMASK(31, 0)
+
 /**
  * Definitions of CPG Core Clocks
  *
@@ -104,6 +112,7 @@ enum clk_types {
  * struct rzv2h_mod_clk - Module Clocks definitions
  *
  * @name: handle between common and hardware-specific interfaces
+ * @mstop_data: packed data mstop register offset and mask
  * @parent: id of parent clock
  * @critical: flag to indicate the clock is critical
  * @no_pm: flag to indicate PM is not supported
@@ -114,6 +123,7 @@ enum clk_types {
  */
 struct rzv2h_mod_clk {
 	const char *name;
+	u32 mstop_data;
 	u16 parent;
 	bool critical;
 	bool no_pm;
@@ -123,9 +133,10 @@ struct rzv2h_mod_clk {
 	u8 mon_bit;
 };
=20
-#define DEF_MOD_BASE(_name, _parent, _critical, _no_pm, _onindex, _onbit, =
_monindex, _monbit) \
+#define DEF_MOD_BASE(_name, _mstop, _parent, _critical, _no_pm, _onindex, =
_onbit, _monindex, _monbit) \
 	{ \
 		.name =3D (_name), \
+		.mstop_data =3D (_mstop), \
 		.parent =3D (_parent), \
 		.critical =3D (_critical), \
 		.no_pm =3D (_no_pm), \
@@ -135,14 +146,14 @@ struct rzv2h_mod_clk {
 		.mon_bit =3D (_monbit), \
 	}
=20
-#define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit)		\
-	DEF_MOD_BASE(_name, _parent, false, false, _onindex, _onbit, _monindex, _=
monbit)
+#define DEF_MOD(_name, _parent, _onindex, _onbit, _monindex, _monbit, _mst=
op) \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, false, _onindex, _onbit, _mon=
index, _monbit)
=20
-#define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _mon=
bit)	\
-	DEF_MOD_BASE(_name, _parent, true, false, _onindex, _onbit, _monindex, _m=
onbit)
+#define DEF_MOD_CRITICAL(_name, _parent, _onindex, _onbit, _monindex, _mon=
bit, _mstop) \
+	DEF_MOD_BASE(_name, _mstop, _parent, true, false, _onindex, _onbit, _moni=
ndex, _monbit)
=20
-#define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit=
)		\
-	DEF_MOD_BASE(_name, _parent, false, true, _onindex, _onbit, _monindex, _m=
onbit)
+#define DEF_MOD_NO_PM(_name, _parent, _onindex, _onbit, _monindex, _monbit=
, _mstop) \
+	DEF_MOD_BASE(_name, _mstop, _parent, false, true, _onindex, _onbit, _moni=
ndex, _monbit)
=20
 /**
  * struct rzv2h_reset - Reset definitions
@@ -184,6 +195,9 @@ struct rzv2h_reset {
  *
  * @resets: Array of Module Reset definitions
  * @num_resets: Number of entries in resets[]
+ *
+ * @num_mstop_bits: Maximum number of MSTOP bits supported, equivalent to =
the
+ *		    number of CPG_BUS_m_MSTOP registers multiplied by 16.
  */
 struct rzv2h_cpg_info {
 	/* Core Clocks */
@@ -200,6 +214,8 @@ struct rzv2h_cpg_info {
 	/* Resets */
 	const struct rzv2h_reset *resets;
 	unsigned int num_resets;
+
+	unsigned int num_mstop_bits;
 };
=20
 extern const struct rzv2h_cpg_info r9a09g057_cpg_info;
--=20
2.43.0


