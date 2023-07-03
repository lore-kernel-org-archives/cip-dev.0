Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7F0C30657
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:17:13 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.39007.1688404626455475162
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:17:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="170260246"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jul 2023 02:17:05 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BB2614003863;
	Tue,  4 Jul 2023 02:17:03 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 5/5] arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support
Date: Mon,  3 Jul 2023 18:16:49 +0100
Message-Id: <20230703171649.15862-6-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
References: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:17:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12196

Commit b6c0be722b0c0a7204b6289464a04cd7b4fdfca0 upstream.

The RZ/V2M EVK comes with a slot for a uSD card, and an eMMC.
Add support for the both of them.

Please note that the pinctrl driver for RZ/V2M doesn't support
interrupts yet, therefore the card detect pin has been connected
to the SDHI IP directly in this patch.
We'll connect the card detect pin to its corresponding GPIO when
we'll have driver support for interrupts in the RZ/V2M pinctrl
driver.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230130191152.182826-1-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Fabrizio: Changed the eMMC/SDHI pinctrl subnode names to avoid
           conflicts during parsing]
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index 8b7f6da693a7..11c5cffea5a5 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "r9a09g011.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzv2m-pinctrl.h>
 
 / {
@@ -60,6 +61,36 @@ memory@180000000 {
 		device_type = "memory";
 		reg = <0x1 0x80000000 0x0 0x80000000>;
 	};
+
+	reg_1v8: regulator-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3v3: regulator-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&pwc 0 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 0>, <1800000 1>;
+	};
 };
 
 &avb {
@@ -75,6 +106,23 @@ phy0: ethernet-phy@0 {
 	};
 };
 
+&emmc {
+	pinctrl-0 = <&emmc_pins>;
+	pinctrl-1 = <&emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&reg_1v8>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	max-frequency = <200000000>;
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <48000000>;
 };
@@ -118,6 +166,26 @@ &i2c2 {
 };
 
 &pinctrl {
+	emmc_pins: emmc {
+		emmc_data {
+			pinmux = <RZV2M_PORT_PINMUX(0, 0, 2)>, /* MMDAT0 */
+				 <RZV2M_PORT_PINMUX(0, 1, 2)>, /* MMDAT1 */
+				 <RZV2M_PORT_PINMUX(0, 2, 2)>, /* MMDAT2 */
+				 <RZV2M_PORT_PINMUX(0, 3, 2)>, /* MMDAT3 */
+				 <RZV2M_PORT_PINMUX(0, 4, 2)>, /* MMDAT4 */
+				 <RZV2M_PORT_PINMUX(0, 5, 2)>, /* MMDAT5 */
+				 <RZV2M_PORT_PINMUX(0, 6, 2)>, /* MMDAT6 */
+				 <RZV2M_PORT_PINMUX(0, 7, 2)>; /* MMDAT7 */
+			power-source = <1800>;
+		};
+
+		emmc_ctrl {
+			pinmux = <RZV2M_PORT_PINMUX(0, 10, 2)>, /* MMCMD */
+				 <RZV2M_PORT_PINMUX(0, 11, 2)>; /* MMCLK */
+			power-source = <1800>;
+		};
+	};
+
 	i2c0_pins: i2c0 {
 		pinmux = <RZV2M_PORT_PINMUX(5, 0, 2)>, /* SDA */
 			 <RZV2M_PORT_PINMUX(5, 1, 2)>; /* SCL */
@@ -128,6 +196,48 @@ i2c2_pins: i2c2 {
 			 <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
 	};
 
+	sdhi0_pins: sd0 {
+		sd0_data {
+			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
+				 <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
+				 <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
+				 <RZV2M_PORT_PINMUX(8, 5, 1)>; /* SD0DAT3 */
+			power-source = <3300>;
+		};
+
+		sd0_ctrl {
+			pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
+				 <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
+			power-source = <3300>;
+		};
+
+		sd0_cd {
+			pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
+			power-source = <3300>;
+		};
+	};
+
+	sdhi0_pins_uhs: sd0-uhs {
+		sd0_uhs_data {
+			pinmux = <RZV2M_PORT_PINMUX(8, 2, 1)>, /* SD0DAT0 */
+				 <RZV2M_PORT_PINMUX(8, 3, 1)>, /* SD0DAT1 */
+				 <RZV2M_PORT_PINMUX(8, 4, 1)>, /* SD0DAT2 */
+				 <RZV2M_PORT_PINMUX(8, 5, 1)>; /* SD0DAT3 */
+			power-source = <1800>;
+		};
+
+		sd0_uhs_ctrl {
+			pinmux = <RZV2M_PORT_PINMUX(8, 0, 1)>, /* SD0CMD */
+				 <RZV2M_PORT_PINMUX(8, 1, 1)>; /* SD0CLK */
+			power-source = <1800>;
+		};
+
+		sd0_uhs_cd {
+			pinmux = <RZV2M_PORT_PINMUX(8, 7, 1)>; /* SD0CD */
+			power-source = <1800>;
+		};
+	};
+
 	uart0_pins: uart0 {
 		pinmux = <RZV2M_PORT_PINMUX(3, 0, 2)>, /* UATX0 */
 			 <RZV2M_PORT_PINMUX(3, 1, 2)>, /* UARX0 */
@@ -141,6 +251,19 @@ &pwc {
 	status = "okay";
 };
 
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3v3>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_pins>;
 	pinctrl-names = "default";
-- 
2.25.1


