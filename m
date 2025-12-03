Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD15D15D9A
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18215.1764776292894303297
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:19 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: hpgvIgBQTEefAB69RiWNjQ==
X-CSE-MsgGUID: PhVOljljQe6HyQ1ncFpSnQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:19 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E0EF440138F5;
	Thu,  4 Dec 2025 00:38:17 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 11/12] arm64: dts: renesas: Add initial device tree for RZ/V2N EVK
Date: Wed,  3 Dec 2025 15:37:56 +0000
Message-ID: <20251203153757.32977-12-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20824

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1a42724ac93535a3aa23a60cbb89ce2635b5075c upstream.

Add the initial device tree for the Renesas RZ/V2N EVK board, based on
the R9A09G056N48 SoC. Enable basic board functionality, including:
  - Memory mapping (reserve the first 128MB for the secure area)
  - Clock inputs (QEXTAL, RTXIN, AUDIO_EXTAL)
  - PINCTRL configurations for peripherals
  - Serial console (SCIF)
  - SDHI1 with power control and UHS modes

Update the Makefile to include the new DTB.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-13-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |   2 +
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 114 ++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 76a59db5f862..14a8255ae878 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -91,6 +91,8 @@ dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G047) += r9a09g047e57-smarc.dtb
 
+dtb-$(CONFIG_ARCH_R9A09G056) += r9a09g056n48-rzv2n-evk.dtb
+
 dtb-$(CONFIG_ARCH_R9A09G057) += r9a09g057h44-rzv2h-evk.dtb
 dtb-$(CONFIG_ARCH_R9A09G057) += rzv2-evk-cn15-emmc.dtbo
 r9a09g057h44-rzv2h-evk-cn15-emmc-dtbs := r9a09g057h44-rzv2h-evk.dtb rzv2-evk-cn15-emmc.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
new file mode 100644
index 000000000000..24343fce7f53
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/V2N EVK board
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "r9a09g056.dtsi"
+
+/ {
+	model = "Renesas RZ/V2N EVK Board based on r9a09g056n48";
+	compatible = "renesas,rzv2n-evk", "renesas,r9a09g056n48", "renesas,r9a09g056";
+
+	aliases {
+		mmc1 = &sdhi1;
+		serial0 = &scif;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x1 0xf8000000>;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vqmmc_sdhi1: regulator-vqmmc-sdhi1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI1 VqmmC";
+		gpios = <&pinctrl RZV2N_GPIO(A, 2) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios-states = <0>;
+		states = <3300000 0>, <1800000 1>;
+	};
+};
+
+&audio_extal_clk {
+	clock-frequency = <22579200>;
+};
+
+&pinctrl {
+	scif_pins: scif {
+		pins = "SCIF_TXD", "SCIF_RXD";
+		renesas,output-impedance = <1>;
+	};
+
+	sd1-pwr-en-hog {
+		gpio-hog;
+		gpios = <RZV2N_GPIO(A, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sd1_pwr_en";
+	};
+
+	sdhi1_pins: sd1 {
+		sd1-cd {
+			pinmux = <RZV2N_PORT_PINMUX(9, 4, 14)>; /* SD1_CD */
+		};
+
+		sd1-clk {
+			pins = "SD1CLK";
+			renesas,output-impedance = <3>;
+			slew-rate = <0>;
+		};
+
+		sd1-dat-cmd {
+			pins = "SD1DAT0", "SD1DAT1", "SD1DAT2", "SD1DAT3", "SD1CMD";
+			input-enable;
+			renesas,output-impedance = <3>;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&qextal_clk {
+	clock-frequency = <24000000>;
+};
+
+&rtxin_clk {
+	clock-frequency = <32768>;
+};
+
+&scif {
+	pinctrl-0 = <&scif_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vqmmc_sdhi1>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
-- 
2.51.0


