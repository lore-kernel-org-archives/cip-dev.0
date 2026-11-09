Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4589.1794226534190972973
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:34 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZTtPARoM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.48, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z2zc/979jiLKbZqU2q/VZjzCmUEKCG/OV7i7ZVJieYMzs0yyq9woWspkexz8vhyMuwDIrEh2ntuklYT5WpEWZpSaRI3k1NKGslY72QqrS+AApVQfWD9icT3wlWpqozFL+QmfSvI4ntRqQmdq/IVZ1tEEqCz2nDBbHgUSw7n6EErm9u8oZ6IPxGgG/KieN6LKgCjUbBtj3AJO19RgRfnACRNXeGTsmWm40hyNXrxJmL3OoOGr6hIWgI8TKac6LK1LHTpxeEYz+UajLcfp1ePhhl+Ie51b4OkaR8+ZW2DoDPw7QjlayzL9q5efPhpzJmfGcOpIv4xVY/r/lhoA2RZiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjDhomcz07JGvBncQR60C1c1z4doMyShIGfPodlqVYI=;
 b=jmR8gYE24ojv/Xze7KU1BVdHDMUK8/2108kiJd+ncenBPnrKaVAxZSrY7TY+OOCWUatn1TbnfTCBqhbm9Mm7LK2A6Eqvd+1lTg7AWhd6Zvz7Sxf7fq8aKGfDYR6fjaPQfL0JruTbthe5Zt2R0mWhyvevgwNTVxB4EqRTW4xKcJ/Jg3bgp35k9dpHN6xr50Vzq4SVoQfJFhd9UUUe5kihaabsk3OthyXTWa1gJmpWhjPA6JIOw4acN3XMwjPVewUDWoSjk5sXc2hZXK5q01DeXWc8+5scrDBsXTA76LuR54OQfJS0HBcLaA4FsOQBEWUVfTy/588el4xytVegqjRl+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjDhomcz07JGvBncQR60C1c1z4doMyShIGfPodlqVYI=;
 b=ZTtPARoMQbnrFO2SYOFe7moKFUtEIBX7AcWdtmM1c2NLPciaq1HAUOl/hujFCGuE3LW7/MAOYmE4Ftw9XIJCrEc1IIE7gtgjrtb+x6oauIaxEnhTHluZ4FSgmUmbHMNPmp3sDjTS8PhnRA34jORp7XFsR09A9rh7O8DcThw3b2Y=
Received: from TY4P286CA0110.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:380::19)
 by TYRPR01MB13611.jpnprd01.prod.outlook.com (2603:1096:405:18c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 12:15:24 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380:cafe::5e) by TY4P286CA0110.outlook.office365.com
 (2603:1096:405:380::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:24 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id C1BED300028E;
	Mon,  9 Nov 2026 21:15:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/24] clk: renesas: r9a09g077: Add LCDC and PLL3 clock support for RZ/T2H display pipeline
Date: Mon,  9 Nov 2026 12:14:45 +0000
Message-ID: <20261109121451.6042-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYRPR01MB13611:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c970a4e-02a0-4423-5c33-08df3e5b21ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|6133799003|3023799007|10067099003|261026140227099003|56012099006|11063799006|5023799004|261102123227099003|261102130727099003|261028144727099003|261022105027099003|261021121427099003|261009223327099003|261009223027099003|261026121527099003|261022075727099003|261009220027099003|261009221727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: 2UUAihPqXSE6fEkM2aDasV9Dk0OaMCwN29sfnDtsaaiuAfaX9WYymfyKJbVOFeRlzvxdumLsNfYPFWfV+C1OD2HHXpiUG4HVAH0NfIAsPgXwMZoGdS8XNopr7eFXAnfXOxJQKVM7w8gRYNnjntK5MHSv/dBQ6wK9LZqgi0SQbOffuWhMMr6bdnWm89IgP7aE+rwLe2BoZXppMuqXMKxFnR/yYkp1TTHY1k7u3dEr5vXxhi4e2ljSOLR5SDlUursxd+Njdz13kKC/5/C4o7+69r5bx7wkqd2nWcf64sXQpISjx41zl0hWWvfXPRYROVznqGTJmAfnWnrdtiEbCxKyUWEa0Ix9DKbLpB2r8+2XWfn1MsBqsFJfnwzr6bZKNzc17Q9QbvFGj6ibE74kK6qVKQHJ3c6MvmRBDWOI/Zq37F5AV9nDZOaMDIvTPrr3sXiun8pPpNJ5rb4Ky2Dy5ICT+GKm2Rjdzet0sgayIH0+mvShc822BEgjykcDH75fC5/dHHALh8qM4CBykGyzoAD3vhpAkSWhUtVHhjnrsirMhdUKwu1IZT8DYOfM5GAlAN2qCLOQf2wRVEYGkSf0ZtEwTSprtMr/k/8xOgIaAilrQCvKmM9s0yisyJuSdPCrU9oZ6l/LFLg7oSQlir84JLwNz1QCmIXX4n34MNx8a6lWArI=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(3023799007)(10067099003)(261026140227099003)(56012099006)(11063799006)(5023799004)(261102123227099003)(261102130727099003)(261028144727099003)(261022105027099003)(261021121427099003)(261009223327099003)(261009223027099003)(261026121527099003)(261022075727099003)(261009220027099003)(261009221727099003)(261009221227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 61LoAbL2W07y46QV/3YyBYl0JXThGhSaeQcTZSJxFwmk8vkgAaYIv4tfl4NDwDTxIQbRHvca0Y90v9+lhupeFM4flCIiznKeWoWhCRmcdY80sMq8k1AaCEsW+5EphaVgTacqPM+OknX/bBaRytewWz8InJVAs+YcCPka9MKw2QACfrM//t5LRQatERUuErIKUtD+1fWe6NqjqvfM4YMxiFOCa8pWAPdITK0PhJ0kdzhzHN5iHa3qKqyA2npg6nHrtV2U7/xjkybu1nTcXVPXGEGUaZ4pv84w2dzrq7Ta70R+sxV4KhmLaXfassekhxi62ZdA0XcKi/UvC6LdTzLVj+xK9+7lMdC5p7sGqmGD6ZWqvP9vroIUb8JzusWQIX90B5z1K+woLy7WPBujfF8yx3vxVgYdQrEnBKLYv0iv3UCtsK1+M6upHocvFmw5FtX2
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:24.1673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c970a4e-02a0-4423-5c33-08df3e5b21ef
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24724
Content-Type: text/plain; charset="utf-8"

commit 6745ca5d95040ddfd3669c27d90b8b1bb126a75f upstream.

Add the clock definitions and PLL logic required to supply the LCDC
(VSPD/FCPVD/DU) blocks on the RZ/T2H (R9A09G077) SoC. The RZ/T2H display
subsystem depends on a dedicated PLL (PLL3) and a set of new derived
clocks.

Introduce a new PLL clock type and implement rate recalculation,
programming and locking sequences for PLL3 using the RZ/T2H specific
divider and VCO limits. Add the corresponding muxes and divider entries,
expose the LCDC core clock, and register the LCDC module clock using the
correct PCLK parent.

This enables the RZ/T2H clock driver to generate the display pipeline
clocking tree needed by the DU and VSP-based composition engines, allowing
upcoming display support to be integrated without duplicating CPG logic.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260618181949.3036280-6-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   2 +
 drivers/clk/renesas/r9a09g077-cpg.c | 371 ++++++++++++++++++++++++++++
 2 files changed, 373 insertions(+)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 7659550b85661..5c0238e878b70 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -218,10 +218,12 @@ config CLK_R9A09G057
 config CLK_R9A09G077
 	bool "RZ/T2H clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSSR
+	select CLK_RZV2H_CPG_LIB
=20
 config CLK_R9A09G087
 	bool "RZ/N2H clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSSR
+	select CLK_RZV2H_CPG_LIB
=20
 config CLK_SH73A0
 	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a0=
9g077-cpg.c
index ceb48f9a6ab67..bf632fe55b4c2 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -8,16 +8,23 @@
=20
 #include <linux/bitfield.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/renesas.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
+#include <linux/module.h>
 #include <linux/types.h>
+#include <linux/units.h>
=20
 #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
 #include <dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h>
 #include "renesas-cpg-mssr.h"
=20
+MODULE_IMPORT_NS("RZV2H_CPG");
+
 #define RZT2H_REG_BLOCK_SHIFT	11
 #define RZT2H_REG_OFFSET_MASK	GENMASK(10, 0)
 #define RZT2H_REG_CONF(block, offset)	(((block) << RZT2H_REG_BLOCK_SHIFT) =
| \
@@ -66,11 +73,26 @@
 #define DIVSCI2ASYNC	CONF_PACK(SCKCR3, 10, 2)
 #define DIVSCI3ASYNC	CONF_PACK(SCKCR3, 12, 2)
 #define DIVSCI4ASYNC	CONF_PACK(SCKCR3, 14, 2)
+#define LCDCDIVSEL	CONF_PACK(SCKCR3, 20, 4)
+
+#define PLL3EN		FIELD_PREP_CONST(OFFSET_MASK, (0xc0))
+
+#define CPG_PLL_EN_EN		BIT(0)
+#define CPG_PLL3_VCO_CTR0(x)	((x) + 0x4)
+#define CPG_PLL3_VCO_CTR0_PDIV	GENMASK(21, 16)
+#define CPG_PLL3_VCO_CTR0_MDIV	GENMASK(9, 0)
+#define CPG_PLL3_VCO_CTR1(x)	((x) + 0x8)
+#define CPG_PLL3_VCO_CTR1_KDIV	GENMASK(31, 16)
+#define CPG_PLL3_VCO_CTR1_SDIV	GENMASK(2, 0)
+#define CPG_PLL_MON(x)		((x) - 0x10)
+#define CPG_PLL_MON_LOCK	BIT(0)
=20
 enum rzt2h_clk_types {
 	CLK_TYPE_RZT2H_DIV =3D CLK_TYPE_CUSTOM,	/* Clock with divider */
 	CLK_TYPE_RZT2H_MUX,			/* Clock with clock source selector */
 	CLK_TYPE_RZT2H_FSELXSPI,		/* Clock with FSELXSPIn source selector */
+	CLK_TYPE_RZT2H_PLL3,			/* PLL3 Clock */
+	CLK_TYPE_RZT2H_LCDCDIV,			/* LCDC divider clock */
 };
=20
 #define DEF_DIV(_name, _id, _parent, _conf, _dtable) \
@@ -83,6 +105,47 @@ enum rzt2h_clk_types {
 #define DEF_DIV_FSELXSPI(_name, _id, _parent, _conf, _dtable) \
 	DEF_TYPE(_name, _id, CLK_TYPE_RZT2H_FSELXSPI, .conf =3D _conf, \
 		 .parent =3D _parent, .dtable =3D _dtable, .flag =3D 0)
+#define DEF_PLL3(_name, _id, _parent, _conf) \
+	DEF_TYPE(_name, _id, CLK_TYPE_RZT2H_PLL3, .conf =3D _conf, \
+		 .parent =3D _parent)
+#define DEF_DIV_LCDC(_name, _id, _parent, _conf, _dtable) \
+	DEF_TYPE(_name, _id, CLK_TYPE_RZT2H_LCDCDIV, .conf =3D _conf, \
+		 .parent =3D _parent, .dtable =3D _dtable, .flag =3D CLK_SET_RATE_PARENT=
)
+
+struct pll_clk {
+	void __iomem *reg;
+	const struct rzv2h_pll_limits *limits;
+	struct device *dev;
+	struct rzv2h_pll_pars pll_parameters;
+	struct clk_hw hw;
+	unsigned long cur_rate;
+};
+
+#define to_pll(_hw)	container_of(_hw, struct pll_clk, hw)
+
+struct r9a09g077_lcdc_div_clk {
+	const struct clk_div_table *dtable;
+	void __iomem *reg;
+	struct device *dev;
+	struct clk_hw hw;
+	u32 conf;
+	u8 divider;
+};
+
+#define to_lcdc_div_clk(_hw) \
+	container_of(_hw, struct r9a09g077_lcdc_div_clk, hw)
+
+#define RZT2H_MAX_LCDC_DIV_TABLES	16
+
+static const struct rzv2h_pll_limits r9a09g077_cpg_pll3_limits =3D {
+	.input_fref =3D 48 * MEGA,
+	.fout =3D { .min =3D 25 * MEGA, .max =3D 430 * MEGA },
+	.fvco =3D { .min =3D 1600 * MEGA, .max =3D 3200 * MEGA },
+	.m =3D { .min =3D 0x40, .max =3D 0x3ff },
+	.p =3D { .min =3D 0x2, .max =3D 0x8 },
+	.s =3D { .min =3D 0x0, .max =3D 0x6 },
+	.k =3D { .min =3D -32768, .max =3D 32767 },
+};
=20
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
@@ -96,10 +159,12 @@ enum clk_ids {
 	CLK_PLL0,
 	CLK_PLL1,
 	CLK_PLL2,
+	CLK_PLL3,
 	CLK_PLL4,
 	CLK_SEL_CLK_PLL0,
 	CLK_SEL_CLK_PLL1,
 	CLK_SEL_CLK_PLL2,
+	CLK_SEL_CLK_PLL3,
 	CLK_SEL_CLK_PLL4,
 	CLK_PLL4D1,
 	CLK_PLL4D1_DIV3,
@@ -107,6 +172,7 @@ enum clk_ids {
 	CLK_PLL4D3,
 	CLK_PLL4D3_DIV10,
 	CLK_PLL4D3_DIV20,
+	CLK_PLL4D50,
 	CLK_SCI0ASYNC,
 	CLK_SCI1ASYNC,
 	CLK_SCI2ASYNC,
@@ -119,6 +185,7 @@ enum clk_ids {
 	CLK_SPI3ASYNC,
 	CLK_DIVSELXSPI0_SCKCR,
 	CLK_DIVSELXSPI1_SCKCR,
+	CLK_LCDDIVSEL,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -130,6 +197,26 @@ static const struct clk_div_table dtable_1_2[] =3D {
 	{0, 0},
 };
=20
+static const struct clk_div_table dtable_2_32[] =3D {
+	{0, 2},
+	{1, 4},
+	{2, 6},
+	{3, 8},
+	{4, 10},
+	{5, 12},
+	{6, 14},
+	{7, 16},
+	{8, 18},
+	{9, 20},
+	{10, 22},
+	{11, 24},
+	{12, 26},
+	{13, 28},
+	{14, 30},
+	{15, 32},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_6_8_16_32_64[] =3D {
 	{6, 64},
 	{5, 32},
@@ -152,6 +239,7 @@ static const struct clk_div_table dtable_24_25_30_32[] =
=3D {
 static const char * const sel_clk_pll0[] =3D { ".loco", ".pll0" };
 static const char * const sel_clk_pll1[] =3D { ".loco", ".pll1" };
 static const char * const sel_clk_pll2[] =3D { ".loco", ".pll2" };
+static const char * const sel_clk_pll3[] =3D { ".loco", ".pll3" };
 static const char * const sel_clk_pll4[] =3D { ".loco", ".pll4" };
 static const char * const sel_clk_pll4d1_div3_div4[] =3D { ".pll4d1_div3",=
 ".pll4d1_div4" };
 static const char * const sel_clk_pll4d3_div10_div20[] =3D { ".pll4d3_div1=
0", ".pll4d3_div20" };
@@ -173,10 +261,14 @@ static const struct cpg_core_clk r9a09g077_core_clks[=
] __initconst =3D {
 		sel_clk_pll1, ARRAY_SIZE(sel_clk_pll1), CLK_MUX_READ_ONLY),
 	DEF_MUX(".sel_clk_pll2", CLK_SEL_CLK_PLL2, SEL_PLL,
 		sel_clk_pll2, ARRAY_SIZE(sel_clk_pll2), CLK_MUX_READ_ONLY),
+	DEF_MUX(".sel_clk_pll3", CLK_SEL_CLK_PLL3, SEL_PLL,
+		sel_clk_pll3, ARRAY_SIZE(sel_clk_pll3), CLK_MUX_READ_ONLY),
 	DEF_MUX(".sel_clk_pll4", CLK_SEL_CLK_PLL4, SEL_PLL,
 		sel_clk_pll4, ARRAY_SIZE(sel_clk_pll4), CLK_MUX_READ_ONLY),
=20
 	DEF_FIXED(".pll4d1", CLK_PLL4D1, CLK_SEL_CLK_PLL4, 1, 1),
+	DEF_FIXED(".pll4d50", CLK_PLL4D50, CLK_SEL_CLK_PLL4, 50, 1),
+	DEF_PLL3(".pll3", CLK_PLL3, CLK_PLL4D50, PLL3EN),
 	DEF_FIXED(".pll4d1_div3", CLK_PLL4D1_DIV3, CLK_PLL4D1, 3, 1),
 	DEF_FIXED(".pll4d1_div4", CLK_PLL4D1_DIV4, CLK_PLL4D1, 4, 1),
 	DEF_FIXED(".pll4d3", CLK_PLL4D3, CLK_SEL_CLK_PLL4, 3, 1),
@@ -228,6 +320,7 @@ static const struct cpg_core_clk r9a09g077_core_clks[] =
__initconst =3D {
 	DEF_FIXED("PCLKL", R9A09G077_CLK_PCLKL, CLK_SEL_CLK_PLL1, 16, 1),
 	DEF_FIXED("PCLKAH", R9A09G077_CLK_PCLKAH, CLK_PLL4D1, 6, 1),
 	DEF_FIXED("PCLKAM", R9A09G077_CLK_PCLKAM, CLK_PLL4D1, 12, 1),
+	DEF_FIXED("PCLKAL", R9A09G077_CLK_PCLKAL, CLK_PLL4D1, 24, 1),
 	DEF_FIXED("SDHI_CLKHS", R9A09G077_SDHI_CLKHS, CLK_SEL_CLK_PLL2, 1, 1),
 	DEF_FIXED("USB_CLK", R9A09G077_USB_CLK, CLK_PLL4D1, 48, 1),
 	DEF_FIXED("ETCLKA", R9A09G077_ETCLKA, CLK_SEL_CLK_PLL1, 5, 1),
@@ -241,6 +334,8 @@ static const struct cpg_core_clk r9a09g077_core_clks[] =
__initconst =3D {
 			 FSELXSPI1, dtable_6_8_16_32_64),
 	DEF_MUX("PCLKCAN", R9A09G077_PCLKCAN, FSELCANFD,
 		sel_clk_pll4d3_div10_div20, ARRAY_SIZE(sel_clk_pll4d3_div10_div20), 0),
+	DEF_DIV_LCDC("LCDC_CLKD", R9A09G077_LCDC_CLKD, CLK_SEL_CLK_PLL3, LCDCDIVS=
EL,
+		     dtable_2_32),
 	DEF_FIXED("PCLKRTC", R9A09G077_PCLKRTC, CLK_EXTAL, 128, 1),
 };
=20
@@ -272,6 +367,7 @@ static const struct mssr_mod_clk r9a09g077_mod_clks[] _=
_initconst =3D {
 	DEF_MOD("iic2", 601, R9A09G077_CLK_PCLKL),
 	DEF_MOD("spi3", 602, CLK_SPI3ASYNC),
 	DEF_MOD("rtc", 605, R9A09G077_CLK_PCLKL),
+	DEF_MOD("lcdc", 1204, R9A09G077_CLK_PCLKAL),
 	DEF_MOD("sdhi0", 1212, R9A09G077_CLK_PCLKAM),
 	DEF_MOD("sdhi1", 1213, R9A09G077_CLK_PCLKAM),
 };
@@ -481,6 +577,276 @@ r9a09g077_cpg_fselxspi_div_clk_register(struct device=
 *dev,
 	return hw->clk;
 }
=20
+static unsigned long r9a09g077_cpg_pll3_clk_recalc_rate(struct clk_hw *hw,
+							unsigned long parent_rate)
+{
+	struct pll_clk *pll_clk =3D to_pll(hw);
+	u32 ctr0, ctr1;
+	u8 pdiv, sdiv;
+	u64 rate;
+	u16 mdiv;
+	s16 kdiv;
+
+	ctr0 =3D readl(CPG_PLL3_VCO_CTR0(pll_clk->reg));
+	ctr1 =3D readl(CPG_PLL3_VCO_CTR1(pll_clk->reg));
+
+	pdiv =3D FIELD_GET(CPG_PLL3_VCO_CTR0_PDIV, ctr0);
+	mdiv =3D FIELD_GET(CPG_PLL3_VCO_CTR0_MDIV, ctr0);
+	kdiv =3D (s16)FIELD_GET(CPG_PLL3_VCO_CTR1_KDIV, ctr1);
+	sdiv =3D FIELD_GET(CPG_PLL3_VCO_CTR1_SDIV, ctr1);
+
+	rate =3D mul_u64_u32_shr(parent_rate, (mdiv << 16) + kdiv, 16 + sdiv);
+
+	return DIV_ROUND_CLOSEST_ULL(rate, pdiv);
+}
+
+static int r9a09g077_cpg_pll3_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	struct pll_clk *pll_clk =3D to_pll(hw);
+	u64 rate_millihz;
+
+	if (req->rate =3D=3D pll_clk->cur_rate)
+		return 0;
+
+	rate_millihz =3D mul_u32_u32(req->rate, MILLI);
+	if (!rzv2h_cpg_get_pll_pars(pll_clk->limits, &pll_clk->pll_parameters,
+				    rate_millihz)) {
+		dev_dbg(pll_clk->dev,
+			"failed to determine rate for req->rate: %lu\n",
+			req->rate);
+		return -EINVAL;
+	}
+	req->rate =3D DIV_ROUND_CLOSEST_ULL(pll_clk->pll_parameters.freq_millihz,=
 MILLI);
+	pll_clk->cur_rate =3D req->rate;
+
+	return 0;
+}
+
+static int r9a09g077_cpg_pll3_set_rate(struct clk_hw *hw, unsigned long ra=
te,
+				       unsigned long parent_rate)
+{
+	struct pll_clk *pll_clk =3D to_pll(hw);
+	struct rzv2h_pll_pars *params =3D &pll_clk->pll_parameters;
+	void __iomem *offset =3D pll_clk->reg;
+	u32 val;
+	int ret;
+
+	/* Put PLL into standby mode */
+	writel(0, offset);
+	ret =3D readl_poll_timeout_atomic(CPG_PLL_MON(offset),
+					val, !(val & CPG_PLL_MON_LOCK),
+					100, 2000);
+	if (ret) {
+		dev_err(pll_clk->dev, "Failed to put PLL into standby mode");
+		return ret;
+	}
+
+	/* Output clock setting 1 */
+	val =3D readl(CPG_PLL3_VCO_CTR0(offset));
+	FIELD_MODIFY(CPG_PLL3_VCO_CTR0_MDIV, &val, params->m);
+	FIELD_MODIFY(CPG_PLL3_VCO_CTR0_PDIV, &val, params->p);
+	writel(val, CPG_PLL3_VCO_CTR0(offset));
+
+	/* Output clock setting 2 */
+	val =3D readl(CPG_PLL3_VCO_CTR1(offset));
+	FIELD_MODIFY(CPG_PLL3_VCO_CTR1_KDIV, &val, params->k);
+	FIELD_MODIFY(CPG_PLL3_VCO_CTR1_SDIV, &val, params->s);
+	writel(val, CPG_PLL3_VCO_CTR1(offset));
+
+	writel(CPG_PLL_EN_EN, offset);
+
+	/* PLL normal mode transition, output clock stability check */
+	ret =3D readl_poll_timeout_atomic(CPG_PLL_MON(offset),
+					val, (val & CPG_PLL_MON_LOCK),
+					100, 2000);
+	if (ret) {
+		writel(0, offset);
+		dev_err(pll_clk->dev, "Failed to put PLL into normal mode");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct clk_ops r9a09g077_cpg_pll3_ops =3D {
+	.recalc_rate =3D r9a09g077_cpg_pll3_clk_recalc_rate,
+	.determine_rate =3D r9a09g077_cpg_pll3_determine_rate,
+	.set_rate =3D r9a09g077_cpg_pll3_set_rate,
+};
+
+static struct clk * __init
+r9a09g077_cpg_pll3_clk_register(struct device *dev,
+				const struct cpg_core_clk *core,
+				void __iomem *addr,
+				struct cpg_mssr_pub *pub,
+				const struct rzv2h_pll_limits *limits)
+{
+	struct clk_init_data init =3D {};
+	const struct clk *parent;
+	const char *parent_name;
+	struct pll_clk *pll_clk;
+	int ret;
+
+	parent =3D pub->clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	pll_clk =3D devm_kzalloc(dev, sizeof(*pll_clk), GFP_KERNEL);
+	if (!pll_clk)
+		return ERR_PTR(-ENOMEM);
+
+	parent_name =3D __clk_get_name(parent);
+	init.name =3D core->name;
+	init.ops =3D &r9a09g077_cpg_pll3_ops;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	pll_clk->dev =3D dev;
+	pll_clk->hw.init =3D &init;
+	pll_clk->reg =3D addr;
+	pll_clk->limits =3D limits;
+
+	ret =3D devm_clk_hw_register(dev, &pll_clk->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return pll_clk->hw.clk;
+}
+
+static int r9a09g077_cpg_lcdc_div_determine_rate(struct clk_hw *hw,
+						 struct clk_rate_request *req)
+{
+	struct r9a09g077_lcdc_div_clk *dsi_div =3D to_lcdc_div_clk(hw);
+	struct clk_hw *mux_hw =3D clk_hw_get_parent(hw);
+	u8 table[RZT2H_MAX_LCDC_DIV_TABLES] =3D { 0 };
+	struct rzv2h_pll_div_pars dsi_params;
+	const struct clk_div_table *div;
+	struct pll_clk *pll_clk;
+	unsigned int i =3D 0;
+	u64 freq_millihz;
+
+	/* index 1 is always .pll3 in sel_clk_pll3[] */
+	pll_clk =3D to_pll(clk_hw_get_parent_by_index(mux_hw, 1));
+
+	for (div =3D dsi_div->dtable; div->div; div++) {
+		if (i >=3D RZT2H_MAX_LCDC_DIV_TABLES)
+			return -EINVAL;
+		table[i++] =3D div->div;
+	}
+
+	freq_millihz =3D mul_u32_u32(req->rate, MILLI);
+
+	if (!rzv2h_cpg_get_pll_divs_pars(pll_clk->limits, &dsi_params, table,
+					 i, freq_millihz)) {
+		dev_err(dsi_div->dev,
+			"LCDC divider failed to determine rate for req->rate: %lu\n",
+			req->rate);
+		return -EINVAL;
+	}
+
+	req->rate =3D DIV_ROUND_CLOSEST_ULL(dsi_params.div.freq_millihz, MILLI);
+	req->best_parent_rate =3D req->rate * dsi_params.div.divider_value;
+	dsi_div->divider =3D dsi_params.div.divider_value;
+	pll_clk->cur_rate =3D req->best_parent_rate;
+	pll_clk->pll_parameters =3D dsi_params.pll;
+
+	return 0;
+}
+
+static int r9a09g077_cpg_lcdc_div_set_rate(struct clk_hw *hw,
+					   unsigned long rate,
+					   unsigned long parent_rate)
+{
+	struct r9a09g077_lcdc_div_clk *dsi_div =3D to_lcdc_div_clk(hw);
+	const struct clk_div_table *clkt;
+	bool divider_found =3D false;
+	u32 val, shift;
+
+	for (clkt =3D dsi_div->dtable; clkt->div; clkt++) {
+		if (clkt->div =3D=3D dsi_div->divider) {
+			divider_found =3D true;
+			break;
+		}
+	}
+
+	if (!divider_found)
+		return -EINVAL;
+
+	shift =3D GET_SHIFT(dsi_div->conf);
+	val =3D readl(dsi_div->reg);
+	val &=3D ~(clk_div_mask(GET_WIDTH(dsi_div->conf)) << shift);
+	val |=3D clkt->val << shift;
+	writel(val, dsi_div->reg);
+
+	return 0;
+}
+
+static unsigned long
+r9a09g077_cpg_lcdc_div_recalc_rate(struct clk_hw *hw,
+				   unsigned long parent_rate)
+{
+	struct r9a09g077_lcdc_div_clk *dsi_div =3D to_lcdc_div_clk(hw);
+	u32 div;
+
+	div =3D readl(dsi_div->reg);
+	div >>=3D GET_SHIFT(dsi_div->conf);
+	div &=3D clk_div_mask(GET_WIDTH(dsi_div->conf));
+	div =3D dsi_div->dtable[div].div;
+
+	return DIV_ROUND_CLOSEST_ULL(parent_rate, div);
+}
+
+static const struct clk_ops r9a09g077_cpg_lcdc_div_ops =3D {
+	.recalc_rate =3D r9a09g077_cpg_lcdc_div_recalc_rate,
+	.determine_rate =3D r9a09g077_cpg_lcdc_div_determine_rate,
+	.set_rate =3D r9a09g077_cpg_lcdc_div_set_rate,
+};
+
+static struct clk * __init
+r9a09g077_cpg_lcdc_div_clk_register(struct device *dev,
+				    const struct cpg_core_clk *core,
+				    void __iomem *addr,
+				    struct cpg_mssr_pub *pub)
+{
+	struct r9a09g077_lcdc_div_clk *clk_hw_data;
+	struct clk_init_data init =3D {};
+	struct clk **clks =3D pub->clks;
+	const struct clk *parent;
+	const char *parent_name;
+	struct clk_hw *hw;
+	int ret;
+
+	parent =3D clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	clk_hw_data =3D devm_kzalloc(dev, sizeof(*clk_hw_data), GFP_KERNEL);
+	if (!clk_hw_data)
+		return ERR_PTR(-ENOMEM);
+
+	clk_hw_data->dtable =3D core->dtable;
+	clk_hw_data->reg =3D addr;
+	clk_hw_data->conf =3D core->conf;
+	clk_hw_data->dev =3D dev;
+	clk_hw_data->divider =3D 32; /* Initialize divider for LCDC */
+
+	parent_name =3D __clk_get_name(parent);
+	init.name =3D core->name;
+	init.ops =3D &r9a09g077_cpg_lcdc_div_ops;
+	init.flags =3D core->flag;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	hw =3D &clk_hw_data->hw;
+	hw->init =3D &init;
+	ret =3D devm_clk_hw_register(dev, hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return hw->clk;
+}
+
 static struct clk * __init
 r9a09g077_cpg_clk_register(struct device *dev, const struct cpg_core_clk *=
core,
 			   const struct cpg_mssr_info *info,
@@ -497,6 +863,11 @@ r9a09g077_cpg_clk_register(struct device *dev, const s=
truct cpg_core_clk *core,
 		return r9a09g077_cpg_mux_clk_register(dev, core, addr, pub);
 	case CLK_TYPE_RZT2H_FSELXSPI:
 		return r9a09g077_cpg_fselxspi_div_clk_register(dev, core, addr, pub);
+	case CLK_TYPE_RZT2H_PLL3:
+		return r9a09g077_cpg_pll3_clk_register(dev, core, pub->base1 + offset,
+						       pub, &r9a09g077_cpg_pll3_limits);
+	case CLK_TYPE_RZT2H_LCDCDIV:
+		return r9a09g077_cpg_lcdc_div_clk_register(dev, core, addr, pub);
 	default:
 		return ERR_PTR(-EINVAL);
 	}
--=20
2.43.0

