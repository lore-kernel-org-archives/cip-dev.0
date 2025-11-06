Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D3F0CCF9F8
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:40:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11710.1762425627318172200
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:40:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: edcQjuKgSG2gFaD6VWQ5kg==
X-CSE-MsgGUID: 01VEfj1JTfWxfPCz54g1FQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2025 19:40:37 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6A0164003FD6;
	Thu,  6 Nov 2025 19:40:36 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 6/9] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros
Date: Thu,  6 Nov 2025 10:40:21 +0000
Message-ID: <20251106104024.28947-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:40:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20456

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 6e526427fa78439cc8045068d78df1d8cd911213 upstream.

Replace RZG2L_* macros with RZV2H_* macros, so that we can define
port names in alpha-numeric.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241216195325.164212-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 4703da8e9cff..0b705c987b6c 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 
-#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+#include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/gpio/gpio.h>
 #include "r9a09g057.dtsi"
 
@@ -56,7 +56,7 @@ reg_3p3v: regulator1 {
 	vqmmc_sdhi1: regulator-vccq-sdhi1 {
 		compatible = "regulator-gpio";
 		regulator-name = "SDHI1 VccQ";
-		gpios = <&pinctrl RZG2L_GPIO(10, 2) GPIO_ACTIVE_HIGH>;
+		gpios = <&pinctrl RZV2H_GPIO(A, 2) GPIO_ACTIVE_HIGH>;
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <3300000>;
 		gpios-states = <0>;
@@ -158,38 +158,38 @@ &ostm7 {
 
 &pinctrl {
 	i2c0_pins: i2c0 {
-		pinmux = <RZG2L_PORT_PINMUX(3, 0, 1)>, /* I2C0_SDA */
-			 <RZG2L_PORT_PINMUX(3, 1, 1)>; /* I2C0_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(3, 0, 1)>, /* I2C0_SDA */
+			 <RZV2H_PORT_PINMUX(3, 1, 1)>; /* I2C0_SCL */
 	};
 
 	i2c1_pins: i2c1 {
-		pinmux = <RZG2L_PORT_PINMUX(3, 2, 1)>, /* I2C1_SDA */
-			 <RZG2L_PORT_PINMUX(3, 3, 1)>; /* I2C1_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(3, 2, 1)>, /* I2C1_SDA */
+			 <RZV2H_PORT_PINMUX(3, 3, 1)>; /* I2C1_SCL */
 	};
 
 	i2c2_pins: i2c2 {
-		pinmux = <RZG2L_PORT_PINMUX(2, 0, 4)>, /* I2C2_SDA */
-			 <RZG2L_PORT_PINMUX(2, 1, 4)>; /* I2C2_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(2, 0, 4)>, /* I2C2_SDA */
+			 <RZV2H_PORT_PINMUX(2, 1, 4)>; /* I2C2_SCL */
 	};
 
 	i2c3_pins: i2c3 {
-		pinmux = <RZG2L_PORT_PINMUX(3, 6, 1)>, /* I2C3_SDA */
-			 <RZG2L_PORT_PINMUX(3, 7, 1)>; /* I2C3_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(3, 6, 1)>, /* I2C3_SDA */
+			 <RZV2H_PORT_PINMUX(3, 7, 1)>; /* I2C3_SCL */
 	};
 
 	i2c6_pins: i2c6 {
-		pinmux = <RZG2L_PORT_PINMUX(4, 4, 1)>, /* I2C6_SDA */
-			 <RZG2L_PORT_PINMUX(4, 5, 1)>; /* I2C6_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(4, 4, 1)>, /* I2C6_SDA */
+			 <RZV2H_PORT_PINMUX(4, 5, 1)>; /* I2C6_SCL */
 	};
 
 	i2c7_pins: i2c7 {
-		pinmux = <RZG2L_PORT_PINMUX(4, 6, 1)>, /* I2C7_SDA */
-			 <RZG2L_PORT_PINMUX(4, 7, 1)>; /* I2C7_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(4, 6, 1)>, /* I2C7_SDA */
+			 <RZV2H_PORT_PINMUX(4, 7, 1)>; /* I2C7_SCL */
 	};
 
 	i2c8_pins: i2c8 {
-		pinmux = <RZG2L_PORT_PINMUX(0, 6, 1)>, /* I2C8_SDA */
-			 <RZG2L_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
+		pinmux = <RZV2H_PORT_PINMUX(0, 6, 1)>, /* I2C8_SDA */
+			 <RZV2H_PORT_PINMUX(0, 7, 1)>; /* I2C8_SCL */
 	};
 
 	scif_pins: scif {
@@ -199,7 +199,7 @@ scif_pins: scif {
 
 	sd1-pwr-en-hog {
 		gpio-hog;
-		gpios = <RZG2L_GPIO(10, 3) GPIO_ACTIVE_HIGH>;
+		gpios = <RZV2H_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
 		output-high;
 		line-name = "sd1_pwr_en";
 	};
@@ -219,7 +219,7 @@ sd1_clk {
 		};
 
 		sd1_cd {
-			pinmux = <RZG2L_PORT_PINMUX(9, 4, 14)>; /* SD1_CD */
+			pinmux = <RZV2H_PORT_PINMUX(9, 4, 14)>; /* SD1_CD */
 		};
 	};
 };
-- 
2.51.0


