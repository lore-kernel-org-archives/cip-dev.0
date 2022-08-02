Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0149C48BE4
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.4832.1659438534534175527
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="130054304"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Aug 2022 20:08:59 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3C1834004934;
	Tue,  2 Aug 2022 20:08:57 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 03/24] arm64: dts: renesas: rzg2lc-smarc-som:
 Enable eMMC on SMARC platform
Date: Tue,  2 Aug 2022 12:08:29 +0100
Message-Id: <20220802110850.1496057-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9000

commit 7ca0ce6478c6803c9f86e7366f5634de9c096207 upstream.

RZ/G2LC SoM has both 64 GB eMMC and microSD connected to SDHI0.

Both these interfaces are mutually exclusive and the SD0 device
selection is based on the XOR between GPIO_SD0_DEV_SEL and SW1[2]
switch position.

This patch sets GPIO_SD0_DEV_SEL to high in DT. Use the below switch
setting logic for device selection between eMMC and microSD slot
connected to SDHI0.

Set SW1[2] to position OFF for selecting eMMC
Set SW1[2] to position ON for selecting microSD

This patch enables eMMC on RZ/G2LC SMARC platform by default.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220117075130.6198-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg2lc-smarc-som.dtsi    | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index e1d7a3a689c6..6ebda3724f2c 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -8,6 +8,16 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+/* SW1[2] should be at OFF position to enable 64 GB eMMC */
+#define EMMC	1
+
+/*
+ * To enable uSD card on CN3,
+ * SW1[2] should be at ON position.
+ * Disable eMMC by setting "#define EMMC	0" above.
+ */
+#define SDHI	(!EMMC)
+
 / {
 	aliases {
 		ethernet0 = &eth0;
@@ -22,6 +32,36 @@ memory@48000000 {
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
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
 
 &eth0 {
@@ -72,5 +112,107 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(26, 0, 1)>, /* ET0_RXD2 */
 			 <RZG2L_PORT_PINMUX(26, 1, 1)>; /* ET0_RXD3 */
 	};
+
+	gpio-sd0-pwr-en-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(18, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "gpio_sd0_pwr_en";
+	};
+
+	/*
+	 * SD0 device selection is XOR between GPIO_SD0_DEV_SEL and SW1[2]
+	 * The below switch logic can be used to select the device between
+	 * eMMC and microSD, after setting GPIO_SD0_DEV_SEL to high in DT.
+	 * SW1[2] should be at OFF position to enable 64 GB eMMC
+	 * SW1[2] should be at position ON to enable uSD card CN3
+	 */
+	gpio-sd0-dev-sel-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(40, 2) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "gpio_sd0_dev_sel";
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
+			pinmux = <RZG2L_PORT_PINMUX(18, 0, 1)>; /* SD0_CD */
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
+			pinmux = <RZG2L_PORT_PINMUX(18, 0, 1)>; /* SD0_CD */
+		};
+	};
+};
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
 };
+#endif
 
-- 
2.25.1


