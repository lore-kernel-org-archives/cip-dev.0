Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7838C3600D
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:02 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.61])
 by mx.groups.io with SMTP id smtpd.web11.67719.1742914615373580948
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:56:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TTY2y3aQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrA/onhpx9xCR6HDBDeKw4DLA/GQvANCiIWyRENnP727Pjc8ALTUzLconACWbxOAU+nLCGMy9Wv/rSYjX4aH2nZ2e3GTvQz6AAYhiRDCU4njkXqjb4QsvPXG0B7JLa9Z0u245Yjjm8tvvDxv2uhHrBIiPLxQx8AkgS/ewom1lgdvP0h2evbachaSJYjLFnOhDflTytw0orLFDp1NtLKIFjjwX20asf8ixSuGBxS5rf023rmVkZDTBGVA0sZo4YWE3K89XcA1/ZVNuke+JINM5YjdvIQ7sFVRHv9wFVy9KksP9JxjtbefBDLU90h+zbNX64uns58e/tfBYTu+MiDnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0PFekG2UT9NL8mGTWWNt/zqdIO/TL3uhOdMzJORf2o=;
 b=dWXv/s8q3ffC9AZGZUcw4R7WFGQenpZJLHUkeFVD7aZHZcrrCTBEfWPcDonyxon05BObeupS5Z1FmZIfKjorMk/nYRbvJ0TwOSKaCxGdZunYrB9KQ+dQp/MDkBwqya3vRZJpXxwWRt/tBKHGoGAqv3HxSA80v4ewYuQeJXZiko/ZhmnH/Jgn/oN4ZR3oP9r9G6YXzYY4CebqdfOSgvCNyYp5DUVELNV0jdRJATdOmRc2wBYwmx9GzEupEd0yGAm22JWDlFwJ14VXuvxs4N80xdnEyZm3GXi+w+983oHqNswXXyyA2SqTGfT8FbZ2JzZwyTPzDSSJcVADm55niw6lxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0PFekG2UT9NL8mGTWWNt/zqdIO/TL3uhOdMzJORf2o=;
 b=TTY2y3aQuqBwVe7XG8PIi8LaaR8TgJfQU9Zj/+2zPJrxqhT+ftepLhDF0PzYVHtkKX03zkLdgsQtEetPVMO2WqWOnciZ3NucliyoWghrW3ksJCxG/Pnr6DJyB88cXi/9WV/tDNFUxVUji9mRm53K8ZT7QbSGELrhbCad1EiHc7o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:56:53 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:56:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/16] clk: renesas: r9a09g057: Add support for PLLVDO, CRU clocks, and resets
Date: Tue, 25 Mar 2025 15:56:01 +0100
Message-ID: <20250325145611.3595454-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fb7cdc-769b-4514-4a6d-08dd6bad4790
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LtGnG+qSXUehd0/Edj7bYT/duq+Zjr8Zd5L49Mf3oXlEsZ/LrwC8uwavD9nF?=
 =?us-ascii?Q?az5pHBPkg2OIYT8DJKyChYoAYJZLvEniRZpWsYshl6UvSYaZSFVpzQkqWilR?=
 =?us-ascii?Q?NbUg086O7cuS3IIyhrf9Re88/NQU9QSDNv5BcXdELhU9ckya/uyJZdSSH4GB?=
 =?us-ascii?Q?8QkZaO15zh76zgkLNqtz/B2KrAFaLD4bmHWm23K7cFW62BBWNDb+6VLFnGMP?=
 =?us-ascii?Q?RZ4E5Zy6FXBQr3nuhVm/s7BrO9x9L4mw7GHAITK7mMIbfH6JO4Hm8CdPpA/1?=
 =?us-ascii?Q?ICm2umbadC9g4vclrARdkRET111Wvf4j4df4DUifzMViJeB9fGq0PXFWlWgu?=
 =?us-ascii?Q?W1GEDLo1kjyj2OcqboHVQeqN+n4733yWmaTtlcr82422Hq99a5tBAWBwy4AG?=
 =?us-ascii?Q?nMsGflKdUT5k+wlOjXDkY8rUk1nv2c+wBCbkAAjJygYT6VdICtM31FAJaGBY?=
 =?us-ascii?Q?qiU2gx5GQ9/fVGc2o3iLHGhg31kCgsSB0q9Z9CYIIikjtv77sZ3pat3ei3a+?=
 =?us-ascii?Q?kwpY3ZqHfdWtrHakm8kqminCy1k2i7sdZNv2NQfZTvQDnGSILuGWdSZZR8xj?=
 =?us-ascii?Q?0YHzVbQjDLy1GbvMZK5PNfoh+VR5MwmUGCdOX0T9wL3WObwIz1WCnycZai+A?=
 =?us-ascii?Q?NwXyYeW2gg4uzLmbr11Gicp29H8ADhn6Qmj1DtkIXxDfjHWxcNolbu4Qomji?=
 =?us-ascii?Q?RwWcn/7WoW3LZd5DzyOJa09ALDKi1QtpEiTQmW/K8uFIz6MRPHpy2c5v3ZnX?=
 =?us-ascii?Q?bF3yHMrAYOrHsLUgbfdlYQW/pO8gEKzK3fFCDTIZ/xCElrxu3WmlCFL5KvHS?=
 =?us-ascii?Q?CD6aIOpfvJKHIg+gBd2qeVbpQ+0BkORDnM7kvKFlGmIJcWnS+n1FFV0mmtxI?=
 =?us-ascii?Q?XpfTIJu4oPyEYg8EEhbXWbEAINC4ibp7SEqQ1ZStE0UnD0ApTGiHuBd7BSH2?=
 =?us-ascii?Q?UvRcK0nPM0YewvCw3WFgPpgwtYjbN9eGlXU41NpW2l4m6Qtjy5c4OcMCz25Y?=
 =?us-ascii?Q?AXZi20Rs3b6/WQyOXUgN7J0PmJGG1a9J2g6spwmitjnC0n1hhMcP+kl1PR8n?=
 =?us-ascii?Q?ZNZ1ZGN+IeMOWJL+gs8pd1AKFbMwxgBmdPPUDBiIQ6is5hEAhH/n5wqncgqV?=
 =?us-ascii?Q?QOFffHWzmhEcq3Xg4soe3M7bRC0UFrDwiwAC5TiqsoWJ9IG6P7Wy0u0y5q5t?=
 =?us-ascii?Q?OLvuR/rcDd76EOg0798Y0vuMY6WwOtKoxwlZ5g44q+dFMItpN1/J6jmTy87P?=
 =?us-ascii?Q?j5ESTXHLBCSzwMWbDo8SBleyEbzuo7WvFi31sxH5coI2oAFIBv/DjLAPWYpB?=
 =?us-ascii?Q?8vvNhIv9pQ+xZGlbMM9emVY0m7ts6HmU3cx13do5cB4XL0p649p5jFoJmNda?=
 =?us-ascii?Q?Wq+jmaq44yLNdpEO5uIk0ilUQh7jZUQHOcRZwVMmtccDqwpRgkyQmnlkCBJT?=
 =?us-ascii?Q?RzBIlxhLMBffH76DPhatr4yZgpTCZ9PB?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R8XinSVeSQygD0pGkKnYUtVKCsRdd23DsOqQizEJYqCwKEwvJMAAfiNfpcWM?=
 =?us-ascii?Q?xwYsOuBE98tMT9eHogZc7bGQMkdAk3sGl5DeTMjDxgcttfTRJocMLL1PwLCl?=
 =?us-ascii?Q?Ikh3+bnb0V9VvSsPCOQZQalZv/f+ZbXPuAaTQO0c2YBQ63TaqdDfgzMjPS7/?=
 =?us-ascii?Q?LN1KrmEaooIr5lEFIVvChSdb+dhQldywyzdL6nE7Pk9ebqHfqsMfvVPm8YVh?=
 =?us-ascii?Q?kUqHO9gWrXT45XhnzRfm/qMyuuLDf9VJ09ie6/R5eYqO3QWP1Lw5imu3N0+O?=
 =?us-ascii?Q?ehKDVRm1OQ8BYjbn9YrPAl9pUrE3wVA7ulgeOgAJAxOf1t8MuwF2Jud0JDuQ?=
 =?us-ascii?Q?kOTs+jHZSKjXxaa3RDluw1KYmehBcYWQQKYTR1MkKCO4hG2vdav7MjtX/SSk?=
 =?us-ascii?Q?GgSBnJany3tWlNrPPJ0G0GoaacZCltmXHC1WsxNnna/oHLd1wbn5Xx6Bncj8?=
 =?us-ascii?Q?X1ZGiFh5mH0cCKbGf6Q3s0HdsxfntEi5bWOXio89ejCo6fDLdZ+lHWFlPx2B?=
 =?us-ascii?Q?JhN5gQlvQD/1OEwAKudMLEphuCAWj+8YO02VJ8BvA2/H4PL6+1+A9kNA+ZLY?=
 =?us-ascii?Q?21W2OZtclG9J5AXSSNp5RaZLOK1Bb3HUrMrez3OUnRFsL6+OGvD1hFSjFgNx?=
 =?us-ascii?Q?MUkcABhYnVKw9SfU3UNc74PIYAlBJSNt642SuUVoNh0tMvtXLOpGq17JN3A+?=
 =?us-ascii?Q?/ihKVdd3uip5QwPIQ9h/8SfLy4+rnhVLtkzmSGrNCBQPYCKePfrU2Tf0U8+x?=
 =?us-ascii?Q?q0odsEwmbm3byccC1h1e+Fb5oXRhca29OaISq2xtSo6AWxw0I54sbB+Qgh6Q?=
 =?us-ascii?Q?SeHQ7D0AgInsgE0V3M3Lrvp1U6boqSrzX5EoVJLNojRXiU9xT+i9ab82B7JP?=
 =?us-ascii?Q?WBNYFDYGjE1DBeD8H+Myg8VXMzw/V9CbSqPzv7bxiycbambHkzzShbVHWiJp?=
 =?us-ascii?Q?+RazkxZCzC47Yy1C3JWM4M4ayxS/oZuzKeaRa7K5S0DSEeYvanLf8ykqzAZ4?=
 =?us-ascii?Q?exDnVdUzV7nkvWVtCw4iLtzajUtzzFV4I8z7SQeStoN5TPp8oYjN9pbldgos?=
 =?us-ascii?Q?O1IW4hwfTHHWicBU5Zq2wQf3bqSRqdfg+kdbEWWnluaXTG6Caklhxv5SbGqn?=
 =?us-ascii?Q?1CG+cuymUIOBv8DaZxz8IIoGUqM0ke1lmvoELOlMkL2ZqSzaoLNLfVN1Wg5h?=
 =?us-ascii?Q?Zn1Xxt1EztklIkxiXdM5rAqDmTjF7iGPyzV/dKjllBzEjY27WfR/vMg7Y+6S?=
 =?us-ascii?Q?e9eNV2ngH0ZgYiPsZLx6WNLdjgpuX+oigGx94d0HOmbyHf6YXHXe79m8TgNd?=
 =?us-ascii?Q?2mnkiQ5OgFTGBvCesfQMD2AKeFREdAOC/3W+CqQQtNGuSM9DNrQ15yez2WKj?=
 =?us-ascii?Q?f7KxHetCzuZ2r3+j5du1RScAhQXs7b1EmSMchKIsefyj+73KX5I4OuAphehS?=
 =?us-ascii?Q?vjvnMq94S6jHeeB+Az9VILteEIgzWlxpD4ID205XaSrHlnciTMFftB1t8Kvd?=
 =?us-ascii?Q?tKvgthNW4sNS+WK/jOAW+IcYZhhTZbcr8sDX6Qk6Yj7XYev3b3MgFIOz6S3s?=
 =?us-ascii?Q?1yL1lNRArfdqo89XjOsJMK+YVEj7qtezglU6NgGjLQY2CXIzwq5XHKoOf0lk?=
 =?us-ascii?Q?w70tntQed+KYwc1MBqtfLcc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fb7cdc-769b-4514-4a6d-08dd6bad4790
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:56:53.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XC0gHM6CG+42cu5ERxsQo+L06gchtndtVbwh5zZyEayRF19yzcEooyH063VC2NJc+j9/C0dDXyEo1kNSU8vpGrQkm55o5/zbpvfX4UCH0SmpfLmxRgI+P72Kog1MS/XJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18357

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
index 7c4507fd34e6a..5aa9710aa4020 100644
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
index 0723df4c11347..ed8d2cad32604 100644
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


