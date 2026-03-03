Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED8EDA6B4
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 16:55:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.23260.1772556884440938222
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 08:54:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: Mqhrzz5ETH2fx4oTyCB4mg==
X-CSE-MsgGUID: NuRsBFsTT1C926KJYLvwdg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Mar 2026 01:54:58 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.13])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id ABB0740031DC;
	Wed,  4 Mar 2026 01:54:56 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 10/11] arm64: dts: renesas: rzt2h-rzn2h-evk: Reorder ADC nodes
Date: Tue,  3 Mar 2026 18:53:50 +0200
Message-ID: <20260303165351.914437-11-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260303165351.914437-1-cosmin-gabriel.tanislav.xa@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 16:55:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22070

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5979010bcc665e9bcf41b22f111b3fe7fc4eadb1 upstream.

Reorder the ADC nodes in the dts/i files so they follow the same
alphabetical ordering used elsewhere in these files.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260115122210.3971063-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  55 +++---
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  89 +++++-----
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 157 +++++++++---------
 3 files changed, 152 insertions(+), 149 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 95348fee1a03..d0a982a101b1 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -115,6 +115,34 @@ led-8 {
 	};
 };
 
+&adc2 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+
+	channel@4 {
+		reg = <0x4>;
+	};
+
+	channel@5 {
+		reg = <0x5>;
+	};
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -149,30 +177,3 @@ i2c1_pins: i2c1-pins {
 	};
 };
 
-&adc2 {
-	status = "okay";
-
-	channel@0 {
-		reg = <0x0>;
-	};
-
-	channel@1 {
-		reg = <0x1>;
-	};
-
-	channel@2 {
-		reg = <0x2>;
-	};
-
-	channel@3 {
-		reg = <0x3>;
-	};
-
-	channel@4 {
-		reg = <0x4>;
-	};
-
-	channel@5 {
-		reg = <0x5>;
-	};
-};
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index 079fda5f8ced..90bfcd76845b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -143,50 +143,6 @@ led-11 {
 	};
 };
 
-#if I2C0
-&i2c0 {
-	pinctrl-0 = <&i2c0_pins>;
-	pinctrl-names = "default";
-	clock-frequency = <400000>;
-	status = "okay";
-};
-#endif
-
-&i2c1 {
-	pinctrl-0 = <&i2c1_pins>;
-	pinctrl-names = "default";
-	clock-frequency = <400000>;
-	status = "okay";
-};
-
-&pinctrl {
-	/*
-	 * I2C0 Pin Configuration:
-	 * ------------------------
-	 * Signal | Pin     | DSW15
-	 * -------|---------|--------------
-	 * SCL    | P14_6   | 8: OFF, 9: ON, 10: OFF
-	 * SDA    | P14_7   | 5: ON, 6: OFF
-	 */
-	i2c0_pins: i2c0-pins {
-		pinmux = <RZT2H_PORT_PINMUX(14, 6, 0x17)>,
-			 <RZT2H_PORT_PINMUX(14, 7, 0x17)>;
-	};
-
-	/*
-	 * I2C1 Pin Configuration:
-	 * ------------------------
-	 * Signal | Pin     | DSW7
-	 * -------|---------|--------------
-	 * SCL    | P03_3   | 1: ON, 2: OFF
-	 * SDA    | P03_4   | 3: ON, 4: OFF
-	 */
-	i2c1_pins: i2c1-pins {
-		pinmux = <RZT2H_PORT_PINMUX(3, 3, 0x17)>,
-			 <RZT2H_PORT_PINMUX(3, 4, 0x17)>;
-	};
-};
-
 &adc2 {
 	status = "okay";
 
@@ -250,3 +206,48 @@ channel@e {
 		reg = <0xe>;
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
+
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index e11293db0f0b..d2cc1774a8aa 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -65,6 +65,85 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 #endif
 };
 
+/*
+ * ADC0 AN000 can be connected to a potentiometer on the board or
+ * exposed on ADC header.
+ *
+ * T2H:
+ * SW17[1] = ON, SW17[2] = OFF - Potentiometer
+ * SW17[1] = OFF, SW17[2] = ON  - CN41 header
+ * N2H:
+ * DSW6[1] = OFF, DSW6[2] = ON - Potentiometer
+ * DSW6[1] = ON, DSW6[2] = OFF - CN3 header
+ */
+&adc0 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+};
+
+/*
+ * ADC1 AN100 can be exposed on ADC header or on mikroBUS connector.
+ *
+ * T2H:
+ * SW18[1] = ON, SW18[2] = OFF - CN42 header
+ * SW18[1] = OFF, SW18[2] = ON - mikroBUS
+ * N2H:
+ * DSW6[3] = ON, DSW6[4] = OFF - CN4 header
+ * DSW6[3] = OFF, DSW6[4] = ON - mikroBUS
+ *
+ * ADC1 AN101 can be exposed on ADC header or on Grove2 connector.
+ *
+ * T2H:
+ * SW18[3] = ON, SW18[4] = OFF - CN42 header
+ * SW18[3] = OFF, SW18[4] = ON - Grove2
+ * N2H:
+ * DSW6[5] = ON, DSW6[6] = OFF - CN4 header
+ * DSW6[5] = OFF, DSW6[6] = ON - Grove2
+ *
+ * ADC1 AN102 can be exposed on ADC header or on Grove2 connector.
+ *
+ * T2H:
+ * SW18[5] = ON, SW18[6] = OFF - CN42 header
+ * SW18[5] = OFF, SW18[6] = ON - Grove2
+ * N2H:
+ * DSW6[7] = ON, DSW6[8] = OFF - CN4 header
+ * DSW6[7] = OFF, DSW6[8] = ON - Grove2
+ */
+&adc1 {
+	status = "okay";
+
+	channel@0 {
+		reg = <0x0>;
+	};
+
+	channel@1 {
+		reg = <0x1>;
+	};
+
+	channel@2 {
+		reg = <0x2>;
+	};
+
+	channel@3 {
+		reg = <0x3>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <25000000>;
 };
@@ -223,81 +302,3 @@ &wdt2 {
 	timeout-sec = <60>;
 };
 
-/*
- * ADC0 AN000 can be connected to a potentiometer on the board or
- * exposed on ADC header.
- *
- * T2H:
- * SW17[1] = ON, SW17[2] = OFF - Potentiometer
- * SW17[1] = OFF, SW17[2] = ON  - CN41 header
- * N2H:
- * DSW6[1] = OFF, DSW6[2] = ON - Potentiometer
- * DSW6[1] = ON, DSW6[2] = OFF - CN3 header
- */
-&adc0 {
-	status = "okay";
-
-	channel@0 {
-		reg = <0x0>;
-	};
-
-	channel@1 {
-		reg = <0x1>;
-	};
-
-	channel@2 {
-		reg = <0x2>;
-	};
-
-	channel@3 {
-		reg = <0x3>;
-	};
-};
-
-/*
- * ADC1 AN100 can be exposed on ADC header or on mikroBUS connector.
- *
- * T2H:
- * SW18[1] = ON, SW18[2] = OFF - CN42 header
- * SW18[1] = OFF, SW18[2] = ON - mikroBUS
- * N2H:
- * DSW6[3] = ON, DSW6[4] = OFF - CN4 header
- * DSW6[3] = OFF, DSW6[4] = ON - mikroBUS
- *
- * ADC1 AN101 can be exposed on ADC header or on Grove2 connector.
- *
- * T2H:
- * SW18[3] = ON, SW18[4] = OFF - CN42 header
- * SW18[3] = OFF, SW18[4] = ON - Grove2
- * N2H:
- * DSW6[5] = ON, DSW6[6] = OFF - CN4 header
- * DSW6[5] = OFF, DSW6[6] = ON - Grove2
- *
- * ADC1 AN102 can be exposed on ADC header or on Grove2 connector.
- *
- * T2H:
- * SW18[5] = ON, SW18[6] = OFF - CN42 header
- * SW18[5] = OFF, SW18[6] = ON - Grove2
- * N2H:
- * DSW6[7] = ON, DSW6[8] = OFF - CN4 header
- * DSW6[7] = OFF, DSW6[8] = ON - Grove2
- */
-&adc1 {
-	status = "okay";
-
-	channel@0 {
-		reg = <0x0>;
-	};
-
-	channel@1 {
-		reg = <0x1>;
-	};
-
-	channel@2 {
-		reg = <0x2>;
-	};
-
-	channel@3 {
-		reg = <0x3>;
-	};
-};
-- 
2.53.0


