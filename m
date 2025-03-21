Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CE6C36000
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:19 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.62])
 by mx.groups.io with SMTP id smtpd.web11.18699.1742554871293291496
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IaAr6vKl;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s6oL3HVh7c8XDPqd7a9EVNZpcyFcSkHcrUuW/hvBfyzHYXQ/NKEAkmKLPW6F9Xn8O8EJY/D9+T8fXhZ7go4Dd0DaT61yOQHkyhGsbnq1rnKrHB0+PMZsdQ1DDnOBSW1ob1hqj+DwwKQqWJVVNzSO28cseZm1OFSJ5GFimhqMUMmNd0fx+ZKYAIebhVTZOQ6R512jp3U8a7l3AIDeSUx/wrurl945rF86Z5BDxljB5480Nh1QzTzGjqrfHyUcsrn5GNk43o+iBp7eF82O4tSTBiVSNK/VBFNRZAdZ4KBrRwfmJ4kB3cgAhe5ocCSSnTTxakb8DUmujtDaRk1ot9anjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91oaFqprP/wRJYPo24+vQGKNfdAyaw3XVaQequq6zpo=;
 b=d7pIiL9V3N+QmC56YIc43PJUyJxRwVKpJcciaZjRVHg3RaQjYra2+o22hCXREtaCKg+0+lwLGq3+mTt8Kj/+AeZGmd5TJvCxFzAuN+D+RtaFxNtzoA6R+yL7WODbDbSHTsw4LNKi0yLkeE66W0pJVKjO22/RFcHD2L8kUXdmJORL1KWXKy4FI2bh6cfYPfFSBgHu73qRY8xQ6pt0NI3r+Oa2/ZYUUfVC0iaDWDic7KV79Q7FxTPzNcjuOg3ysGdyCtGid5SZDJ2090AA/qU/a6gGANZQdTw1eS//UQ0mNhFI+lHhWN4P2Bo1uQLkFDEVBmjm9e7nVMxqgx97lyXKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91oaFqprP/wRJYPo24+vQGKNfdAyaw3XVaQequq6zpo=;
 b=IaAr6vKlQw0saBCGslC1HROMQgcxPwSIm3ka69RXLE61Zy1DQ/ATYSQ1eONbCpoNBkLBDFas+9EZ+a8SX9KeyK/uDM/m6yJrgdft6VCcSDcJdIE4j8iDARrmHEAeiumP8ihKNkpHueXBmG5u4DKi/3/23rCPJ+Inhf/L2mqWu9s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:07 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:07 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/21] clk: renesas: r9a09g057: Add clock and reset entries for GTM/RIIC/SDHI/WDT
Date: Fri, 21 Mar 2025 12:00:09 +0100
Message-ID: <20250321110021.3612805-10-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: e5991bf6-2d38-4138-32ca-08dd6867ae73
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?V8IYfQnE7w2lxhXVnCz6v+qFUpZPUjXljnGglluBvtcE+wlr1D5SpETaYyyW?=
 =?us-ascii?Q?auQLyFrh3die7JspLEoYF9D79jB7YO8ft+HesNI0egTOYI4rshmCx46AYIQw?=
 =?us-ascii?Q?JdGMk9h/D77BoKbH4LUgLnr1HW5TYLazU/cqGkWS+Zqka65dXTpd8a1aMxJM?=
 =?us-ascii?Q?5j25w/eU4mhciaU81ng+4tpQosfW7arVAs3r5w8Xykr9zqmn/bRGCYFc1owH?=
 =?us-ascii?Q?p7MdMUiwxhmNP9WqiPRIHOT01bFnYNFWALRg0TaQkMCivcNWgv2Wbr+aYU0W?=
 =?us-ascii?Q?VSeGSWTtqbnnub6QrWwVBewsGN/2lOXnRz911o/9EHVi0h9MbgXuNkCVjj0r?=
 =?us-ascii?Q?BQ7FlXmVHKtquoUoah005L2titjorfSg6BGVWJ6L2KsFwB4bx6XkDWZCzrqp?=
 =?us-ascii?Q?AV37ggmq0VlgwTfT937zu2UCOcPcu0TO2dwiNkOqJxGBbLmAZ7WFueOBdB9H?=
 =?us-ascii?Q?1I36pQ+ZHPMtyJXExmAsa81ctv3VHdCyekdoriS+Snve6qnzD14udmSZXUuC?=
 =?us-ascii?Q?TWIVc4H6Yv522VyTCVi/mYtwICR5Npa382GgGPVtOq64RIINW2ultkusHI47?=
 =?us-ascii?Q?KEHesEbfaRlT/rHJ+qe1fMRoevJAjLsCwCXjhspRP257Qo2RMEBf3wuIus5r?=
 =?us-ascii?Q?CQn/I1MoQkrArcbmFNp66PYOMu4Yu+6laWEeNnuHLkJ+VxBdUIjTqpzGt4RG?=
 =?us-ascii?Q?tMaRC/3wdIjOPYeRfolOfC3wjrJ/dIjufAHXrYLtBWdKKvDWJwISZTMjEZMQ?=
 =?us-ascii?Q?TphDSfQrSLBn1ASLvliHixG7m3afUTkFn1ZBviwIadNRJ4BLZbX8oFSzG0ue?=
 =?us-ascii?Q?A9FNdwwF3IoQaN8EonXd5ufMzWHUFmhbhKcCmq1wdajzWablvd9T0+N080GL?=
 =?us-ascii?Q?yuvkWo4YWA4wNMJRNlVCHqDZYxOgZ/XFFyA4P0N2QKIIDoWXabuKEMiyL4Go?=
 =?us-ascii?Q?nheBFR33DcId5cYYbMf0PG92I8wwM6yVAuu0ndLf1787acAEYDhOELj+Z8I2?=
 =?us-ascii?Q?qezBnp9ielChFhTQMMIa6rYLS/yotGSrhqFt3Ir5jNncGBlKEbBFIT8h4QEI?=
 =?us-ascii?Q?quXWaO00fOC5w9OYIFnONLTcQTvcQFbtTqrH9jWddbO1fWWkLQ5f5Wt8xkup?=
 =?us-ascii?Q?i2n4yah8sERWd6Z3x8Ci7pph2FJk2yDzgaggcwaPM3uUbADOJHkX4m8LSbdU?=
 =?us-ascii?Q?fhsi7rqYezt0uc03qnw3rtCweeyswXOI/CWMc5uc7sBzEgFLbxw+NlLid6iA?=
 =?us-ascii?Q?gr7lUzhNt2TpzlQzL75/F0jEY1mgUCuTTEvpIMqNydPOsFU6xVQotjelALEP?=
 =?us-ascii?Q?6UwQJ8qr2tiYk2LPlu4Jt0FfWjw34PloVf9NwGhais7SUi1OXlgcUh6ZmfqS?=
 =?us-ascii?Q?+zD4yVeDe9PmZdgKlqIig6qCuUBj669m7GAQtKYXbDwzC6q+DVWyuGLo+/kf?=
 =?us-ascii?Q?UIDwBumjfzOshEjFNcFHaHVNI1cdtzhb?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FSBKDy5seEtglbQ5loGdkc+EzUdezGGekCGmBv/1CYi2UBYLnDkQrxAWutAD?=
 =?us-ascii?Q?gJ92YFg556IH8YgggOVQD0OJ1bmoonQf+x3qC/ut+Cxe6katz4GlbvQPXbfj?=
 =?us-ascii?Q?0Nxyd61NCev3V2zp4h0haNES5vDhNZ1Ozh8G9s71PJnn/yZZlQ2OP8VQGnvX?=
 =?us-ascii?Q?JUhvSXfE2Oyt0rq3Ww9J3EwNVFVxT4BzEaEd0gSEtbxfT0Q5/mOPhg/hBogT?=
 =?us-ascii?Q?Ed2wTQSS/VGqrYjPl+gSPqPRr+5q5ammDuUgTNsD82fbRFe9+4D7RwT31ijj?=
 =?us-ascii?Q?7ZzS5Na/OJH8i6EY5M4riiQGezJ1yg1e2FXf3xxabjqwNSiAtrQIIz4ar9zo?=
 =?us-ascii?Q?x5SeoYEJXOg61z2AI8GUz5K1WNb9inKcqEhhomeLXa4xxodnT/JXTa6RA1wq?=
 =?us-ascii?Q?KYHwfaashFgr9cUH+g3KdR26tm70eL2yH4IwidDARjiasFcubNymAXI606Bz?=
 =?us-ascii?Q?mbbvFAcxlZPEyWyphBInZNoNJ+QkJJnno4m1+uCgSNiE0SyA7r3ksVOohg6J?=
 =?us-ascii?Q?ZNZq0/LVHvJME+qQBQ8FRYND5Z48ApNMD0FS+rAMsZ+53iezu/d6i14M3E+2?=
 =?us-ascii?Q?aD3d95JHjoo/qkLdD8vs3gQ9SCZFjEz5ZXgCUcd1OzUkhYmRt9nk1yVKmfAw?=
 =?us-ascii?Q?7ZCOzXVYHve230TJHOlCY2drXT3FWpQkeSjIaVggjQP42MfkUcfhX4dfCbwF?=
 =?us-ascii?Q?NFvgClSDKYLP2IVEy3/GTbINE+jonZBItSKhgvnT9MuWNxHGgMUbRb2UZHc6?=
 =?us-ascii?Q?lm1he44h5Lvr89saZpU8ZnRTk8OlKh3Hrm0wk8VwtGRCnrdyUnAFM7lrrdYP?=
 =?us-ascii?Q?zePE1L7o6Yevi92oHk34pYdh8pRwnft//8kI7Al3i2cw/MItJrUm1zvi22Bg?=
 =?us-ascii?Q?EaS3qlXZClmBrywstjJWS2Ma7yXGp0I6XZwPLuD8YeXwvWwwSJyr3Nl5uOnk?=
 =?us-ascii?Q?AkNLo453+O4s/4CvascgjFO7w9GDRLBv7WJs0c8D3Nx38fJRoNCOB5W8Oo1S?=
 =?us-ascii?Q?fLJfRjkTZhGx+u+GkpvxhrcVhvs97cHp2W4DJrxmwX0eVKmpnxiCohdD2cCn?=
 =?us-ascii?Q?Hu1N1affoZw8V0dHnxdzevOj9e+ZVbVZN3SGCUVVpMvkmG9bqCeKLLp0cQ0z?=
 =?us-ascii?Q?2GVTL+JPXXrlSm1nYTiA5ErY1NiSVScqCIS9LG1Kb4srUJ/Op1kB5ouSDJGV?=
 =?us-ascii?Q?pzG/YXZ+QVLhcKe9NbmAw0A7utVnnYYs/E9lp/hFT1pKJzGINKJWGh+hDn7r?=
 =?us-ascii?Q?VUw7pEkedaL8UsxFv8FzaKe74WHIC58mDlth0/wgx6RlK3UOoBthWwGhncyf?=
 =?us-ascii?Q?SwSoZjBfeunx5+p4lnByV57s1cf7OrC4MaWlwVbEWz801pNlw0AN15sTlVI/?=
 =?us-ascii?Q?goI1MKn2dClkdy3xn+d2c9wA+4Dyx6a1Hu+Pf0deOhiy0wq0cQ3Jwbac3ccd?=
 =?us-ascii?Q?IGWLvJ16p7DgjPABJsCiK80+5fKCsL6BfippuHKzLsRDs53hFXZ1Pfz/3Bwy?=
 =?us-ascii?Q?wSt6Exni0nkzKxH/WUnhBPZiizLoP1CdodDP296SNm3hU2Mp65s6v5mVa5as?=
 =?us-ascii?Q?qohs+/1X9+2bezQ2ciFogMbvenIZj5jwzYM2FSv6xqqqpvP2BnGGOjwZoQmK?=
 =?us-ascii?Q?i7A+zPXCPqJQ9+qAAeE5Ug4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5991bf6-2d38-4138-32ca-08dd6867ae73
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:07.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7RubOU5WaRaVl5uvjxFsJ6R+5fMkaxq7c86DdXHqXdaqj3244isTQGqUJAaT0xjRhwGcx+XpUC6l/QBoFxROG/8NtfAKGZGqNQ4xBeCA5ooYitWJ/Ahps2a0UaYvuzp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18316

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3aeccbe08171b79f82fb802393a6324c7b732669 upstream.

Add clock and reset entries for Generic Timer (GTM), I2C Bus Interface
(RIIC), SD/MMC Host Interface (SDHI) and Watchdog Timer (WDT) IP blocks.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240828093822.162855-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 84 +++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  4 ++
 2 files changed, 88 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index 9722b810e027..3ee32db5c0af 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -25,16 +25,31 @@ enum clk_ids {
=20
 	/* PLL Clocks */
 	CLK_PLLCM33,
+	CLK_PLLCLN,
 	CLK_PLLDTY,
 	CLK_PLLCA55,
=20
 	/* Internal Core Clocks */
 	CLK_PLLCM33_DIV16,
+	CLK_PLLCLN_DIV2,
+	CLK_PLLCLN_DIV8,
+	CLK_PLLCLN_DIV16,
+	CLK_PLLDTY_ACPU,
+	CLK_PLLDTY_ACPU_DIV4,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
 };
=20
+static const struct clk_div_table dtable_2_64[] =3D {
+	{0, 2},
+	{1, 4},
+	{2, 8},
+	{3, 16},
+	{4, 64},
+	{0, 0},
+};
+
 static const struct cpg_core_clk r9a09g057_core_clks[] __initconst =3D {
 	/* External Clock Inputs */
 	DEF_INPUT("audio_extal", CLK_AUDIO_EXTAL),
@@ -43,23 +58,92 @@ static const struct cpg_core_clk r9a09g057_core_clks[] =
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
+	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
+	DEF_FIXED(".pllcln_div8", CLK_PLLCLN_DIV8, CLK_PLLCLN, 1, 8),
+	DEF_FIXED(".pllcln_div16", CLK_PLLCLN_DIV16, CLK_PLLCLN, 1, 16),
+
+	DEF_DDIV(".plldty_acpu", CLK_PLLDTY_ACPU, CLK_PLLDTY, CDDIV0_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
+
 	/* Core Clocks */
 	DEF_FIXED("sys_0_pclk", R9A09G057_SYS_0_PCLK, CLK_QEXTAL, 1, 1),
 	DEF_FIXED("iotop_0_shclk", R9A09G057_IOTOP_0_SHCLK, CLK_PLLCM33_DIV16, 1,=
 1),
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD("gtm_0_pclk",			CLK_PLLCM33_DIV16, 4, 3, 2, 3),
+	DEF_MOD("gtm_1_pclk",			CLK_PLLCM33_DIV16, 4, 4, 2, 4),
+	DEF_MOD("gtm_2_pclk",			CLK_PLLCLN_DIV16, 4, 5, 2, 5),
+	DEF_MOD("gtm_3_pclk",			CLK_PLLCLN_DIV16, 4, 6, 2, 6),
+	DEF_MOD("gtm_4_pclk",			CLK_PLLCLN_DIV16, 4, 7, 2, 7),
+	DEF_MOD("gtm_5_pclk",			CLK_PLLCLN_DIV16, 4, 8, 2, 8),
+	DEF_MOD("gtm_6_pclk",			CLK_PLLCLN_DIV16, 4, 9, 2, 9),
+	DEF_MOD("gtm_7_pclk",			CLK_PLLCLN_DIV16, 4, 10, 2, 10),
+	DEF_MOD("wdt_0_clkp",			CLK_PLLCM33_DIV16, 4, 11, 2, 11),
+	DEF_MOD("wdt_0_clk_loco",		CLK_QEXTAL, 4, 12, 2, 12),
+	DEF_MOD("wdt_1_clkp",			CLK_PLLCLN_DIV16, 4, 13, 2, 13),
+	DEF_MOD("wdt_1_clk_loco",		CLK_QEXTAL, 4, 14, 2, 14),
+	DEF_MOD("wdt_2_clkp",			CLK_PLLCLN_DIV16, 4, 15, 2, 15),
+	DEF_MOD("wdt_2_clk_loco",		CLK_QEXTAL, 5, 0, 2, 16),
+	DEF_MOD("wdt_3_clkp",			CLK_PLLCLN_DIV16, 5, 1, 2, 17),
+	DEF_MOD("wdt_3_clk_loco",		CLK_QEXTAL, 5, 2, 2, 18),
 	DEF_MOD("scif_0_clk_pck",		CLK_PLLCM33_DIV16, 8, 15, 4, 15),
+	DEF_MOD("riic_8_ckm",			CLK_PLLCM33_DIV16, 9, 3, 4, 19),
+	DEF_MOD("riic_0_ckm",			CLK_PLLCLN_DIV16, 9, 4, 4, 20),
+	DEF_MOD("riic_1_ckm",			CLK_PLLCLN_DIV16, 9, 5, 4, 21),
+	DEF_MOD("riic_2_ckm",			CLK_PLLCLN_DIV16, 9, 6, 4, 22),
+	DEF_MOD("riic_3_ckm",			CLK_PLLCLN_DIV16, 9, 7, 4, 23),
+	DEF_MOD("riic_4_ckm",			CLK_PLLCLN_DIV16, 9, 8, 4, 24),
+	DEF_MOD("riic_5_ckm",			CLK_PLLCLN_DIV16, 9, 9, 4, 25),
+	DEF_MOD("riic_6_ckm",			CLK_PLLCLN_DIV16, 9, 10, 4, 26),
+	DEF_MOD("riic_7_ckm",			CLK_PLLCLN_DIV16, 9, 11, 4, 27),
+	DEF_MOD("sdhi_0_imclk",			CLK_PLLCLN_DIV8, 10, 3, 5, 3),
+	DEF_MOD("sdhi_0_imclk2",		CLK_PLLCLN_DIV8, 10, 4, 5, 4),
+	DEF_MOD("sdhi_0_clk_hs",		CLK_PLLCLN_DIV2, 10, 5, 5, 5),
+	DEF_MOD("sdhi_0_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 6, 5, 6),
+	DEF_MOD("sdhi_1_imclk",			CLK_PLLCLN_DIV8, 10, 7, 5, 7),
+	DEF_MOD("sdhi_1_imclk2",		CLK_PLLCLN_DIV8, 10, 8, 5, 8),
+	DEF_MOD("sdhi_1_clk_hs",		CLK_PLLCLN_DIV2, 10, 9, 5, 9),
+	DEF_MOD("sdhi_1_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 10, 5, 10),
+	DEF_MOD("sdhi_2_imclk",			CLK_PLLCLN_DIV8, 10, 11, 5, 11),
+	DEF_MOD("sdhi_2_imclk2",		CLK_PLLCLN_DIV8, 10, 12, 5, 12),
+	DEF_MOD("sdhi_2_clk_hs",		CLK_PLLCLN_DIV2, 10, 13, 5, 13),
+	DEF_MOD("sdhi_2_aclk",			CLK_PLLDTY_ACPU_DIV4, 10, 14, 5, 14),
 };
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
+	DEF_RST(6, 13, 2, 30),		/* GTM_0_PRESETZ */
+	DEF_RST(6, 14, 2, 31),		/* GTM_1_PRESETZ */
+	DEF_RST(6, 15, 3, 0),		/* GTM_2_PRESETZ */
+	DEF_RST(7, 0, 3, 1),		/* GTM_3_PRESETZ */
+	DEF_RST(7, 1, 3, 2),		/* GTM_4_PRESETZ */
+	DEF_RST(7, 2, 3, 3),		/* GTM_5_PRESETZ */
+	DEF_RST(7, 3, 3, 4),		/* GTM_6_PRESETZ */
+	DEF_RST(7, 4, 3, 5),		/* GTM_7_PRESETZ */
+	DEF_RST(7, 5, 3, 6),		/* WDT_0_RESET */
+	DEF_RST(7, 6, 3, 7),		/* WDT_1_RESET */
+	DEF_RST(7, 7, 3, 8),		/* WDT_2_RESET */
+	DEF_RST(7, 8, 3, 9),		/* WDT_3_RESET */
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
+	DEF_RST(10, 7, 4, 24),		/* SDHI_0_IXRST */
+	DEF_RST(10, 8, 4, 25),		/* SDHI_1_IXRST */
+	DEF_RST(10, 9, 4, 26),		/* SDHI_2_IXRST */
 };
=20
 const struct rzv2h_cpg_info r9a09g057_cpg_info __initconst =3D {
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 99bc08bd7cc1..60016b6122a9 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -31,6 +31,10 @@ struct ddiv {
 		.monbit =3D _monbit \
 	})
=20
+#define CPG_CDDIV0		(0x400)
+
+#define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
+
 /**
  * Definitions of CPG Core Clocks
  *
--=20
2.43.0


