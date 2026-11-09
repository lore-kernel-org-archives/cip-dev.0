Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.25])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4581.1794226522219503324
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WXYFb1PQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.25, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/XSHdsAuTHKS7g/JOm8dEl290r11F+0I/yoSP6rkfAgjO4xCv41qLsjb5IEGx2kyWIwB2i7qhCBW3IcdpQ56bNcYo6xNWjuQmditcI7lkCq/1VJ4syeewGtPIGKInxxhPROLiWPV6iG43iqMIB5gDgzHej7AuwUxj2HgkgrvSzigwTIM0LfjeFoPAGNg+XyZ7d31n/Pf5zP4RJ2o9PS6Vbo7lng48HAjlM33eEZfy3WKBtl7lcKbSr5BZpx2CcLu7xdHxvsZSwvNm6VmC42JF1OKw672Ks7Hq2lf4DOmxWdz8FwYQak3rb2Kl4PkZRnwn1f8f5irAp/HJrdSQs//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ8gGulqRX5ac4pCwhf4+UXcqOkE+8tpNCjJk+3jjtM=;
 b=VtZKPnG5518W9/w1lLdA28pOk0ZdO4elrcA1YTQkgbeGUH864xgwiReYSpWydizmubASUt41e9BzBgXZEwM++X77NymMbc+fW+KStJcci7fsyRDdCdsMghcSD6QhU/UuoDHfzbtfqKpN628lhAT1gtmH4p7WW0Kp4Fo/pst0ExlMB9gzyUKIFsmQeA6Za4xe1v3DVkCOmxQY8XO5lGFqxbhAjvl1BJ0PMdafnrG+YImucsqQpMB24XQLP9DCLlqcraiZN/pOKN6zfb2UUfs1SQGpZ9uV7gDAFOtjFDya6MZzBRHFnhzkN5/tz7tcFs3UV7r03HCvh9pJ5gwBCZMBMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ8gGulqRX5ac4pCwhf4+UXcqOkE+8tpNCjJk+3jjtM=;
 b=WXYFb1PQbctNW6PMSE8ARLTmmyyujso1uKqIDVy+bdtPxZP5stlCQaiEbq3EJOgNqn/IAbZZVucupxqJ+rIYF2mpz3LD1Y3B2tkUvztWie22XxGUYk0Vicc8zHhUZS2cR9FzDGgTR5Hrqry6TpfFhZ9n43OOQ2UIDmxRuZw/TXo=
Received: from OS7P301CA0023.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:26b::12)
 by TY7PR01MB15390.jpnprd01.prod.outlook.com (2603:1096:405:246::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 12:15:15 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:26b:cafe::88) by OS7P301CA0023.outlook.office365.com
 (2603:1096:604:26b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 12:15:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:15 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5352430002A9;
	Mon,  9 Nov 2026 21:15:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/24] clk: renesas: rzv2h-cpg: Use per-SoC PLL reference frequency for calculations
Date: Mon,  9 Nov 2026 12:14:40 +0000
Message-ID: <20261109121451.6042-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|TY7PR01MB15390:EE_
X-MS-Office365-Filtering-Correlation-Id: 567be484-75c2-4363-c768-08df3e5b1ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|6133799003|10067099003|3023799007|13003099007|11063799006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|56012099006|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: c8SFZIIO7zwPLSJ+1uhiRMFaGS7QStDDxxPnHLPqJHnOMKbkE8fosgt/FNVOTAE6bbYOBQkqDin2fPmnLqMfsV5fH4v7sQ3IW6KkeC3GE383HE/pZ7u1B/h28ROKzzQE9MYYWMQWGczRdK+bFrrFigf5NkSFQ4CeRecPA6IP4gr5XPWJtTrQXqIsLI7wzMqBL4vQVhRNn0PzKtfDGp9RaBQc/e1vA2xrFh/dirjy5vOwJmpnpNr2gJ9hBg2k5cZvbkgkDEbYXSqCdDviASghKpFygkCodc+ObQQlSkKQ6YVK8+6N60WWmkCOqdcrKEnyiDEtsc8u2VY4IJ1EAiyqlHgbjGnoiIqI2Wuir2QTq+sy40rsj8bfhXBfTEEgvicVa10fjpw5LwVy2sKIT87gr/6Ytbaoq9pWcBe7ob8hhAiRroahUxFP6X+HzrOamxYoo8N0Kfoc66Bv4ngNdT+f/7EG/aD8ljPSnzfNiAKf4CFI9Gk+YoMaSzgMSnWgOwUOngCIJIvyWbcD6sAz1z/1xIXA6us8XHQJ2suI6Rw9mywdgcqFCAIdmnjXmKWA1MQrqLFuu8CtTOVo5bBakhqwHLDAnWzafH1Rr7GlNeYzoB0LTzFlkgSkDxjsKaCuX0+SL+bbpUyz3EBTWFtnQMNOgV84Z2pxThh3ZjGvqGYaj/w=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(13003099007)(11063799006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GsAJtp/IDLMfYKBnZW7OsKYx8APGaDPrC3W4VdXx+HX7OTTS7dMWm/OMM48dy2QbpxRJOVg6x9zy26SKtw+rr11pNP0NyvZWOChDGOoTvTMdA7YQdvSBMnpPIxod+NnIcaqGGH8XQTF9GhYcHdGbVtpzvwROhfbSSQHbE9bl2exVPxeccvEmxU2FxdR9bPgsDp/kKbSsPcO3s5gSmhzjOJHt6ZNG25W17QEZLPw10ewP9w6tSYggP61itzcViIJfc6RnAGYqBWm4dW7Em/NWYBVEmFboWz6iZuzRUJkWEGhXGclGlj3jl7aB0QjmmSsDayve0uSSPq/hRkQV+3UWlkaRGdEwjEPi8QfO+ebfyM/Oipuvrp6PskFWrjO15VYGbNeK2IJIQl7XV9H86kI7oonPFTcP39xIVcIN3j1TrdDu1lIiqJltYXJMk4/KU6Br
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:15.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 567be484-75c2-4363-c768-08df3e5b1ce4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB15390
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24717
Content-Type: text/plain; charset="utf-8"

commit 4f4230ff5d0aec3a5f3b3d9bab39b3db13800a44 upstream.

Introduce a per-SoC PLL reference input frequency parameter to avoid
relying on a hardcoded 24MHz constant during PLL configuration math.

Add an input_fref member to struct rzv2h_pll_limits. In the core
calculation helper rzv2h_get_pll_pars(), derive the base input clock
rate from limits->input_fref, utilizing the conditional ternary operator
to fall back to 24MHz if the struct field is left uninitialized (0),
and drop the obsolete macro RZ_V2H_OSC_CLK_IN_MEGA.

This abstraction permits the reuse of the common PLL divider logic on
newer SoC platforms like the RZ/T2H, which feature a 48 MHz PLL reference
clock input instead of the 24 MHz signal used by RZ/V2H(P), without
disrupting existing platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260618181949.3036280-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 8 ++++----
 include/linux/clk/renesas.h     | 5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index 170dbe452c34e..e309129b73a8f 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -213,7 +213,6 @@ struct rzv2h_plldsi_div_clk {
 #define to_plldsi_div_clk(_hw) \
 	container_of(_hw, struct rzv2h_plldsi_div_clk, hw)
=20
-#define RZ_V2H_OSC_CLK_IN_MEGA		(24 * MEGA)
 #define RZV2H_MAX_DIV_TABLES		(16)
=20
 /**
@@ -237,6 +236,7 @@ struct rzv2h_plldsi_div_clk {
 bool rzv2h_get_pll_pars(const struct rzv2h_pll_limits *limits,
 			struct rzv2h_pll_pars *pars, u64 freq_millihz)
 {
+	unsigned long input_fref =3D limits->input_fref ?: (24 * MEGA);
 	u64 fout_min_millihz =3D mul_u32_u32(limits->fout.min, MILLI);
 	u64 fout_max_millihz =3D mul_u32_u32(limits->fout.max, MILLI);
 	struct rzv2h_pll_pars p, best;
@@ -249,7 +249,7 @@ bool rzv2h_get_pll_pars(const struct rzv2h_pll_limits *=
limits,
 	best.error_millihz =3D S64_MAX;
=20
 	for (p.p =3D limits->p.min; p.p <=3D limits->p.max; p.p++) {
-		u32 fref =3D RZ_V2H_OSC_CLK_IN_MEGA / p.p;
+		u32 fref =3D input_fref / p.p;
 		u16 divider;
=20
 		for (divider =3D 1 << limits->s.min, p.s =3D limits->s.min;
@@ -330,9 +330,9 @@ bool rzv2h_get_pll_pars(const struct rzv2h_pll_limits *=
limits,
 					continue;
=20
 				/* PLL_M component of (output * 65536 * PLL_P) */
-				output =3D mul_u32_u32(p.m * 65536, RZ_V2H_OSC_CLK_IN_MEGA);
+				output =3D mul_u32_u32(p.m * 65536, input_fref);
 				/* PLL_K component of (output * 65536 * PLL_P) */
-				output +=3D p.k * RZ_V2H_OSC_CLK_IN_MEGA;
+				output +=3D p.k * input_fref;
 				/* Make it in mHz */
 				output *=3D MILLI;
 				output =3D DIV_U64_ROUND_CLOSEST(output, 65536 * p.p * divider);
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index c360df9fa735c..039cf545a20b6 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -53,6 +53,9 @@ static inline void rzg2l_cpg_dsi_div_set_divider(u8 divid=
er, int target) { }
  * various parameters used to configure a PLL. These limits ensure
  * the PLL operates within valid and stable ranges.
  *
+ * @input_fref: Reference input frequency to the PLL (in Hz). If set
+ * to 0, a default value of 24MHz is used.
+ *
  * @fout: Output frequency range (in MHz)
  * @fout.min: Minimum allowed output frequency
  * @fout.max: Maximum allowed output frequency
@@ -78,6 +81,8 @@ static inline void rzg2l_cpg_dsi_div_set_divider(u8 divid=
er, int target) { }
  * @k.max: Maximum delta-sigma value
  */
 struct rzv2h_pll_limits {
+	u32 input_fref;
+
 	struct {
 		u32 min;
 		u32 max;
--=20
2.43.0

