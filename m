Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838F5C83F22
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 10:10:10 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.74801.1752487784571804237
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 03:10:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 1oItz14FSC2LhkoFAxSVpQ==
X-CSE-MsgGUID: xBQNi2frQFSAgMpy84C6xA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jul 2025 19:10:02 +0900
Received: from localhost.localdomain (unknown [10.226.92.48])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2E31740503AB;
	Mon, 14 Jul 2025 19:10:00 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 56/57] arm64: dts: renesas: r9a09g047e57-smarc: Enable CAN Transceiver
Date: Mon, 14 Jul 2025 11:07:37 +0100
Message-ID: <20250714100802.80035-57-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
References: <20250714100802.80035-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Jul 2025 10:10:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19484

commit 99256644c8c9523e27312f6318058481943281ab upstream.

Enable TCAN1046V-Q1 CAN Transceiver populated on RZ/G3E SMARC EVK by
modelling it as two instances of tcan1042.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250320164121.193857-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 22 ++++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 25 +++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 7e1daaabce8a..1f5e61a73c35 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -8,6 +8,8 @@
 /dts-v1/;
 
 /* Switch selection settings */
+#define SW_GPIO8_CAN0_STB	0
+#define SW_GPIO9_CAN1_STB	0
 #define SW_LCD_EN		0
 #define SW_PDM_EN		0
 #define SW_SD0_DEV_SEL		0
@@ -42,16 +44,36 @@ &canfd {
 #if (!SW_PDM_EN)
 	channel1 {
 		status = "okay";
+#if (!SW_LCD_EN) && (SW_GPIO9_CAN1_STB)
+		phys = <&can_transceiver1>;
+#endif
 	};
 #endif
 
 #if (!SW_LCD_EN)
 	channel4 {
 		status = "okay";
+#if (SW_GPIO8_CAN0_STB)
+		phys = <&can_transceiver0>;
+#endif
 	};
 #endif
 };
 
+#if (!SW_LCD_EN) && (SW_GPIO8_CAN0_STB)
+&can_transceiver0 {
+	standby-gpios = <&pinctrl RZG3E_GPIO(5, 4) GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+#endif
+
+#if (!SW_LCD_EN) && (SW_GPIO9_CAN1_STB)
+&can_transceiver1 {
+	standby-gpios = <&pinctrl RZG3E_GPIO(5, 5) GPIO_ACTIVE_HIGH>;
+	status = "okay";
+};
+#endif
+
 &pinctrl {
 	canfd_pins: canfd {
 		can1_pins: can1 {
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index 1d3a844174b3..afdc1940e24a 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -12,6 +12,17 @@
  * SW_SDIO_M2E:
  *     0 - SMARC SDIO signal is connected to uSD1
  *     1 - SMARC SDIO signal is connected to M.2 Key E connector
+ *
+ * Please set the switch position SW_GPIO_CAN_PMOD on the carrier board and the
+ * corresponding macro SW_GPIO8_CAN0_STB/SW_GPIO8_CAN0_STB on the board DTS:
+ *
+ * SW_GPIO8_CAN0_STB:
+ *	0 - Connect to GPIO8 PMOD (default)
+ *	1 - Connect to CAN0 transceiver STB pin
+ *
+ * SW_GPIO9_CAN1_STB:
+ *	0 - Connect to GPIO9 PMOD (default)
+ *	1 - Connect to CAN1 transceiver STB pin
  */
 
 / {
@@ -27,6 +38,20 @@ aliases {
 		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
+
+	can_transceiver0: can-phy0 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		status = "disabled";
+	};
+
+	can_transceiver1: can-phy1 {
+		compatible = "ti,tcan1042";
+		#phy-cells = <0>;
+		max-bitrate = <8000000>;
+		status = "disabled";
+	};
 };
 
 &canfd {
-- 
2.43.0


