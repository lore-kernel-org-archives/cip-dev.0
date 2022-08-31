Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8220DECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:48:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.1265.1661964487009489496
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:48:10 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240553"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:48:10 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 11B8040457DA;
	Thu,  1 Sep 2022 01:48:06 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/26] arm64: dts: renesas: rzg2ul-smarc-som:
 Enable eMMC on SMARC platform
Date: Wed, 31 Aug 2022 17:46:44 +0100
Message-Id: <20220831164645.2134258-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:48:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9385

commit ed8efe50b76e751791a9aa4ce1f95fe3d9d794ac upstream.

RZ/G2UL SoM has both 64GB eMMC and microSD connected to SDHI0.

Both these interfaces are mutually exclusive and the SD0 device
selection is based on SW1[2] on SoM module.

Set SW1[2] to position OFF for selecting eMMC
Set SW1[2] to position ON for selecting microSD

This patch enables eMMC on RZ/G2UL SMARC platform by default.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402081328.26292-7-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    | 104 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |   8 ++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 8ecc650099a7..0d6fc0d84783 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -19,6 +19,15 @@ memory@48000000 {
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
+	reg_1p8v: regulator0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_3p3v: regulator1 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-3.3V";
@@ -27,8 +36,103 @@ reg_3p3v: regulator1 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+#if !(SW_SW0_DEV_SEL)
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		states = <3300000 1>, <1800000 0>;
+		regulator-boot-on;
+		gpios = <&pinctrl RZG2L_GPIO(6, 2) GPIO_ACTIVE_HIGH>;
+		regulator-always-on;
+	};
+#endif
 };
 
 &extal_clk {
 	clock-frequency = <24000000>;
 };
+
+&pinctrl {
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
+			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
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
+			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
+		};
+	};
+};
+
+#if (SW_SW0_DEV_SEL)
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
+#else
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
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index f47b4e2e0feb..f8c90ff676fe 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -5,6 +5,14 @@
  * Copyright (C) 2022 Renesas Electronics Corp.
  */
 
+/*
+ * DIP-Switch SW1 setting
+ * 1 : High; 0: Low
+ * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
+ * Please change below macros according to SW1 setting
+ */
+#define SW_SW0_DEV_SEL	1
+
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
-- 
2.25.1


