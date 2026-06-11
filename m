Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C09CD98D7
	for <webhook@archiver.kernel.org>; Thu, 11 Jun 2026 10:45:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42601.1781174737025307826
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jun 2026 03:45:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=pbru=eh=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CF2F443378;
	Thu, 11 Jun 2026 10:45:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC4F1F00893;
	Thu, 11 Jun 2026 10:45:35 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 01/21] clk: renesas: r9a08g045: Add clocks, resets and power domains for USB
Date: Thu, 11 Jun 2026 13:45:11 +0300
Message-ID: <20260611104532.2532863-2-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
References: <20260611104532.2532863-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jun 2026 10:45:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23090

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit f0fe60cae63573c801246204414e70035770bdc6 upstream.

Add clocks, resets and power domains for USB modules available on the
Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240822152801.602318-2-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
 - fixed conflict in r9a08g045_mod_clks[] array by keeping the code from
   v6.1 CIP and adding USB clocks along with filling the MSTOP
   information (as this was not present in the original commit)
 - fixed conflict in r9a08g045_resets[] array by keeping both the SSI
   and USB nodes
 - dropped the r9a08g045_pm_domains[] as this is not available in v6.1
   CIP
 - kept r9a08g045_no_pm_mod_clks[] array]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/r9a08g045-cpg.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/renesas/r9a08g045-cpg.c b/drivers/clk/renesas/r9=
a08g045-cpg.c
index 3e8eae79af09..937a044cd5d3 100644
--- a/drivers/clk/renesas/r9a08g045-cpg.c
+++ b/drivers/clk/renesas/r9a08g045-cpg.c
@@ -245,6 +245,14 @@ static const struct rzg2l_mod_clk r9a08g045_mod_clks=
[] =3D {
 					MSTOP(BUS_MCPU1, BIT(13))),
 	DEF_MOD("ssi3_sfr",		R9A08G045_SSI3_PCLK_SFR, R9A08G045_CLK_P0, 0x570, =
7,
 					MSTOP(BUS_MCPU1, BIT(13))),
+	DEF_MOD("usb0_host",		R9A08G045_USB_U2H0_HCLK, R9A08G045_CLK_P1, 0x578,=
 0,
+					MSTOP(BUS_PERI_COM, BIT(5))),
+	DEF_MOD("usb1_host",		R9A08G045_USB_U2H1_HCLK, R9A08G045_CLK_P1, 0x578,=
 1,
+					MSTOP(BUS_PERI_COM, BIT(7))),
+	DEF_MOD("usb0_func",		R9A08G045_USB_U2P_EXR_CPUCLK, R9A08G045_CLK_P1, 0=
x578, 2,
+					MSTOP(BUS_PERI_COM, BIT(6))),
+	DEF_MOD("usb_pclk",		R9A08G045_USB_PCLK, R9A08G045_CLK_P1, 0x578, 3,
+					MSTOP(BUS_PERI_COM, BIT(4))),
 	DEF_COUPLED("eth0_axi",		R9A08G045_ETH0_CLK_AXI, R9A08G045_CLK_M0, 0x57=
c, 0,
 					MSTOP(BUS_PERI_COM, BIT(2))),
 	DEF_COUPLED("eth0_chi",		R9A08G045_ETH0_CLK_CHI, R9A08G045_CLK_ZT, 0x57=
c, 0,
@@ -305,6 +313,10 @@ static const struct rzg2l_reset r9a08g045_resets[] =3D=
 {
 	DEF_RST(R9A08G045_SSI1_RST_M2_REG, 0x870, 1),
 	DEF_RST(R9A08G045_SSI2_RST_M2_REG, 0x870, 2),
 	DEF_RST(R9A08G045_SSI3_RST_M2_REG, 0x870, 3),
+	DEF_RST(R9A08G045_USB_U2H0_HRESETN, 0x878, 0),
+	DEF_RST(R9A08G045_USB_U2H1_HRESETN, 0x878, 1),
+	DEF_RST(R9A08G045_USB_U2P_EXL_SYSRST, 0x878, 2),
+	DEF_RST(R9A08G045_USB_PRESETN, 0x878, 3),
 	DEF_RST(R9A08G045_ETH0_RST_HW_N, 0x87c, 0),
 	DEF_RST(R9A08G045_ETH1_RST_HW_N, 0x87c, 1),
 	DEF_RST(R9A08G045_I2C0_MRST, 0x880, 0),
--=20
2.43.0


