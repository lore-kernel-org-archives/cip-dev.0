Return-Path: <SRS0=RA9q=CG=lists.cip-project.org=bounce+64572+5313+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,UPPERCASE_50_75 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2576BC433E7
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBB6D208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="DWgsMTc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBB6D208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5313+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LiVFYY4521723xMh7viF0EUi; Fri, 28 Aug 2020 09:07:52 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.45775.1598629367424711810
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:48 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804749"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:46 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D433C400C9FD;
	Sat, 29 Aug 2020 00:42:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 23/30] pinctrl: sh-pfc: r8a7790: Add r8a7742 PFC support
Date: Fri, 28 Aug 2020 16:41:48 +0100
Message-Id: <20200828154155.5827-24-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PrrvzhXT3QjDj4eqLW6DcPhcx4520388AA=
Content-Type: multipart/mixed; boundary="iVD8GJboSs2m8vwb0hk8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630872;
 bh=OcHX1fJgEobfK8pWV+vlUasR4lP3J1mHLhio+tqiv8o=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=DWgsMTc/Z6TIql6o+k8hz6WyVTFpAiix9UysOhV3KrRdvWovT+rhOYX2tJZFtIj+b4x
 plPEfnouCTyM2YxHyf/26g+cS7/haBKDLChNmtzUKgaeXrgHsd/ezOxuBVtN/A6QTmD0O
 rRoOiqZ2wCKXJuCgDj+1uyl+YkbqFZbPWNU=

--iVD8GJboSs2m8vwb0hk8

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4ecc7ff82ecfdf44997ed2a1016945fc8f6fca3e upstream.

Renesas RZ/G1H (R8A7742) is pin compatible with R-Car H2 (R8A7790),
however it doesn't have several automotive specific peripherals. Add
automotive-specific pin groups/functions along with common pin
groups/functions for supporting both r8a7790 and r8a7742 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588542414-14826-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: removed voltage switching, tdsel related changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/Kconfig       |   5 +
 drivers/pinctrl/sh-pfc/Makefile      |   1 +
 drivers/pinctrl/sh-pfc/core.c        |   6 +
 drivers/pinctrl/sh-pfc/core.h        |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 743 ++++++++++++++-------------
 5 files changed, 404 insertions(+), 352 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index eef770b6acc6..f4a2a9f708a4 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -35,6 +35,11 @@ config PINCTRL_PFC_R8A7740
 	depends on ARCH_R8A7740
 	select PINCTRL_SH_PFC
 
+config PINCTRL_PFC_R8A7742
+	def_bool y
+	depends on ARCH_R8A7742
+	select PINCTRL_SH_PFC
+
 config PINCTRL_PFC_R8A7743
 	def_bool y
 	depends on ARCH_R8A7743
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index 5310c07daaa2..39180441e538 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_PINCTRL_SH_PFC)	+= sh-pfc.o
 obj-$(CONFIG_PINCTRL_PFC_EMEV2)	+= pfc-emev2.o
 obj-$(CONFIG_PINCTRL_PFC_R8A73A4)	+= pfc-r8a73a4.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7740)	+= pfc-r8a7740.o
+obj-$(CONFIG_PINCTRL_PFC_R8A7742)	+= pfc-r8a7790.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7743)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7744)	+= pfc-r8a7791.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7745)	+= pfc-r8a7794.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 6827a398ed0f..0fd6833b8259 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -453,6 +453,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a7740_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A7742
+	{
+		.compatible = "renesas,pfc-r8a7742",
+		.data = &r8a7742_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7743
 	{
 		.compatible = "renesas,pfc-r8a7743",
diff --git a/drivers/pinctrl/sh-pfc/core.h b/drivers/pinctrl/sh-pfc/core.h
index 5675ecf3bc94..d67d2fb8888a 100644
--- a/drivers/pinctrl/sh-pfc/core.h
+++ b/drivers/pinctrl/sh-pfc/core.h
@@ -69,6 +69,7 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type);
 extern const struct sh_pfc_soc_info emev2_pinmux_info;
 extern const struct sh_pfc_soc_info r8a73a4_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7740_pinmux_info;
+extern const struct sh_pfc_soc_info r8a7742_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7743_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7744_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7745_pinmux_info;
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index a790e913e6bb..00b64c5ec866 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -3957,297 +3957,304 @@ static const unsigned int vin3_clk_mux[] = {
 	VI3_CLK_MARK,
 };
 
-static const struct sh_pfc_pin_group pinmux_groups[] = {
-	SH_PFC_PIN_GROUP(audio_clk_a),
-	SH_PFC_PIN_GROUP(audio_clk_b),
-	SH_PFC_PIN_GROUP(audio_clk_c),
-	SH_PFC_PIN_GROUP(audio_clkout),
-	SH_PFC_PIN_GROUP(audio_clkout_b),
-	SH_PFC_PIN_GROUP(audio_clkout_c),
-	SH_PFC_PIN_GROUP(audio_clkout_d),
-	SH_PFC_PIN_GROUP(avb_link),
-	SH_PFC_PIN_GROUP(avb_magic),
-	SH_PFC_PIN_GROUP(avb_phy_int),
-	SH_PFC_PIN_GROUP(avb_mdio),
-	SH_PFC_PIN_GROUP(avb_mii),
-	SH_PFC_PIN_GROUP(avb_gmii),
-	SH_PFC_PIN_GROUP(du_rgb666),
-	SH_PFC_PIN_GROUP(du_rgb888),
-	SH_PFC_PIN_GROUP(du_clk_out_0),
-	SH_PFC_PIN_GROUP(du_clk_out_1),
-	SH_PFC_PIN_GROUP(du_sync_0),
-	SH_PFC_PIN_GROUP(du_sync_1),
-	SH_PFC_PIN_GROUP(du_cde),
-	SH_PFC_PIN_GROUP(du0_clk_in),
-	SH_PFC_PIN_GROUP(du1_clk_in),
-	SH_PFC_PIN_GROUP(du2_clk_in),
-	SH_PFC_PIN_GROUP(eth_link),
-	SH_PFC_PIN_GROUP(eth_magic),
-	SH_PFC_PIN_GROUP(eth_mdio),
-	SH_PFC_PIN_GROUP(eth_rmii),
-	SH_PFC_PIN_GROUP(hscif0_data),
-	SH_PFC_PIN_GROUP(hscif0_clk),
-	SH_PFC_PIN_GROUP(hscif0_ctrl),
-	SH_PFC_PIN_GROUP(hscif0_data_b),
-	SH_PFC_PIN_GROUP(hscif0_ctrl_b),
-	SH_PFC_PIN_GROUP(hscif0_data_c),
-	SH_PFC_PIN_GROUP(hscif0_ctrl_c),
-	SH_PFC_PIN_GROUP(hscif0_data_d),
-	SH_PFC_PIN_GROUP(hscif0_ctrl_d),
-	SH_PFC_PIN_GROUP(hscif0_data_e),
-	SH_PFC_PIN_GROUP(hscif0_ctrl_e),
-	SH_PFC_PIN_GROUP(hscif0_data_f),
-	SH_PFC_PIN_GROUP(hscif0_ctrl_f),
-	SH_PFC_PIN_GROUP(hscif1_data),
-	SH_PFC_PIN_GROUP(hscif1_clk),
-	SH_PFC_PIN_GROUP(hscif1_ctrl),
-	SH_PFC_PIN_GROUP(hscif1_data_b),
-	SH_PFC_PIN_GROUP(hscif1_clk_b),
-	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
-	SH_PFC_PIN_GROUP(i2c0),
-	SH_PFC_PIN_GROUP(i2c1),
-	SH_PFC_PIN_GROUP(i2c1_b),
-	SH_PFC_PIN_GROUP(i2c1_c),
-	SH_PFC_PIN_GROUP(i2c2),
-	SH_PFC_PIN_GROUP(i2c2_b),
-	SH_PFC_PIN_GROUP(i2c2_c),
-	SH_PFC_PIN_GROUP(i2c2_d),
-	SH_PFC_PIN_GROUP(i2c2_e),
-	SH_PFC_PIN_GROUP(i2c3),
-	SH_PFC_PIN_GROUP(iic0),
-	SH_PFC_PIN_GROUP(iic1),
-	SH_PFC_PIN_GROUP(iic1_b),
-	SH_PFC_PIN_GROUP(iic1_c),
-	SH_PFC_PIN_GROUP(iic2),
-	SH_PFC_PIN_GROUP(iic2_b),
-	SH_PFC_PIN_GROUP(iic2_c),
-	SH_PFC_PIN_GROUP(iic2_d),
-	SH_PFC_PIN_GROUP(iic2_e),
-	SH_PFC_PIN_GROUP(iic3),
-	SH_PFC_PIN_GROUP(intc_irq0),
-	SH_PFC_PIN_GROUP(intc_irq1),
-	SH_PFC_PIN_GROUP(intc_irq2),
-	SH_PFC_PIN_GROUP(intc_irq3),
-	SH_PFC_PIN_GROUP(mlb_3pin),
-	SH_PFC_PIN_GROUP(mmc0_data1),
-	SH_PFC_PIN_GROUP(mmc0_data4),
-	SH_PFC_PIN_GROUP(mmc0_data8),
-	SH_PFC_PIN_GROUP(mmc0_ctrl),
-	SH_PFC_PIN_GROUP(mmc1_data1),
-	SH_PFC_PIN_GROUP(mmc1_data4),
-	SH_PFC_PIN_GROUP(mmc1_data8),
-	SH_PFC_PIN_GROUP(mmc1_ctrl),
-	SH_PFC_PIN_GROUP(msiof0_clk),
-	SH_PFC_PIN_GROUP(msiof0_sync),
-	SH_PFC_PIN_GROUP(msiof0_ss1),
-	SH_PFC_PIN_GROUP(msiof0_ss2),
-	SH_PFC_PIN_GROUP(msiof0_rx),
-	SH_PFC_PIN_GROUP(msiof0_tx),
-	SH_PFC_PIN_GROUP(msiof0_clk_b),
-	SH_PFC_PIN_GROUP(msiof0_ss1_b),
-	SH_PFC_PIN_GROUP(msiof0_ss2_b),
-	SH_PFC_PIN_GROUP(msiof0_rx_b),
-	SH_PFC_PIN_GROUP(msiof0_tx_b),
-	SH_PFC_PIN_GROUP(msiof1_clk),
-	SH_PFC_PIN_GROUP(msiof1_sync),
-	SH_PFC_PIN_GROUP(msiof1_ss1),
-	SH_PFC_PIN_GROUP(msiof1_ss2),
-	SH_PFC_PIN_GROUP(msiof1_rx),
-	SH_PFC_PIN_GROUP(msiof1_tx),
-	SH_PFC_PIN_GROUP(msiof1_clk_b),
-	SH_PFC_PIN_GROUP(msiof1_ss1_b),
-	SH_PFC_PIN_GROUP(msiof1_ss2_b),
-	SH_PFC_PIN_GROUP(msiof1_rx_b),
-	SH_PFC_PIN_GROUP(msiof1_tx_b),
-	SH_PFC_PIN_GROUP(msiof2_clk),
-	SH_PFC_PIN_GROUP(msiof2_sync),
-	SH_PFC_PIN_GROUP(msiof2_ss1),
-	SH_PFC_PIN_GROUP(msiof2_ss2),
-	SH_PFC_PIN_GROUP(msiof2_rx),
-	SH_PFC_PIN_GROUP(msiof2_tx),
-	SH_PFC_PIN_GROUP(msiof3_clk),
-	SH_PFC_PIN_GROUP(msiof3_sync),
-	SH_PFC_PIN_GROUP(msiof3_ss1),
-	SH_PFC_PIN_GROUP(msiof3_ss2),
-	SH_PFC_PIN_GROUP(msiof3_rx),
-	SH_PFC_PIN_GROUP(msiof3_tx),
-	SH_PFC_PIN_GROUP(msiof3_clk_b),
-	SH_PFC_PIN_GROUP(msiof3_sync_b),
-	SH_PFC_PIN_GROUP(msiof3_rx_b),
-	SH_PFC_PIN_GROUP(msiof3_tx_b),
-	SH_PFC_PIN_GROUP(pwm0),
-	SH_PFC_PIN_GROUP(pwm0_b),
-	SH_PFC_PIN_GROUP(pwm1),
-	SH_PFC_PIN_GROUP(pwm1_b),
-	SH_PFC_PIN_GROUP(pwm2),
-	SH_PFC_PIN_GROUP(pwm3),
-	SH_PFC_PIN_GROUP(pwm4),
-	SH_PFC_PIN_GROUP(pwm5),
-	SH_PFC_PIN_GROUP(pwm6),
-	SH_PFC_PIN_GROUP(qspi_ctrl),
-	SH_PFC_PIN_GROUP(qspi_data2),
-	SH_PFC_PIN_GROUP(qspi_data4),
-	SH_PFC_PIN_GROUP(scif0_data),
-	SH_PFC_PIN_GROUP(scif0_clk),
-	SH_PFC_PIN_GROUP(scif0_ctrl),
-	SH_PFC_PIN_GROUP(scif0_data_b),
-	SH_PFC_PIN_GROUP(scif1_data),
-	SH_PFC_PIN_GROUP(scif1_clk),
-	SH_PFC_PIN_GROUP(scif1_ctrl),
-	SH_PFC_PIN_GROUP(scif1_data_b),
-	SH_PFC_PIN_GROUP(scif1_data_c),
-	SH_PFC_PIN_GROUP(scif1_data_d),
-	SH_PFC_PIN_GROUP(scif1_clk_d),
-	SH_PFC_PIN_GROUP(scif1_data_e),
-	SH_PFC_PIN_GROUP(scif1_clk_e),
-	SH_PFC_PIN_GROUP(scif2_data),
-	SH_PFC_PIN_GROUP(scif2_clk),
-	SH_PFC_PIN_GROUP(scif2_data_b),
-	SH_PFC_PIN_GROUP(scifa0_data),
-	SH_PFC_PIN_GROUP(scifa0_clk),
-	SH_PFC_PIN_GROUP(scifa0_ctrl),
-	SH_PFC_PIN_GROUP(scifa0_data_b),
-	SH_PFC_PIN_GROUP(scifa0_clk_b),
-	SH_PFC_PIN_GROUP(scifa0_ctrl_b),
-	SH_PFC_PIN_GROUP(scifa1_data),
-	SH_PFC_PIN_GROUP(scifa1_clk),
-	SH_PFC_PIN_GROUP(scifa1_ctrl),
-	SH_PFC_PIN_GROUP(scifa1_data_b),
-	SH_PFC_PIN_GROUP(scifa1_clk_b),
-	SH_PFC_PIN_GROUP(scifa1_ctrl_b),
-	SH_PFC_PIN_GROUP(scifa1_data_c),
-	SH_PFC_PIN_GROUP(scifa1_clk_c),
-	SH_PFC_PIN_GROUP(scifa1_ctrl_c),
-	SH_PFC_PIN_GROUP(scifa1_data_d),
-	SH_PFC_PIN_GROUP(scifa1_clk_d),
-	SH_PFC_PIN_GROUP(scifa1_ctrl_d),
-	SH_PFC_PIN_GROUP(scifa2_data),
-	SH_PFC_PIN_GROUP(scifa2_clk),
-	SH_PFC_PIN_GROUP(scifa2_ctrl),
-	SH_PFC_PIN_GROUP(scifa2_data_b),
-	SH_PFC_PIN_GROUP(scifa2_data_c),
-	SH_PFC_PIN_GROUP(scifa2_clk_c),
-	SH_PFC_PIN_GROUP(scifb0_data),
-	SH_PFC_PIN_GROUP(scifb0_clk),
-	SH_PFC_PIN_GROUP(scifb0_ctrl),
-	SH_PFC_PIN_GROUP(scifb0_data_b),
-	SH_PFC_PIN_GROUP(scifb0_clk_b),
-	SH_PFC_PIN_GROUP(scifb0_ctrl_b),
-	SH_PFC_PIN_GROUP(scifb0_data_c),
-	SH_PFC_PIN_GROUP(scifb1_data),
-	SH_PFC_PIN_GROUP(scifb1_clk),
-	SH_PFC_PIN_GROUP(scifb1_ctrl),
-	SH_PFC_PIN_GROUP(scifb1_data_b),
-	SH_PFC_PIN_GROUP(scifb1_clk_b),
-	SH_PFC_PIN_GROUP(scifb1_ctrl_b),
-	SH_PFC_PIN_GROUP(scifb1_data_c),
-	SH_PFC_PIN_GROUP(scifb1_data_d),
-	SH_PFC_PIN_GROUP(scifb1_data_e),
-	SH_PFC_PIN_GROUP(scifb1_clk_e),
-	SH_PFC_PIN_GROUP(scifb1_data_f),
-	SH_PFC_PIN_GROUP(scifb1_data_g),
-	SH_PFC_PIN_GROUP(scifb1_clk_g),
-	SH_PFC_PIN_GROUP(scifb2_data),
-	SH_PFC_PIN_GROUP(scifb2_clk),
-	SH_PFC_PIN_GROUP(scifb2_ctrl),
-	SH_PFC_PIN_GROUP(scifb2_data_b),
-	SH_PFC_PIN_GROUP(scifb2_clk_b),
-	SH_PFC_PIN_GROUP(scifb2_ctrl_b),
-	SH_PFC_PIN_GROUP(scifb2_data_c),
-	SH_PFC_PIN_GROUP(scif_clk),
-	SH_PFC_PIN_GROUP(scif_clk_b),
-	SH_PFC_PIN_GROUP(sdhi0_data1),
-	SH_PFC_PIN_GROUP(sdhi0_data4),
-	SH_PFC_PIN_GROUP(sdhi0_ctrl),
-	SH_PFC_PIN_GROUP(sdhi0_cd),
-	SH_PFC_PIN_GROUP(sdhi0_wp),
-	SH_PFC_PIN_GROUP(sdhi1_data1),
-	SH_PFC_PIN_GROUP(sdhi1_data4),
-	SH_PFC_PIN_GROUP(sdhi1_ctrl),
-	SH_PFC_PIN_GROUP(sdhi1_cd),
-	SH_PFC_PIN_GROUP(sdhi1_wp),
-	SH_PFC_PIN_GROUP(sdhi2_data1),
-	SH_PFC_PIN_GROUP(sdhi2_data4),
-	SH_PFC_PIN_GROUP(sdhi2_ctrl),
-	SH_PFC_PIN_GROUP(sdhi2_cd),
-	SH_PFC_PIN_GROUP(sdhi2_wp),
-	SH_PFC_PIN_GROUP(sdhi3_data1),
-	SH_PFC_PIN_GROUP(sdhi3_data4),
-	SH_PFC_PIN_GROUP(sdhi3_ctrl),
-	SH_PFC_PIN_GROUP(sdhi3_cd),
-	SH_PFC_PIN_GROUP(sdhi3_wp),
-	SH_PFC_PIN_GROUP(ssi0_data),
-	SH_PFC_PIN_GROUP(ssi0129_ctrl),
-	SH_PFC_PIN_GROUP(ssi1_data),
-	SH_PFC_PIN_GROUP(ssi1_ctrl),
-	SH_PFC_PIN_GROUP(ssi2_data),
-	SH_PFC_PIN_GROUP(ssi2_ctrl),
-	SH_PFC_PIN_GROUP(ssi3_data),
-	SH_PFC_PIN_GROUP(ssi34_ctrl),
-	SH_PFC_PIN_GROUP(ssi4_data),
-	SH_PFC_PIN_GROUP(ssi4_ctrl),
-	SH_PFC_PIN_GROUP(ssi5),
-	SH_PFC_PIN_GROUP(ssi5_b),
-	SH_PFC_PIN_GROUP(ssi5_c),
-	SH_PFC_PIN_GROUP(ssi6),
-	SH_PFC_PIN_GROUP(ssi6_b),
-	SH_PFC_PIN_GROUP(ssi7_data),
-	SH_PFC_PIN_GROUP(ssi7_b_data),
-	SH_PFC_PIN_GROUP(ssi7_c_data),
-	SH_PFC_PIN_GROUP(ssi78_ctrl),
-	SH_PFC_PIN_GROUP(ssi78_b_ctrl),
-	SH_PFC_PIN_GROUP(ssi78_c_ctrl),
-	SH_PFC_PIN_GROUP(ssi8_data),
-	SH_PFC_PIN_GROUP(ssi8_b_data),
-	SH_PFC_PIN_GROUP(ssi8_c_data),
-	SH_PFC_PIN_GROUP(ssi9_data),
-	SH_PFC_PIN_GROUP(ssi9_ctrl),
-	SH_PFC_PIN_GROUP(tpu0_to0),
-	SH_PFC_PIN_GROUP(tpu0_to1),
-	SH_PFC_PIN_GROUP(tpu0_to2),
-	SH_PFC_PIN_GROUP(tpu0_to3),
-	SH_PFC_PIN_GROUP(usb0),
-	SH_PFC_PIN_GROUP(usb0_ovc_vbus),
-	SH_PFC_PIN_GROUP(usb1),
-	SH_PFC_PIN_GROUP(usb2),
-	VIN_DATA_PIN_GROUP(vin0_data, 24),
-	VIN_DATA_PIN_GROUP(vin0_data, 20),
-	SH_PFC_PIN_GROUP(vin0_data18),
-	VIN_DATA_PIN_GROUP(vin0_data, 16),
-	VIN_DATA_PIN_GROUP(vin0_data, 12),
-	VIN_DATA_PIN_GROUP(vin0_data, 10),
-	VIN_DATA_PIN_GROUP(vin0_data, 8),
-	VIN_DATA_PIN_GROUP(vin0_data, 4),
-	SH_PFC_PIN_GROUP(vin0_sync),
-	SH_PFC_PIN_GROUP(vin0_field),
-	SH_PFC_PIN_GROUP(vin0_clkenb),
-	SH_PFC_PIN_GROUP(vin0_clk),
-	VIN_DATA_PIN_GROUP(vin1_data, 24),
-	VIN_DATA_PIN_GROUP(vin1_data, 20),
-	SH_PFC_PIN_GROUP(vin1_data18),
-	VIN_DATA_PIN_GROUP(vin1_data, 16),
-	VIN_DATA_PIN_GROUP(vin1_data, 12),
-	VIN_DATA_PIN_GROUP(vin1_data, 10),
-	VIN_DATA_PIN_GROUP(vin1_data, 8),
-	VIN_DATA_PIN_GROUP(vin1_data, 4),
-	SH_PFC_PIN_GROUP(vin1_sync),
-	SH_PFC_PIN_GROUP(vin1_field),
-	SH_PFC_PIN_GROUP(vin1_clkenb),
-	SH_PFC_PIN_GROUP(vin1_clk),
-	VIN_DATA_PIN_GROUP(vin2_data, 24),
-	SH_PFC_PIN_GROUP(vin2_data18),
-	VIN_DATA_PIN_GROUP(vin2_data, 16),
-	VIN_DATA_PIN_GROUP(vin2_data, 8),
-	VIN_DATA_PIN_GROUP(vin2_data, 4),
-	SH_PFC_PIN_GROUP(vin2_sync),
-	SH_PFC_PIN_GROUP(vin2_field),
-	SH_PFC_PIN_GROUP(vin2_clkenb),
-	SH_PFC_PIN_GROUP(vin2_clk),
-	SH_PFC_PIN_GROUP(vin3_data8),
-	SH_PFC_PIN_GROUP(vin3_sync),
-	SH_PFC_PIN_GROUP(vin3_field),
-	SH_PFC_PIN_GROUP(vin3_clkenb),
-	SH_PFC_PIN_GROUP(vin3_clk),
+static const struct {
+	struct sh_pfc_pin_group common[289];
+	struct sh_pfc_pin_group automotive[1];
+} pinmux_groups = {
+	.common = {
+		SH_PFC_PIN_GROUP(audio_clk_a),
+		SH_PFC_PIN_GROUP(audio_clk_b),
+		SH_PFC_PIN_GROUP(audio_clk_c),
+		SH_PFC_PIN_GROUP(audio_clkout),
+		SH_PFC_PIN_GROUP(audio_clkout_b),
+		SH_PFC_PIN_GROUP(audio_clkout_c),
+		SH_PFC_PIN_GROUP(audio_clkout_d),
+		SH_PFC_PIN_GROUP(avb_link),
+		SH_PFC_PIN_GROUP(avb_magic),
+		SH_PFC_PIN_GROUP(avb_phy_int),
+		SH_PFC_PIN_GROUP(avb_mdio),
+		SH_PFC_PIN_GROUP(avb_mii),
+		SH_PFC_PIN_GROUP(avb_gmii),
+		SH_PFC_PIN_GROUP(du_rgb666),
+		SH_PFC_PIN_GROUP(du_rgb888),
+		SH_PFC_PIN_GROUP(du_clk_out_0),
+		SH_PFC_PIN_GROUP(du_clk_out_1),
+		SH_PFC_PIN_GROUP(du_sync_0),
+		SH_PFC_PIN_GROUP(du_sync_1),
+		SH_PFC_PIN_GROUP(du_cde),
+		SH_PFC_PIN_GROUP(du0_clk_in),
+		SH_PFC_PIN_GROUP(du1_clk_in),
+		SH_PFC_PIN_GROUP(du2_clk_in),
+		SH_PFC_PIN_GROUP(eth_link),
+		SH_PFC_PIN_GROUP(eth_magic),
+		SH_PFC_PIN_GROUP(eth_mdio),
+		SH_PFC_PIN_GROUP(eth_rmii),
+		SH_PFC_PIN_GROUP(hscif0_data),
+		SH_PFC_PIN_GROUP(hscif0_clk),
+		SH_PFC_PIN_GROUP(hscif0_ctrl),
+		SH_PFC_PIN_GROUP(hscif0_data_b),
+		SH_PFC_PIN_GROUP(hscif0_ctrl_b),
+		SH_PFC_PIN_GROUP(hscif0_data_c),
+		SH_PFC_PIN_GROUP(hscif0_ctrl_c),
+		SH_PFC_PIN_GROUP(hscif0_data_d),
+		SH_PFC_PIN_GROUP(hscif0_ctrl_d),
+		SH_PFC_PIN_GROUP(hscif0_data_e),
+		SH_PFC_PIN_GROUP(hscif0_ctrl_e),
+		SH_PFC_PIN_GROUP(hscif0_data_f),
+		SH_PFC_PIN_GROUP(hscif0_ctrl_f),
+		SH_PFC_PIN_GROUP(hscif1_data),
+		SH_PFC_PIN_GROUP(hscif1_clk),
+		SH_PFC_PIN_GROUP(hscif1_ctrl),
+		SH_PFC_PIN_GROUP(hscif1_data_b),
+		SH_PFC_PIN_GROUP(hscif1_clk_b),
+		SH_PFC_PIN_GROUP(hscif1_ctrl_b),
+		SH_PFC_PIN_GROUP(i2c0),
+		SH_PFC_PIN_GROUP(i2c1),
+		SH_PFC_PIN_GROUP(i2c1_b),
+		SH_PFC_PIN_GROUP(i2c1_c),
+		SH_PFC_PIN_GROUP(i2c2),
+		SH_PFC_PIN_GROUP(i2c2_b),
+		SH_PFC_PIN_GROUP(i2c2_c),
+		SH_PFC_PIN_GROUP(i2c2_d),
+		SH_PFC_PIN_GROUP(i2c2_e),
+		SH_PFC_PIN_GROUP(i2c3),
+		SH_PFC_PIN_GROUP(iic0),
+		SH_PFC_PIN_GROUP(iic1),
+		SH_PFC_PIN_GROUP(iic1_b),
+		SH_PFC_PIN_GROUP(iic1_c),
+		SH_PFC_PIN_GROUP(iic2),
+		SH_PFC_PIN_GROUP(iic2_b),
+		SH_PFC_PIN_GROUP(iic2_c),
+		SH_PFC_PIN_GROUP(iic2_d),
+		SH_PFC_PIN_GROUP(iic2_e),
+		SH_PFC_PIN_GROUP(iic3),
+		SH_PFC_PIN_GROUP(intc_irq0),
+		SH_PFC_PIN_GROUP(intc_irq1),
+		SH_PFC_PIN_GROUP(intc_irq2),
+		SH_PFC_PIN_GROUP(intc_irq3),
+		SH_PFC_PIN_GROUP(mmc0_data1),
+		SH_PFC_PIN_GROUP(mmc0_data4),
+		SH_PFC_PIN_GROUP(mmc0_data8),
+		SH_PFC_PIN_GROUP(mmc0_ctrl),
+		SH_PFC_PIN_GROUP(mmc1_data1),
+		SH_PFC_PIN_GROUP(mmc1_data4),
+		SH_PFC_PIN_GROUP(mmc1_data8),
+		SH_PFC_PIN_GROUP(mmc1_ctrl),
+		SH_PFC_PIN_GROUP(msiof0_clk),
+		SH_PFC_PIN_GROUP(msiof0_sync),
+		SH_PFC_PIN_GROUP(msiof0_ss1),
+		SH_PFC_PIN_GROUP(msiof0_ss2),
+		SH_PFC_PIN_GROUP(msiof0_rx),
+		SH_PFC_PIN_GROUP(msiof0_tx),
+		SH_PFC_PIN_GROUP(msiof0_clk_b),
+		SH_PFC_PIN_GROUP(msiof0_ss1_b),
+		SH_PFC_PIN_GROUP(msiof0_ss2_b),
+		SH_PFC_PIN_GROUP(msiof0_rx_b),
+		SH_PFC_PIN_GROUP(msiof0_tx_b),
+		SH_PFC_PIN_GROUP(msiof1_clk),
+		SH_PFC_PIN_GROUP(msiof1_sync),
+		SH_PFC_PIN_GROUP(msiof1_ss1),
+		SH_PFC_PIN_GROUP(msiof1_ss2),
+		SH_PFC_PIN_GROUP(msiof1_rx),
+		SH_PFC_PIN_GROUP(msiof1_tx),
+		SH_PFC_PIN_GROUP(msiof1_clk_b),
+		SH_PFC_PIN_GROUP(msiof1_ss1_b),
+		SH_PFC_PIN_GROUP(msiof1_ss2_b),
+		SH_PFC_PIN_GROUP(msiof1_rx_b),
+		SH_PFC_PIN_GROUP(msiof1_tx_b),
+		SH_PFC_PIN_GROUP(msiof2_clk),
+		SH_PFC_PIN_GROUP(msiof2_sync),
+		SH_PFC_PIN_GROUP(msiof2_ss1),
+		SH_PFC_PIN_GROUP(msiof2_ss2),
+		SH_PFC_PIN_GROUP(msiof2_rx),
+		SH_PFC_PIN_GROUP(msiof2_tx),
+		SH_PFC_PIN_GROUP(msiof3_clk),
+		SH_PFC_PIN_GROUP(msiof3_sync),
+		SH_PFC_PIN_GROUP(msiof3_ss1),
+		SH_PFC_PIN_GROUP(msiof3_ss2),
+		SH_PFC_PIN_GROUP(msiof3_rx),
+		SH_PFC_PIN_GROUP(msiof3_tx),
+		SH_PFC_PIN_GROUP(msiof3_clk_b),
+		SH_PFC_PIN_GROUP(msiof3_sync_b),
+		SH_PFC_PIN_GROUP(msiof3_rx_b),
+		SH_PFC_PIN_GROUP(msiof3_tx_b),
+		SH_PFC_PIN_GROUP(pwm0),
+		SH_PFC_PIN_GROUP(pwm0_b),
+		SH_PFC_PIN_GROUP(pwm1),
+		SH_PFC_PIN_GROUP(pwm1_b),
+		SH_PFC_PIN_GROUP(pwm2),
+		SH_PFC_PIN_GROUP(pwm3),
+		SH_PFC_PIN_GROUP(pwm4),
+		SH_PFC_PIN_GROUP(pwm5),
+		SH_PFC_PIN_GROUP(pwm6),
+		SH_PFC_PIN_GROUP(qspi_ctrl),
+		SH_PFC_PIN_GROUP(qspi_data2),
+		SH_PFC_PIN_GROUP(qspi_data4),
+		SH_PFC_PIN_GROUP(scif0_data),
+		SH_PFC_PIN_GROUP(scif0_clk),
+		SH_PFC_PIN_GROUP(scif0_ctrl),
+		SH_PFC_PIN_GROUP(scif0_data_b),
+		SH_PFC_PIN_GROUP(scif1_data),
+		SH_PFC_PIN_GROUP(scif1_clk),
+		SH_PFC_PIN_GROUP(scif1_ctrl),
+		SH_PFC_PIN_GROUP(scif1_data_b),
+		SH_PFC_PIN_GROUP(scif1_data_c),
+		SH_PFC_PIN_GROUP(scif1_data_d),
+		SH_PFC_PIN_GROUP(scif1_clk_d),
+		SH_PFC_PIN_GROUP(scif1_data_e),
+		SH_PFC_PIN_GROUP(scif1_clk_e),
+		SH_PFC_PIN_GROUP(scif2_data),
+		SH_PFC_PIN_GROUP(scif2_clk),
+		SH_PFC_PIN_GROUP(scif2_data_b),
+		SH_PFC_PIN_GROUP(scifa0_data),
+		SH_PFC_PIN_GROUP(scifa0_clk),
+		SH_PFC_PIN_GROUP(scifa0_ctrl),
+		SH_PFC_PIN_GROUP(scifa0_data_b),
+		SH_PFC_PIN_GROUP(scifa0_clk_b),
+		SH_PFC_PIN_GROUP(scifa0_ctrl_b),
+		SH_PFC_PIN_GROUP(scifa1_data),
+		SH_PFC_PIN_GROUP(scifa1_clk),
+		SH_PFC_PIN_GROUP(scifa1_ctrl),
+		SH_PFC_PIN_GROUP(scifa1_data_b),
+		SH_PFC_PIN_GROUP(scifa1_clk_b),
+		SH_PFC_PIN_GROUP(scifa1_ctrl_b),
+		SH_PFC_PIN_GROUP(scifa1_data_c),
+		SH_PFC_PIN_GROUP(scifa1_clk_c),
+		SH_PFC_PIN_GROUP(scifa1_ctrl_c),
+		SH_PFC_PIN_GROUP(scifa1_data_d),
+		SH_PFC_PIN_GROUP(scifa1_clk_d),
+		SH_PFC_PIN_GROUP(scifa1_ctrl_d),
+		SH_PFC_PIN_GROUP(scifa2_data),
+		SH_PFC_PIN_GROUP(scifa2_clk),
+		SH_PFC_PIN_GROUP(scifa2_ctrl),
+		SH_PFC_PIN_GROUP(scifa2_data_b),
+		SH_PFC_PIN_GROUP(scifa2_data_c),
+		SH_PFC_PIN_GROUP(scifa2_clk_c),
+		SH_PFC_PIN_GROUP(scifb0_data),
+		SH_PFC_PIN_GROUP(scifb0_clk),
+		SH_PFC_PIN_GROUP(scifb0_ctrl),
+		SH_PFC_PIN_GROUP(scifb0_data_b),
+		SH_PFC_PIN_GROUP(scifb0_clk_b),
+		SH_PFC_PIN_GROUP(scifb0_ctrl_b),
+		SH_PFC_PIN_GROUP(scifb0_data_c),
+		SH_PFC_PIN_GROUP(scifb1_data),
+		SH_PFC_PIN_GROUP(scifb1_clk),
+		SH_PFC_PIN_GROUP(scifb1_ctrl),
+		SH_PFC_PIN_GROUP(scifb1_data_b),
+		SH_PFC_PIN_GROUP(scifb1_clk_b),
+		SH_PFC_PIN_GROUP(scifb1_ctrl_b),
+		SH_PFC_PIN_GROUP(scifb1_data_c),
+		SH_PFC_PIN_GROUP(scifb1_data_d),
+		SH_PFC_PIN_GROUP(scifb1_data_e),
+		SH_PFC_PIN_GROUP(scifb1_clk_e),
+		SH_PFC_PIN_GROUP(scifb1_data_f),
+		SH_PFC_PIN_GROUP(scifb1_data_g),
+		SH_PFC_PIN_GROUP(scifb1_clk_g),
+		SH_PFC_PIN_GROUP(scifb2_data),
+		SH_PFC_PIN_GROUP(scifb2_clk),
+		SH_PFC_PIN_GROUP(scifb2_ctrl),
+		SH_PFC_PIN_GROUP(scifb2_data_b),
+		SH_PFC_PIN_GROUP(scifb2_clk_b),
+		SH_PFC_PIN_GROUP(scifb2_ctrl_b),
+		SH_PFC_PIN_GROUP(scifb2_data_c),
+		SH_PFC_PIN_GROUP(scif_clk),
+		SH_PFC_PIN_GROUP(scif_clk_b),
+		SH_PFC_PIN_GROUP(sdhi0_data1),
+		SH_PFC_PIN_GROUP(sdhi0_data4),
+		SH_PFC_PIN_GROUP(sdhi0_ctrl),
+		SH_PFC_PIN_GROUP(sdhi0_cd),
+		SH_PFC_PIN_GROUP(sdhi0_wp),
+		SH_PFC_PIN_GROUP(sdhi1_data1),
+		SH_PFC_PIN_GROUP(sdhi1_data4),
+		SH_PFC_PIN_GROUP(sdhi1_ctrl),
+		SH_PFC_PIN_GROUP(sdhi1_cd),
+		SH_PFC_PIN_GROUP(sdhi1_wp),
+		SH_PFC_PIN_GROUP(sdhi2_data1),
+		SH_PFC_PIN_GROUP(sdhi2_data4),
+		SH_PFC_PIN_GROUP(sdhi2_ctrl),
+		SH_PFC_PIN_GROUP(sdhi2_cd),
+		SH_PFC_PIN_GROUP(sdhi2_wp),
+		SH_PFC_PIN_GROUP(sdhi3_data1),
+		SH_PFC_PIN_GROUP(sdhi3_data4),
+		SH_PFC_PIN_GROUP(sdhi3_ctrl),
+		SH_PFC_PIN_GROUP(sdhi3_cd),
+		SH_PFC_PIN_GROUP(sdhi3_wp),
+		SH_PFC_PIN_GROUP(ssi0_data),
+		SH_PFC_PIN_GROUP(ssi0129_ctrl),
+		SH_PFC_PIN_GROUP(ssi1_data),
+		SH_PFC_PIN_GROUP(ssi1_ctrl),
+		SH_PFC_PIN_GROUP(ssi2_data),
+		SH_PFC_PIN_GROUP(ssi2_ctrl),
+		SH_PFC_PIN_GROUP(ssi3_data),
+		SH_PFC_PIN_GROUP(ssi34_ctrl),
+		SH_PFC_PIN_GROUP(ssi4_data),
+		SH_PFC_PIN_GROUP(ssi4_ctrl),
+		SH_PFC_PIN_GROUP(ssi5),
+		SH_PFC_PIN_GROUP(ssi5_b),
+		SH_PFC_PIN_GROUP(ssi5_c),
+		SH_PFC_PIN_GROUP(ssi6),
+		SH_PFC_PIN_GROUP(ssi6_b),
+		SH_PFC_PIN_GROUP(ssi7_data),
+		SH_PFC_PIN_GROUP(ssi7_b_data),
+		SH_PFC_PIN_GROUP(ssi7_c_data),
+		SH_PFC_PIN_GROUP(ssi78_ctrl),
+		SH_PFC_PIN_GROUP(ssi78_b_ctrl),
+		SH_PFC_PIN_GROUP(ssi78_c_ctrl),
+		SH_PFC_PIN_GROUP(ssi8_data),
+		SH_PFC_PIN_GROUP(ssi8_b_data),
+		SH_PFC_PIN_GROUP(ssi8_c_data),
+		SH_PFC_PIN_GROUP(ssi9_data),
+		SH_PFC_PIN_GROUP(ssi9_ctrl),
+		SH_PFC_PIN_GROUP(tpu0_to0),
+		SH_PFC_PIN_GROUP(tpu0_to1),
+		SH_PFC_PIN_GROUP(tpu0_to2),
+		SH_PFC_PIN_GROUP(tpu0_to3),
+		SH_PFC_PIN_GROUP(usb0),
+		SH_PFC_PIN_GROUP(usb0_ovc_vbus),
+		SH_PFC_PIN_GROUP(usb1),
+		SH_PFC_PIN_GROUP(usb2),
+		VIN_DATA_PIN_GROUP(vin0_data, 24),
+		VIN_DATA_PIN_GROUP(vin0_data, 20),
+		SH_PFC_PIN_GROUP(vin0_data18),
+		VIN_DATA_PIN_GROUP(vin0_data, 16),
+		VIN_DATA_PIN_GROUP(vin0_data, 12),
+		VIN_DATA_PIN_GROUP(vin0_data, 10),
+		VIN_DATA_PIN_GROUP(vin0_data, 8),
+		VIN_DATA_PIN_GROUP(vin0_data, 4),
+		SH_PFC_PIN_GROUP(vin0_sync),
+		SH_PFC_PIN_GROUP(vin0_field),
+		SH_PFC_PIN_GROUP(vin0_clkenb),
+		SH_PFC_PIN_GROUP(vin0_clk),
+		VIN_DATA_PIN_GROUP(vin1_data, 24),
+		VIN_DATA_PIN_GROUP(vin1_data, 20),
+		SH_PFC_PIN_GROUP(vin1_data18),
+		VIN_DATA_PIN_GROUP(vin1_data, 16),
+		VIN_DATA_PIN_GROUP(vin1_data, 12),
+		VIN_DATA_PIN_GROUP(vin1_data, 10),
+		VIN_DATA_PIN_GROUP(vin1_data, 8),
+		VIN_DATA_PIN_GROUP(vin1_data, 4),
+		SH_PFC_PIN_GROUP(vin1_sync),
+		SH_PFC_PIN_GROUP(vin1_field),
+		SH_PFC_PIN_GROUP(vin1_clkenb),
+		SH_PFC_PIN_GROUP(vin1_clk),
+		VIN_DATA_PIN_GROUP(vin2_data, 24),
+		SH_PFC_PIN_GROUP(vin2_data18),
+		VIN_DATA_PIN_GROUP(vin2_data, 16),
+		VIN_DATA_PIN_GROUP(vin2_data, 8),
+		VIN_DATA_PIN_GROUP(vin2_data, 4),
+		SH_PFC_PIN_GROUP(vin2_sync),
+		SH_PFC_PIN_GROUP(vin2_field),
+		SH_PFC_PIN_GROUP(vin2_clkenb),
+		SH_PFC_PIN_GROUP(vin2_clk),
+		SH_PFC_PIN_GROUP(vin3_data8),
+		SH_PFC_PIN_GROUP(vin3_sync),
+		SH_PFC_PIN_GROUP(vin3_field),
+		SH_PFC_PIN_GROUP(vin3_clkenb),
+		SH_PFC_PIN_GROUP(vin3_clk),
+	},
+	.automotive = {
+		SH_PFC_PIN_GROUP(mlb_3pin),
+	}
 };
 
 static const char * const audio_clk_groups[] = {
@@ -4708,63 +4715,70 @@ static const char * const vin3_groups[] = {
 	"vin3_clk",
 };
 
-static const struct sh_pfc_function pinmux_functions[] = {
-	SH_PFC_FUNCTION(audio_clk),
-	SH_PFC_FUNCTION(avb),
-	SH_PFC_FUNCTION(du),
-	SH_PFC_FUNCTION(du0),
-	SH_PFC_FUNCTION(du1),
-	SH_PFC_FUNCTION(du2),
-	SH_PFC_FUNCTION(eth),
-	SH_PFC_FUNCTION(hscif0),
-	SH_PFC_FUNCTION(hscif1),
-	SH_PFC_FUNCTION(i2c0),
-	SH_PFC_FUNCTION(i2c1),
-	SH_PFC_FUNCTION(i2c2),
-	SH_PFC_FUNCTION(i2c3),
-	SH_PFC_FUNCTION(iic0),
-	SH_PFC_FUNCTION(iic1),
-	SH_PFC_FUNCTION(iic2),
-	SH_PFC_FUNCTION(iic3),
-	SH_PFC_FUNCTION(intc),
-	SH_PFC_FUNCTION(mlb),
-	SH_PFC_FUNCTION(mmc0),
-	SH_PFC_FUNCTION(mmc1),
-	SH_PFC_FUNCTION(msiof0),
-	SH_PFC_FUNCTION(msiof1),
-	SH_PFC_FUNCTION(msiof2),
-	SH_PFC_FUNCTION(msiof3),
-	SH_PFC_FUNCTION(pwm0),
-	SH_PFC_FUNCTION(pwm1),
-	SH_PFC_FUNCTION(pwm2),
-	SH_PFC_FUNCTION(pwm3),
-	SH_PFC_FUNCTION(pwm4),
-	SH_PFC_FUNCTION(pwm5),
-	SH_PFC_FUNCTION(pwm6),
-	SH_PFC_FUNCTION(qspi),
-	SH_PFC_FUNCTION(scif0),
-	SH_PFC_FUNCTION(scif1),
-	SH_PFC_FUNCTION(scif2),
-	SH_PFC_FUNCTION(scifa0),
-	SH_PFC_FUNCTION(scifa1),
-	SH_PFC_FUNCTION(scifa2),
-	SH_PFC_FUNCTION(scifb0),
-	SH_PFC_FUNCTION(scifb1),
-	SH_PFC_FUNCTION(scifb2),
-	SH_PFC_FUNCTION(scif_clk),
-	SH_PFC_FUNCTION(sdhi0),
-	SH_PFC_FUNCTION(sdhi1),
-	SH_PFC_FUNCTION(sdhi2),
-	SH_PFC_FUNCTION(sdhi3),
-	SH_PFC_FUNCTION(ssi),
-	SH_PFC_FUNCTION(tpu0),
-	SH_PFC_FUNCTION(usb0),
-	SH_PFC_FUNCTION(usb1),
-	SH_PFC_FUNCTION(usb2),
-	SH_PFC_FUNCTION(vin0),
-	SH_PFC_FUNCTION(vin1),
-	SH_PFC_FUNCTION(vin2),
-	SH_PFC_FUNCTION(vin3),
+static const struct {
+	struct sh_pfc_function common[55];
+	struct sh_pfc_function automotive[1];
+} pinmux_functions = {
+	.common = {
+		SH_PFC_FUNCTION(audio_clk),
+		SH_PFC_FUNCTION(avb),
+		SH_PFC_FUNCTION(du),
+		SH_PFC_FUNCTION(du0),
+		SH_PFC_FUNCTION(du1),
+		SH_PFC_FUNCTION(du2),
+		SH_PFC_FUNCTION(eth),
+		SH_PFC_FUNCTION(hscif0),
+		SH_PFC_FUNCTION(hscif1),
+		SH_PFC_FUNCTION(i2c0),
+		SH_PFC_FUNCTION(i2c1),
+		SH_PFC_FUNCTION(i2c2),
+		SH_PFC_FUNCTION(i2c3),
+		SH_PFC_FUNCTION(iic0),
+		SH_PFC_FUNCTION(iic1),
+		SH_PFC_FUNCTION(iic2),
+		SH_PFC_FUNCTION(iic3),
+		SH_PFC_FUNCTION(intc),
+		SH_PFC_FUNCTION(mmc0),
+		SH_PFC_FUNCTION(mmc1),
+		SH_PFC_FUNCTION(msiof0),
+		SH_PFC_FUNCTION(msiof1),
+		SH_PFC_FUNCTION(msiof2),
+		SH_PFC_FUNCTION(msiof3),
+		SH_PFC_FUNCTION(pwm0),
+		SH_PFC_FUNCTION(pwm1),
+		SH_PFC_FUNCTION(pwm2),
+		SH_PFC_FUNCTION(pwm3),
+		SH_PFC_FUNCTION(pwm4),
+		SH_PFC_FUNCTION(pwm5),
+		SH_PFC_FUNCTION(pwm6),
+		SH_PFC_FUNCTION(qspi),
+		SH_PFC_FUNCTION(scif0),
+		SH_PFC_FUNCTION(scif1),
+		SH_PFC_FUNCTION(scif2),
+		SH_PFC_FUNCTION(scifa0),
+		SH_PFC_FUNCTION(scifa1),
+		SH_PFC_FUNCTION(scifa2),
+		SH_PFC_FUNCTION(scifb0),
+		SH_PFC_FUNCTION(scifb1),
+		SH_PFC_FUNCTION(scifb2),
+		SH_PFC_FUNCTION(scif_clk),
+		SH_PFC_FUNCTION(sdhi0),
+		SH_PFC_FUNCTION(sdhi1),
+		SH_PFC_FUNCTION(sdhi2),
+		SH_PFC_FUNCTION(sdhi3),
+		SH_PFC_FUNCTION(ssi),
+		SH_PFC_FUNCTION(tpu0),
+		SH_PFC_FUNCTION(usb0),
+		SH_PFC_FUNCTION(usb1),
+		SH_PFC_FUNCTION(usb2),
+		SH_PFC_FUNCTION(vin0),
+		SH_PFC_FUNCTION(vin1),
+		SH_PFC_FUNCTION(vin2),
+		SH_PFC_FUNCTION(vin3),
+	},
+	.automotive = {
+		SH_PFC_FUNCTION(mlb),
+	}
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
@@ -5707,6 +5721,28 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 	{ },
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A7742
+const struct sh_pfc_soc_info r8a7742_pinmux_info = {
+	.name = "r8a77420_pfc",
+	.unlock_reg = 0xe6060000, /* PMMR */
+
+	.function = { PINMUX_FUNCTION_BEGIN, PINMUX_FUNCTION_END },
+
+	.pins = pinmux_pins,
+	.nr_pins = ARRAY_SIZE(pinmux_pins),
+	.groups = pinmux_groups.common,
+	.nr_groups = ARRAY_SIZE(pinmux_groups.common),
+	.functions = pinmux_functions.common,
+	.nr_functions = ARRAY_SIZE(pinmux_functions.common),
+
+	.cfg_regs = pinmux_config_regs,
+
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
+};
+#endif
+
+#ifdef CONFIG_PINCTRL_PFC_R8A7790
 const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 	.name = "r8a77900_pfc",
 	.unlock_reg = 0xe6060000, /* PMMR */
@@ -5715,13 +5751,16 @@ const struct sh_pfc_soc_info r8a7790_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
-	.groups = pinmux_groups,
-	.nr_groups = ARRAY_SIZE(pinmux_groups),
-	.functions = pinmux_functions,
-	.nr_functions = ARRAY_SIZE(pinmux_functions),
+	.groups = pinmux_groups.common,
+	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
+		ARRAY_SIZE(pinmux_groups.automotive),
+	.functions = pinmux_functions.common,
+	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
+		ARRAY_SIZE(pinmux_functions.automotive),
 
 	.cfg_regs = pinmux_config_regs,
 
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
+#endif
-- 
2.17.1


--iVD8GJboSs2m8vwb0hk8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5313): https://lists.cip-project.org/g/cip-dev/message=
/5313
Mute This Topic: https://lists.cip-project.org/mt/76477101/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iVD8GJboSs2m8vwb0hk8--
