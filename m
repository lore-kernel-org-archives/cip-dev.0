Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CADC83F05
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web11.20547.1751452555834169188
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:35:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LiJXjM0h;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QehDO2KTOGAnn93fkQNzdJgme2LPitFP8526glGItMxGJptzdHog/ebaT/vgxbAZTa+tsky650VFbGmxhQf6C4r6EyrvuNQZcyT8O6ktmGYSKuIX5rZ34NaqGF5xUavW5+bCr5R6rELIw7D8iK//p7Qj0PbE2orSpJStAind3sci0p9zc/jAh0AiZsCp3+NaBD3RuKSbfIDkGGQvbaRh07vB7JYW7Hpmfy/LL8I/CAAow318LWVc56Qi1linBU5h6Xl7beOG0QOctsqHFzi++u9hg8Nbou1cjAim6TiM3l8JH1WIJEbIxhiy6L72Zv4GMRJjmTRt6SKYp5warkPOxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bp/Stf06FlQw9yLfOOkSBQ1de/29Rcu58g4VNKEeGjA=;
 b=N5nP459k1ND1BWa/8phQefWSiNdPU+9nONPmRI71IUw3Mv0dCYghjjya82z4ScnUDGCHIfoQWWjglm4WUIgA8wlA1hdDYM5+cCkyy1OjZns8CaA3lnOnrl9xq+ScWWDR8lq5PbP0b45pUU4tQipVkOIl2XNpw6sw5uG9sw2W3bqJnaJCHdRDR2hM5X1+ghp2S/7v61Uvm8ixRYv0wT93ToAlvKGOEFOXfpXjnkXN3EzIj6rbr6kiPE9RPgvqaWoMCknEPps50JHsSZhb3/7D5LKs/klfbry0GAtUS2rQEqWWsx/8VA7+2bN0T4NcOxRPEyzYvjIG8+lCHe6C93b1kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bp/Stf06FlQw9yLfOOkSBQ1de/29Rcu58g4VNKEeGjA=;
 b=LiJXjM0hCxZDTQYN1jcsG7fewyjbDhqyodAV9H6ABNmCU2bY2lv/ouDp0UdjetzLK2n1p3/DDCVsl+EI7kLhzBs7QzXdBi27xevNjmG2ZGlAPWOln6j1O5rbc3CFEPI71lJS/GHErCPNStKYv5UvHyq4QkWwloWUqbw7bMHDSlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:35:56 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:35:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/12] clk: renesas: r9a09g047: Add CANFD clocks and resets
Date: Wed,  2 Jul 2025 12:35:16 +0200
Message-ID: <20250702103525.117166-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e9472c36-baff-4e3a-d05e-08ddb9543a4f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?IeWNJUuKyQqcKjYTkBdNfR1dna2X776UhdjB+0nkH73U5n/FdL8uIOZAYyDJ?=
 =?us-ascii?Q?vAL6jzYKydC4YIzJYaO6nHbAFDlxhS9oRA2SWlnsD5Rq3/lp55bRE+/C8fSE?=
 =?us-ascii?Q?yjWKwTbrjX9jxRzTUh59ltpWxoMdsr4UeRJWvZYRM+SeZN4Ve/uiroDkqdWn?=
 =?us-ascii?Q?06KmVGPbTx68sFWCzp7HRfd2p3qjNIa5yminxBBu03RakPQjqRXMCDdEvjZk?=
 =?us-ascii?Q?ToSuY6huNq/AnpT2+ypRmjRIVSp0/Tik6PXy9VzolSS8FId9/RxpTZo2uqS1?=
 =?us-ascii?Q?P0Nmm7yS8hB7IQS/xp985bkPy/6A7jmC88ouFof5/MG4xEgvHxAYtIpSG20k?=
 =?us-ascii?Q?Zi3yqRKWoEGz28RNG/mH/IECZbPrDDviR23tHghMS7RMkMawc/pDhmyqlBQ4?=
 =?us-ascii?Q?zcVoH7KxW5JruinlbHmw+zpvWyaSvRyChnQPoWRNJbmA8B98nT+V3W1gSSrs?=
 =?us-ascii?Q?YitFPWeeDWG6s1Ru4ZT2pGDaLiXp3Rw1zyyH29xyGb8Am7d8eOU0jR8XgXxD?=
 =?us-ascii?Q?DkKEmSnWAsYoCq+wlQAmbmak98dDiWWz4mXlqHftUqWPavz8Jp17YCXOHd7T?=
 =?us-ascii?Q?Ek0M2enopi2yTGX9Icoj5NLLt2Z653u/+HwQA+ypmhxF/Prc2nvCS+FZx/87?=
 =?us-ascii?Q?xwpBi/4HJsanOMv+lPxWtaqK8RhREyHRPzY8N1q4utclX1X0aD72UUhA+LkR?=
 =?us-ascii?Q?60JT2ztW2WA9OFnvJAbdHmdovhdGo6s+MMaubyz20U672ssx2uoKahQ+FK4A?=
 =?us-ascii?Q?VCo2dMtTwLpaeI5Aqad5Wo64HFHv9R6XwLUa/V1vE5+j1I8MUHeeVJURiJ3E?=
 =?us-ascii?Q?tRIPU8KrGV3UHr7t63AA/L+apryxmu410VHqgmNHZaVk/RPi34VeGB38V0+X?=
 =?us-ascii?Q?mdTQyy3uMGvbzlC5fZ6y6LKpWFhAI+LAcuye7kOR7u6i25HBiO1Dhvou6aLT?=
 =?us-ascii?Q?nHqJWLSnLJt9387uPDCeaLXoL18WVUk5cRWJT5AKD0yZw2+Vr5+gMWhwcqRj?=
 =?us-ascii?Q?rhoBgtu/mVq+BE3txoCGr3Gh7/REovC7iQYCuLKU0GCAxpxZcI9PhAq/Z1WI?=
 =?us-ascii?Q?hrInGpqRvjRxBrG0hNtghUDciw1dNxpvIT2/d2PnFp9uQSM+mgYeqxu5U7LT?=
 =?us-ascii?Q?1eChxA93VYRvDavxIcrsLhu0vGUWRcFPIBzIzO7sRw8mjP9BT1a7O2ps+0Hs?=
 =?us-ascii?Q?LEl8RozA8rZ53HlTJbGCtIbc1J9DfVsbeA73UISY2fw1luBGpC/38155jrzs?=
 =?us-ascii?Q?TcR77Cke1WdUzNYKthHhetYbomO/LDVI7sIg6u1VWvCzmnD6IK4XqV71/jTY?=
 =?us-ascii?Q?PHTkvMwDdGJR1zj+TzZTppVP4gO82PGYCSRl0GX0mMnKwEi2vT3Bqg2i9CeU?=
 =?us-ascii?Q?sgeuE7u/dJXDJAiwFeblPDDBhWeRVC0y4wLmF+EbmgH3FOVne0QVmpqUZqBw?=
 =?us-ascii?Q?oDdsF9yIbu9tztjsZ1zJfduVT3a/+ECVZ/+tp0wTfSaXLLIrv/BWtp0e6tSR?=
 =?us-ascii?Q?QZnc2rcKdd9RjtY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zga8kpFLrpoj6RsD4QxYnl43uLjsWZO1UO+9HAgF2uj+9k8jn4Tl1nsjNIHF?=
 =?us-ascii?Q?Hw56F0JcX+5iy58QzGaPJgfT0rCgBDqi0POsl7lIHtuA/Wc9OKj5nG+6QJnn?=
 =?us-ascii?Q?IG/85IMWeHgM6yB7cDo2jBEBgC/ttLJyG1EGDk9S6gKXZJ02Avxo2NLjzKlk?=
 =?us-ascii?Q?M+AzGhMt5Kcz14UYow7m8/MLZxIsVGW0FAygfqsgJ+oiG/mwVWasVTaenu0E?=
 =?us-ascii?Q?u7xSI7fKzgopGbQRixRuBffWcYIBQdLlmTsSHbhCwrptjefWn9MyFdt5KZty?=
 =?us-ascii?Q?XzPZvssDm1FufIe2UxO1zwLVxeqTtfRjyypwYv4WoRvrfkEsHIZXeNeFRs6Y?=
 =?us-ascii?Q?gBaAdmwpTWVp9MGq4+vPe0aCgcqMmsbxZ4THWRvcrKSM3Xgk5lPgPwQp0SQV?=
 =?us-ascii?Q?0bzTomB1vFmRND95+0bNbb/rlL9xOB8r/MLANFgyQxWquB0s6mnq9xV0deOe?=
 =?us-ascii?Q?T3kV8mZRBQNzP9tP9APz5Ar1oShOM75p3VJuI/DgdWIaA0o9fa27P//5JTyd?=
 =?us-ascii?Q?DH+549QjEQXN56N71bT8NpheiGbuvEauADn9O+8buQ9EdVwW2i0GUdKKKZGq?=
 =?us-ascii?Q?dRArAYK71iu0rM3iqu2rpIfopFY8nrtbMtSlrVxQ23RvK3jfVxqvWHjtDfEx?=
 =?us-ascii?Q?eOO43ptJz0K2E5jpqbjm2RVv2c4hY/iNySn8s9KtLb0HWofjoqfFVRfugtp0?=
 =?us-ascii?Q?sBSE+C8I44e9SzxhjIXKfR5MT3qRc05KDaDkDzwpQnQC2DCnnSolSF4FbAFQ?=
 =?us-ascii?Q?rWp1Y7eqQnpNoLodXRhcbUeCf/35G5ZI0/ZtG5AgSjeET7jgApOzKueFeTbl?=
 =?us-ascii?Q?IVg0bjuIgfFjG8ShjHWcD7kn2wRrwbyXy1mmWoToXLwzD2eXnHD/wnEqs0Q1?=
 =?us-ascii?Q?Vn6aFs0+6FvF+2oCcs1yFbZ2Q6KX9Ax0gfg2SERvo6/YOyr6jeiRkOTrzCCB?=
 =?us-ascii?Q?W6RWqtj9QabuD79W3bMiC8y+oscNlKyCdJ/3Hh907VC2kqFk/qSGlMAgRu06?=
 =?us-ascii?Q?Nun4Rg+tkAjSNrM912Fgqd6IcW4zJpb5BBgI9wYMksKOGSeqdsQSaa+S+qqg?=
 =?us-ascii?Q?t6Vf0Vc7TVmR9Vc3evePuU01fihvAxfiq2lbRkd+OsB64Untm96cfdvVJk3L?=
 =?us-ascii?Q?J+JTefxTWOGZskCjeI4Nd0uqCnhVOCyliQj++laxbdtOrw9azGvcAC/1YVej?=
 =?us-ascii?Q?sXflahIc7uE1hkZMMSayaeY0MA2dvDx5BB4uXz4rnXekwHzn739Ly5TFxQNj?=
 =?us-ascii?Q?1AgLKqM1Lbm8CiNq/TTP5gGwMk6TU9uxym1lPcxeW8frqn92GhduuBV5BjBa?=
 =?us-ascii?Q?81Zjnnte85SbfBpzVYHrknS8XOuENl0CYWOSMVBFMfbz8Tb4k4+i5zBTeDWp?=
 =?us-ascii?Q?My9ZQM0I1tPdGD+sSi+dx/llhvHX8Her3YvDjhv95hYyzOi34VlX2DK3zlut?=
 =?us-ascii?Q?aQwpb1wRlHjU6zk+/hYjeRzJdNnGnN1FIehVV0ZF/P5biIxP7/xuoOHHwYUc?=
 =?us-ascii?Q?EbleoNWo8FQ5TfOdHbHLj7fBz8+2GujFx/Ty/qOpmzKo28M8aoDS4D5X615c?=
 =?us-ascii?Q?ie2zmb5H7fCdOuxV2tNxUoVcAXbPK/tPxPge/xrhiVIfETA6NHg4EF9j3rDs?=
 =?us-ascii?Q?rUXmJa72rAXQXljYJcfFJ6I=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9472c36-baff-4e3a-d05e-08ddb9543a4f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:35:56.6460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qgyLdjrE0V2QDo0Hb69mTLi6L7m3UeOVwBHqKC4toH5uXrsR2Yzk2Mzo+XmXmBeO1P37xbsN85tRTIgbXOKmPVtgPyTyzva1wP9Py38IbHA8ENWgUGjwsYlCg7GoJOpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19288

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9b12504e8c8c2f1f7e5f16afdd829603dd0c9508 upstream.

Add CANFD clock and reset entries.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250218105007.66358-2-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g047-cpg.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g047-cpg.c b/drivers/clk/renesas/r9a0=
9g047-cpg.c
index 5d02031219d8..ff015b3b4d2f 100644
--- a/drivers/clk/renesas/r9a09g047-cpg.c
+++ b/drivers/clk/renesas/r9a09g047-cpg.c
@@ -35,6 +35,7 @@ enum clk_ids {
 	CLK_PLLCLN_DIV2,
 	CLK_PLLCLN_DIV8,
 	CLK_PLLCLN_DIV16,
+	CLK_PLLCLN_DIV20,
 	CLK_PLLDTY_ACPU,
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
@@ -87,6 +88,7 @@ static const struct cpg_core_clk r9a09g047_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
 	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
 	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+	DEF_FIXED(".pllcln_div20", CLK_PLLCLN_DIV20, CLK_PLLCLN, 1, 20),
=20
 	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
 	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
@@ -145,6 +147,12 @@ static const struct rzv2h_mod_clk r9a09g047_mod_clks[]=
 __initconst =3D {
 						BUS_MSTOP(1, BIT(7))),
 	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27,
 						BUS_MSTOP(1, BIT(8))),
+	DEF_MOD("canfd_0_pclk",			CLK_PLLCLN_DIV16, 9, 12, 4, 28,
+						BUS_MSTOP(10, BIT(14))),
+	DEF_MOD("canfd_0_clk_ram",		CLK_PLLCLN_DIV8, 9, 13, 4, 29,
+						BUS_MSTOP(10, BIT(14))),
+	DEF_MOD("canfd_0_clkc",			CLK_PLLCLN_DIV20, 9, 14, 4, 30,
+						BUS_MSTOP(10, BIT(14))),
 	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3,
 						BUS_MSTOP(8, BIT(2))),
 	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4,
@@ -195,6 +203,8 @@ static const struct rzv2h_reset r9a09g047_resets[] __in=
itconst =3D {
 	DEF_RST(9, 14, 4, 15),		/* RIIC_6_MRST */
 	DEF_RST(9, 15, 4, 16),		/* RIIC_7_MRST */
 	DEF_RST(10, 0, 4, 17),		/* RIIC_8_MRST */
+	DEF_RST(10, 1, 4, 18),		/* CANFD_0_RSTP_N */
+	DEF_RST(10, 2, 4, 19),		/* CANFD_0_RSTC_N */
 	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
 	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
 	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
--=20
2.43.0


