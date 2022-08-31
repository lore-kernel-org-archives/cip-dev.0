Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EA2C0502A
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.1257.1661964455934492253
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133251681"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C983D40457CD;
	Thu,  1 Sep 2022 01:47:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/26] pinctrl: renesas: rzg2l: Add RZ/G2UL support
Date: Wed, 31 Aug 2022 17:46:33 +0100
Message-Id: <20220831164645.2134258-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9374

commit bfc69bdbaad141ac408e6de86b7e0d771c8e3ccb upstream.

RZ/G2UL SoC has fewer pins compared to RZ/G2L and the port pin
definitions are different compared to RZ/G2L.

This patch adds a new compatible to take care of these differences by
adding r9a07g043_data with r9a07g043_gpio_configs and
rzg2l_dedicated_pins.common.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220401180230.19950-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig         |   5 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 200 ++++++++++++++----------
 2 files changed, 124 insertions(+), 81 deletions(-)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 623d0c01e259..0d2f985918bb 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -36,6 +36,7 @@ config PINCTRL_RENESAS
 	select PINCTRL_PFC_R8A77980 if ARCH_R8A77980
 	select PINCTRL_PFC_R8A77990 if ARCH_R8A77990
 	select PINCTRL_PFC_R8A77995 if ARCH_R8A77995
+	select PINCTRL_RZG2L if ARCH_R9A07G043
 	select PINCTRL_RZG2L if ARCH_R9A07G044
 	select PINCTRL_RZG2L if ARCH_R9A07G054
 	select PINCTRL_PFC_SH7203 if CPU_SUBTYPE_SH7203
@@ -174,14 +175,14 @@ config PINCTRL_RZA2
 	  This selects GPIO and pinctrl driver for Renesas RZ/A2 platforms.
 
 config PINCTRL_RZG2L
-	bool "pin control support for RZ/{G2L,V2L}" if COMPILE_TEST
+	bool "pin control support for RZ/{G2L,G2UL,V2L}" if COMPILE_TEST
 	depends on OF
 	select GPIOLIB
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
 	help
-	  This selects GPIO and pinctrl driver for Renesas RZ/{G2L,V2L}
+	  This selects GPIO and pinctrl driver for Renesas RZ/{G2L,G2UL,V2L}
 	  platforms.
 
 config PINCTRL_PFC_R8A77470
diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index cb805502fb0f..86a7096640ad 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -996,83 +996,112 @@ static const u32 rzg2l_gpio_configs[] = {
 	RZG2L_GPIO_PORT_PACK(5, 0x40, RZG2L_MPXED_PIN_FUNCS),
 };
 
-static  struct rzg2l_dedicated_configs rzg2l_dedicated_pins[] = {
-	{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
-	 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
-	{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
-	 (PIN_CFG_SR | PIN_CFG_IOLH_A | PIN_CFG_IEN)) },
-	{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
-	 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
-	{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x4, 0, PIN_CFG_IEN) },
-	{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x4, 1, PIN_CFG_IEN) },
-	{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x6, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x6, 2,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x7, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x7, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x7, 2,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x7, 3,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x7, 4,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x7, 5,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x7, 6,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x7, 7,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
-	{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x8, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD1)) },
-	{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x8, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
-	{ "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x9, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
-	{ "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x9, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
-	{ "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x9, 2,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
-	{ "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x9, 3,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
-	{ "QSPI0_SPCLK", RZG2L_SINGLE_PIN_PACK(0xa, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0xa, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0xa, 2,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0xa, 3,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0xa, 4,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI0_SSL", RZG2L_SINGLE_PIN_PACK(0xa, 5,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI1_SPCLK", RZG2L_SINGLE_PIN_PACK(0xb, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI1_IO0", RZG2L_SINGLE_PIN_PACK(0xb, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI1_IO1", RZG2L_SINGLE_PIN_PACK(0xb, 2,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI1_IO2", RZG2L_SINGLE_PIN_PACK(0xb, 3,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI1_IO3", RZG2L_SINGLE_PIN_PACK(0xb, 4,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR  | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI1_SSL", RZG2L_SINGLE_PIN_PACK(0xb, 5,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI_RESET#", RZG2L_SINGLE_PIN_PACK(0xc, 0,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI_WP#", RZG2L_SINGLE_PIN_PACK(0xc, 1,
-	 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "QSPI_INT#", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
-	{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0xd, 0, (PIN_CFG_IOLH_A | PIN_CFG_SR)) },
-	{ "RIIC0_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 0, PIN_CFG_IEN) },
-	{ "RIIC0_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 1, PIN_CFG_IEN) },
-	{ "RIIC1_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 2, PIN_CFG_IEN) },
-	{ "RIIC1_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 3, PIN_CFG_IEN) },
+static const u32 r9a07g043_gpio_configs[] = {
+	RZG2L_GPIO_PORT_PACK(4, 0x10, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(5, 0x11, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(4, 0x12, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(4, 0x13, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(6, 0x14, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH0)),
+	RZG2L_GPIO_PORT_PACK(5, 0x15, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(5, 0x16, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(5, 0x17, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(5, 0x18, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(4, 0x19, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(5, 0x1a, RZG2L_MPXED_ETH_PIN_FUNCS(PIN_CFG_IO_VMC_ETH1)),
+	RZG2L_GPIO_PORT_PACK(4, 0x1b, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x1c, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(5, 0x1d, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(3, 0x1e, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x1f, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(2, 0x20, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(4, 0x21, RZG2L_MPXED_PIN_FUNCS),
+	RZG2L_GPIO_PORT_PACK(6, 0x22, RZG2L_MPXED_PIN_FUNCS),
+};
+
+static struct {
+	struct rzg2l_dedicated_configs common[35];
+	struct rzg2l_dedicated_configs rzg2l_pins[7];
+} rzg2l_dedicated_pins = {
+	.common = {
+		{ "NMI", RZG2L_SINGLE_PIN_PACK(0x1, 0,
+		 (PIN_CFG_FILONOFF | PIN_CFG_FILNUM | PIN_CFG_FILCLKSEL)) },
+		{ "TMS/SWDIO", RZG2L_SINGLE_PIN_PACK(0x2, 0,
+		 (PIN_CFG_SR | PIN_CFG_IOLH_A | PIN_CFG_IEN)) },
+		{ "TDO", RZG2L_SINGLE_PIN_PACK(0x3, 0,
+		 (PIN_CFG_IOLH_A | PIN_CFG_SR | PIN_CFG_IEN)) },
+		{ "AUDIO_CLK1", RZG2L_SINGLE_PIN_PACK(0x4, 0, PIN_CFG_IEN) },
+		{ "AUDIO_CLK2", RZG2L_SINGLE_PIN_PACK(0x4, 1, PIN_CFG_IEN) },
+		{ "SD0_CLK", RZG2L_SINGLE_PIN_PACK(0x6, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_CMD", RZG2L_SINGLE_PIN_PACK(0x6, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_RST#", RZG2L_SINGLE_PIN_PACK(0x6, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA0", RZG2L_SINGLE_PIN_PACK(0x7, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA1", RZG2L_SINGLE_PIN_PACK(0x7, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA2", RZG2L_SINGLE_PIN_PACK(0x7, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA3", RZG2L_SINGLE_PIN_PACK(0x7, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA4", RZG2L_SINGLE_PIN_PACK(0x7, 4,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA5", RZG2L_SINGLE_PIN_PACK(0x7, 5,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA6", RZG2L_SINGLE_PIN_PACK(0x7, 6,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD0_DATA7", RZG2L_SINGLE_PIN_PACK(0x7, 7,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD0)) },
+		{ "SD1_CLK", RZG2L_SINGLE_PIN_PACK(0x8, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_CMD", RZG2L_SINGLE_PIN_PACK(0x8, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA0", RZG2L_SINGLE_PIN_PACK(0x9, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA1", RZG2L_SINGLE_PIN_PACK(0x9, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA2", RZG2L_SINGLE_PIN_PACK(0x9, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "SD1_DATA3", RZG2L_SINGLE_PIN_PACK(0x9, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IEN | PIN_CFG_IO_VMC_SD1)) },
+		{ "QSPI0_SPCLK", RZG2L_SINGLE_PIN_PACK(0xa, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO0", RZG2L_SINGLE_PIN_PACK(0xa, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO1", RZG2L_SINGLE_PIN_PACK(0xa, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO2", RZG2L_SINGLE_PIN_PACK(0xa, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_IO3", RZG2L_SINGLE_PIN_PACK(0xa, 4,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI0_SSL", RZG2L_SINGLE_PIN_PACK(0xa, 5,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI_RESET#", RZG2L_SINGLE_PIN_PACK(0xc, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI_WP#", RZG2L_SINGLE_PIN_PACK(0xc, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "WDTOVF_PERROUT#", RZG2L_SINGLE_PIN_PACK(0xd, 0, (PIN_CFG_IOLH_A | PIN_CFG_SR)) },
+		{ "RIIC0_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 0, PIN_CFG_IEN) },
+		{ "RIIC0_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 1, PIN_CFG_IEN) },
+		{ "RIIC1_SDA", RZG2L_SINGLE_PIN_PACK(0xe, 2, PIN_CFG_IEN) },
+		{ "RIIC1_SCL", RZG2L_SINGLE_PIN_PACK(0xe, 3, PIN_CFG_IEN) },
+	},
+	.rzg2l_pins = {
+		{ "QSPI_INT#", RZG2L_SINGLE_PIN_PACK(0xc, 2, (PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_SPCLK", RZG2L_SINGLE_PIN_PACK(0xb, 0,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO0", RZG2L_SINGLE_PIN_PACK(0xb, 1,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO1", RZG2L_SINGLE_PIN_PACK(0xb, 2,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO2", RZG2L_SINGLE_PIN_PACK(0xb, 3,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_IO3", RZG2L_SINGLE_PIN_PACK(0xb, 4,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR  | PIN_CFG_IO_VMC_QSPI)) },
+		{ "QSPI1_SSL", RZG2L_SINGLE_PIN_PACK(0xb, 5,
+		 (PIN_CFG_IOLH_B | PIN_CFG_SR | PIN_CFG_IO_VMC_QSPI)) },
+	}
 };
 
 static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
@@ -1250,15 +1279,28 @@ static int rzg2l_pinctrl_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static struct rzg2l_pinctrl_data r9a07g043_data = {
+	.port_pins = rzg2l_gpio_names,
+	.port_pin_configs = r9a07g043_gpio_configs,
+	.dedicated_pins = rzg2l_dedicated_pins.common,
+	.n_port_pins = ARRAY_SIZE(r9a07g043_gpio_configs) * RZG2L_PINS_PER_PORT,
+	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common),
+};
+
 static struct rzg2l_pinctrl_data r9a07g044_data = {
 	.port_pins = rzg2l_gpio_names,
 	.port_pin_configs = rzg2l_gpio_configs,
-	.dedicated_pins = rzg2l_dedicated_pins,
+	.dedicated_pins = rzg2l_dedicated_pins.common,
 	.n_port_pins = ARRAY_SIZE(rzg2l_gpio_names),
-	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins),
+	.n_dedicated_pins = ARRAY_SIZE(rzg2l_dedicated_pins.common) +
+		ARRAY_SIZE(rzg2l_dedicated_pins.rzg2l_pins),
 };
 
 static const struct of_device_id rzg2l_pinctrl_of_table[] = {
+	{
+		.compatible = "renesas,r9a07g043-pinctrl",
+		.data = &r9a07g043_data,
+	},
 	{
 		.compatible = "renesas,r9a07g044-pinctrl",
 		.data = &r9a07g044_data,
-- 
2.25.1


