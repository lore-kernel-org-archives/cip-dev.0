Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D730CE7AE6
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:13:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15676.1763118830440514286
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:13:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: J0aX2VPXS5mRPR7ZlvxxQA==
X-CSE-MsgGUID: vxa3l67gTfmLfd/nJcmBXg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Nov 2025 20:13:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.4])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B2D1E4575F01;
	Fri, 14 Nov 2025 20:13:48 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 2/2] arm64: dts: renesas: Add CN15 eMMC and SD overlays for RZ/V2H and RZ/V2N EVKs
Date: Fri, 14 Nov 2025 11:13:43 +0000
Message-ID: <20251114111343.74438-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
References: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20550

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 3d6c2bc7629c8b1bfd75416767122096bb75ba7b upstream.

Introduce device tree overlays for supporting the eMMC (RTK0EF0186B02000BJ)
and microSD (RTK0EF0186B01000BJ) sub-boards connected via the CN15
connector on the RZ/V2H and RZ/V2N evaluation kits.

These overlays enable SDHI0 with appropriate pin control settings, power
regulators, and GPIO handling. Both sub-boards are supported using shared
overlay files that can be applied to either EVK due to their identical
connector layout and interface support.

To support this, new DT overlay files are added:
- `rzv2-evk-cn15-emmc.dtso` for eMMC
- `rzv2-evk-cn15-sd.dtso` for microSD

Additionally, the base DTS files for both EVKs are updated to include a
fixed 1.8V regulator (`reg_1p8v`) needed by the eMMC sub-board and
potential future use cases such as HDMI output.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627193742.110818-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: cherry-picked the RZ/V2H parts only]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  6 ++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  9 +++
 .../boot/dts/renesas/rzv2-evk-cn15-emmc.dtso  | 50 ++++++++++++++
 .../boot/dts/renesas/rzv2-evk-cn15-sd.dtso    | 69 +++++++++++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index c978bbe7c5b3..76a59db5f862 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -92,6 +92,12 @@ dtb-$(CONFIG_ARCH_R9A09G011) += r9a09g011-v2mevk2.dtb
 dtb-$(CONFIG_ARCH_R9A09G047) += r9a09g047e57-smarc.dtb
 
 dtb-$(CONFIG_ARCH_R9A09G057) += r9a09g057h44-rzv2h-evk.dtb
+dtb-$(CONFIG_ARCH_R9A09G057) += rzv2-evk-cn15-emmc.dtbo
+r9a09g057h44-rzv2h-evk-cn15-emmc-dtbs := r9a09g057h44-rzv2h-evk.dtb rzv2-evk-cn15-emmc.dtbo
+dtb-$(CONFIG_ARCH_R9A09G057) += r9a09g057h44-rzv2h-evk-cn15-emmc.dtb
+dtb-$(CONFIG_ARCH_R9A09G057) += rzv2-evk-cn15-sd.dtbo
+r9a09g057h44-rzv2h-evk-cn15-sd-dtbs := r9a09g057h44-rzv2h-evk.dtb rzv2-evk-cn15-sd.dtbo
+dtb-$(CONFIG_ARCH_R9A09G057) += r9a09g057h44-rzv2h-evk-cn15-sd.dtb
 
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += draak-ebisu-panel-aa104xd12.dtbo
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += salvator-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index c798d20e3dea..8201c887e84d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -60,6 +60,15 @@ memory@240000000 {
 		reg = <0x2 0x40000000 0x2 0x00000000>;
 	};
 
+	reg_1p8v: regulator-1p8v {
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
 
diff --git a/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
new file mode 100644
index 000000000000..eda2b31f6d79
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-emmc.dtso
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shared DT overlay for the eMMC Sub Board (RTK0EF0186B02000BJ), which
+ * is connected to the CN15 connector on the RZ/V2H and RZ/V2N EVKs.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+&{/} {
+	aliases {
+		mmc0 = "/soc/mmc@15c00000";
+	};
+};
+
+&pinctrl {
+	sdhi0_emmc_pins: emmc-pins {
+		sd0-clk {
+			pins = "SD0CLK";
+			renesas,output-impedance = <3>;
+			slew-rate = <0>;
+		};
+
+		sd0-dat-cmd {
+			pins = "SD0DAT0", "SD0DAT1", "SD0DAT2", "SD0DAT3", "SD0DAT4",
+			       "SD0DAT5", "SD0DAT6", "SD0DAT7", "SD0CMD";
+			input-enable;
+			renesas,output-impedance = <3>;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_emmc_pins>;
+	pinctrl-1 = <&sdhi0_emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	mmc-hs200-1_8v;
+	non-removable;
+	fixed-emmc-driver-type = <1>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
new file mode 100644
index 000000000000..0af1e0a6c7f4
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzv2-evk-cn15-sd.dtso
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Shared DT overlay for the microSD Sub Board (RTK0EF0186B01000BJ), which
+ * is connected to the CN15 connector on the RZ/V2H and RZ/V2N EVKs.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+&{/} {
+	aliases {
+		mmc0 = "/soc/mmc@15c00000";
+	};
+
+	vqmmc_sdhi0: regulator-vqmmc-sdhi0 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI0 VqmmC";
+		gpios = <&pinctrl RZG2L_GPIO(10, 0) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios-states = <0>;
+		states = <3300000 0>, <1800000 1>;
+	};
+};
+
+&pinctrl {
+	sdhi0-pwr-en-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(10, 1) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sd0_pwr_en";
+	};
+
+	sdhi0_pins: sd0 {
+		sd0-cd {
+			pinmux = <RZG2L_PORT_PINMUX(10, 5, 15)>; /* SD0_CD */
+		};
+
+		sd0-clk {
+			pins = "SD0CLK";
+			renesas,output-impedance = <3>;
+			slew-rate = <0>;
+		};
+
+		sd0-dat-cmd {
+			pins = "SD0DAT0", "SD0DAT1", "SD0DAT2", "SD0DAT3", "SD0CMD";
+			input-enable;
+			renesas,output-impedance = <3>;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-1 = <&sdhi0_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vqmmc_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
-- 
2.51.0


