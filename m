Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.28])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4586.1794226526377247877
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Nov 2026 04:15:26 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pFaiso+U;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.28, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KasvZC/WYJ4y7qbhS3cjqeqiQAMzE+bZ62PaGMWuq+u+U+fRIozx3QoLJi/O/qtKGUNHNDGQDbJgpU8Y7v/hnff9d2+8nh12HhtKCBSawsOXfOMn7IbNMl5R7a0mx+aEt2/GUUOSK5Byqd8gUZ9IFfeRiYH3tA7Sem/4WBfKaAXMnebZYX2tBJM83DP/LHNBQKGxUMpai9RVc8U9SquqNi+rXgs5p3fgFdGOCAQvG2s0i+sukJ4hjz1vAsv+0HIVIHtkwJZbMY7djYXg4ChlTbGMxLikiW5BioIs/ksbo5cRiySSAZvAz4qYxY6rIP7F2cBlNdakU4YSE3eaUyWjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=igKHHGOhpw4nOjHhsbVwmVrCgBtS2J7NaIMkbIqk9JA=;
 b=hV4+oAdRSmq+LT4vz5wJPO3HktgYOhUdoJYeMSxn+3OQqcTVtDHs79Z/qlxJveh3ssMzQIoAplV7MlsyjtEvAu/itpsqSRM2k9M6F9c11GtdZDJ2Cw01LgMQq/W35n3OiZXWBPl7LNw2RAWAXMRaF5izvZF/eVCGPV4hh1v13ggAPdc6Bhbd+4yYUotfQqVfjNeB2xrXW2Oi+SVsvC0B+yBQopArqB9UsKpIWbFKtnztL2OIH7aEjCpUFoYIZ+Xnmc+BwGn/VLU3it88xynxMv6ukAqZt8t+tvLkhGdvrI55rcMi9RStZWhhacDZWuakKFLHo6z1PSVct5aoRbq3yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=igKHHGOhpw4nOjHhsbVwmVrCgBtS2J7NaIMkbIqk9JA=;
 b=pFaiso+Uy/ojRvkwntqfjqVF18AeQh7jnlldlXEADBjlA1x4NcBVLAMTk+9Az2cCNqYc6Oej6bP77iDiKKxZllb97rTcgsFU4w72JKYMBGt9ogkR55YzuWpqrjQQ8EjdyPWhrzkoBAftwKC46HIb6T4ZsSMKOObjyUUedrOEJY8=
Received: from TY6P301CA0020.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3bf::10)
 by OS9PR01MB12485.jpnprd01.prod.outlook.com (2603:1096:604:2f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:15:19 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bf:cafe::f) by TY6P301CA0020.outlook.office365.com
 (2603:1096:405:3bf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.12 via Frontend Transport; Mon, 9
 Nov 2026 12:15:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 9 Nov 2026 12:15:19 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.1.30])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id AB528300022D;
	Mon,  9 Nov 2026 21:15:17 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/24] clk: renesas: rzv2h-cpg: Extract PLL calculation helpers into shared library
Date: Mon,  9 Nov 2026 12:14:42 +0000
Message-ID: <20261109121451.6042-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261109121451.6042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OS9PR01MB12485:EE_
X-MS-Office365-Filtering-Correlation-Id: 9558fef3-bd8e-49f4-9ca7-08df3e5b1eea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261009223027099003|11063799006|56012099006|261021123027099003|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009221227099003|261009220027099003|261009221727099003|261009223327099003|261026121527099003|261026140227099003|261102130727099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info: PCq8DTJ+rAZtbX9cPkK96/0rdvMgDYeNBV7ftO5TGaeuG4zynCXeWLyDtP6pvic6GP2ewOefhlAC8PcmhsW31LIBEs/4786ED3+ycGDC6mTJyTJdZrYntunULPpbpQaeGFvuruoTaAa4OrmYvnfIyYZm446tUgUbb1UNaVN1qvVhAYQhcEGLokubB+oDeFLDnT07+mH7F+8/1+PH6bFEARiPWu8RTAg/qeAr6HWVCSuf6/XOROfYoaU41xbJDYeaitXORMNouXz1tIa6csdUt9MfKQ8/t5i3WPEBRGvYr/4Y1gsZHXuZnaV4c58AAq/TElcgTn7FGAMFaAsi9zdzZOio29d5AOaAJ/LQfcOLLnjMVmQ+OPFZNgNb/6ipKGhj7QwgOJQ40BDuzlwSt+DJgpH48gJJ3mVNp0Am25H65J3MBbl2PdjNpFPt7vnBvAK/geuDqLAV5RrRtZN0Qx7rLKOCNV5faQfug1CkFpysYKVi2XeF2xBV9SgPbqQR7hBACZ74MUJV4ATBXlsxIJWxq9Gr2e/FsVQ83wmZo8bUIbMPwZ7AXLRRj8Xn8CzqKiOhJW9N5O9PNCx+MyW7WsaaMVu8BLEvodmu6ivorWJuChrH/bXLE6jXcXG4tunWRwQrk22AIWeHzxkzHYOL3ajlnKSAICqNIUQKN0PyqdIFt4c=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261009223027099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009221227099003)(261009220027099003)(261009221727099003)(261009223327099003)(261026121527099003)(261026140227099003)(261102130727099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Djy5tFNGQxM/HsagVNYbAWLIjNulpzNMOh43FWJLyp4eWt8EQNR6WQMUle7LSc7YkizC/axLoUNti9hPT9m7jtkoIzBvh0UwcB0tyJBOHiYTie6oq75s+KhzOxQ/c22ppBycN3DqRzfOtoIO0B95wl0B7LkUWFlT6OhZFJprvH9B4qZegsY3bXMBsdVvFp56LIDqpoqmVirScUhe4LYcnVaVj76WGun2aQEktz7ONAFXPr62uqxKUwcVpLI9npqpeybH91py9GU0k9HPBsTL++MdQprdihnjE+0b4YxsRKmFoHhNPh9lNXba7ykjsTeP2BfFJSMHKrS9v965MBGZKPQhxNQiKXDAAXCNihVlVtk6RJCp/lt/OJ3ULcEYtoYqcdBJodAwQAkN98cl3KkcuIq0XSyfvPh3hj/kJuHwjp/RNiaZF85NAtSaNPqZUe/4
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:15:19.0519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9558fef3-bd8e-49f4-9ca7-08df3e5b1eea
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12485
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 09 Nov 2026 12:15:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24721
Content-Type: text/plain; charset="utf-8"

commit 73c360100dec2ecb0e905ceb58a01df45fda8988 upstream.

Move the RZ/V2H PLL and divider parameter calculation helpers from
rzv2h-cpg.c into a new reusable library.

Introduce the CLK_RZV2H_CPG_LIB Kconfig symbol and add
rzv2h-cpg-lib.c to host the PLL parameter search algorithms currently
implemented by rzv2h_get_pll_pars() and rzv2h_get_pll_divs_pars().
Export the helpers as rzv2h_cpg_get_pll_pars() and
rzv2h_cpg_get_pll_divs_pars() for use by other drivers.

Update the public clock header to expose the new interfaces and provide
compatibility aliases for the existing helper names, avoiding build
breakage for current users while allowing future conversions to the new
API.

This prepares for reuse of the PLL and divider calculation logic by
other Renesas clock drivers, including upcoming RZ/T2H and RZ/N2H CPG
support, without duplicating the implementation.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260618181949.3036280-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig         |   4 +
 drivers/clk/renesas/Makefile        |   1 +
 drivers/clk/renesas/rzv2h-cpg-lib.c | 217 ++++++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.c     | 203 --------------------------
 include/linux/clk/renesas.h         |  29 ++--
 5 files changed, 238 insertions(+), 216 deletions(-)
 create mode 100644 drivers/clk/renesas/rzv2h-cpg-lib.c

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 0203ecbb38825..7659550b85661 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -260,8 +260,12 @@ config CLK_RZG2L
=20
 config CLK_RZV2H
 	bool "RZ/{G3E,V2H(P)} family clock support" if COMPILE_TEST
+	select CLK_RZV2H_CPG_LIB
 	select RESET_CONTROLLER
=20
+config CLK_RZV2H_CPG_LIB
+	bool "RZV2H CPG library functions" if COMPILE_TEST
+
 config CLK_RENESAS_VBATTB
 	tristate "Renesas VBATTB clock controller"
 	depends on ARCH_RZG2L || COMPILE_TEST
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index bd2bed91ab291..ac790e56034b9 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_CLK_RCAR_GEN3_CPG)		+=3D rcar-gen3-cpg.o
 obj-$(CONFIG_CLK_RCAR_GEN4_CPG)		+=3D rcar-gen4-cpg.o
 obj-$(CONFIG_CLK_RCAR_USB2_CLOCK_SEL)	+=3D rcar-usb2-clock-sel.o
 obj-$(CONFIG_CLK_RZG2L)			+=3D rzg2l-cpg.o
+obj-$(CONFIG_CLK_RZV2H_CPG_LIB)		+=3D rzv2h-cpg-lib.o
 obj-$(CONFIG_CLK_RZV2H)			+=3D rzv2h-cpg.o
=20
 # Generic
diff --git a/drivers/clk/renesas/rzv2h-cpg-lib.c b/drivers/clk/renesas/rzv2=
h-cpg-lib.c
new file mode 100644
index 0000000000000..4eb3f949f326f
--- /dev/null
+++ b/drivers/clk/renesas/rzv2h-cpg-lib.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZV2H CPG Library. This library provides common functions to calculate
+ * PLL parameters for the RZV2H SoC.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ *
+ */
+
+#include <linux/clk/renesas.h>
+#include <linux/export.h>
+#include <linux/math.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+/**
+ * rzv2h_cpg_get_pll_pars - Finds the best combination of PLL parameters
+ * for a given frequency.
+ *
+ * @limits: Pointer to the structure containing the limits for the PLL par=
ameters
+ * @pars: Pointer to the structure where the best calculated PLL parameter=
s values
+ * will be stored
+ * @freq_millihz: Target output frequency in millihertz
+ *
+ * This function calculates the best set of PLL parameters (M, K, P, S) to=
 achieve
+ * the desired frequency.
+ * There is no direct formula to calculate the PLL parameters, as it's an =
open
+ * system of equations, therefore this function uses an iterative approach=
 to
+ * determine the best solution. The best solution is one that minimizes th=
e error
+ * (desired frequency - actual frequency).
+ *
+ * Return: true if a valid set of parameters values is found, false otherw=
ise.
+ */
+bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
+			    struct rzv2h_pll_pars *pars, u64 freq_millihz)
+{
+	unsigned long input_fref =3D limits->input_fref ?: (24 * MEGA);
+	u64 fout_min_millihz =3D mul_u32_u32(limits->fout.min, MILLI);
+	u64 fout_max_millihz =3D mul_u32_u32(limits->fout.max, MILLI);
+	struct rzv2h_pll_pars p, best;
+
+	if (freq_millihz > fout_max_millihz ||
+	    freq_millihz < fout_min_millihz)
+		return false;
+
+	/* Initialize best error to maximum possible value */
+	best.error_millihz =3D S64_MAX;
+
+	for (p.p =3D limits->p.min; p.p <=3D limits->p.max; p.p++) {
+		u32 fref =3D input_fref / p.p;
+		u16 divider;
+
+		for (divider =3D 1 << limits->s.min, p.s =3D limits->s.min;
+			p.s <=3D limits->s.max; p.s++, divider <<=3D 1) {
+			for (p.m =3D limits->m.min; p.m <=3D limits->m.max; p.m++) {
+				u64 output_m, output_k_range;
+				s64 pll_k, output_k;
+				u64 fvco, output;
+
+				/*
+				 * The frequency generated by the PLL + divider
+				 * is calculated as follows:
+				 *
+				 * With:
+				 * Freq =3D Ffout =3D Ffvco / 2^(pll_s)
+				 * Ffvco =3D (pll_m + (pll_k / 65536)) * Ffref
+				 * Ffref =3D 24MHz / pll_p
+				 *
+				 * Freq can also be rewritten as:
+				 * Freq =3D Ffvco / 2^(pll_s)
+				 *      =3D ((pll_m + (pll_k / 65536)) * Ffref) / 2^(pll_s)
+				 *      =3D (pll_m * Ffref) / 2^(pll_s) + ((pll_k / 65536) * Ffref) / =
2^(pll_s)
+				 *      =3D output_m + output_k
+				 *
+				 * Every parameter has been determined at this
+				 * point, but pll_k.
+				 *
+				 * Considering that:
+				 * limits->k.min <=3D pll_k <=3D limits->k.max
+				 * Then:
+				 * -0.5 <=3D (pll_k / 65536) < 0.5
+				 * Therefore:
+				 * -Ffref / (2 * 2^(pll_s)) <=3D output_k < Ffref / (2 * 2^(pll_s))
+				 */
+
+				/* Compute output M component (in mHz) */
+				output_m =3D DIV_ROUND_CLOSEST_ULL(mul_u32_u32(p.m, fref) * MILLI,
+								 divider);
+				/* Compute range for output K (in mHz) */
+				output_k_range =3D DIV_ROUND_CLOSEST_ULL(mul_u32_u32(fref, MILLI),
+								       2 * divider);
+				/*
+				 * No point in continuing if we can't achieve
+				 * the desired frequency
+				 */
+				if (freq_millihz <  (output_m - output_k_range) ||
+				    freq_millihz >=3D (output_m + output_k_range)) {
+					continue;
+				}
+
+				/*
+				 * Compute the K component
+				 *
+				 * Since:
+				 * Freq =3D output_m + output_k
+				 * Then:
+				 * output_k =3D Freq - output_m
+				 *          =3D ((pll_k / 65536) * Ffref) / 2^(pll_s)
+				 * Therefore:
+				 * pll_k =3D (output_k * 65536 * 2^(pll_s)) / Ffref
+				 */
+				output_k =3D freq_millihz - output_m;
+				pll_k =3D div_s64(output_k * 65536ULL * divider,
+						fref);
+				pll_k =3D DIV_S64_ROUND_CLOSEST(pll_k, MILLI);
+
+				/* Validate K value within allowed limits */
+				if (pll_k < limits->k.min ||
+				    pll_k > limits->k.max)
+					continue;
+
+				p.k =3D pll_k;
+
+				/* Compute (Ffvco * 65536) */
+				fvco =3D mul_u32_u32(p.m * 65536 + p.k, fref);
+				if (fvco < mul_u32_u32(limits->fvco.min, 65536) ||
+				    fvco > mul_u32_u32(limits->fvco.max, 65536))
+					continue;
+
+				/* PLL_M component of (output * 65536 * PLL_P) */
+				output =3D mul_u32_u32(p.m * 65536, input_fref);
+				/* PLL_K component of (output * 65536 * PLL_P) */
+				output +=3D p.k * input_fref;
+				/* Make it in mHz */
+				output *=3D MILLI;
+				output =3D DIV_U64_ROUND_CLOSEST(output, 65536 * p.p * divider);
+
+				/* Check output frequency against limits */
+				if (output < fout_min_millihz ||
+				    output > fout_max_millihz)
+					continue;
+
+				p.error_millihz =3D freq_millihz - output;
+				p.freq_millihz =3D output;
+
+				/* If an exact match is found, return immediately */
+				if (p.error_millihz =3D=3D 0) {
+					*pars =3D p;
+					return true;
+				}
+
+				/* Update best match if error is smaller */
+				if (abs(best.error_millihz) > abs(p.error_millihz))
+					best =3D p;
+			}
+		}
+	}
+
+	/* If no valid parameters were found, return false */
+	if (best.error_millihz =3D=3D S64_MAX)
+		return false;
+
+	*pars =3D best;
+	return true;
+}
+EXPORT_SYMBOL_NS_GPL(rzv2h_cpg_get_pll_pars, RZV2H_CPG);
+
+/*
+ * rzv2h_cpg_get_pll_divs_pars - Finds the best combination of PLL paramet=
ers
+ * and divider value for a given frequency.
+ *
+ * @limits: Pointer to the structure containing the limits for the PLL par=
ameters
+ * @pars: Pointer to the structure where the best calculated PLL parameter=
s and
+ * divider values will be stored
+ * @table: Pointer to the array of valid divider values
+ * @table_size: Size of the divider values array
+ * @freq_millihz: Target output frequency in millihertz
+ *
+ * This function calculates the best set of PLL parameters (M, K, P, S) an=
d divider
+ * value to achieve the desired frequency. See rzv2h_cpg_get_pll_pars() fo=
r more
+ * details on how the PLL parameters are calculated.
+ *
+ * freq_millihz is the desired frequency generated by the PLL followed by =
a
+ * a gear.
+ */
+bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
+				 struct rzv2h_pll_div_pars *pars,
+				 const u8 *table, u8 table_size, u64 freq_millihz)
+{
+	struct rzv2h_pll_div_pars p, best;
+
+	best.div.error_millihz =3D S64_MAX;
+	p.div.error_millihz =3D S64_MAX;
+	for (unsigned int i =3D 0; i < table_size; i++) {
+		if (!rzv2h_cpg_get_pll_pars(limits, &p.pll, freq_millihz * table[i]))
+			continue;
+
+		p.div.divider_value =3D table[i];
+		p.div.freq_millihz =3D DIV_U64_ROUND_CLOSEST(p.pll.freq_millihz, table[i=
]);
+		p.div.error_millihz =3D freq_millihz - p.div.freq_millihz;
+
+		if (p.div.error_millihz =3D=3D 0) {
+			*pars =3D p;
+			return true;
+		}
+
+		if (abs(best.div.error_millihz) > abs(p.div.error_millihz))
+			best =3D p;
+	}
+
+	if (best.div.error_millihz =3D=3D S64_MAX)
+		return false;
+
+	*pars =3D best;
+	return true;
+}
+EXPORT_SYMBOL_NS_GPL(rzv2h_cpg_get_pll_divs_pars, RZV2H_CPG);
diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cp=
g.c
index f3ef7b4a21434..ab87413d0df74 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -220,209 +220,6 @@ struct rzv2h_plldsi_div_clk {
=20
 #define RZV2H_MAX_DIV_TABLES		(16)
=20
-/**
- * rzv2h_get_pll_pars - Finds the best combination of PLL parameters
- * for a given frequency.
- *
- * @limits: Pointer to the structure containing the limits for the PLL par=
ameters
- * @pars: Pointer to the structure where the best calculated PLL parameter=
s values
- * will be stored
- * @freq_millihz: Target output frequency in millihertz
- *
- * This function calculates the best set of PLL parameters (M, K, P, S) to=
 achieve
- * the desired frequency.
- * There is no direct formula to calculate the PLL parameters, as it's an =
open
- * system of equations, therefore this function uses an iterative approach=
 to
- * determine the best solution. The best solution is one that minimizes th=
e error
- * (desired frequency - actual frequency).
- *
- * Return: true if a valid set of parameters values is found, false otherw=
ise.
- */
-bool rzv2h_get_pll_pars(const struct rzv2h_pll_limits *limits,
-			struct rzv2h_pll_pars *pars, u64 freq_millihz)
-{
-	unsigned long input_fref =3D limits->input_fref ?: (24 * MEGA);
-	u64 fout_min_millihz =3D mul_u32_u32(limits->fout.min, MILLI);
-	u64 fout_max_millihz =3D mul_u32_u32(limits->fout.max, MILLI);
-	struct rzv2h_pll_pars p, best;
-
-	if (freq_millihz > fout_max_millihz ||
-	    freq_millihz < fout_min_millihz)
-		return false;
-
-	/* Initialize best error to maximum possible value */
-	best.error_millihz =3D S64_MAX;
-
-	for (p.p =3D limits->p.min; p.p <=3D limits->p.max; p.p++) {
-		u32 fref =3D input_fref / p.p;
-		u16 divider;
-
-		for (divider =3D 1 << limits->s.min, p.s =3D limits->s.min;
-			p.s <=3D limits->s.max; p.s++, divider <<=3D 1) {
-			for (p.m =3D limits->m.min; p.m <=3D limits->m.max; p.m++) {
-				u64 output_m, output_k_range;
-				s64 pll_k, output_k;
-				u64 fvco, output;
-
-				/*
-				 * The frequency generated by the PLL + divider
-				 * is calculated as follows:
-				 *
-				 * With:
-				 * Freq =3D Ffout =3D Ffvco / 2^(pll_s)
-				 * Ffvco =3D (pll_m + (pll_k / 65536)) * Ffref
-				 * Ffref =3D 24MHz / pll_p
-				 *
-				 * Freq can also be rewritten as:
-				 * Freq =3D Ffvco / 2^(pll_s)
-				 *      =3D ((pll_m + (pll_k / 65536)) * Ffref) / 2^(pll_s)
-				 *      =3D (pll_m * Ffref) / 2^(pll_s) + ((pll_k / 65536) * Ffref) / =
2^(pll_s)
-				 *      =3D output_m + output_k
-				 *
-				 * Every parameter has been determined at this
-				 * point, but pll_k.
-				 *
-				 * Considering that:
-				 * limits->k.min <=3D pll_k <=3D limits->k.max
-				 * Then:
-				 * -0.5 <=3D (pll_k / 65536) < 0.5
-				 * Therefore:
-				 * -Ffref / (2 * 2^(pll_s)) <=3D output_k < Ffref / (2 * 2^(pll_s))
-				 */
-
-				/* Compute output M component (in mHz) */
-				output_m =3D DIV_ROUND_CLOSEST_ULL(mul_u32_u32(p.m, fref) * MILLI,
-								 divider);
-				/* Compute range for output K (in mHz) */
-				output_k_range =3D DIV_ROUND_CLOSEST_ULL(mul_u32_u32(fref, MILLI),
-								       2 * divider);
-				/*
-				 * No point in continuing if we can't achieve
-				 * the desired frequency
-				 */
-				if (freq_millihz <  (output_m - output_k_range) ||
-				    freq_millihz >=3D (output_m + output_k_range)) {
-					continue;
-				}
-
-				/*
-				 * Compute the K component
-				 *
-				 * Since:
-				 * Freq =3D output_m + output_k
-				 * Then:
-				 * output_k =3D Freq - output_m
-				 *          =3D ((pll_k / 65536) * Ffref) / 2^(pll_s)
-				 * Therefore:
-				 * pll_k =3D (output_k * 65536 * 2^(pll_s)) / Ffref
-				 */
-				output_k =3D freq_millihz - output_m;
-				pll_k =3D div_s64(output_k * 65536ULL * divider,
-						fref);
-				pll_k =3D DIV_S64_ROUND_CLOSEST(pll_k, MILLI);
-
-				/* Validate K value within allowed limits */
-				if (pll_k < limits->k.min ||
-				    pll_k > limits->k.max)
-					continue;
-
-				p.k =3D pll_k;
-
-				/* Compute (Ffvco * 65536) */
-				fvco =3D mul_u32_u32(p.m * 65536 + p.k, fref);
-				if (fvco < mul_u32_u32(limits->fvco.min, 65536) ||
-				    fvco > mul_u32_u32(limits->fvco.max, 65536))
-					continue;
-
-				/* PLL_M component of (output * 65536 * PLL_P) */
-				output =3D mul_u32_u32(p.m * 65536, input_fref);
-				/* PLL_K component of (output * 65536 * PLL_P) */
-				output +=3D p.k * input_fref;
-				/* Make it in mHz */
-				output *=3D MILLI;
-				output =3D DIV_U64_ROUND_CLOSEST(output, 65536 * p.p * divider);
-
-				/* Check output frequency against limits */
-				if (output < fout_min_millihz ||
-				    output > fout_max_millihz)
-					continue;
-
-				p.error_millihz =3D freq_millihz - output;
-				p.freq_millihz =3D output;
-
-				/* If an exact match is found, return immediately */
-				if (p.error_millihz =3D=3D 0) {
-					*pars =3D p;
-					return true;
-				}
-
-				/* Update best match if error is smaller */
-				if (abs(best.error_millihz) > abs(p.error_millihz))
-					best =3D p;
-			}
-		}
-	}
-
-	/* If no valid parameters were found, return false */
-	if (best.error_millihz =3D=3D S64_MAX)
-		return false;
-
-	*pars =3D best;
-	return true;
-}
-EXPORT_SYMBOL_NS_GPL(rzv2h_get_pll_pars, RZV2H_CPG);
-
-/*
- * rzv2h_get_pll_divs_pars - Finds the best combination of PLL parameters
- * and divider value for a given frequency.
- *
- * @limits: Pointer to the structure containing the limits for the PLL par=
ameters
- * @pars: Pointer to the structure where the best calculated PLL parameter=
s and
- * divider values will be stored
- * @table: Pointer to the array of valid divider values
- * @table_size: Size of the divider values array
- * @freq_millihz: Target output frequency in millihertz
- *
- * This function calculates the best set of PLL parameters (M, K, P, S) an=
d divider
- * value to achieve the desired frequency. See rzv2h_get_pll_pars() for mo=
re details
- * on how the PLL parameters are calculated.
- *
- * freq_millihz is the desired frequency generated by the PLL followed by =
a
- * a gear.
- */
-bool rzv2h_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
-			     struct rzv2h_pll_div_pars *pars,
-			     const u8 *table, u8 table_size, u64 freq_millihz)
-{
-	struct rzv2h_pll_div_pars p, best;
-
-	best.div.error_millihz =3D S64_MAX;
-	p.div.error_millihz =3D S64_MAX;
-	for (unsigned int i =3D 0; i < table_size; i++) {
-		if (!rzv2h_get_pll_pars(limits, &p.pll, freq_millihz * table[i]))
-			continue;
-
-		p.div.divider_value =3D table[i];
-		p.div.freq_millihz =3D DIV_U64_ROUND_CLOSEST(p.pll.freq_millihz, table[i=
]);
-		p.div.error_millihz =3D freq_millihz - p.div.freq_millihz;
-
-		if (p.div.error_millihz =3D=3D 0) {
-			*pars =3D p;
-			return true;
-		}
-
-		if (abs(best.div.error_millihz) > abs(p.div.error_millihz))
-			best =3D p;
-	}
-
-	if (best.div.error_millihz =3D=3D S64_MAX)
-		return false;
-
-	*pars =3D best;
-	return true;
-}
-EXPORT_SYMBOL_NS_GPL(rzv2h_get_pll_divs_pars, RZV2H_CPG);
-
 /**
  * struct rzv2h_plldsi_mux_clk - PLL DSI MUX clock
  *
diff --git a/include/linux/clk/renesas.h b/include/linux/clk/renesas.h
index 039cf545a20b6..168ae20f52a02 100644
--- a/include/linux/clk/renesas.h
+++ b/include/linux/clk/renesas.h
@@ -169,28 +169,31 @@ struct rzv2h_pll_div_pars {
 		.k =3D { .min =3D -32768, .max =3D 32767 },			\
 	}								\
=20
-#ifdef CONFIG_CLK_RZV2H
-bool rzv2h_get_pll_pars(const struct rzv2h_pll_limits *limits,
-			struct rzv2h_pll_pars *pars, u64 freq_millihz);
+#ifdef CONFIG_CLK_RZV2H_CPG_LIB
+bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *limits,
+			    struct rzv2h_pll_pars *pars, u64 freq_millihz);
=20
-bool rzv2h_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
-			     struct rzv2h_pll_div_pars *pars,
-			     const u8 *table, u8 table_size, u64 freq_millihz);
+bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limits *limits,
+				 struct rzv2h_pll_div_pars *pars,
+				 const u8 *table, u8 table_size, u64 freq_millihz);
 #else
-static inline bool rzv2h_get_pll_pars(const struct rzv2h_pll_limits *limit=
s,
-				      struct rzv2h_pll_pars *pars,
-				      u64 freq_millihz)
+static inline bool rzv2h_cpg_get_pll_pars(const struct rzv2h_pll_limits *l=
imits,
+					  struct rzv2h_pll_pars *pars,
+					  u64 freq_millihz)
 {
 	return false;
 }
=20
-static inline bool rzv2h_get_pll_divs_pars(const struct rzv2h_pll_limits *=
limits,
-					   struct rzv2h_pll_div_pars *pars,
-					   const u8 *table, u8 table_size,
-					   u64 freq_millihz)
+static inline bool rzv2h_cpg_get_pll_divs_pars(const struct rzv2h_pll_limi=
ts *limits,
+					       struct rzv2h_pll_div_pars *pars,
+					       const u8 *table, u8 table_size,
+					       u64 freq_millihz)
 {
 	return false;
 }
 #endif
=20
+#define rzv2h_get_pll_pars	rzv2h_cpg_get_pll_pars
+#define rzv2h_get_pll_divs_pars	rzv2h_cpg_get_pll_divs_pars
+
 #endif
--=20
2.43.0

