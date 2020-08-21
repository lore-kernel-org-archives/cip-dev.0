Return-Path: <SRS0=eoLP=B7=lists.cip-project.org=bounce+64572+5199+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EAEC433E5
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:41 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CD32078D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="F4bzm+bk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CD32078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5199+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qPYGYY4521723xoxi4F7dJBA; Fri, 21 Aug 2020 03:58:40 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.130439.1598003056666915018
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:17 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170383"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:16 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 030694232078;
	Fri, 21 Aug 2020 18:44:13 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 32/36] pinctrl: sh-pfc: pfc-r8a77951: Add R8A774E1 PFC support
Date: Fri, 21 Aug 2020 10:43:08 +0100
Message-Id: <20200821094312.3249-33-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XFIGFyCWBIPokHQDicxPzPuIx4520388AA=
Content-Type: multipart/mixed; boundary="sS266VR6vF0koQ0QcmfF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007520;
 bh=+YGQuL+7hciDNWmEpMqklL00/xQwRIVL9VA++mXJLTs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=F4bzm+bk5SsVyfxrrEOKVxvwxFb7lzBCjW+0ZGg2yh999o2o+CcbsF2INN3JmDcfNY3
 aLfsZlrk2k2ADMas0A5Zs0nx751ueDeaq7XImC75sCveHsBxERthV9ims4WOj/uj7hhxU
 OdRGAgzrxx32K/nG7JHlIuPj/pSQ1Qppnsk=

--sS266VR6vF0koQ0QcmfF

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a5e8b53adeb4b458971dfd6232b71299010e981a upstream.

Renesas RZ/G2H (r8a774e1) is pin compatible with R-Car H3 (R8A77951),
however it doesn't have several automotive specific peripherals. Add
automotive-specific pin groups/functions along with common pin
groups/functions for supporting both r8a77951 and r8a774e1 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-13-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[biju: updated config file for 4.19.y-cip]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/sh-pfc/Kconfig        |   5 +
 drivers/pinctrl/sh-pfc/Makefile       |   1 +
 drivers/pinctrl/sh-pfc/core.c         |   6 +
 drivers/pinctrl/sh-pfc/pfc-r8a77951.c | 877 ++++++++++++++------------
 drivers/pinctrl/sh-pfc/sh_pfc.h       |   1 +
 5 files changed, 475 insertions(+), 415 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/Kconfig b/drivers/pinctrl/sh-pfc/Kconfig
index 77f606928220..6161f906668b 100644
--- a/drivers/pinctrl/sh-pfc/Kconfig
+++ b/drivers/pinctrl/sh-pfc/Kconfig
@@ -64,6 +64,11 @@ config PINCTRL_PFC_R8A774C0
         depends on ARCH_R8A774C0
         select PINCTRL_SH_PFC
 
+config PINCTRL_PFC_R8A774E1
+        def_bool y
+        depends on ARCH_R8A774E1
+        select PINCTRL_SH_PFC
+
 config PINCTRL_PFC_R8A7778
 	def_bool y
 	depends on ARCH_R8A7778
diff --git a/drivers/pinctrl/sh-pfc/Makefile b/drivers/pinctrl/sh-pfc/Makefile
index 930be8cf259f..8f65494b1bff 100644
--- a/drivers/pinctrl/sh-pfc/Makefile
+++ b/drivers/pinctrl/sh-pfc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_PINCTRL_PFC_R8A77470)	+= pfc-r8a77470.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774A1)	+= pfc-r8a7796.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774B1)	+= pfc-r8a77965.o
 obj-$(CONFIG_PINCTRL_PFC_R8A774C0)	+= pfc-r8a77990.o
+obj-$(CONFIG_PINCTRL_PFC_R8A774E1)	+= pfc-r8a77951.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7778)	+= pfc-r8a7778.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7779)	+= pfc-r8a7779.o
 obj-$(CONFIG_PINCTRL_PFC_R8A7790)	+= pfc-r8a7790.o
diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 53cb82a7aa5d..1b4bc27d1911 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -528,6 +528,12 @@ static const struct of_device_id sh_pfc_of_table[] = {
 		.data = &r8a774c0_pinmux_info,
 	},
 #endif
+#ifdef CONFIG_PINCTRL_PFC_R8A774E1
+	{
+		.compatible = "renesas,pfc-r8a774e1",
+		.data = &r8a774e1_pinmux_info,
+	},
+#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7778
 	{
 		.compatible = "renesas,pfc-r8a7778",
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a77951.c b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
index f922aa46dba4..c2d0269417ea 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a77951.c
@@ -4160,357 +4160,365 @@ static const unsigned int vin5_clk_mux[] = {
 	VI5_CLK_MARK,
 };
 
-static const struct sh_pfc_pin_group pinmux_groups[] = {
-	SH_PFC_PIN_GROUP(audio_clk_a_a),
-	SH_PFC_PIN_GROUP(audio_clk_a_b),
-	SH_PFC_PIN_GROUP(audio_clk_a_c),
-	SH_PFC_PIN_GROUP(audio_clk_b_a),
-	SH_PFC_PIN_GROUP(audio_clk_b_b),
-	SH_PFC_PIN_GROUP(audio_clk_c_a),
-	SH_PFC_PIN_GROUP(audio_clk_c_b),
-	SH_PFC_PIN_GROUP(audio_clkout_a),
-	SH_PFC_PIN_GROUP(audio_clkout_b),
-	SH_PFC_PIN_GROUP(audio_clkout_c),
-	SH_PFC_PIN_GROUP(audio_clkout_d),
-	SH_PFC_PIN_GROUP(audio_clkout1_a),
-	SH_PFC_PIN_GROUP(audio_clkout1_b),
-	SH_PFC_PIN_GROUP(audio_clkout2_a),
-	SH_PFC_PIN_GROUP(audio_clkout2_b),
-	SH_PFC_PIN_GROUP(audio_clkout3_a),
-	SH_PFC_PIN_GROUP(audio_clkout3_b),
-	SH_PFC_PIN_GROUP(avb_link),
-	SH_PFC_PIN_GROUP(avb_magic),
-	SH_PFC_PIN_GROUP(avb_phy_int),
-	SH_PFC_PIN_GROUP_ALIAS(avb_mdc, avb_mdio),	/* Deprecated */
-	SH_PFC_PIN_GROUP(avb_mdio),
-	SH_PFC_PIN_GROUP(avb_mii),
-	SH_PFC_PIN_GROUP(avb_avtp_pps),
-	SH_PFC_PIN_GROUP(avb_avtp_match_a),
-	SH_PFC_PIN_GROUP(avb_avtp_capture_a),
-	SH_PFC_PIN_GROUP(avb_avtp_match_b),
-	SH_PFC_PIN_GROUP(avb_avtp_capture_b),
-	SH_PFC_PIN_GROUP(can0_data_a),
-	SH_PFC_PIN_GROUP(can0_data_b),
-	SH_PFC_PIN_GROUP(can1_data),
-	SH_PFC_PIN_GROUP(can_clk),
-	SH_PFC_PIN_GROUP(canfd0_data_a),
-	SH_PFC_PIN_GROUP(canfd0_data_b),
-	SH_PFC_PIN_GROUP(canfd1_data),
-	SH_PFC_PIN_GROUP(drif0_ctrl_a),
-	SH_PFC_PIN_GROUP(drif0_data0_a),
-	SH_PFC_PIN_GROUP(drif0_data1_a),
-	SH_PFC_PIN_GROUP(drif0_ctrl_b),
-	SH_PFC_PIN_GROUP(drif0_data0_b),
-	SH_PFC_PIN_GROUP(drif0_data1_b),
-	SH_PFC_PIN_GROUP(drif0_ctrl_c),
-	SH_PFC_PIN_GROUP(drif0_data0_c),
-	SH_PFC_PIN_GROUP(drif0_data1_c),
-	SH_PFC_PIN_GROUP(drif1_ctrl_a),
-	SH_PFC_PIN_GROUP(drif1_data0_a),
-	SH_PFC_PIN_GROUP(drif1_data1_a),
-	SH_PFC_PIN_GROUP(drif1_ctrl_b),
-	SH_PFC_PIN_GROUP(drif1_data0_b),
-	SH_PFC_PIN_GROUP(drif1_data1_b),
-	SH_PFC_PIN_GROUP(drif1_ctrl_c),
-	SH_PFC_PIN_GROUP(drif1_data0_c),
-	SH_PFC_PIN_GROUP(drif1_data1_c),
-	SH_PFC_PIN_GROUP(drif2_ctrl_a),
-	SH_PFC_PIN_GROUP(drif2_data0_a),
-	SH_PFC_PIN_GROUP(drif2_data1_a),
-	SH_PFC_PIN_GROUP(drif2_ctrl_b),
-	SH_PFC_PIN_GROUP(drif2_data0_b),
-	SH_PFC_PIN_GROUP(drif2_data1_b),
-	SH_PFC_PIN_GROUP(drif3_ctrl_a),
-	SH_PFC_PIN_GROUP(drif3_data0_a),
-	SH_PFC_PIN_GROUP(drif3_data1_a),
-	SH_PFC_PIN_GROUP(drif3_ctrl_b),
-	SH_PFC_PIN_GROUP(drif3_data0_b),
-	SH_PFC_PIN_GROUP(drif3_data1_b),
-	SH_PFC_PIN_GROUP(du_rgb666),
-	SH_PFC_PIN_GROUP(du_rgb888),
-	SH_PFC_PIN_GROUP(du_clk_out_0),
-	SH_PFC_PIN_GROUP(du_clk_out_1),
-	SH_PFC_PIN_GROUP(du_sync),
-	SH_PFC_PIN_GROUP(du_oddf),
-	SH_PFC_PIN_GROUP(du_cde),
-	SH_PFC_PIN_GROUP(du_disp),
-	SH_PFC_PIN_GROUP(hscif0_data),
-	SH_PFC_PIN_GROUP(hscif0_clk),
-	SH_PFC_PIN_GROUP(hscif0_ctrl),
-	SH_PFC_PIN_GROUP(hscif1_data_a),
-	SH_PFC_PIN_GROUP(hscif1_clk_a),
-	SH_PFC_PIN_GROUP(hscif1_ctrl_a),
-	SH_PFC_PIN_GROUP(hscif1_data_b),
-	SH_PFC_PIN_GROUP(hscif1_clk_b),
-	SH_PFC_PIN_GROUP(hscif1_ctrl_b),
-	SH_PFC_PIN_GROUP(hscif2_data_a),
-	SH_PFC_PIN_GROUP(hscif2_clk_a),
-	SH_PFC_PIN_GROUP(hscif2_ctrl_a),
-	SH_PFC_PIN_GROUP(hscif2_data_b),
-	SH_PFC_PIN_GROUP(hscif2_clk_b),
-	SH_PFC_PIN_GROUP(hscif2_ctrl_b),
-	SH_PFC_PIN_GROUP(hscif2_data_c),
-	SH_PFC_PIN_GROUP(hscif2_clk_c),
-	SH_PFC_PIN_GROUP(hscif2_ctrl_c),
-	SH_PFC_PIN_GROUP(hscif3_data_a),
-	SH_PFC_PIN_GROUP(hscif3_clk),
-	SH_PFC_PIN_GROUP(hscif3_ctrl),
-	SH_PFC_PIN_GROUP(hscif3_data_b),
-	SH_PFC_PIN_GROUP(hscif3_data_c),
-	SH_PFC_PIN_GROUP(hscif3_data_d),
-	SH_PFC_PIN_GROUP(hscif4_data_a),
-	SH_PFC_PIN_GROUP(hscif4_clk),
-	SH_PFC_PIN_GROUP(hscif4_ctrl),
-	SH_PFC_PIN_GROUP(hscif4_data_b),
-	SH_PFC_PIN_GROUP(i2c0),
-	SH_PFC_PIN_GROUP(i2c1_a),
-	SH_PFC_PIN_GROUP(i2c1_b),
-	SH_PFC_PIN_GROUP(i2c2_a),
-	SH_PFC_PIN_GROUP(i2c2_b),
-	SH_PFC_PIN_GROUP(i2c3),
-	SH_PFC_PIN_GROUP(i2c5),
-	SH_PFC_PIN_GROUP(i2c6_a),
-	SH_PFC_PIN_GROUP(i2c6_b),
-	SH_PFC_PIN_GROUP(i2c6_c),
-	SH_PFC_PIN_GROUP(intc_ex_irq0),
-	SH_PFC_PIN_GROUP(intc_ex_irq1),
-	SH_PFC_PIN_GROUP(intc_ex_irq2),
-	SH_PFC_PIN_GROUP(intc_ex_irq3),
-	SH_PFC_PIN_GROUP(intc_ex_irq4),
-	SH_PFC_PIN_GROUP(intc_ex_irq5),
-	SH_PFC_PIN_GROUP(msiof0_clk),
-	SH_PFC_PIN_GROUP(msiof0_sync),
-	SH_PFC_PIN_GROUP(msiof0_ss1),
-	SH_PFC_PIN_GROUP(msiof0_ss2),
-	SH_PFC_PIN_GROUP(msiof0_txd),
-	SH_PFC_PIN_GROUP(msiof0_rxd),
-	SH_PFC_PIN_GROUP(msiof1_clk_a),
-	SH_PFC_PIN_GROUP(msiof1_sync_a),
-	SH_PFC_PIN_GROUP(msiof1_ss1_a),
-	SH_PFC_PIN_GROUP(msiof1_ss2_a),
-	SH_PFC_PIN_GROUP(msiof1_txd_a),
-	SH_PFC_PIN_GROUP(msiof1_rxd_a),
-	SH_PFC_PIN_GROUP(msiof1_clk_b),
-	SH_PFC_PIN_GROUP(msiof1_sync_b),
-	SH_PFC_PIN_GROUP(msiof1_ss1_b),
-	SH_PFC_PIN_GROUP(msiof1_ss2_b),
-	SH_PFC_PIN_GROUP(msiof1_txd_b),
-	SH_PFC_PIN_GROUP(msiof1_rxd_b),
-	SH_PFC_PIN_GROUP(msiof1_clk_c),
-	SH_PFC_PIN_GROUP(msiof1_sync_c),
-	SH_PFC_PIN_GROUP(msiof1_ss1_c),
-	SH_PFC_PIN_GROUP(msiof1_ss2_c),
-	SH_PFC_PIN_GROUP(msiof1_txd_c),
-	SH_PFC_PIN_GROUP(msiof1_rxd_c),
-	SH_PFC_PIN_GROUP(msiof1_clk_d),
-	SH_PFC_PIN_GROUP(msiof1_sync_d),
-	SH_PFC_PIN_GROUP(msiof1_ss1_d),
-	SH_PFC_PIN_GROUP(msiof1_ss2_d),
-	SH_PFC_PIN_GROUP(msiof1_txd_d),
-	SH_PFC_PIN_GROUP(msiof1_rxd_d),
-	SH_PFC_PIN_GROUP(msiof1_clk_e),
-	SH_PFC_PIN_GROUP(msiof1_sync_e),
-	SH_PFC_PIN_GROUP(msiof1_ss1_e),
-	SH_PFC_PIN_GROUP(msiof1_ss2_e),
-	SH_PFC_PIN_GROUP(msiof1_txd_e),
-	SH_PFC_PIN_GROUP(msiof1_rxd_e),
-	SH_PFC_PIN_GROUP(msiof1_clk_f),
-	SH_PFC_PIN_GROUP(msiof1_sync_f),
-	SH_PFC_PIN_GROUP(msiof1_ss1_f),
-	SH_PFC_PIN_GROUP(msiof1_ss2_f),
-	SH_PFC_PIN_GROUP(msiof1_txd_f),
-	SH_PFC_PIN_GROUP(msiof1_rxd_f),
-	SH_PFC_PIN_GROUP(msiof1_clk_g),
-	SH_PFC_PIN_GROUP(msiof1_sync_g),
-	SH_PFC_PIN_GROUP(msiof1_ss1_g),
-	SH_PFC_PIN_GROUP(msiof1_ss2_g),
-	SH_PFC_PIN_GROUP(msiof1_txd_g),
-	SH_PFC_PIN_GROUP(msiof1_rxd_g),
-	SH_PFC_PIN_GROUP(msiof2_clk_a),
-	SH_PFC_PIN_GROUP(msiof2_sync_a),
-	SH_PFC_PIN_GROUP(msiof2_ss1_a),
-	SH_PFC_PIN_GROUP(msiof2_ss2_a),
-	SH_PFC_PIN_GROUP(msiof2_txd_a),
-	SH_PFC_PIN_GROUP(msiof2_rxd_a),
-	SH_PFC_PIN_GROUP(msiof2_clk_b),
-	SH_PFC_PIN_GROUP(msiof2_sync_b),
-	SH_PFC_PIN_GROUP(msiof2_ss1_b),
-	SH_PFC_PIN_GROUP(msiof2_ss2_b),
-	SH_PFC_PIN_GROUP(msiof2_txd_b),
-	SH_PFC_PIN_GROUP(msiof2_rxd_b),
-	SH_PFC_PIN_GROUP(msiof2_clk_c),
-	SH_PFC_PIN_GROUP(msiof2_sync_c),
-	SH_PFC_PIN_GROUP(msiof2_ss1_c),
-	SH_PFC_PIN_GROUP(msiof2_ss2_c),
-	SH_PFC_PIN_GROUP(msiof2_txd_c),
-	SH_PFC_PIN_GROUP(msiof2_rxd_c),
-	SH_PFC_PIN_GROUP(msiof2_clk_d),
-	SH_PFC_PIN_GROUP(msiof2_sync_d),
-	SH_PFC_PIN_GROUP(msiof2_ss1_d),
-	SH_PFC_PIN_GROUP(msiof2_ss2_d),
-	SH_PFC_PIN_GROUP(msiof2_txd_d),
-	SH_PFC_PIN_GROUP(msiof2_rxd_d),
-	SH_PFC_PIN_GROUP(msiof3_clk_a),
-	SH_PFC_PIN_GROUP(msiof3_sync_a),
-	SH_PFC_PIN_GROUP(msiof3_ss1_a),
-	SH_PFC_PIN_GROUP(msiof3_ss2_a),
-	SH_PFC_PIN_GROUP(msiof3_txd_a),
-	SH_PFC_PIN_GROUP(msiof3_rxd_a),
-	SH_PFC_PIN_GROUP(msiof3_clk_b),
-	SH_PFC_PIN_GROUP(msiof3_sync_b),
-	SH_PFC_PIN_GROUP(msiof3_ss1_b),
-	SH_PFC_PIN_GROUP(msiof3_ss2_b),
-	SH_PFC_PIN_GROUP(msiof3_txd_b),
-	SH_PFC_PIN_GROUP(msiof3_rxd_b),
-	SH_PFC_PIN_GROUP(msiof3_clk_c),
-	SH_PFC_PIN_GROUP(msiof3_sync_c),
-	SH_PFC_PIN_GROUP(msiof3_txd_c),
-	SH_PFC_PIN_GROUP(msiof3_rxd_c),
-	SH_PFC_PIN_GROUP(msiof3_clk_d),
-	SH_PFC_PIN_GROUP(msiof3_sync_d),
-	SH_PFC_PIN_GROUP(msiof3_ss1_d),
-	SH_PFC_PIN_GROUP(msiof3_txd_d),
-	SH_PFC_PIN_GROUP(msiof3_rxd_d),
-	SH_PFC_PIN_GROUP(msiof3_clk_e),
-	SH_PFC_PIN_GROUP(msiof3_sync_e),
-	SH_PFC_PIN_GROUP(msiof3_ss1_e),
-	SH_PFC_PIN_GROUP(msiof3_ss2_e),
-	SH_PFC_PIN_GROUP(msiof3_txd_e),
-	SH_PFC_PIN_GROUP(msiof3_rxd_e),
-	SH_PFC_PIN_GROUP(pwm0),
-	SH_PFC_PIN_GROUP(pwm1_a),
-	SH_PFC_PIN_GROUP(pwm1_b),
-	SH_PFC_PIN_GROUP(pwm2_a),
-	SH_PFC_PIN_GROUP(pwm2_b),
-	SH_PFC_PIN_GROUP(pwm3_a),
-	SH_PFC_PIN_GROUP(pwm3_b),
-	SH_PFC_PIN_GROUP(pwm4_a),
-	SH_PFC_PIN_GROUP(pwm4_b),
-	SH_PFC_PIN_GROUP(pwm5_a),
-	SH_PFC_PIN_GROUP(pwm5_b),
-	SH_PFC_PIN_GROUP(pwm6_a),
-	SH_PFC_PIN_GROUP(pwm6_b),
-	SH_PFC_PIN_GROUP(sata0_devslp_a),
-	SH_PFC_PIN_GROUP(sata0_devslp_b),
-	SH_PFC_PIN_GROUP(scif0_data),
-	SH_PFC_PIN_GROUP(scif0_clk),
-	SH_PFC_PIN_GROUP(scif0_ctrl),
-	SH_PFC_PIN_GROUP(scif1_data_a),
-	SH_PFC_PIN_GROUP(scif1_clk),
-	SH_PFC_PIN_GROUP(scif1_ctrl),
-	SH_PFC_PIN_GROUP(scif1_data_b),
-	SH_PFC_PIN_GROUP(scif2_data_a),
-	SH_PFC_PIN_GROUP(scif2_clk),
-	SH_PFC_PIN_GROUP(scif2_data_b),
-	SH_PFC_PIN_GROUP(scif3_data_a),
-	SH_PFC_PIN_GROUP(scif3_clk),
-	SH_PFC_PIN_GROUP(scif3_ctrl),
-	SH_PFC_PIN_GROUP(scif3_data_b),
-	SH_PFC_PIN_GROUP(scif4_data_a),
-	SH_PFC_PIN_GROUP(scif4_clk_a),
-	SH_PFC_PIN_GROUP(scif4_ctrl_a),
-	SH_PFC_PIN_GROUP(scif4_data_b),
-	SH_PFC_PIN_GROUP(scif4_clk_b),
-	SH_PFC_PIN_GROUP(scif4_ctrl_b),
-	SH_PFC_PIN_GROUP(scif4_data_c),
-	SH_PFC_PIN_GROUP(scif4_clk_c),
-	SH_PFC_PIN_GROUP(scif4_ctrl_c),
-	SH_PFC_PIN_GROUP(scif5_data_a),
-	SH_PFC_PIN_GROUP(scif5_clk_a),
-	SH_PFC_PIN_GROUP(scif5_data_b),
-	SH_PFC_PIN_GROUP(scif5_clk_b),
-	SH_PFC_PIN_GROUP(scif_clk_a),
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
-	SH_PFC_PIN_GROUP(sdhi2_data8),
-	SH_PFC_PIN_GROUP(sdhi2_ctrl),
-	SH_PFC_PIN_GROUP(sdhi2_cd_a),
-	SH_PFC_PIN_GROUP(sdhi2_wp_a),
-	SH_PFC_PIN_GROUP(sdhi2_cd_b),
-	SH_PFC_PIN_GROUP(sdhi2_wp_b),
-	SH_PFC_PIN_GROUP(sdhi2_ds),
-	SH_PFC_PIN_GROUP(sdhi3_data1),
-	SH_PFC_PIN_GROUP(sdhi3_data4),
-	SH_PFC_PIN_GROUP(sdhi3_data8),
-	SH_PFC_PIN_GROUP(sdhi3_ctrl),
-	SH_PFC_PIN_GROUP(sdhi3_cd),
-	SH_PFC_PIN_GROUP(sdhi3_wp),
-	SH_PFC_PIN_GROUP(sdhi3_ds),
-	SH_PFC_PIN_GROUP(ssi0_data),
-	SH_PFC_PIN_GROUP(ssi01239_ctrl),
-	SH_PFC_PIN_GROUP(ssi1_data_a),
-	SH_PFC_PIN_GROUP(ssi1_data_b),
-	SH_PFC_PIN_GROUP(ssi1_ctrl_a),
-	SH_PFC_PIN_GROUP(ssi1_ctrl_b),
-	SH_PFC_PIN_GROUP(ssi2_data_a),
-	SH_PFC_PIN_GROUP(ssi2_data_b),
-	SH_PFC_PIN_GROUP(ssi2_ctrl_a),
-	SH_PFC_PIN_GROUP(ssi2_ctrl_b),
-	SH_PFC_PIN_GROUP(ssi3_data),
-	SH_PFC_PIN_GROUP(ssi349_ctrl),
-	SH_PFC_PIN_GROUP(ssi4_data),
-	SH_PFC_PIN_GROUP(ssi4_ctrl),
-	SH_PFC_PIN_GROUP(ssi5_data),
-	SH_PFC_PIN_GROUP(ssi5_ctrl),
-	SH_PFC_PIN_GROUP(ssi6_data),
-	SH_PFC_PIN_GROUP(ssi6_ctrl),
-	SH_PFC_PIN_GROUP(ssi7_data),
-	SH_PFC_PIN_GROUP(ssi78_ctrl),
-	SH_PFC_PIN_GROUP(ssi8_data),
-	SH_PFC_PIN_GROUP(ssi9_data_a),
-	SH_PFC_PIN_GROUP(ssi9_data_b),
-	SH_PFC_PIN_GROUP(ssi9_ctrl_a),
-	SH_PFC_PIN_GROUP(ssi9_ctrl_b),
-	SH_PFC_PIN_GROUP(tmu_tclk1_a),
-	SH_PFC_PIN_GROUP(tmu_tclk1_b),
-	SH_PFC_PIN_GROUP(tmu_tclk2_a),
-	SH_PFC_PIN_GROUP(tmu_tclk2_b),
-	SH_PFC_PIN_GROUP(tpu_to0),
-	SH_PFC_PIN_GROUP(tpu_to1),
-	SH_PFC_PIN_GROUP(tpu_to2),
-	SH_PFC_PIN_GROUP(tpu_to3),
-	SH_PFC_PIN_GROUP(usb0),
-	SH_PFC_PIN_GROUP(usb1),
-	SH_PFC_PIN_GROUP(usb2),
-	SH_PFC_PIN_GROUP(usb2_ch3),
-	SH_PFC_PIN_GROUP(usb30),
-	VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
-	VIN_DATA_PIN_GROUP(vin4_data, 10, _a),
-	VIN_DATA_PIN_GROUP(vin4_data, 12, _a),
-	VIN_DATA_PIN_GROUP(vin4_data, 16, _a),
-	SH_PFC_PIN_GROUP(vin4_data18_a),
-	VIN_DATA_PIN_GROUP(vin4_data, 20, _a),
-	VIN_DATA_PIN_GROUP(vin4_data, 24, _a),
-	VIN_DATA_PIN_GROUP(vin4_data, 8, _b),
-	VIN_DATA_PIN_GROUP(vin4_data, 10, _b),
-	VIN_DATA_PIN_GROUP(vin4_data, 12, _b),
-	VIN_DATA_PIN_GROUP(vin4_data, 16, _b),
-	SH_PFC_PIN_GROUP(vin4_data18_b),
-	VIN_DATA_PIN_GROUP(vin4_data, 20, _b),
-	VIN_DATA_PIN_GROUP(vin4_data, 24, _b),
-	SH_PFC_PIN_GROUP(vin4_sync),
-	SH_PFC_PIN_GROUP(vin4_field),
-	SH_PFC_PIN_GROUP(vin4_clkenb),
-	SH_PFC_PIN_GROUP(vin4_clk),
-	VIN_DATA_PIN_GROUP(vin5_data, 8),
-	VIN_DATA_PIN_GROUP(vin5_data, 10),
-	VIN_DATA_PIN_GROUP(vin5_data, 12),
-	VIN_DATA_PIN_GROUP(vin5_data, 16),
-	SH_PFC_PIN_GROUP(vin5_sync),
-	SH_PFC_PIN_GROUP(vin5_field),
-	SH_PFC_PIN_GROUP(vin5_clkenb),
-	SH_PFC_PIN_GROUP(vin5_clk),
+static const struct {
+	struct sh_pfc_pin_group common[320];
+	struct sh_pfc_pin_group automotive[30];
+} pinmux_groups = {
+	.common = {
+		SH_PFC_PIN_GROUP(audio_clk_a_a),
+		SH_PFC_PIN_GROUP(audio_clk_a_b),
+		SH_PFC_PIN_GROUP(audio_clk_a_c),
+		SH_PFC_PIN_GROUP(audio_clk_b_a),
+		SH_PFC_PIN_GROUP(audio_clk_b_b),
+		SH_PFC_PIN_GROUP(audio_clk_c_a),
+		SH_PFC_PIN_GROUP(audio_clk_c_b),
+		SH_PFC_PIN_GROUP(audio_clkout_a),
+		SH_PFC_PIN_GROUP(audio_clkout_b),
+		SH_PFC_PIN_GROUP(audio_clkout_c),
+		SH_PFC_PIN_GROUP(audio_clkout_d),
+		SH_PFC_PIN_GROUP(audio_clkout1_a),
+		SH_PFC_PIN_GROUP(audio_clkout1_b),
+		SH_PFC_PIN_GROUP(audio_clkout2_a),
+		SH_PFC_PIN_GROUP(audio_clkout2_b),
+		SH_PFC_PIN_GROUP(audio_clkout3_a),
+		SH_PFC_PIN_GROUP(audio_clkout3_b),
+		SH_PFC_PIN_GROUP(avb_link),
+		SH_PFC_PIN_GROUP(avb_magic),
+		SH_PFC_PIN_GROUP(avb_phy_int),
+		SH_PFC_PIN_GROUP_ALIAS(avb_mdc, avb_mdio),	/* Deprecated */
+		SH_PFC_PIN_GROUP(avb_mdio),
+		SH_PFC_PIN_GROUP(avb_mii),
+		SH_PFC_PIN_GROUP(avb_avtp_pps),
+		SH_PFC_PIN_GROUP(avb_avtp_match_a),
+		SH_PFC_PIN_GROUP(avb_avtp_capture_a),
+		SH_PFC_PIN_GROUP(avb_avtp_match_b),
+		SH_PFC_PIN_GROUP(avb_avtp_capture_b),
+		SH_PFC_PIN_GROUP(can0_data_a),
+		SH_PFC_PIN_GROUP(can0_data_b),
+		SH_PFC_PIN_GROUP(can1_data),
+		SH_PFC_PIN_GROUP(can_clk),
+		SH_PFC_PIN_GROUP(canfd0_data_a),
+		SH_PFC_PIN_GROUP(canfd0_data_b),
+		SH_PFC_PIN_GROUP(canfd1_data),
+		SH_PFC_PIN_GROUP(du_rgb666),
+		SH_PFC_PIN_GROUP(du_rgb888),
+		SH_PFC_PIN_GROUP(du_clk_out_0),
+		SH_PFC_PIN_GROUP(du_clk_out_1),
+		SH_PFC_PIN_GROUP(du_sync),
+		SH_PFC_PIN_GROUP(du_oddf),
+		SH_PFC_PIN_GROUP(du_cde),
+		SH_PFC_PIN_GROUP(du_disp),
+		SH_PFC_PIN_GROUP(hscif0_data),
+		SH_PFC_PIN_GROUP(hscif0_clk),
+		SH_PFC_PIN_GROUP(hscif0_ctrl),
+		SH_PFC_PIN_GROUP(hscif1_data_a),
+		SH_PFC_PIN_GROUP(hscif1_clk_a),
+		SH_PFC_PIN_GROUP(hscif1_ctrl_a),
+		SH_PFC_PIN_GROUP(hscif1_data_b),
+		SH_PFC_PIN_GROUP(hscif1_clk_b),
+		SH_PFC_PIN_GROUP(hscif1_ctrl_b),
+		SH_PFC_PIN_GROUP(hscif2_data_a),
+		SH_PFC_PIN_GROUP(hscif2_clk_a),
+		SH_PFC_PIN_GROUP(hscif2_ctrl_a),
+		SH_PFC_PIN_GROUP(hscif2_data_b),
+		SH_PFC_PIN_GROUP(hscif2_clk_b),
+		SH_PFC_PIN_GROUP(hscif2_ctrl_b),
+		SH_PFC_PIN_GROUP(hscif2_data_c),
+		SH_PFC_PIN_GROUP(hscif2_clk_c),
+		SH_PFC_PIN_GROUP(hscif2_ctrl_c),
+		SH_PFC_PIN_GROUP(hscif3_data_a),
+		SH_PFC_PIN_GROUP(hscif3_clk),
+		SH_PFC_PIN_GROUP(hscif3_ctrl),
+		SH_PFC_PIN_GROUP(hscif3_data_b),
+		SH_PFC_PIN_GROUP(hscif3_data_c),
+		SH_PFC_PIN_GROUP(hscif3_data_d),
+		SH_PFC_PIN_GROUP(hscif4_data_a),
+		SH_PFC_PIN_GROUP(hscif4_clk),
+		SH_PFC_PIN_GROUP(hscif4_ctrl),
+		SH_PFC_PIN_GROUP(hscif4_data_b),
+		SH_PFC_PIN_GROUP(i2c0),
+		SH_PFC_PIN_GROUP(i2c1_a),
+		SH_PFC_PIN_GROUP(i2c1_b),
+		SH_PFC_PIN_GROUP(i2c2_a),
+		SH_PFC_PIN_GROUP(i2c2_b),
+		SH_PFC_PIN_GROUP(i2c3),
+		SH_PFC_PIN_GROUP(i2c5),
+		SH_PFC_PIN_GROUP(i2c6_a),
+		SH_PFC_PIN_GROUP(i2c6_b),
+		SH_PFC_PIN_GROUP(i2c6_c),
+		SH_PFC_PIN_GROUP(intc_ex_irq0),
+		SH_PFC_PIN_GROUP(intc_ex_irq1),
+		SH_PFC_PIN_GROUP(intc_ex_irq2),
+		SH_PFC_PIN_GROUP(intc_ex_irq3),
+		SH_PFC_PIN_GROUP(intc_ex_irq4),
+		SH_PFC_PIN_GROUP(intc_ex_irq5),
+		SH_PFC_PIN_GROUP(msiof0_clk),
+		SH_PFC_PIN_GROUP(msiof0_sync),
+		SH_PFC_PIN_GROUP(msiof0_ss1),
+		SH_PFC_PIN_GROUP(msiof0_ss2),
+		SH_PFC_PIN_GROUP(msiof0_txd),
+		SH_PFC_PIN_GROUP(msiof0_rxd),
+		SH_PFC_PIN_GROUP(msiof1_clk_a),
+		SH_PFC_PIN_GROUP(msiof1_sync_a),
+		SH_PFC_PIN_GROUP(msiof1_ss1_a),
+		SH_PFC_PIN_GROUP(msiof1_ss2_a),
+		SH_PFC_PIN_GROUP(msiof1_txd_a),
+		SH_PFC_PIN_GROUP(msiof1_rxd_a),
+		SH_PFC_PIN_GROUP(msiof1_clk_b),
+		SH_PFC_PIN_GROUP(msiof1_sync_b),
+		SH_PFC_PIN_GROUP(msiof1_ss1_b),
+		SH_PFC_PIN_GROUP(msiof1_ss2_b),
+		SH_PFC_PIN_GROUP(msiof1_txd_b),
+		SH_PFC_PIN_GROUP(msiof1_rxd_b),
+		SH_PFC_PIN_GROUP(msiof1_clk_c),
+		SH_PFC_PIN_GROUP(msiof1_sync_c),
+		SH_PFC_PIN_GROUP(msiof1_ss1_c),
+		SH_PFC_PIN_GROUP(msiof1_ss2_c),
+		SH_PFC_PIN_GROUP(msiof1_txd_c),
+		SH_PFC_PIN_GROUP(msiof1_rxd_c),
+		SH_PFC_PIN_GROUP(msiof1_clk_d),
+		SH_PFC_PIN_GROUP(msiof1_sync_d),
+		SH_PFC_PIN_GROUP(msiof1_ss1_d),
+		SH_PFC_PIN_GROUP(msiof1_ss2_d),
+		SH_PFC_PIN_GROUP(msiof1_txd_d),
+		SH_PFC_PIN_GROUP(msiof1_rxd_d),
+		SH_PFC_PIN_GROUP(msiof1_clk_e),
+		SH_PFC_PIN_GROUP(msiof1_sync_e),
+		SH_PFC_PIN_GROUP(msiof1_ss1_e),
+		SH_PFC_PIN_GROUP(msiof1_ss2_e),
+		SH_PFC_PIN_GROUP(msiof1_txd_e),
+		SH_PFC_PIN_GROUP(msiof1_rxd_e),
+		SH_PFC_PIN_GROUP(msiof1_clk_f),
+		SH_PFC_PIN_GROUP(msiof1_sync_f),
+		SH_PFC_PIN_GROUP(msiof1_ss1_f),
+		SH_PFC_PIN_GROUP(msiof1_ss2_f),
+		SH_PFC_PIN_GROUP(msiof1_txd_f),
+		SH_PFC_PIN_GROUP(msiof1_rxd_f),
+		SH_PFC_PIN_GROUP(msiof1_clk_g),
+		SH_PFC_PIN_GROUP(msiof1_sync_g),
+		SH_PFC_PIN_GROUP(msiof1_ss1_g),
+		SH_PFC_PIN_GROUP(msiof1_ss2_g),
+		SH_PFC_PIN_GROUP(msiof1_txd_g),
+		SH_PFC_PIN_GROUP(msiof1_rxd_g),
+		SH_PFC_PIN_GROUP(msiof2_clk_a),
+		SH_PFC_PIN_GROUP(msiof2_sync_a),
+		SH_PFC_PIN_GROUP(msiof2_ss1_a),
+		SH_PFC_PIN_GROUP(msiof2_ss2_a),
+		SH_PFC_PIN_GROUP(msiof2_txd_a),
+		SH_PFC_PIN_GROUP(msiof2_rxd_a),
+		SH_PFC_PIN_GROUP(msiof2_clk_b),
+		SH_PFC_PIN_GROUP(msiof2_sync_b),
+		SH_PFC_PIN_GROUP(msiof2_ss1_b),
+		SH_PFC_PIN_GROUP(msiof2_ss2_b),
+		SH_PFC_PIN_GROUP(msiof2_txd_b),
+		SH_PFC_PIN_GROUP(msiof2_rxd_b),
+		SH_PFC_PIN_GROUP(msiof2_clk_c),
+		SH_PFC_PIN_GROUP(msiof2_sync_c),
+		SH_PFC_PIN_GROUP(msiof2_ss1_c),
+		SH_PFC_PIN_GROUP(msiof2_ss2_c),
+		SH_PFC_PIN_GROUP(msiof2_txd_c),
+		SH_PFC_PIN_GROUP(msiof2_rxd_c),
+		SH_PFC_PIN_GROUP(msiof2_clk_d),
+		SH_PFC_PIN_GROUP(msiof2_sync_d),
+		SH_PFC_PIN_GROUP(msiof2_ss1_d),
+		SH_PFC_PIN_GROUP(msiof2_ss2_d),
+		SH_PFC_PIN_GROUP(msiof2_txd_d),
+		SH_PFC_PIN_GROUP(msiof2_rxd_d),
+		SH_PFC_PIN_GROUP(msiof3_clk_a),
+		SH_PFC_PIN_GROUP(msiof3_sync_a),
+		SH_PFC_PIN_GROUP(msiof3_ss1_a),
+		SH_PFC_PIN_GROUP(msiof3_ss2_a),
+		SH_PFC_PIN_GROUP(msiof3_txd_a),
+		SH_PFC_PIN_GROUP(msiof3_rxd_a),
+		SH_PFC_PIN_GROUP(msiof3_clk_b),
+		SH_PFC_PIN_GROUP(msiof3_sync_b),
+		SH_PFC_PIN_GROUP(msiof3_ss1_b),
+		SH_PFC_PIN_GROUP(msiof3_ss2_b),
+		SH_PFC_PIN_GROUP(msiof3_txd_b),
+		SH_PFC_PIN_GROUP(msiof3_rxd_b),
+		SH_PFC_PIN_GROUP(msiof3_clk_c),
+		SH_PFC_PIN_GROUP(msiof3_sync_c),
+		SH_PFC_PIN_GROUP(msiof3_txd_c),
+		SH_PFC_PIN_GROUP(msiof3_rxd_c),
+		SH_PFC_PIN_GROUP(msiof3_clk_d),
+		SH_PFC_PIN_GROUP(msiof3_sync_d),
+		SH_PFC_PIN_GROUP(msiof3_ss1_d),
+		SH_PFC_PIN_GROUP(msiof3_txd_d),
+		SH_PFC_PIN_GROUP(msiof3_rxd_d),
+		SH_PFC_PIN_GROUP(msiof3_clk_e),
+		SH_PFC_PIN_GROUP(msiof3_sync_e),
+		SH_PFC_PIN_GROUP(msiof3_ss1_e),
+		SH_PFC_PIN_GROUP(msiof3_ss2_e),
+		SH_PFC_PIN_GROUP(msiof3_txd_e),
+		SH_PFC_PIN_GROUP(msiof3_rxd_e),
+		SH_PFC_PIN_GROUP(pwm0),
+		SH_PFC_PIN_GROUP(pwm1_a),
+		SH_PFC_PIN_GROUP(pwm1_b),
+		SH_PFC_PIN_GROUP(pwm2_a),
+		SH_PFC_PIN_GROUP(pwm2_b),
+		SH_PFC_PIN_GROUP(pwm3_a),
+		SH_PFC_PIN_GROUP(pwm3_b),
+		SH_PFC_PIN_GROUP(pwm4_a),
+		SH_PFC_PIN_GROUP(pwm4_b),
+		SH_PFC_PIN_GROUP(pwm5_a),
+		SH_PFC_PIN_GROUP(pwm5_b),
+		SH_PFC_PIN_GROUP(pwm6_a),
+		SH_PFC_PIN_GROUP(pwm6_b),
+		SH_PFC_PIN_GROUP(sata0_devslp_a),
+		SH_PFC_PIN_GROUP(sata0_devslp_b),
+		SH_PFC_PIN_GROUP(scif0_data),
+		SH_PFC_PIN_GROUP(scif0_clk),
+		SH_PFC_PIN_GROUP(scif0_ctrl),
+		SH_PFC_PIN_GROUP(scif1_data_a),
+		SH_PFC_PIN_GROUP(scif1_clk),
+		SH_PFC_PIN_GROUP(scif1_ctrl),
+		SH_PFC_PIN_GROUP(scif1_data_b),
+		SH_PFC_PIN_GROUP(scif2_data_a),
+		SH_PFC_PIN_GROUP(scif2_clk),
+		SH_PFC_PIN_GROUP(scif2_data_b),
+		SH_PFC_PIN_GROUP(scif3_data_a),
+		SH_PFC_PIN_GROUP(scif3_clk),
+		SH_PFC_PIN_GROUP(scif3_ctrl),
+		SH_PFC_PIN_GROUP(scif3_data_b),
+		SH_PFC_PIN_GROUP(scif4_data_a),
+		SH_PFC_PIN_GROUP(scif4_clk_a),
+		SH_PFC_PIN_GROUP(scif4_ctrl_a),
+		SH_PFC_PIN_GROUP(scif4_data_b),
+		SH_PFC_PIN_GROUP(scif4_clk_b),
+		SH_PFC_PIN_GROUP(scif4_ctrl_b),
+		SH_PFC_PIN_GROUP(scif4_data_c),
+		SH_PFC_PIN_GROUP(scif4_clk_c),
+		SH_PFC_PIN_GROUP(scif4_ctrl_c),
+		SH_PFC_PIN_GROUP(scif5_data_a),
+		SH_PFC_PIN_GROUP(scif5_clk_a),
+		SH_PFC_PIN_GROUP(scif5_data_b),
+		SH_PFC_PIN_GROUP(scif5_clk_b),
+		SH_PFC_PIN_GROUP(scif_clk_a),
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
+		SH_PFC_PIN_GROUP(sdhi2_data8),
+		SH_PFC_PIN_GROUP(sdhi2_ctrl),
+		SH_PFC_PIN_GROUP(sdhi2_cd_a),
+		SH_PFC_PIN_GROUP(sdhi2_wp_a),
+		SH_PFC_PIN_GROUP(sdhi2_cd_b),
+		SH_PFC_PIN_GROUP(sdhi2_wp_b),
+		SH_PFC_PIN_GROUP(sdhi2_ds),
+		SH_PFC_PIN_GROUP(sdhi3_data1),
+		SH_PFC_PIN_GROUP(sdhi3_data4),
+		SH_PFC_PIN_GROUP(sdhi3_data8),
+		SH_PFC_PIN_GROUP(sdhi3_ctrl),
+		SH_PFC_PIN_GROUP(sdhi3_cd),
+		SH_PFC_PIN_GROUP(sdhi3_wp),
+		SH_PFC_PIN_GROUP(sdhi3_ds),
+		SH_PFC_PIN_GROUP(ssi0_data),
+		SH_PFC_PIN_GROUP(ssi01239_ctrl),
+		SH_PFC_PIN_GROUP(ssi1_data_a),
+		SH_PFC_PIN_GROUP(ssi1_data_b),
+		SH_PFC_PIN_GROUP(ssi1_ctrl_a),
+		SH_PFC_PIN_GROUP(ssi1_ctrl_b),
+		SH_PFC_PIN_GROUP(ssi2_data_a),
+		SH_PFC_PIN_GROUP(ssi2_data_b),
+		SH_PFC_PIN_GROUP(ssi2_ctrl_a),
+		SH_PFC_PIN_GROUP(ssi2_ctrl_b),
+		SH_PFC_PIN_GROUP(ssi3_data),
+		SH_PFC_PIN_GROUP(ssi349_ctrl),
+		SH_PFC_PIN_GROUP(ssi4_data),
+		SH_PFC_PIN_GROUP(ssi4_ctrl),
+		SH_PFC_PIN_GROUP(ssi5_data),
+		SH_PFC_PIN_GROUP(ssi5_ctrl),
+		SH_PFC_PIN_GROUP(ssi6_data),
+		SH_PFC_PIN_GROUP(ssi6_ctrl),
+		SH_PFC_PIN_GROUP(ssi7_data),
+		SH_PFC_PIN_GROUP(ssi78_ctrl),
+		SH_PFC_PIN_GROUP(ssi8_data),
+		SH_PFC_PIN_GROUP(ssi9_data_a),
+		SH_PFC_PIN_GROUP(ssi9_data_b),
+		SH_PFC_PIN_GROUP(ssi9_ctrl_a),
+		SH_PFC_PIN_GROUP(ssi9_ctrl_b),
+		SH_PFC_PIN_GROUP(tmu_tclk1_a),
+		SH_PFC_PIN_GROUP(tmu_tclk1_b),
+		SH_PFC_PIN_GROUP(tmu_tclk2_a),
+		SH_PFC_PIN_GROUP(tmu_tclk2_b),
+		SH_PFC_PIN_GROUP(tpu_to0),
+		SH_PFC_PIN_GROUP(tpu_to1),
+		SH_PFC_PIN_GROUP(tpu_to2),
+		SH_PFC_PIN_GROUP(tpu_to3),
+		SH_PFC_PIN_GROUP(usb0),
+		SH_PFC_PIN_GROUP(usb1),
+		SH_PFC_PIN_GROUP(usb2),
+		SH_PFC_PIN_GROUP(usb2_ch3),
+		SH_PFC_PIN_GROUP(usb30),
+		VIN_DATA_PIN_GROUP(vin4_data, 8, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 10, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 12, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 16, _a),
+		SH_PFC_PIN_GROUP(vin4_data18_a),
+		VIN_DATA_PIN_GROUP(vin4_data, 20, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 24, _a),
+		VIN_DATA_PIN_GROUP(vin4_data, 8, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 10, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 12, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 16, _b),
+		SH_PFC_PIN_GROUP(vin4_data18_b),
+		VIN_DATA_PIN_GROUP(vin4_data, 20, _b),
+		VIN_DATA_PIN_GROUP(vin4_data, 24, _b),
+		SH_PFC_PIN_GROUP(vin4_sync),
+		SH_PFC_PIN_GROUP(vin4_field),
+		SH_PFC_PIN_GROUP(vin4_clkenb),
+		SH_PFC_PIN_GROUP(vin4_clk),
+		VIN_DATA_PIN_GROUP(vin5_data, 8),
+		VIN_DATA_PIN_GROUP(vin5_data, 10),
+		VIN_DATA_PIN_GROUP(vin5_data, 12),
+		VIN_DATA_PIN_GROUP(vin5_data, 16),
+		SH_PFC_PIN_GROUP(vin5_sync),
+		SH_PFC_PIN_GROUP(vin5_field),
+		SH_PFC_PIN_GROUP(vin5_clkenb),
+		SH_PFC_PIN_GROUP(vin5_clk),
+	},
+	.automotive = {
+		SH_PFC_PIN_GROUP(drif0_ctrl_a),
+		SH_PFC_PIN_GROUP(drif0_data0_a),
+		SH_PFC_PIN_GROUP(drif0_data1_a),
+		SH_PFC_PIN_GROUP(drif0_ctrl_b),
+		SH_PFC_PIN_GROUP(drif0_data0_b),
+		SH_PFC_PIN_GROUP(drif0_data1_b),
+		SH_PFC_PIN_GROUP(drif0_ctrl_c),
+		SH_PFC_PIN_GROUP(drif0_data0_c),
+		SH_PFC_PIN_GROUP(drif0_data1_c),
+		SH_PFC_PIN_GROUP(drif1_ctrl_a),
+		SH_PFC_PIN_GROUP(drif1_data0_a),
+		SH_PFC_PIN_GROUP(drif1_data1_a),
+		SH_PFC_PIN_GROUP(drif1_ctrl_b),
+		SH_PFC_PIN_GROUP(drif1_data0_b),
+		SH_PFC_PIN_GROUP(drif1_data1_b),
+		SH_PFC_PIN_GROUP(drif1_ctrl_c),
+		SH_PFC_PIN_GROUP(drif1_data0_c),
+		SH_PFC_PIN_GROUP(drif1_data1_c),
+		SH_PFC_PIN_GROUP(drif2_ctrl_a),
+		SH_PFC_PIN_GROUP(drif2_data0_a),
+		SH_PFC_PIN_GROUP(drif2_data1_a),
+		SH_PFC_PIN_GROUP(drif2_ctrl_b),
+		SH_PFC_PIN_GROUP(drif2_data0_b),
+		SH_PFC_PIN_GROUP(drif2_data1_b),
+		SH_PFC_PIN_GROUP(drif3_ctrl_a),
+		SH_PFC_PIN_GROUP(drif3_data0_a),
+		SH_PFC_PIN_GROUP(drif3_data1_a),
+		SH_PFC_PIN_GROUP(drif3_ctrl_b),
+		SH_PFC_PIN_GROUP(drif3_data0_b),
+		SH_PFC_PIN_GROUP(drif3_data1_b),
+	}
+
 };
 
 static const char * const audio_clk_groups[] = {
@@ -5034,64 +5042,72 @@ static const char * const vin5_groups[] = {
 	"vin5_clk",
 };
 
-static const struct sh_pfc_function pinmux_functions[] = {
-	SH_PFC_FUNCTION(audio_clk),
-	SH_PFC_FUNCTION(avb),
-	SH_PFC_FUNCTION(can0),
-	SH_PFC_FUNCTION(can1),
-	SH_PFC_FUNCTION(can_clk),
-	SH_PFC_FUNCTION(canfd0),
-	SH_PFC_FUNCTION(canfd1),
-	SH_PFC_FUNCTION(drif0),
-	SH_PFC_FUNCTION(drif1),
-	SH_PFC_FUNCTION(drif2),
-	SH_PFC_FUNCTION(drif3),
-	SH_PFC_FUNCTION(du),
-	SH_PFC_FUNCTION(hscif0),
-	SH_PFC_FUNCTION(hscif1),
-	SH_PFC_FUNCTION(hscif2),
-	SH_PFC_FUNCTION(hscif3),
-	SH_PFC_FUNCTION(hscif4),
-	SH_PFC_FUNCTION(i2c0),
-	SH_PFC_FUNCTION(i2c1),
-	SH_PFC_FUNCTION(i2c2),
-	SH_PFC_FUNCTION(i2c3),
-	SH_PFC_FUNCTION(i2c5),
-	SH_PFC_FUNCTION(i2c6),
-	SH_PFC_FUNCTION(intc_ex),
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
-	SH_PFC_FUNCTION(sata0),
-	SH_PFC_FUNCTION(scif0),
-	SH_PFC_FUNCTION(scif1),
-	SH_PFC_FUNCTION(scif2),
-	SH_PFC_FUNCTION(scif3),
-	SH_PFC_FUNCTION(scif4),
-	SH_PFC_FUNCTION(scif5),
-	SH_PFC_FUNCTION(scif_clk),
-	SH_PFC_FUNCTION(sdhi0),
-	SH_PFC_FUNCTION(sdhi1),
-	SH_PFC_FUNCTION(sdhi2),
-	SH_PFC_FUNCTION(sdhi3),
-	SH_PFC_FUNCTION(ssi),
-	SH_PFC_FUNCTION(tmu),
-	SH_PFC_FUNCTION(tpu),
-	SH_PFC_FUNCTION(usb0),
-	SH_PFC_FUNCTION(usb1),
-	SH_PFC_FUNCTION(usb2),
-	SH_PFC_FUNCTION(usb2_ch3),
-	SH_PFC_FUNCTION(usb30),
-	SH_PFC_FUNCTION(vin4),
-	SH_PFC_FUNCTION(vin5),
+static const struct {
+	struct sh_pfc_function common[53];
+	struct sh_pfc_function automotive[4];
+} pinmux_functions = {
+	.common = {
+		SH_PFC_FUNCTION(audio_clk),
+		SH_PFC_FUNCTION(avb),
+		SH_PFC_FUNCTION(can0),
+		SH_PFC_FUNCTION(can1),
+		SH_PFC_FUNCTION(can_clk),
+		SH_PFC_FUNCTION(canfd0),
+		SH_PFC_FUNCTION(canfd1),
+		SH_PFC_FUNCTION(du),
+		SH_PFC_FUNCTION(hscif0),
+		SH_PFC_FUNCTION(hscif1),
+		SH_PFC_FUNCTION(hscif2),
+		SH_PFC_FUNCTION(hscif3),
+		SH_PFC_FUNCTION(hscif4),
+		SH_PFC_FUNCTION(i2c0),
+		SH_PFC_FUNCTION(i2c1),
+		SH_PFC_FUNCTION(i2c2),
+		SH_PFC_FUNCTION(i2c3),
+		SH_PFC_FUNCTION(i2c5),
+		SH_PFC_FUNCTION(i2c6),
+		SH_PFC_FUNCTION(intc_ex),
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
+		SH_PFC_FUNCTION(sata0),
+		SH_PFC_FUNCTION(scif0),
+		SH_PFC_FUNCTION(scif1),
+		SH_PFC_FUNCTION(scif2),
+		SH_PFC_FUNCTION(scif3),
+		SH_PFC_FUNCTION(scif4),
+		SH_PFC_FUNCTION(scif5),
+		SH_PFC_FUNCTION(scif_clk),
+		SH_PFC_FUNCTION(sdhi0),
+		SH_PFC_FUNCTION(sdhi1),
+		SH_PFC_FUNCTION(sdhi2),
+		SH_PFC_FUNCTION(sdhi3),
+		SH_PFC_FUNCTION(ssi),
+		SH_PFC_FUNCTION(tmu),
+		SH_PFC_FUNCTION(tpu),
+		SH_PFC_FUNCTION(usb0),
+		SH_PFC_FUNCTION(usb1),
+		SH_PFC_FUNCTION(usb2),
+		SH_PFC_FUNCTION(usb2_ch3),
+		SH_PFC_FUNCTION(usb30),
+		SH_PFC_FUNCTION(vin4),
+		SH_PFC_FUNCTION(vin5),
+	},
+	.automotive = {
+		SH_PFC_FUNCTION(drif0),
+		SH_PFC_FUNCTION(drif1),
+		SH_PFC_FUNCTION(drif2),
+		SH_PFC_FUNCTION(drif3),
+	}
+
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
@@ -5780,7 +5796,9 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ PIN_DU_DOTCLKIN1,    0, 2 },	/* DU_DOTCLKIN1 */
 	} },
 	{ PINMUX_DRIVE_REG("DRVCTRL12", 0xe6060330) {
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 		{ PIN_DU_DOTCLKIN2,   28, 2 },	/* DU_DOTCLKIN2 */
+#endif
 		{ PIN_DU_DOTCLKIN3,   24, 2 },	/* DU_DOTCLKIN3 */
 		{ PIN_FSCLKST_N,      20, 2 },	/* FSCLKST# */
 		{ PIN_TMS,             4, 2 },	/* TMS */
@@ -5901,8 +5919,8 @@ static const struct pinmux_drive_reg pinmux_drive_regs[] = {
 		{ RCAR_GP_PIN(6, 27), 20, 3 },	/* USB1_OVC */
 		{ RCAR_GP_PIN(6, 28), 16, 3 },	/* USB30_PWEN */
 		{ RCAR_GP_PIN(6, 29), 12, 3 },	/* USB30_OVC */
-		{ RCAR_GP_PIN(6, 30),  8, 3 },	/* USB2_CH3_PWEN */
-		{ RCAR_GP_PIN(6, 31),  4, 3 },	/* USB2_CH3_OVC */
+		{ RCAR_GP_PIN(6, 30),  8, 3 },	/* GP6_30/USB2_CH3_PWEN */
+		{ RCAR_GP_PIN(6, 31),  4, 3 },	/* GP6_31/USB2_CH3_OVC */
 	} },
 	{ },
 };
@@ -6223,6 +6241,32 @@ static const struct sh_pfc_soc_operations r8a77951_pinmux_ops = {
 	.set_bias = r8a77951_pinmux_set_bias,
 };
 
+#ifdef CONFIG_PINCTRL_PFC_R8A774E1
+const struct sh_pfc_soc_info r8a774e1_pinmux_info = {
+	.name = "r8a774e1_pfc",
+	.ops = &r8a77951_pinmux_ops,
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
+	.drive_regs = pinmux_drive_regs,
+	.bias_regs = pinmux_bias_regs,
+	.ioctrl_regs = pinmux_ioctrl_regs,
+
+	.pinmux_data = pinmux_data,
+	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
+};
+#endif
+
+#ifdef CONFIG_PINCTRL_PFC_R8A77951
 const struct sh_pfc_soc_info r8a77951_pinmux_info = {
 	.name = "r8a77951_pfc",
 	.ops = &r8a77951_pinmux_ops,
@@ -6232,10 +6276,12 @@ const struct sh_pfc_soc_info r8a77951_pinmux_info = {
 
 	.pins = pinmux_pins,
 	.nr_pins = ARRAY_SIZE(pinmux_pins),
-	.groups = pinmux_groups,
-	.nr_groups = ARRAY_SIZE(pinmux_groups),
-	.functions = pinmux_functions,
-	.nr_functions = ARRAY_SIZE(pinmux_functions),
+	.groups = pinmux_groups.common,
+	.nr_groups = ARRAY_SIZE(pinmux_groups.common) +
+			ARRAY_SIZE(pinmux_groups.automotive),
+	.functions = pinmux_functions.common,
+	.nr_functions = ARRAY_SIZE(pinmux_functions.common) +
+			ARRAY_SIZE(pinmux_functions.automotive),
 
 	.cfg_regs = pinmux_config_regs,
 	.drive_regs = pinmux_drive_regs,
@@ -6245,3 +6291,4 @@ const struct sh_pfc_soc_info r8a77951_pinmux_info = {
 	.pinmux_data = pinmux_data,
 	.pinmux_data_size = ARRAY_SIZE(pinmux_data),
 };
+#endif
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e8e1e1a8a7cf..5342031a8a44 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -313,6 +313,7 @@ extern const struct sh_pfc_soc_info r8a77470_pinmux_info;
 extern const struct sh_pfc_soc_info r8a774a1_pinmux_info;
 extern const struct sh_pfc_soc_info r8a774b1_pinmux_info;
 extern const struct sh_pfc_soc_info r8a774c0_pinmux_info;
+extern const struct sh_pfc_soc_info r8a774e1_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7778_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7779_pinmux_info;
 extern const struct sh_pfc_soc_info r8a7790_pinmux_info;
-- 
2.17.1


--sS266VR6vF0koQ0QcmfF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5199): https://lists.cip-project.org/g/cip-dev/message=
/5199
Mute This Topic: https://lists.cip-project.org/mt/76326739/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--sS266VR6vF0koQ0QcmfF--
