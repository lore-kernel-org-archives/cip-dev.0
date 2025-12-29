Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A4EE92FFB
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53265.1767047973878245967
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: U0RMZKmyQ32xdB09ZK/HBg==
X-CSE-MsgGUID: B4ng8lt5SOG86A9ZYOrmzQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:42 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B91F9400A0FF;
	Tue, 30 Dec 2025 07:39:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/17] arm64: dts: renesas: r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1 support
Date: Mon, 29 Dec 2025 22:39:10 +0000
Message-ID: <20251229223911.8663-17-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21274

commit fc14be9667ee06301c3fff578357c8d78749bb13 upstream.

Enable I2C0 and I2C1 on the RZ/N2H evaluation board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index fb2651c4c3383..a068661fc4429 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -10,6 +10,14 @@
 #include "r9a09g087m44.dtsi"
 #include "rzt2h-n2h-evk-common.dtsi"
 
+/*
+ * I2C0 and LED8/9 share the same pins use the below
+ * macro to choose (and set approopriate DIP switches).
+ */
+#define I2C0	1
+#define LED8	(!I2C0)
+#define LED9	(!I2C0)
+
 / {
 	model = "Renesas RZ/N2H EVK Board based on r9a09g087m44";
 	compatible = "renesas,rzn2h-evk", "renesas,r9a09g087m44", "renesas,r9a09g087";
@@ -60,6 +68,7 @@ led-7 {
 			function-enumerator = <8>;
 		};
 
+#if LED8
 		led-8 {
 			/*
 			 * USER_LED0
@@ -70,7 +79,9 @@ led-8 {
 			function = LED_FUNCTION_DEBUG;
 			function-enumerator = <0>;
 		};
+#endif
 
+#if LED9
 		led-9 {
 			/*
 			 * USER_LED1
@@ -81,6 +92,7 @@ led-9 {
 			function = LED_FUNCTION_DEBUG;
 			function-enumerator = <1>;
 		};
+#endif
 
 		led-10 {
 			/*
@@ -105,3 +117,47 @@ led-11 {
 		};
 	};
 };
+
+#if I2C0
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+#endif
+
+&i2c1 {
+	pinctrl-0 = <&i2c1_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&pinctrl {
+	/*
+	 * I2C0 Pin Configuration:
+	 * ------------------------
+	 * Signal | Pin     | DSW15
+	 * -------|---------|--------------
+	 * SCL    | P14_6   | 8: OFF, 9: ON, 10: OFF
+	 * SDA    | P14_7   | 5: ON, 6: OFF
+	 */
+	i2c0_pins: i2c0-pins {
+		pinmux = <RZT2H_PORT_PINMUX(14, 6, 0x17)>,
+			 <RZT2H_PORT_PINMUX(14, 7, 0x17)>;
+	};
+
+	/*
+	 * I2C1 Pin Configuration:
+	 * ------------------------
+	 * Signal | Pin     | DSW7
+	 * -------|---------|--------------
+	 * SCL    | P03_3   | 1: ON, 2: OFF
+	 * SDA    | P03_4   | 3: ON, 4: OFF
+	 */
+	i2c1_pins: i2c1-pins {
+		pinmux = <RZT2H_PORT_PINMUX(3, 3, 0x17)>,
+			 <RZT2H_PORT_PINMUX(3, 4, 0x17)>;
+	};
+};
-- 
2.43.0


