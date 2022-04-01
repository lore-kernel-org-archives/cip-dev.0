Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7395C64EBC
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:48 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.3615.1648842199155839517
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 Apr 2022 12:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,228,1643641200";
   d="scan'208";a="116465403"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Apr 2022 04:43:43 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A5B4340061B8;
	Sat,  2 Apr 2022 04:43:42 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RESEND PATCH 5.10.y-cip 39/40] arm64: dts: renesas: rzg2l-smarc-som:
 Enable eMMC on SMARC platform
Date: Fri,  1 Apr 2022 20:42:33 +0100
Message-Id: <20220401194234.14057-40-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220401194234.14057-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7950

From: Biju Das <biju.das.jz@bp.renesas.com>

commit a60a311cb8d0cddaaeb1eee22bfd76138e6b5ad6 upstream.

RZ/G2L SoM has both 64 GB eMMC and microSD connected to SDHI0.

Both these interfaces are mutually exclusive and the SD0 device
selection is based on the XOR between GPIO_SD0_DEV_SEL and SW1[2]
switch position.

This patch sets GPIO_SD0_DEV_SEL to high in DT. Use the below switch
setting logic for device selection between eMMC and microSD slot
connected to SDHI0.

Set SW1[2] to position 2/OFF for selecting eMMC
Set SW1[2] to position 3/ON for selecting microSD

This patch enables eMMC on RZ/G2L SMARC platform by default.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20211010142520.21976-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi     | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
index 9804ca0fd528..c496c3bf212b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -5,8 +5,19 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+/* SW1[2] should be at position 2/OFF to enable 64 GB eMMC */
+#define EMMC	1
+
+/*
+ * To enable uSD card on CN3,
+ * SW1[2] should be at position 3/ON.
+ * Disable eMMC by setting "#define EMMC	0" above.
+ */
+#define SDHI	(!EMMC)
+
 / {
 	aliases {
 		ethernet0 = &eth0;
@@ -22,6 +33,36 @@
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
+
+	reg_1p8v: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator1 {
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
+		states = <3300000 1>, <1800000 0>;
+		regulator-boot-on;
+		gpios = <&pinctrl RZG2L_GPIO(39, 0) GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+	};
 };
 
 &adc {
@@ -130,6 +171,13 @@
 			 <RZG2L_PORT_PINMUX(36, 0, 1)>; /* ET1_RXD3 */
 	};
 
+	gpio-sd0-pwr-en-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(4, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "gpio_sd0_pwr_en";
+	};
+
 	qspi0_pins: qspi0 {
 		qspi0-data {
 			pins = "QSPI0_IO0", "QSPI0_IO1", "QSPI0_IO2", "QSPI0_IO3";
@@ -141,6 +189,70 @@
 			power-source = <1800>;
 		};
 	};
+
+	/*
+	 * SD0 device selection is XOR between GPIO_SD0_DEV_SEL and SW1[2]
+	 * The below switch logic can be used to select the device between
+	 * eMMC and microSD, after setting GPIO_SD0_DEV_SEL to high in DT.
+	 * SW1[2] should be at position 2/OFF to enable 64 GB eMMC
+	 * SW1[2] should be at position 3/ON to enable uSD card CN3
+	 */
+	sd0-dev-sel-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(41, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sd0_dev_sel";
+	};
+
+	sdhi0_emmc_pins: sd0emmc {
+		sd0_emmc_data {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3",
+			       "SD0_DATA4", "SD0_DATA5", "SD0_DATA6", "SD0_DATA7";
+			power-source = <1800>;
+		};
+
+		sd0_emmc_ctrl {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <1800>;
+		};
+
+		sd0_emmc_rst {
+			pins = "SD0_RST#";
+			power-source = <1800>;
+		};
+	};
+
+	sdhi0_pins: sd0 {
+		sd0_data {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
+			power-source = <3300>;
+		};
+
+		sd0_ctrl {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <3300>;
+		};
+
+		sd0_mux {
+			pinmux = <RZG2L_PORT_PINMUX(47, 0, 2)>; /* SD0_CD */
+		};
+	};
+
+	sdhi0_pins_uhs: sd0_uhs {
+		sd0_data_uhs {
+			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3";
+			power-source = <1800>;
+		};
+
+		sd0_ctrl_uhs {
+			pins = "SD0_CLK", "SD0_CMD";
+			power-source = <1800>;
+		};
+
+		sd0_mux_uhs {
+			pinmux = <RZG2L_PORT_PINMUX(47, 0, 2)>; /* SD0_CD */
+		};
+	};
 };
 
 &sbc {
@@ -170,3 +282,34 @@
 		};
 	};
 };
+
+#if SDHI
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+#endif
+
+#if EMMC
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_emmc_pins>;
+	pinctrl-1 = <&sdhi0_emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	status = "okay";
+};
+#endif
-- 
2.17.1


