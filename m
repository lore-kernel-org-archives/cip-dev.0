Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6260DEEB565
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88804.1767200431635644184
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: kyq5PAfAQ3G6dOSAnHrvGw==
X-CSE-MsgGUID: Q0FNI/d5RUq0ZAZ87XXGbA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:51 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4AC364024131;
	Thu,  1 Jan 2026 02:00:50 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 13/17] arm64: dts: renesas: rzt2h-rzn2h-evk: Enable MicroSD card slot
Date: Wed, 31 Dec 2025 17:00:22 +0000
Message-ID: <20251231170026.17006-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21292

commit dba8ee27c5de15c3c347816bb189af939092aea9 upstream.

Enable MicroSD card slot which is connected to SDHI1 on the RZ/T2H and
RZ/N2H EVKs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-9-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  9 ++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  6 +++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 51 +++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 7f196f1d1a2d8..e9c691d568448 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -19,6 +19,13 @@
  */
 #define SD0_EMMC	1
 
+/*
+ * P17_4 = SD1_CD; SW2[3] = ON
+ * P08_5 = SD1_PWEN; SW2[3] = ON
+ * P08_6 = SD1_IOVS; SW2[3] = ON; SW5[3] = OFF; SW5[4] = ON
+ */
+#define SD1_MICRO_SD	1
+
 #include "rzt2h-n2h-evk-common.dtsi"
 
 / {
@@ -51,6 +58,7 @@ led-2 {
 			function-enumerator = <2>;
 		};
 
+#if (!SD1_MICRO_SD)
 		led-3 {
 			/* SW2-3: OFF */
 			gpios = <&pinctrl RZT2H_GPIO(8, 5) GPIO_ACTIVE_HIGH>;
@@ -58,6 +66,7 @@ led-3 {
 			function = LED_FUNCTION_DEBUG;
 			function-enumerator = <3>;
 		};
+#endif
 
 		led-4 {
 			/* SW8-3: ON, SW8-4: OFF */
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index 87e362f6f09f7..87178933bee8d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -18,6 +18,12 @@
  */
 #define SD0_EMMC       1
 
+/*
+ * P17_4 = SD1_CD; DSW5[3] = ON; DSW19[1] = OFF; DSW19[2] = ON
+ * P08_6 = SD1_IOVS; DSW5[3] = ON
+ */
+#define SD1_MICRO_SD	1
+
 #include "rzt2h-n2h-evk-common.dtsi"
 
 /*
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 68d493bf5e8cf..34572630ecbe7 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -14,6 +14,7 @@ aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		mmc0 = &sdhi0;
+		mmc1 = &sdhi1;
 		serial0 = &sci0;
 	};
 
@@ -38,6 +39,18 @@ reg_3p3v: regulator-3p3v {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+#if SD1_MICRO_SD
+	vccq_sdhi1: regulator-vccq-sdhi1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZT2H_GPIO(8, 6) GPIO_ACTIVE_HIGH>;
+		gpios-states = <0>;
+		states = <3300000 0>, <1800000 1>;
+	};
+#endif
 };
 
 &extal_clk {
@@ -93,6 +106,30 @@ ctrl-pins {
 				 <RZT2H_PORT_PINMUX(13, 2, 0x29)>; /* SD0_RST# */
 		};
 	};
+
+#if SD1_MICRO_SD
+	sdhi1-pwen-hog {
+		gpio-hog;
+		gpios = <RZT2H_GPIO(8, 5) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SD1_PWEN";
+	};
+#endif
+
+	sdhi1_pins: sd1-group {
+		data-pins {
+			pinmux = <RZT2H_PORT_PINMUX(16, 7, 0x29)>, /* SD1_DATA0 */
+				 <RZT2H_PORT_PINMUX(17, 0, 0x29)>, /* SD1_DATA1 */
+				 <RZT2H_PORT_PINMUX(17, 1, 0x29)>, /* SD1_DATA2 */
+				 <RZT2H_PORT_PINMUX(17, 2, 0x29)>; /* SD1_DATA3 */
+		};
+
+		ctrl-pins {
+			pinmux = <RZT2H_PORT_PINMUX(16, 5, 0x29)>, /* SD1_CLK */
+				 <RZT2H_PORT_PINMUX(16, 6, 0x29)>, /* SD1_CMD */
+				 <RZT2H_PORT_PINMUX(17, 4, 0x29)>; /* SD1_CD */
+		};
+	};
 };
 
 &sci0 {
@@ -115,3 +152,17 @@ &sdhi0 {
 	status = "okay";
 };
 #endif
+
+#if SD1_MICRO_SD
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+#endif
-- 
2.43.0


