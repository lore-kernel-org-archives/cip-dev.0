Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CC4EE645E
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:00:53 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88807.1767200439989639331
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: gtTRU5hgSr+w9TXZ3z+Jsw==
X-CSE-MsgGUID: 2XKXisyGRle3kx3o3HMRnQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:49 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 89A494024131;
	Thu,  1 Jan 2026 02:00:48 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/17] arm64: dts: renesas: rzt2h-rzn2h-evk: Enable eMMC
Date: Wed, 31 Dec 2025 17:00:21 +0000
Message-ID: <20251231170026.17006-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:00:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21291

commit 4d7624fc85a27240ce35e0acc624dd165a314fca upstream.

Enable eMMC on RZ/T2H and RZ/N2H EVKs. As SDHI0 can be connected to
either eMMC0/SD0 `SD0_EMMC` macro is added.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  9 +++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    | 10 +++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 62 +++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index 6aeb5cacead32..7f196f1d1a2d8 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -10,6 +10,15 @@
 #include <dt-bindings/pinctrl/renesas,r9a09g077-pinctrl.h>
 
 #include "r9a09g077m44.dtsi"
+
+/*
+ * SD0 can be connected to either eMMC (IC49) or SD card slot CN31
+ * Lets by default enable the eMMC, note we need the below SW settings
+ * for eMMC.
+ * SW2[1] = ON; SW2[2] = ON
+ */
+#define SD0_EMMC	1
+
 #include "rzt2h-n2h-evk-common.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index a068661fc4429..87e362f6f09f7 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -8,6 +8,16 @@
 /dts-v1/;
 
 #include "r9a09g087m44.dtsi"
+
+/*
+ * SD0 can be connected to either eMMC (U33) or SD card slot CN21
+ * Lets by default enable the eMMC, note we need the below SW settings
+ * for eMMC.
+ * DSW5[1] = ON; DSW5[2] = ON
+ * DSW17[5] = OFF; DSW17[6] = ON
+ */
+#define SD0_EMMC       1
+
 #include "rzt2h-n2h-evk-common.dtsi"
 
 /*
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 1b7e16ffe6b69..68d493bf5e8cf 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -13,12 +13,31 @@ / {
 	aliases {
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
+		mmc0 = &sdhi0;
 		serial0 = &sci0;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
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
 };
 
 &extal_clk {
@@ -46,6 +65,34 @@ sci0_pins: sci0-pins {
 		pinmux = <RZT2H_PORT_PINMUX(27, 4, 0x14)>,
 			 <RZT2H_PORT_PINMUX(27, 5, 0x14)>;
 	};
+
+#if SD0_EMMC
+	sdhi0-emmc-iovs-hog {
+		gpio-hog;
+		gpios = <RZT2H_GPIO(2, 6) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SD0_IOVS";
+	};
+#endif
+
+	sdhi0_emmc_pins: sd0-emmc-group {
+		data-pins {
+			pinmux = <RZT2H_PORT_PINMUX(12, 2, 0x29)>, /* SD0_DATA0 */
+				 <RZT2H_PORT_PINMUX(12, 3, 0x29)>, /* SD0_DATA1 */
+				 <RZT2H_PORT_PINMUX(12, 4, 0x29)>, /* SD0_DATA2 */
+				 <RZT2H_PORT_PINMUX(12, 5, 0x29)>, /* SD0_DATA3 */
+				 <RZT2H_PORT_PINMUX(12, 6, 0x29)>, /* SD0_DATA4 */
+				 <RZT2H_PORT_PINMUX(12, 7, 0x29)>, /* SD0_DATA5 */
+				 <RZT2H_PORT_PINMUX(13, 0, 0x29)>, /* SD0_DATA6 */
+				 <RZT2H_PORT_PINMUX(13, 1, 0x29)>; /* SD0_DATA7 */
+		};
+
+		ctrl-pins {
+			pinmux = <RZT2H_PORT_PINMUX(12, 0, 0x29)>, /* SD0_CLK */
+				 <RZT2H_PORT_PINMUX(12, 1, 0x29)>, /* SD0_CMD */
+				 <RZT2H_PORT_PINMUX(13, 2, 0x29)>; /* SD0_RST# */
+		};
+	};
 };
 
 &sci0 {
@@ -53,3 +100,18 @@ &sci0 {
 	pinctrl-names = "default";
 	status = "okay";
 };
+
+#if SD0_EMMC
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_emmc_pins>;
+	pinctrl-1 = <&sdhi0_emmc_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	bus-width = <8>;
+	non-removable;
+	mmc-hs200-1_8v;
+	fixed-emmc-driver-type = <1>;
+	status = "okay";
+};
+#endif
-- 
2.43.0


