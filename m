Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1820AC44502
	for <webhook@archiver.kernel.org>; Mon,  6 Jul 2026 18:23:44 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.156742.1783362222188156287
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Jul 2026 11:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KULwWDOj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.46, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ6lQjhBKaFpz5oT5bCmz4abX2ezqoMyUXlSWfCHxqB7moet5eJ7/ECZpwgTIx3QmJDGUXVMbwV14dB3fwqmWIiYBKP6Yh8CKLcFc4iZIwTZ/becduSTGdOecY4aiL/akqsBmzjKqms5KHvzlKynIOXSfs6ygh8mZy2nJFb4FQk536bUaxJ+xWESKsnFGGHxNlfbCkgfr25fBjSHED4oNHFfG2PCT2bq0rYHJB09wt9nX5reEBmrNBw5phZwTPSHoAW1wNQd+lXPr6YSZk71p/U3Umua/NhWLZGiaUoON4+BMK85o0BjMv18btUPe9LpqGNtDRJF/ppPstaACJeTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2NEb1SUtGCRUjGPgeSQHI0iXcD3P5cbN8CTrkjNKfM=;
 b=En8b+DYBqW/3woOL+AVeW2dI/sDtBNFpnWLwMut8tfrfQYIrIM3oNUo9B4WVxsNA1nGTmY3AMsfOCUrVdyoIOX09t/FNqcV/4mIdsJ8tEO0XJfj+xb1Xx+r8tFQ0/Bz8vUfAaspkIQUpUbGPHyE48wxOi64FHvmTfV2vdNqKdYpWSvhSDSEfILSKPubckYt3LDcUK1Cf5bQW9KLm6nNpbWO7xlP2lwR9okaPBHxrK6QiVaSk/Ire0FTMFyy8/Bsrg46X9Zg+HRrH1UGKpGsMzXIYQXEVxfGInSrca7bNXc8ImyrXFsep6JyKdHEzaQFpD9DJNOmdJ7qpGBr88ywIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2NEb1SUtGCRUjGPgeSQHI0iXcD3P5cbN8CTrkjNKfM=;
 b=KULwWDOj7XwI9v6jWXt7h3ZSYSwsEIObbUJGau771uHwRWTBZSGNh4aXOaMQzD7nBI1IHzQVlYRU62xSXBnOJCy7SJtYXMeahcwnTGD/nICE2W9un09SqJTrr9ixVWmHxxkTJGuucyPZJHQV3rCsImEPGAJNctkuzCveL/EFnDc=
Received: from TY4PR01CA0095.jpnprd01.prod.outlook.com (2603:1096:405:37d::6)
 by OS3PR01MB8272.jpnprd01.prod.outlook.com (2603:1096:604:1a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 18:23:35 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37d:cafe::a7) by TY4PR01CA0095.outlook.office365.com
 (2603:1096:405:37d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 18:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 6 Jul 2026 18:23:34 +0000
Received: from Ubuntu-22.. (ed-eng-lt-ism.diasemi.com [10.24.0.36])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 839993000152;
	Tue,  7 Jul 2026 03:23:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/8] clk: renesas: r9a09g077: Add xSPI core and module clocks
Date: Mon,  6 Jul 2026 19:23:22 +0100
Message-ID: <20260706182328.5237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260706182328.5237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|OS3PR01MB8272:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aa25e456-cbc6-4203-efcb-08dedb8bb103
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|56012099006|5023799004|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	KlRMH9YaezPRQt57ybLzFXN9NOzfP0WINitQp7FOQsbsPa9Y43NLWwYT7JpbVs8zR6XX/keflPLaNLTLMC/v9P/spY0w8O1bI9fpW7S1DcfqWSsYIO4sma4yqGHu2xSTQxmkVf+/MmoQw8lVflC3f1SzG00FqeY00dsbErpjFsuqXbwXYpg3YyQa310W0fsxGNxYsaspGY+kYdHqCda99y1cpmDy3WmkxBykwlKLJVBoZC8bpse89fW9ow3J4i3iWmqhWe9WGYZ3ZXWfQ04YeOSVSyvWGaq4DtkQfH5jH4r26jpvJhSQUxGQKHB72JpewMPLuplPLWwzIP9bFfX/ZwBvay+HIHvdNckLJTXFIQX8JVUePv7A/Sb97qq9G79FcSXLSfAZzHtC00hL/kDtEm9h5J0XR7U3nKKjWKn88NIXvXdo/hMeLZUGd4AU8n7xrCwz3O9vLYZVxmLQgFU9v06jAfJNTbArBy1eGwgWEznTMsBeoRPSqSJlUQVLitCHs4Hv12TJZOi62i2F/xvzKyssSnfGMeyMLkTJPg6BWyjdP6XGAU9I1NZf75WxRkr51KbWC0rAlKqWtwrHrf6vm4zkEe8Zl7ZIJ8el7/rDR+JC/N9ji/pnVMPwVYDHLdK2nYrv2DPmMms2MHbxXCr1kzpRyiILx10r1IyONMlQb6M=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	lzE4F4ZEvzaUhzC4kwa1CQfUwMpo1qExlT4eZbk7/R0yJNzCBq+EMqRkYuY0MJd2jR1Ea3p/sy68JDup+re0/GrJijTP2GVqHUIEtD9XimDOMDJmj34mGWWOXQs69RrwABHdixUxE0xq9tk+T5YeU0hmXIfIy1XJQ3p0+Pmte6p+9XWz5wNNbSKS2qoljDy0RAUJf5fx9zEY05sBxMxIhWD1ZwpXBBEsBuQhW/CgTzRsSiGtUkHuC0JEVaEvjtHUADx2EpGkR44RLup9eahpqY11CefrL+W6Ry41jbI5/YnaTgWmE+IkkA8WiYiUFtZxMc5uERP8BhBoxEOQWohj1CXqe+aH0A9v6+lgB6x/Ailmxml6DM2ZQJiYtkgHe6vV95ok6th2xAe03BcgicaA5hIUAmKyzaWRokbTV+HTV5bLsG668qmECGOVOPrbN9Im
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 18:23:34.9439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa25e456-cbc6-4203-efcb-08dedb8bb103
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8272
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Jul 2026 18:23:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23465

commit ec74d201e697503d8460597e2c3cc5ade222c4fb upstream.

Add core clocks and module clock definitions required by the xSPI
(Expanded SPI) IP on the R9A09G077 SoC.

Define the new SCKCR fields FSELXSPI0/FSELXSPI1 and DIVSEL_XSPI0/1 and
add two new core clocks XSPI_CLK0 and XSPI_CLK1. The xSPI block uses
PCLKH as its bus clock (use as module clock parent) while the operation
clock (XSPI_CLKn) is derived from PLL4. To support this arrangement
provide mux/div selectors and divider tables for the supported
XSPI operating rates.

Add CLK_TYPE_RZT2H_FSELXSPI to implement a custom divider/mux clock
where the determine_rate() callback enforces the hardware constraint:
when the parent output is 600MHz only dividers 8 and 16 are valid,
whereas for 800MHz operation the full divider set (6,8,16,32,64) may
be used. The custom determine_rate() picks the best parent/divider pair
to match the requested rate and programs the appropriate SCKCR fields.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251117205627.39376-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g077-cpg.c | 192 +++++++++++++++++++++++++++-
 1 file changed, 189 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a0=
9g077-cpg.c
index af54dadb3233..7cc7439290d3 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -11,6 +11,8 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
+#include <linux/types.h>
=20
 #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
 #include <dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h>
@@ -41,6 +43,13 @@
 #define GET_WIDTH(val)         FIELD_GET(WIDTH_MASK, val)
 #define GET_REG_OFFSET(val)    FIELD_GET(OFFSET_MASK, val)
=20
+#define FSELXSPI0	CONF_PACK(SCKCR, 0, 3)
+#define FSELXSPI1	CONF_PACK(SCKCR, 8, 3)
+#define DIVSEL_XSPI0	CONF_PACK(SCKCR, 6, 1)
+#define DIVSEL_XSPI1	CONF_PACK(SCKCR, 14, 1)
+#define FSELCANFD	CONF_PACK(SCKCR, 20, 1)
+#define SEL_PLL		CONF_PACK(SCKCR, 22, 1)
+
 #define DIVCA55C0	CONF_PACK(SCKCR2, 8, 1)
 #define DIVCA55C1	CONF_PACK(SCKCR2, 9, 1)
 #define DIVCA55C2	CONF_PACK(SCKCR2, 10, 1)
@@ -58,12 +67,10 @@
 #define DIVSCI3ASYNC	CONF_PACK(SCKCR3, 12, 2)
 #define DIVSCI4ASYNC	CONF_PACK(SCKCR3, 14, 2)
=20
-#define FSELCANFD	CONF_PACK(SCKCR, 20, 1)
-#define SEL_PLL		CONF_PACK(SCKCR, 22, 1)
-
 enum rzt2h_clk_types {
 	CLK_TYPE_RZT2H_DIV =3D CLK_TYPE_CUSTOM,	/* Clock with divider */
 	CLK_TYPE_RZT2H_MUX,			/* Clock with clock source selector */
+	CLK_TYPE_RZT2H_FSELXSPI,		/* Clock with FSELXSPIn source selector */
 };
=20
 #define DEF_DIV(_name, _id, _parent, _conf, _dtable) \
@@ -73,6 +80,9 @@ enum rzt2h_clk_types {
 	DEF_TYPE(_name, _id, CLK_TYPE_RZT2H_MUX, .conf =3D _conf, \
 		 .parent_names =3D _parent_names, .num_parents =3D _num_parents, \
 		 .flag =3D CLK_SET_RATE_PARENT, .mux_flags =3D _mux_flags)
+#define DEF_DIV_FSELXSPI(_name, _id, _parent, _conf, _dtable) \
+	DEF_TYPE(_name, _id, CLK_TYPE_RZT2H_FSELXSPI, .conf =3D _conf, \
+		 .parent =3D _parent, .dtable =3D _dtable, .flag =3D 0)
=20
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
@@ -92,6 +102,8 @@ enum clk_ids {
 	CLK_SEL_CLK_PLL2,
 	CLK_SEL_CLK_PLL4,
 	CLK_PLL4D1,
+	CLK_PLL4D1_DIV3,
+	CLK_PLL4D1_DIV4,
 	CLK_PLL4D3,
 	CLK_PLL4D3_DIV10,
 	CLK_PLL4D3_DIV20,
@@ -105,6 +117,8 @@ enum clk_ids {
 	CLK_SPI1ASYNC,
 	CLK_SPI2ASYNC,
 	CLK_SPI3ASYNC,
+	CLK_DIVSELXSPI0_SCKCR,
+	CLK_DIVSELXSPI1_SCKCR,
=20
 	/* Module Clocks */
 	MOD_CLK_BASE,
@@ -116,6 +130,15 @@ static const struct clk_div_table dtable_1_2[] =3D {
 	{0, 0},
 };
=20
+static const struct clk_div_table dtable_6_8_16_32_64[] =3D {
+	{6, 64},
+	{5, 32},
+	{4, 16},
+	{3, 8},
+	{2, 6},
+	{0, 0},
+};
+
 static const struct clk_div_table dtable_24_25_30_32[] =3D {
 	{0, 32},
 	{1, 30},
@@ -130,6 +153,7 @@ static const char * const sel_clk_pll0[] =3D { ".loco",=
 ".pll0" };
 static const char * const sel_clk_pll1[] =3D { ".loco", ".pll1" };
 static const char * const sel_clk_pll2[] =3D { ".loco", ".pll2" };
 static const char * const sel_clk_pll4[] =3D { ".loco", ".pll4" };
+static const char * const sel_clk_pll4d1_div3_div4[] =3D { ".pll4d1_div3",=
 ".pll4d1_div4" };
 static const char * const sel_clk_pll4d3_div10_div20[] =3D { ".pll4d3_div1=
0", ".pll4d3_div20" };
=20
 static const struct cpg_core_clk r9a09g077_core_clks[] __initconst =3D {
@@ -153,6 +177,8 @@ static const struct cpg_core_clk r9a09g077_core_clks[] =
__initconst =3D {
 		sel_clk_pll4, ARRAY_SIZE(sel_clk_pll4), CLK_MUX_READ_ONLY),
=20
 	DEF_FIXED(".pll4d1", CLK_PLL4D1, CLK_SEL_CLK_PLL4, 1, 1),
+	DEF_FIXED(".pll4d1_div3", CLK_PLL4D1_DIV3, CLK_PLL4D1, 3, 1),
+	DEF_FIXED(".pll4d1_div4", CLK_PLL4D1_DIV4, CLK_PLL4D1, 4, 1),
 	DEF_FIXED(".pll4d3", CLK_PLL4D3, CLK_SEL_CLK_PLL4, 3, 1),
 	DEF_FIXED(".pll4d3_div10", CLK_PLL4D3_DIV10, CLK_PLL4D3, 10, 1),
 	DEF_FIXED(".pll4d3_div20", CLK_PLL4D3_DIV20, CLK_PLL4D3, 20, 1),
@@ -178,6 +204,13 @@ static const struct cpg_core_clk r9a09g077_core_clks[]=
 __initconst =3D {
 	DEF_DIV(".spi3async", CLK_SPI3ASYNC, CLK_PLL4D1, DIVSPI3ASYNC,
 		dtable_24_25_30_32),
=20
+	DEF_MUX(".divselxspi0", CLK_DIVSELXSPI0_SCKCR, DIVSEL_XSPI0,
+		sel_clk_pll4d1_div3_div4,
+		ARRAY_SIZE(sel_clk_pll4d1_div3_div4), 0),
+	DEF_MUX(".divselxspi1", CLK_DIVSELXSPI1_SCKCR, DIVSEL_XSPI1,
+		sel_clk_pll4d1_div3_div4,
+		ARRAY_SIZE(sel_clk_pll4d1_div3_div4), 0),
+
 	/* Core output clk */
 	DEF_DIV("CA55C0", R9A09G077_CLK_CA55C0, CLK_SEL_CLK_PLL0, DIVCA55C0,
 		dtable_1_2),
@@ -202,11 +235,17 @@ static const struct cpg_core_clk r9a09g077_core_clks[=
] __initconst =3D {
 	DEF_FIXED("ETCLKC", R9A09G077_ETCLKC, CLK_SEL_CLK_PLL1, 10, 1),
 	DEF_FIXED("ETCLKD", R9A09G077_ETCLKD, CLK_SEL_CLK_PLL1, 20, 1),
 	DEF_FIXED("ETCLKE", R9A09G077_ETCLKE, CLK_SEL_CLK_PLL1, 40, 1),
+	DEF_DIV_FSELXSPI("XSPI_CLK0", R9A09G077_XSPI_CLK0, CLK_DIVSELXSPI0_SCKCR,
+			 FSELXSPI0, dtable_6_8_16_32_64),
+	DEF_DIV_FSELXSPI("XSPI_CLK1", R9A09G077_XSPI_CLK1, CLK_DIVSELXSPI1_SCKCR,
+			 FSELXSPI1, dtable_6_8_16_32_64),
 	DEF_MUX("PCLKCAN", R9A09G077_PCLKCAN, FSELCANFD,
 		sel_clk_pll4d3_div10_div20, ARRAY_SIZE(sel_clk_pll4d3_div10_div20), 0),
 };
=20
 static const struct mssr_mod_clk r9a09g077_mod_clks[] __initconst =3D {
+	DEF_MOD("xspi0", 4, R9A09G077_CLK_PCLKH),
+	DEF_MOD("xspi1", 5, R9A09G077_CLK_PCLKH),
 	DEF_MOD("sci0fck", 8, CLK_SCI0ASYNC),
 	DEF_MOD("sci1fck", 9, CLK_SCI1ASYNC),
 	DEF_MOD("sci2fck", 10, CLK_SCI2ASYNC),
@@ -295,6 +334,151 @@ r9a09g077_cpg_mux_clk_register(struct device *dev,
 	return clk_hw->clk;
 }
=20
+static unsigned int r9a09g077_cpg_fselxspi_get_divider(struct clk_hw *hw, =
unsigned long rate,
+						       unsigned int num_parents)
+{
+	struct clk_fixed_factor *ff;
+	struct clk_hw *parent_hw;
+	unsigned long best_rate;
+	unsigned int i;
+
+	for (i =3D 0; i < num_parents; i++) {
+		parent_hw =3D clk_hw_get_parent_by_index(hw, i);
+		best_rate =3D clk_hw_round_rate(parent_hw, rate);
+
+		if (best_rate =3D=3D rate) {
+			ff =3D to_clk_fixed_factor(parent_hw);
+			return ff->div;
+		}
+	}
+
+	/* No parent could provide the exact rate - this should not happen */
+	return 0;
+}
+
+static int r9a09g077_cpg_fselxspi_determine_rate(struct clk_hw *hw,
+						 struct clk_rate_request *req)
+{
+	struct clk_divider *divider =3D to_clk_divider(hw);
+	unsigned long parent_rate, best =3D 0, now;
+	const struct clk_div_table *clkt;
+	unsigned long rate =3D req->rate;
+	unsigned int num_parents;
+	unsigned int divselxspi;
+	unsigned int div =3D 0;
+
+	if (!rate)
+		rate =3D 1;
+
+	/* Get the number of parents for FSELXSPIn */
+	num_parents =3D clk_hw_get_num_parents(req->best_parent_hw);
+
+	for (clkt =3D divider->table; clkt->div; clkt++) {
+		parent_rate =3D clk_hw_round_rate(req->best_parent_hw, rate * clkt->div)=
;
+		/* Skip if parent can't provide any valid rate */
+		if (!parent_rate)
+			continue;
+
+		/* Determine which DIVSELXSPIn divider (3 or 4) provides this parent_rat=
e */
+		divselxspi =3D r9a09g077_cpg_fselxspi_get_divider(req->best_parent_hw, p=
arent_rate,
+								num_parents);
+		if (!divselxspi)
+			continue;
+
+		/*
+		 * DIVSELXSPIx supports 800MHz and 600MHz operation.
+		 * When divselxspi is 4 (600MHz operation), only FSELXSPIn dividers of 8=
 and 16
+		 * are supported. Otherwise, when divselxspi is 3 (800MHz operation),
+		 * dividers of 6, 8, 16, 32, and 64 are supported. This check ensures th=
at
+		 * FSELXSPIx is set correctly based on hardware limitations.
+		 */
+		if (divselxspi =3D=3D 4 && (clkt->div !=3D 8 && clkt->div !=3D 16))
+			continue;
+
+		now =3D DIV_ROUND_UP_ULL(parent_rate, clkt->div);
+		if (abs(rate - now) < abs(rate - best)) {
+			div =3D clkt->div;
+			best =3D now;
+			req->best_parent_rate =3D parent_rate;
+		}
+	}
+
+	if (!div) {
+		req->best_parent_rate =3D clk_hw_round_rate(req->best_parent_hw, 1);
+		divselxspi =3D r9a09g077_cpg_fselxspi_get_divider(req->best_parent_hw,
+								req->best_parent_rate,
+								num_parents);
+		/* default to divider 3 which will result DIVSELXSPIn =3D 800 MHz */
+		if (!divselxspi)
+			divselxspi =3D 3;
+
+		/*
+		 * Use the maximum divider based on the parent clock rate:
+		 *  - 64 when DIVSELXSPIx is 800 MHz (divider =3D 3)
+		 *  - 16 when DIVSELXSPIx is 600 MHz (divider =3D 4)
+		 */
+		div =3D divselxspi =3D=3D 3 ? 64 : 16;
+	}
+
+	req->rate =3D DIV_ROUND_UP_ULL(req->best_parent_rate, div);
+
+	return 0;
+}
+
+static struct clk * __init
+r9a09g077_cpg_fselxspi_div_clk_register(struct device *dev,
+					const struct cpg_core_clk *core,
+					void __iomem *addr,
+					struct cpg_mssr_pub *pub)
+{
+	static struct clk_ops *xspi_div_ops;
+	struct clk_init_data init =3D {};
+	const struct clk *parent;
+	const char *parent_name;
+	struct clk_divider *div;
+	struct clk_hw *hw;
+	int ret;
+
+	parent =3D pub->clks[core->parent];
+	if (IS_ERR(parent))
+		return ERR_CAST(parent);
+
+	div =3D devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
+	if (!div)
+		return ERR_PTR(-ENOMEM);
+
+	if (!xspi_div_ops) {
+		xspi_div_ops =3D devm_kzalloc(dev, sizeof(*xspi_div_ops), GFP_KERNEL);
+		if (!xspi_div_ops)
+			return  ERR_PTR(-ENOMEM);
+		memcpy(xspi_div_ops, &clk_divider_ops,
+		       sizeof(const struct clk_ops));
+		xspi_div_ops->determine_rate =3D r9a09g077_cpg_fselxspi_determine_rate;
+	}
+
+	parent_name =3D __clk_get_name(parent);
+	init.name =3D core->name;
+	init.ops =3D xspi_div_ops;
+	init.flags =3D CLK_SET_RATE_PARENT;
+	init.parent_names =3D &parent_name;
+	init.num_parents =3D 1;
+
+	div->reg =3D addr;
+	div->shift =3D GET_SHIFT(core->conf);
+	div->width =3D GET_WIDTH(core->conf);
+	div->flags =3D core->flag;
+	div->lock =3D &pub->rmw_lock;
+	div->hw.init =3D &init;
+	div->table =3D core->dtable;
+
+	hw =3D &div->hw;
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
@@ -309,6 +493,8 @@ r9a09g077_cpg_clk_register(struct device *dev, const st=
ruct cpg_core_clk *core,
 		return r9a09g077_cpg_div_clk_register(dev, core, addr, pub);
 	case CLK_TYPE_RZT2H_MUX:
 		return r9a09g077_cpg_mux_clk_register(dev, core, addr, pub);
+	case CLK_TYPE_RZT2H_FSELXSPI:
+		return r9a09g077_cpg_fselxspi_div_clk_register(dev, core, addr, pub);
 	default:
 		return ERR_PTR(-EINVAL);
 	}
--=20
2.43.0


