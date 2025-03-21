Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F0CC35FFF
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:19 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.44])
 by mx.groups.io with SMTP id smtpd.web10.18690.1742554875918275740
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=XIjCErrm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.44, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHiY6YDLGyXzcgiKhqdUWRt6WYyWavKMcgJtDSuKGx/YOCAncqoJz01qCi+bwkF7Dx1mKfhXWmicOfUtI+SUVh3nZkQ+ejTiX6pd4WOE2ylfIxesU3/Cvl7o9hGT3Xe3+WvHsScYR8Dnt/pzR6fOsgFD+IyROoQ0XgW7yBTltzJTDYby8gOo0r5VcDJjp9lQj1d/a8jAkOyWrYn/QKZfDRrTVEIGaDKbeGjQGlCNBTiniAgjCRmSYIXfWofv3Tqj5Ja1BhWti33e0q4IzjFh8dyPVWTt9znsSPUfA3rKSlYgmxrJ06z3XfBfShg1KJA7xQeJctx/QGXhd+ly2tHaOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RH/ESjptCYxOTolqywNsRKiiHR8f021b7aSXw0LVu10=;
 b=IRjzEesvQyrt1+AKQYGcpzWk6qolESiE2jDpZbhoDu+Te9g2ZBVZkpL0MIkZyjrztmogAPDHhUClccbt2amSMxsel3t3vzIQ0iyRBzsf6VDUPfcfVQWFssGYKAjl93J6uu6Nb8z5Jce2s/Sm1JZEeQrSQe/N7niN3BhQKP+sflvvYsjSK2fB8DrJ72aq1leq/JKxu/t/lIQvCaJLQK96mMsigBYAoDczkNgovokx1S3q8Mw8o5iO6si6fsceJqjeave5bNRmy6xxPBpknoAJp88EwWobEn6UTl+Nklw+kuppr5LYqq3rcgUVuj8BXTTUHVcRaVhtOElpZinDaUeNow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RH/ESjptCYxOTolqywNsRKiiHR8f021b7aSXw0LVu10=;
 b=XIjCErrmzSFem49czEfsGEqJldYBFxN4pcsLTRQ44qsWrFn22k5TvJ9ATBb6O1/eIpeqVmw1nnIECa0K5YSK2Ye5O4fp/C0320cfqaM+lO8uo3x4zdS72hUPkz7TWTa8+cHRhaxtBQzmLGgMqj9XP9TjU6W2cUZi7f2uuvmn+oU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/21] clk: renesas: r9a09g057: Add clock and reset entries for ICU
Date: Fri, 21 Mar 2025 12:00:11 +0100
Message-ID: <20250321110021.3612805-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77246e0d-cd19-4773-2950-08dd6867b1e9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?O44zSpsk/fTY9l0GdApqC0tu4eEDCUUTVSerE/lFcKSisMLNkjimbZRR8QLU?=
 =?us-ascii?Q?hSZSknyh6NvFaNMg2VmY0apuwvQkw4r/igK3ZWwjKPsuzEBScET2HIkPO2OW?=
 =?us-ascii?Q?k4MqXbwKy+jpeFE7QFeEwWso+LUt39t5jYad1AGfjrmyY8kkI5U+q/2ph6PH?=
 =?us-ascii?Q?9pOIfHrHJepd/wkEjis91XTrR6uC9XwwqzeHD2m4Uzqvw3k2hmj6qIhzri6D?=
 =?us-ascii?Q?LgMMEdIBt6VTREmC7GEakTH/U3lTKjSmpc3OOfdbdQ+N2nuklMyzxNxnD9y2?=
 =?us-ascii?Q?L9RQlShUsKsAP1vbCTBxA7tL+Nx/hY9K+lAkGVqSbExyU5Ud5jWknoSXnfO+?=
 =?us-ascii?Q?IY+zk+CPBVGwXyaPdbbowydMhHr+DgkeBw7hLCbfLURwU1cFxxRpcWhw6kp8?=
 =?us-ascii?Q?WbSNMoiLIQpdc2gdFf/JTP3HnYNs+dFAWRi0mln2GyaU0hCKaS+15uYzySgq?=
 =?us-ascii?Q?JZdz1avHkvsGXIsFkmCsM3rrVUmVCVraV6roReUskwPhJEXgmLi23UO/IPHE?=
 =?us-ascii?Q?PZiyX/c/fNxHIH1tvgYPOMkUGpv/uu4nclSufzBw7bUgjL9fYtKqIbkicfAv?=
 =?us-ascii?Q?J4t/iUEtfBafIh3MkEUpdfwYXIWfo+Uzawi5WwkY2ggar43ZN4mz/2F6PJAs?=
 =?us-ascii?Q?+JS/wpPyglQdYAEhJ0AvFJLR7x9TSfkExzG7EgCck5kGseWHOFXcO0+COodj?=
 =?us-ascii?Q?QUea4j3pNe3o/oFz9gxL41q66t90vvfU4UQBFboOAV0zPqAlvDF7ZqoQS0eQ?=
 =?us-ascii?Q?Lp1geTUm54yJS+SxmUA+9B9JVjMY9ksFbjL+6cI+zW/zGDwK9FEkNBf5dWhQ?=
 =?us-ascii?Q?FTIBk9i+mYg8Y+dnWYItLPqN5kaHodqQwGMy0Yv/git9v478UvykuZGPuCU0?=
 =?us-ascii?Q?JY+R+A0HS82twOfhtbotmhFvGpXcGvTkh6rQnIOg3jRcDOJqRKfXUP0+u/ce?=
 =?us-ascii?Q?c7q6XORHXWSsJJqJbzUNMGb25jFllwz0tKbhji3cnrC+W/iHq8YSAOm/npT4?=
 =?us-ascii?Q?6rCDO42WeAuPP6ZyQ5aBttcfy9LyJE+dbacQl0mH4L0Xq1YYhdSYlfeyfPzm?=
 =?us-ascii?Q?zsLoaJWZpnLjzGYu69hEn2nuWk5if2f5/szauROgnp4vDEvDZcYMe2IqNalX?=
 =?us-ascii?Q?Rb8z3aO4cdFpZC1SDsw6yrqZg0VSlWAzj+Qr93NXgFRqkXEw4XtWgfTcV4L8?=
 =?us-ascii?Q?4OJ00d/l7vjvaDyCMSZZn9WW/Dr+nDmdEyE7Na7yrgoqAIS7UxwT2VH/wluV?=
 =?us-ascii?Q?Ra5NFcOv6L/z3v4h2gLReWI7GE8IoN6G05YPMp2IxKygRQJvxh9xfEYq2kv+?=
 =?us-ascii?Q?5qW3Mj4vJvY9jmv8EVzLXannl07GCnsbJcWYtY0THJ4EY1pHV8ww41sZQmWa?=
 =?us-ascii?Q?2JDqTFHbvPW6PuduNJKBhFPJdJbZBSHtM3N5ITs7luaXwVJ0ANui61DzwrI8?=
 =?us-ascii?Q?5QQVT9rXxEDe2WYXBi+Sg31unOQCt3H2?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ol6OqgYIeizET8xBQUp6WTKDOm+TUfMaGATeUe2MME0Inf2B/RpMKSiN6bzx?=
 =?us-ascii?Q?sRL814afEPyj8ZNpH4KLIh/VCzv08t1tZYV2qDbmJo0DthC9KSASzeAqcZNW?=
 =?us-ascii?Q?fqOf+GUFvDT7suhlDE1xPN/KrI8ln5eQaA00vPUg6dzajpjvRU3uj0B+IEpz?=
 =?us-ascii?Q?iSHmH+GyaMYei7X3uhuvKw7ueKnVx/LrxwgDNhVBLbZaFAWzD88sS7o2He4c?=
 =?us-ascii?Q?qXt0iTbkwUZzWgW45J7bGOSJA829XoUczCiIuis62uzicYGDwZ4BY0wavO+p?=
 =?us-ascii?Q?AcvqQjIdvwIQirZvacLugvoa8YnbuJxxWZxRnR8kOXxYZxcNkKGZjK8lcnbq?=
 =?us-ascii?Q?Q8RdU50NswuFNxvyeU0QALoVDG+78f8vmWYIiF+rbpqZOkOA/242UmQN9vV2?=
 =?us-ascii?Q?gtPlHEdc+m65ACP6mDjzbgz7XoDmC+gebD3IybOKKxjhhB4lCDxo1k2MQQs7?=
 =?us-ascii?Q?kdOF+FxroUr6A40As3QpnaYYNs7XgISRDarXdck/pbv6cS+S13XLi0sO7/o+?=
 =?us-ascii?Q?NV1lpWwxXWZL9yrVLzoV+tVfAex8Dt1K2fYwpa4r+mOGQAlC7/3eS71S9Cr6?=
 =?us-ascii?Q?kGQDBZ/VvjYuAOEhnlWFh1tw3YWlVAKNL1H2gvWR3WL8mFwixfGgYKgvnon6?=
 =?us-ascii?Q?0mqyCORWfYeJXtuscRw6+ko+PmC7mf9ZJVTBXTgOmEueNH4D9jrZgT+StbK4?=
 =?us-ascii?Q?PqQDgQ1m57dDvzm77eiW8by5caUxfUNOVJAQDyTyxe3+ddU9IZ4UY5YNGLOG?=
 =?us-ascii?Q?Fw2Pe2ogoMCnx2msUCH2aBWRLCQfZRu7XHnFerU8Mp+epfVuPolP/PDGtHRm?=
 =?us-ascii?Q?BraSTNXrRroNhxWZHkc51RaJO3Jv8wvKlT2R72PzdrDY0UydiU79XBgKbsNM?=
 =?us-ascii?Q?i0mbdIwk099iPOwcSypVsxyiVfsbrpXCzDJogedtWnFX5C8x4jodrLUhNlvP?=
 =?us-ascii?Q?S/V52QtMIQb0BeHG9jdVaD7a7RkDXkFrL5CoqoZtEYbYnvEVWhB/IWBqjvSp?=
 =?us-ascii?Q?xX2PqaLNgFPVvJn6DUl0DM9wEyttFMgLDIY3cJFAti7yeZZ7LeY2e2sv4dGI?=
 =?us-ascii?Q?9lMA79Wkn2bN56OpIlcl+/ewTlrhJNaVDKPMqvfEh2tvXKPiMwm6LenOVbsB?=
 =?us-ascii?Q?rlZYqTu8m7MkU4jPr+f1zSqygLJjv700DF8dAt3icbXFTYXcskpjxreSeYJj?=
 =?us-ascii?Q?d4S+AW/qsscQrA/EveTyIFmn3LGTINk/O+8l4GIQila0RXQ9rjNe/B7zoAw0?=
 =?us-ascii?Q?uQkKGFOOe5oo5DnjvkrAtLpfqvt3RLCJjwqDjefzeO/9P+RYxkQWZFMNFnzJ?=
 =?us-ascii?Q?81EiBFCtKgEXIrBBncmHNB0UumEkgk0BAIml4jGA8hBlHtP9i7UV4pupSEci?=
 =?us-ascii?Q?8/BS4DBzlN1RMbbOE1g4aLz6iHuMeIuoCGB+PFwgh8RawGPV/K6GzzE8F3mL?=
 =?us-ascii?Q?Yr8R0jvIa6RRUd5oqe6Tq7Cc+OZni1HEbj6MPrEzUmDp1j77/ostZ0du7s6e?=
 =?us-ascii?Q?OacC/oAX6qoD4ZdC5ME98c62v4watluT2+q2tzwqQ4lFG+TMs/NqonNbd8H+?=
 =?us-ascii?Q?OuxncBy1b5m1VdL8pX9KAaOaIbpsLyDmAeYVaMvTnVGAmTFQa/djQ3thtcqy?=
 =?us-ascii?Q?oIEFNChXPxUkNJJ/tpqP+vg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77246e0d-cd19-4773-2950-08dd6867b1e9
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:13.3194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/xXmxZqRT+hb2M/xn4qKcA+wBrP6/ROadtY25ZCK5Jpqiva0Mm4xgh/ycU6sXK1CUD3K5142vlwnyb8KG6WljaPEM8+Lag4pEjMUGn4PFbKJk3Xf6uc4xeh3vN6V7ZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18318

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 44d13e198cbf031fdb8cb20b6bbbe82adcb951ca upstream.

Add clock and reset entries for the Renesas RZ/V2H(P) ICU IP block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240930145244.356565-4-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index a426d0aa4592..7c4507fd34e6 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -94,6 +94,7 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5),
 	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
 	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
 	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
@@ -135,6 +136,7 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[] =
__initconst =3D {
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
+	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(6, 13, 2, 30),		/* GTM_0_PRESETZ */
 	DEF_RST(6, 14, 2, 31),		/* GTM_1_PRESETZ */
 	DEF_RST(6, 15, 3, 0),		/* GTM_2_PRESETZ */
--=20
2.43.0


