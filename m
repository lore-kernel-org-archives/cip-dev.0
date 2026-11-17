Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15958.1794916023244202070
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 03:47:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=gktq=jg=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 10EEB437EA;
	Tue, 17 Nov 2026 11:47:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57011F000C4;
	Tue, 17 Nov 2026 11:47:01 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 41/69] clk: renesas: r9a08g045: Add I3C clocks and resets
Date: Tue, 17 Nov 2026 13:45:25 +0200
Message-ID: <20261117114553.1484215-42-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
References: <20261117114553.1484215-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 11:47:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24882
Content-Type: text/plain; charset="utf-8"

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 148bda0cfeae913b1212c4c683e6d3f6ae1a5e69 upstream.

Extracted from the BSP driver and rebased.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250630192438.38311-2-wsa+renesas@sang-eng=
ineering.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict b/w PCIe and I3C clocks and resets by
 keeping them all]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9=
a08g045-cpg.c
index 937a044cd5d3..cb4b004e7bc7 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -182,6 +182,7 @@ static const struct cpg_core_clk r9a08g045_core_clks[=
] __initconst =3D {
 	DEF_G3S_DIV("P3", R9A08G045_CLK_P3, CLK_PLL3_DIV2_4, DIVPL3C, G3S_DIVPL=
3C_STS,
 		    dtable_1_32, 0, 0, 0, NULL),
 	DEF_FIXED("P3_DIV2", CLK_P3_DIV2, R9A08G045_CLK_P3, 1, 2),
+	DEF_FIXED("P5", R9A08G045_CLK_P5, CLK_PLL2_DIV2, 1, 4),
 	DEF_FIXED("ZT", R9A08G045_CLK_ZT, CLK_PLL3_DIV2_8, 1, 1),
 	DEF_FIXED("S0", R9A08G045_CLK_S0, CLK_SEL_PLL4, 1, 2),
 	DEF_FIXED("OSC", R9A08G045_OSCCLK, CLK_EXTAL, 1, 1),
@@ -295,6 +296,10 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks=
[] =3D {
 					MSTOP(BUS_PERI_COM, BIT(10))),
 	DEF_MOD("pci_clkl1pm",		R9A08G045_PCI_CLKL1PM, R9A08G045_CLK_ZT, 0x608,=
 1,
 					MSTOP(BUS_PERI_COM, BIT(10))),
+	DEF_MOD("i3c_pclk",             R9A08G045_I3C_PCLK, R9A08G045_CLK_TSU, =
0x610, 0,
+					MSTOP(BUS_MCPU3, BIT(10))),
+	DEF_MOD("i3c_tclk",             R9A08G045_I3C_TCLK, R9A08G045_CLK_P5, 0=
x610, 1,
+					MSTOP(BUS_MCPU3, BIT(10))),
 	DEF_MOD("vbat_bclk",		R9A08G045_VBAT_BCLK, R9A08G045_OSCCLK, 0x614, 0,
 					MSTOP(BUS_MCPU3, GENMASK(8, 7))),
 };
@@ -342,6 +347,8 @@ static const struct rzg2l_reset r9a08g045_resets[] =3D=
 {
 	DEF_RST(R9A08G045_PCI_RST_RSM_B, 0x908, 4),
 	DEF_RST(R9A08G045_PCI_RST_CFG_B, 0x908, 5),
 	DEF_RST(R9A08G045_PCI_RST_LOAD_B, 0x908, 6),
+	DEF_RST(R9A08G045_I3C_TRESETN, 0x910, 0),
+	DEF_RST(R9A08G045_I3C_PRESETN, 0x910, 1),
 	DEF_RST(R9A08G045_VBAT_BRESETN, 0x914, 0),
 };
=20
--=20
2.43.0

