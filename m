Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC11C35FFA
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.27])
 by mx.groups.io with SMTP id smtpd.web11.34793.1741778666850461276
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QFsbYfTT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.27, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQe/lrnV4xQOfE1SPNq4mRTnMri+uCZFKr13vprHihpM44jSdLYy7+3Bt4PYWAmJSanoEw8PaJ+l4t1fdEVGBkt/DgB5TdQ7ysY8/gSrHfLubPy76u2FzlR8ogI+soxoYJCW0la5Wk6ysgxZFizbo+6n7Y7G2qdvrriuIf2pYcfaqxi5wop/M6bVE3pLyh/x2Lzbkzda3/o6tuAIn7WFNPDptlnKdTBvszvnEiLqWYbxij3Y8DF6Agp97EZlqGqTdg4ypm+4g4TCJEFwvYPzeOIzD4T8bjDSUddXrr2mHAlnGS/d85/lIUKVHfwmtsII2pV1sSjSM9rfUY6MVfvFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLRtbI0vQzE8qneS+ZE4hVYfXmA0jzWK9wziGA+k5Xk=;
 b=RL1uUwsldGlSqNL1i/e2yAqzWBT6WsbPUbbctESbInZMzY1nvtxY8WnJwr9+VfLWnd3QSz6+QZLgM3ZQOH4gRBYaiUfBUjIa+joDP6CMZOweMM2m2w9wYxkvZnR2IBwOtaFrd3c0sCs+XEFjLZZZ3H71SqnsAWdIumBxEg0oh1/HPbvxxegN/bmnmWlDtHECQOmi5hnZ+0NVjZbvQzhBHx/B5t4az8fch24NPE3i4oqLwh2P0sYyNz9YXflYUBRp4u/UjrkL/9/PDciwkqz5d+MtvAzFESWtGo6NFFAx2BFloECJJPbIoIzc7QLcm88ZubCfcYaVv4hQBV/6XBB4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLRtbI0vQzE8qneS+ZE4hVYfXmA0jzWK9wziGA+k5Xk=;
 b=QFsbYfTTwLkUMzjC8JtwXsBG2dSdCmw72rRi6PL2rkC/O4UJLPbOPp6/V/46tQWwGMqVr9FEXvb7wfymLv/ywL0VJetneQTdz1zZL/YwdDuaoCAiyqMPEfy1/fHke9MRC9mFv8PUd7Du9sa6Ad4bTM7AYIkn77w/MtZd7gU0CFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:23 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/85] clk: renesas: r9a09g047: Add I2C clocks/resets
Date: Wed, 12 Mar 2025 12:21:53 +0100
Message-ID: <20250312112302.1605750-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d83857-2505-4c6d-0667-08dd615870cd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?L5ILc1ul1L/gH1CshusR77uLjnIoXmmi2W2jOaaSZW7vM7IiPg/PT98cDOx5?=
 =?us-ascii?Q?z6Wt4PQX/PBww9QkBzZttDWLgo9iHfoqA6Hhaor7unMwqcXBwXlnxicZPoIR?=
 =?us-ascii?Q?eLNo6v99vPpk1rqhSqTxjKrwSrOpdAVrg2GT7bF0QPKS92XRMyfYmv+Kgvgi?=
 =?us-ascii?Q?cYZckVYejNjjwRWfFMuLpLFg1FjHwok8bac+Yz16AElXlf9xsCaRCy7LVC3y?=
 =?us-ascii?Q?HWxTlSA3lWD/wqi+4JDwhcigPQqSGufvDvaQu1N8dELgKNqOuPnUbjOwdNup?=
 =?us-ascii?Q?MhvlaWTSB8mpr/xwZCaTSHM/Eub4z0nEJm9myH4vlBxs3PFvJqOGrIIE1B6d?=
 =?us-ascii?Q?kCneveO1BKoiYxMiF3WpWEfQ0vK/IUTJonUajWwo4fD/NfKcC3m5B8ME6kk4?=
 =?us-ascii?Q?DUsmhnjN0cYMRfjXPqzFs/5SnIR+I8Ahwl1l/G15xYPxhLqGrDAPTtV95vTF?=
 =?us-ascii?Q?4D18/ek1AOLkv4jNOno/AFSQF7E2cgAxNEEseGmXgFDaLDH2ZoHUPZk9dQkO?=
 =?us-ascii?Q?UANcX2QrC6s8TzGVcwC3txBKrcqevZuAvtTBFS2zubT0m1QEBjZlxvf0U8LP?=
 =?us-ascii?Q?mR6qNsu0TqQW7WHVAmQxsYnqWQ04jbOvRVKfx9V9bI6A+f0nCsFhEPXTtWFG?=
 =?us-ascii?Q?iL+4IqEC2cmqX0FSwbtzS9v+Q6SizDYoiadbLhSJiax48vslt4nc9i+0KX8N?=
 =?us-ascii?Q?RzrfUGN6rOk/cSkb0AIjBc+ClISxtLgoOLKxlpzN7z+jENEGo0oj6PX+QjZu?=
 =?us-ascii?Q?nCGvoCnojWg87+WiE3uZBC0erqbwKMP2ONmj/UhdQQ54xvpSm0y4s+IV2OtN?=
 =?us-ascii?Q?nJD2ivtoY4GOcH/j87LxB7PC2jPcI5KzJgyUPY6Q5nRCKh8KLBQT5MXO6PE4?=
 =?us-ascii?Q?BKS8u5BXvklXEwV9oOxWv/piRhRXwc88PdBPZHB9EvTL0CV1+VhEy3EfHNYt?=
 =?us-ascii?Q?xtvkLJUcQZWgukkKlGfn0sjAtrc6CQkgVJHs1ssyPaojcluRS47tgNND5xcd?=
 =?us-ascii?Q?OnnUJK4URoamHnn88cxb0yk0nCoDiBLM19VEOmR+gN/CH93WODv5Ebf/hIu9?=
 =?us-ascii?Q?RuMPfhd67pCXtTOluS2im3UFYfnAdhgwYOyJEY5ELmAMSMpQeyGR7+C2abLv?=
 =?us-ascii?Q?KjD3GsJPLKjwdhVOakrSyqU84V7unXWUHXxJQaHnxs33L1e/rjuegSLfVcyh?=
 =?us-ascii?Q?GNRsXbXEBjWQfUzeWWP+o0db4ahKwovSlhv5+wEd2DYoyQVNDVID7EK5k/vd?=
 =?us-ascii?Q?h6dvpQDssbg5jYK2313K6/hrVRBzqm5+1v6rgC13bgfpFXXHB+b9t+GWndDP?=
 =?us-ascii?Q?QqU+ae22odkxcL0my9PMXcHfAGg6pWu8IMQELdV6FGpQMCZ6odm55Gg+NiWs?=
 =?us-ascii?Q?Firx87mJSxTlftzjAVpGlABneVulQWm/Uqq2I8RuL/hwlhxU2bVKFg7fcWLZ?=
 =?us-ascii?Q?7Bbc2kg3T/57u0tct4BOEYIxvdoEGlx4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sWtxIvbXSU7XRjMRXUwdXlGsTCU1UAZB8djK0PyMlFlD6P0SulqkTkoYvnTu?=
 =?us-ascii?Q?l1eutBh0XGH2cDh1Sf1e+ZNoqpbjRXiMVIdPJUh1fmjzLruegqyDfLwtmiGS?=
 =?us-ascii?Q?RstwoImibwGqWrQgXRj6rQRSzsF8Gsr5UjUJGrR8/4l+s7DNGjyt6FBkOpYH?=
 =?us-ascii?Q?BWbsytK4r5fP7Emf0yVyGy+58qtLLXnQloTojHC0YzINa1frbkFu2y7vyhKt?=
 =?us-ascii?Q?RftvXFYzZmT7qF+owieZTxiBztUF61mYrhPr8zNbip4m6nm9jRcpnumXU/4v?=
 =?us-ascii?Q?lgbqK5w/Z59TUMpgAlygxywZ3UPLbFXT1xe4rHe2Uw4IsxfrrxeBQlzdY3sh?=
 =?us-ascii?Q?MqESwSd5+sU7jqUp98tNrS28yc2XmARlkJfQZr/ORPF5OM6PmdmIc7cOU9CM?=
 =?us-ascii?Q?t7exz5rDhjHkFeTIzDLYKE9hkBBfeCYSqoYJyQn5d+UpteD922+oV7Z54I2N?=
 =?us-ascii?Q?U3RkydU2m0FLlCyZg5yb0ArmCLwAafhm6jGDtPQ1whQMZayVb9fCtPFevHcT?=
 =?us-ascii?Q?25QZ1VNC47+zbTIll/np54E7+yLW/t3MyA0dBDmhoYudKAJMHNEejK5MGS5D?=
 =?us-ascii?Q?Px8fOXYVKYxBwhyl9K0KS8f0Is6tnyC/U7H69gIlft9WmbYVOhZpsgMBHZqi?=
 =?us-ascii?Q?3gA7d5qahtgcwmnK8ANASXR1GaKtu9k2FOGzoZua0jPIdpMftpeMp9mMzhOA?=
 =?us-ascii?Q?mgY4ka7mhOmhaJ7DM0QRuzTZcMTrSXxaOpObMb8UXz9hckM7JuKGWLGk2rMk?=
 =?us-ascii?Q?qD2OPmJGiVeIbmRm13TAAlGQTJDwaOsYib0kKfzllzEs4atHKWtMinFw+6jW?=
 =?us-ascii?Q?+grlW5pfTIR6qVvezlV4IRbyuYdPnZQ8BwG2BmPjzQ8zl6O/2bq6/IVMEcrY?=
 =?us-ascii?Q?4ergTXI0R0ONR8ZDQKEru7tTwz7rcnbk7rShu99pE4Y8MF8IOCeSGwDxRhf3?=
 =?us-ascii?Q?mAijuzZMzmBCitqf23GRRZ783WHvODkA3PFp+/EZfZVOiaZtp7J3mycmfStf?=
 =?us-ascii?Q?Av4j7zqVKuKVEWIdAgS3TbGJQpE/oKFwMIyf0BAc/dwgVkiuC+8/bS4zP0rp?=
 =?us-ascii?Q?UIxBpEtrhxJIkH8M/uUf9UTleS0ddHgVQyojHH7YIv6D+c41c8v5hfJQ90Pc?=
 =?us-ascii?Q?lSFLSTTXruWCey5PMgD0FPwkspwz/lPf++kCQP8iBbfu6x3u4DxtkUIC/dFN?=
 =?us-ascii?Q?ysRzlpV71qFp2ytfTHvsFnvqlu8cwpksRKNCdYtDJrPWGf58jDmgUdhNJGYA?=
 =?us-ascii?Q?XiW4P/UTsR0YA6zj8KL1PveSSDjnxGQ9yoErIK3/te0lf7tsep8VVSSz+g/9?=
 =?us-ascii?Q?SMtHAX7ZC81tAfEvsu+WIqrFC1TikZtR6hOx9fs6bxsza1M7egUXM3ETZ85+?=
 =?us-ascii?Q?R+2Eu/4Cmu+K1jJVX/fiNfc70RuRZpQjhLVlbYxtgjS5KGhFSI53EmGvGD7M?=
 =?us-ascii?Q?dHkDBSjaKOhP4FP/TMcdykW22ppN0Id7cjCvJMY5z7cPv/0ynPBjw85WcESQ?=
 =?us-ascii?Q?EfX777Hta0HR18uXHBjceDOSqT9QdSmXTV1uCY6WqTHOzRfD+aB2rspXt/tO?=
 =?us-ascii?Q?5ST9+Oz230q5xJqPyeps8mNIKyxcomh1Fc1hnsBtte1gTojRIsv/2qGToT8R?=
 =?us-ascii?Q?BbbigDpHXzUXAgBasnf1B/Q=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d83857-2505-4c6d-0667-08dd615870cd
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:23.5219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3OwvqvKqOdxYnrBMD8YH5/8yqwStX3uZbXWUAz4evfu/PoTBOBy0IkswWYJtzbc9n5/Ddd7ew7HccN+SFLQ1VLNsILowKp0pPkWGq9TMKW33tY/hyk5S0wmH3rz26QF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18108

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 29ebc6197403c643f389b59ba334e5bb53457103 upstream.

Add I2C{0..8} clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216120029.143944-3-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index f5966c08de41..536d922bed70 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -25,11 +25,13 @@ enum clk_ids {
=20
 	/* PLL Clocks */
 	CLK_PLLCM33,
+	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV16,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV4,
=20
@@ -62,12 +64,15 @@ static const struct cpg_core_clk r9a09g047_core_clks[] =
__initconst =3D {
=20
 	/* PLL Clocks */
 	DEF_FIXED(".pllcm33", CLK_PLLCM33, CLK_QEXTAL, 200, 3),
+	DEF_FIXED(".pllcln", CLK_PLLCLN, CLK_QEXTAL, 200, 3),
 	DEF_FIXED(".plldty", CLK_PLLDTY, CLK_QEXTAL, 200, 3),
 	DEF_PLL(".pllca55", CLK_PLLCA55, CLK_QEXTAL, PLL_CONF(0x64)),
=20
 	/* Internal Core Clocks */
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
+	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
=20
@@ -89,6 +94,24 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[] _=
_initconst =3D {
 						BUS_MSTOP(3, BIT(5))),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15,
 						BUS_MSTOP(3, BIT(14))),
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
 };
=20
 static const struct rzv2h_reset r9a09g047_resets[] __initconst =3D {
@@ -96,6 +119,15 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
 	DEF_RST(9, 5, 4, 6),		/* SCIF_0_RST_SYSTEM_N */
+	DEF_RST(9, 8, 4, 9),		/* RIIC_0_MRST */
+	DEF_RST(9, 9, 4, 10),		/* RIIC_1_MRST */
+	DEF_RST(9, 10, 4, 11),		/* RIIC_2_MRST */
+	DEF_RST(9, 11, 4, 12),		/* RIIC_3_MRST */
+	DEF_RST(9, 12, 4, 13),		/* RIIC_4_MRST */
+	DEF_RST(9, 13, 4, 14),		/* RIIC_5_MRST */
+	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
+	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
+	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
 };
=20
 const struct rzv2h_cpg_info r9a09g047_cpg_info __initconst =3D {
--=20
2.43.0


