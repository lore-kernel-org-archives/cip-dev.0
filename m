Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BC6C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:22 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.web11.366.1750690033414325324
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ta1zYumH;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cGaXS3sSaMeVYc6RTBvsORAKjj60MnsI2x/1jEqa3EoRJTw7LUM6bw0W76KH/C8hzQTYKuhazs8Q5XEHDOU8kphC6PRjRApP4ztJPRxO480lEoSx6Jitjfih0gY4JYODKi/EcWQeq08jQAB3tbmwzt8U2xfnu4SZpcCQv73w2RfILhSxLsJqPHZ9SHNmR91vCgYLXlbuS2jVH4pzwXHYcrOj6lCpj34iIelzUjuLm+yCszNxbgUh9YpA4puaPBhwvHpjz/DMXio5P+wcCvcLKwjMBEe9OvLo9/m3xYj29aifrbu/S4IP2DvsSCsOxFWYx7ozdZ+BVyER0CMLspOBDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bn1b0VTVvQarsm3HhswKba3KRfqW9E+PdfSyclQN+zI=;
 b=Rl9Aj2cMTvA19RYfIcPgp3ltORNfuUHh3smVacptSR/OZpkz7QTvR1oOIyedyJEmr9RSM3XzJRu6JkpRfGrLZx+GZpRllOHCRos9qX7ATbdu92D/3mvbo1EcVsxdLpnmN8l4B6a+go3toMBVEKZEsIWC8GvaqrpyTWYP3ilrNEDXvcwACM/H5zuBEnpLVUD0D54npDANLWKVzIp2Dful6qayeoPg/6sbbCmTar+L5rPyC5NrHbKkmwKCS/E4adVNyacW8N2Q7WMCb3HIhVObBFYiTYj3R/eH6IDTIXREf3e8cNzSZnw/3CNm72OzEur/8hzTmlBadIIauj15am50hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bn1b0VTVvQarsm3HhswKba3KRfqW9E+PdfSyclQN+zI=;
 b=Ta1zYumHret72tdOQf29eYSVzpUep+oixT/umFhM0qlslOb37VCCdoOKtsB0+YQXgEZEDXZL+k0u58U00lEtmX1O+pFHKYVi2f0h9bT9+FTMtU05NOVmb0LdxocO9x+olN+1vLFEuwFwPjt5B3oH6HuvgAiAJnFwyLPS+NR7QGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:09 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/17] clk: renesas: r9a09g047: Add SDHI clocks/resets
Date: Mon, 23 Jun 2025 16:46:23 +0200
Message-ID: <20250623144639.2119707-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d56d160-8229-47ac-fb93-08ddb264d4bf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cTumlSOmMi4LAHctCaDqyX48BvFb2KLb2d+LiU1eJ2dl3NeKREnRs1ir8GzC?=
 =?us-ascii?Q?Ld4PBCrqd6yriQKmWnSRbUzvAOo2rf+zGSi4cJuSWhV+4VH4QeiNZbpMrXJP?=
 =?us-ascii?Q?QtuU3+NufzrEX2uV5UKTik7OZMkHDwFqh0CpQFrGRQu/ZKUFZ15cw7JFEwMO?=
 =?us-ascii?Q?E/pShbHsPR68xGAoK5FTMlNkSMP0KlUka+ptb7I47PzKQFGmE3OYaCPvbpnQ?=
 =?us-ascii?Q?UlzMQ8vJDadOn40tJM/hsV5mFJSJhlAx9lGa8eEAU/xpjKN6IPlsTFLSFFik?=
 =?us-ascii?Q?CzEStniCwcWy3BYWq8C1D3NDuYOkDobadpMOAjeEl6AwubOQUAS3748dr/eE?=
 =?us-ascii?Q?xRV4TSlxTz+rZt/xWkd41/R7ukeQIpFhYS0tRG0ZFajbZeVQSra6itv/nwRB?=
 =?us-ascii?Q?KUR17pFXVscB1E+dB4/xvixCv74TbV+3zLR5yyfR8BaWo/JskCnhVe0PRCyr?=
 =?us-ascii?Q?lqqAmzoEbmDZDybHqFmUJ+s7SAi1PruqebNSvrHR7szv7uR7zXqIZiiVMg0Y?=
 =?us-ascii?Q?Eata3t1axfVUjRE1P3bJ48auTKdhESkCziAeca+ZGOjCfGgj7//pMAGgUak/?=
 =?us-ascii?Q?b98GJEmNdO+whfRRZVl3WzzaL9t2zqjhSWWrzU+nDNiiorU3zsezF4rp/nUA?=
 =?us-ascii?Q?xwA6B2CGsR4zQmsREVpojTUP4UY6Hykb/4s5t7wGJYTtCj/4uK+hbXlfNLFt?=
 =?us-ascii?Q?T4zCRxs7gHelYFJjlsNx15CqqPAmQ/UJXrEELC+KPGr1DhQd6tX3RBzo+yQ1?=
 =?us-ascii?Q?4BYe415I0SG1dopl4YbVsAanEvmQ2f9WtlGJYIAkBDrHRvDUNUcHxAywIw1o?=
 =?us-ascii?Q?r4VAydP6Dwc3Y/ZbU2AiwusFXUc4mYg0gOLYZEzUEm6koehvhfD+F6DM3zpI?=
 =?us-ascii?Q?C2RBxOmGgvkSEGD5/cqrdhzf/cjKQJJLk7HBJiHVTcF+XNiXaA46Hpr3oqUt?=
 =?us-ascii?Q?qfYXUfzzfbK1OSSBXgeBnKoMIC6TS31qg7OjVM5lTow3GaW3++DCYz+NU6IU?=
 =?us-ascii?Q?XMazJSrortWhvh6rCF2rZrDNRmGjg+z1u+nIQ0rWeeEaLP7NA1SDg2jLBRc7?=
 =?us-ascii?Q?mDcwPhJ/0uPOkCv7cjqCoyRqW7v/FF0h0WNEmeno21z17jGSRtCXg39spjce?=
 =?us-ascii?Q?UpjAYiQOiOamD1EpcqoUbXWaC+GumctZa/P1IWzv/vQA3p8lSzHRPyXye+JW?=
 =?us-ascii?Q?RDGmjb3zPRnYV+8sU4wKYSWClLvgbl51zZFUGIejiTSOzi4wi27AhhLAFfwa?=
 =?us-ascii?Q?0F0DRCs/Gug/iCdrAG/U7W8rPLW2Odf0Lbv1p/Q8WBUzCvPLFuTv1JjHSjKF?=
 =?us-ascii?Q?7TaJx7vT/gschPGpPIqzpneW4sn3fTeHgl4acT1GOIAjzIASe4lWk2dtVKyK?=
 =?us-ascii?Q?wZWnywbv8ATDzgtr2HgJtyH5n2V7QWDssGK9Fqeqt+0jtf5sdTd+R6PP1PQX?=
 =?us-ascii?Q?7/eSQCa5sZv+4bhvRucSKOUHUGt0DJiCyBrhBBbqvQdaKfWTW1PIohrC/ZxS?=
 =?us-ascii?Q?GANW1FZ6DS+eiSE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?heqhdOWi2/rZfufOUYuEmX5XyWot41FfCnxCprGQLFdT3LsmhSCSb3JYt4+A?=
 =?us-ascii?Q?PHvorRb8w1ESAGp1xFwwPSkvay0LZuDS1cvpShHHAKSjCnvrrS1z3ObyATCr?=
 =?us-ascii?Q?sDnj+FxXAy8ycAtBydMBUhxjzMQB0p4G2mdpV7M08cErDNaVUtcsDsTPBQHn?=
 =?us-ascii?Q?cEq1g+m95SACOgC0Lxmqac5c7+CoZc8XbaBcsE4niAdGpeQgb0jqHkPAOTLy?=
 =?us-ascii?Q?V3O5QOPGaOV5RqBLfex3m9KH8eRFXWJCkrA+07MH0LP22r5cbixL74p9rrxV?=
 =?us-ascii?Q?FgZJ6AVGWRq25Op/I99SbyKzP1Vr73t0LonYnF3xlmaZJRSa1NoRznlHtsIn?=
 =?us-ascii?Q?nAmytodKaAIj/gmWCY7rge+qh9pFSsMaOgYgaXDF5jXE0ynYwTgoBVCzfdr0?=
 =?us-ascii?Q?beIdViX38MJYWsYLI1CiGG9vH9b8RH5g4LNvkOEUuKPbDzkmEusXHlm2E6J0?=
 =?us-ascii?Q?VS3nN6ETI3+BTSp04zmDEKd1Np9MXWQABJpS7FKwKCU4KXamscWo65zeG4ZO?=
 =?us-ascii?Q?BjxtZGDgbGn2b9JlnSqhR1hfYviBmCpLXVIFyP8vEdi95BK7/PwdgK+IKnFO?=
 =?us-ascii?Q?rddzhmvEdp9MEzJ1RcPZ5dKuFijF23we8CN/IMaglnd3lxMkmpFo+IM4ZFoH?=
 =?us-ascii?Q?uuonXvJDXM40DCA2zh6IBgAooMl8JqaComGetB02509pEsdFOFjPcqrh7B1G?=
 =?us-ascii?Q?2bXcUmF/za5DLlTRN2aa8zdRG4ybf5ES7xQxNdnUzlCYCbC9do79YYsUD/re?=
 =?us-ascii?Q?26HT6HMzTpusghFYkKaRdJvJMZXKVzoXiSYbGEJ963oczNxBAXo9I0IlU3+c?=
 =?us-ascii?Q?jaZoUupvovt/UIWSoxvrmWCSkXGqh2yurPeIg2oqVerJ8KHEClkfG/XcSaue?=
 =?us-ascii?Q?HEqp5wpu/06nc5iZ8McE6P57OhlQVSJHmyC1s70ZweJ7xbpslWjmOK8jvD8S?=
 =?us-ascii?Q?Rj5M2gvu38K6OaMLME4nSjYa5k2/BhTgYkyhyHbPH0+bNcGRn/BlUWJaRX73?=
 =?us-ascii?Q?RJ9oYNZmfugdxoDp0ttvqBPV6GdjXYudxdc+fGYWAPmy9czi3X+a1HF6NDsK?=
 =?us-ascii?Q?1VGRIaRmtt+/HELyogCdnurXA7nJ7t/QwxoiZLvpE1e2tzROMM8Oii+bGGyp?=
 =?us-ascii?Q?qnAsvvDIMk/GyaIe1WPuOe2N+0hEpJBVf3WfdESsLHEwzFMR2yoKxl/GUTYr?=
 =?us-ascii?Q?CnoCDMng0IAjVqBZQ9ocskKpYIc42FnT2jZQGAPJJkhgl3UwDQDk3h9L4COW?=
 =?us-ascii?Q?QYa/vfZt792CBY1BeSR+BlL9c8Y5sGHvseVQQC2VTQEe3oFH4A8MF6cOZSuh?=
 =?us-ascii?Q?HceOMO7+gfRnlZd5lVD6EdIc/88IWUQN5Tw8mO+ut+iiWAz69yIwB03YDgOk?=
 =?us-ascii?Q?/iqXJcmyeaxfl/EFWm4PmzZF558UP+yK1D5ZWQhZGQwlz5X7szwm4aue2Sac?=
 =?us-ascii?Q?3iewvTC7to0jb35EBiV3cwi321bX60PbToYVn6+V+aCfBNr3ssiYldQReEC3?=
 =?us-ascii?Q?9/pgJr5KRbmJsv77SoqWLkzp7qMCXoO4kxIg0929ibQEgDmmHkW3QhqlyA+d?=
 =?us-ascii?Q?9eGSEyAeFFL5LzqgykYZKLzJLvfKwctbSr8G6IrzKIgn8V2TMvIaR2fs/haa?=
 =?us-ascii?Q?jNUCLvCIjYGUe+/u8y0CFWA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d56d160-8229-47ac-fb93-08ddb264d4bf
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:09.3228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woP4An7CkYwQwK3zcP265XUZHGAQ958+pwO5RtTdCXpdH+zOUNwF9to/5vMwCOfaMf53TxMIFjohKPvAloS7lCppoiNeHppWqh/yDv6DZI70/xRnbHS5ihUonAq2e89S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19188

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 922c892834689939953c74bd34d01788b17feb7e upstream.

Add SDHI[0-2] clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250126134616.37334-3-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 31 +++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 1886eab9ef9e..133582317490 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -31,6 +31,8 @@ enum clk_ids {
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV2,
+	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV4,
@@ -71,6 +73,8 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
+	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
+	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
@@ -124,6 +128,30 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(1, BIT(7))),
 	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
 						BUS_MSTOP(1, BIT(8))),
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
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -143,6 +171,9 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
 	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
 	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
+	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
+	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


