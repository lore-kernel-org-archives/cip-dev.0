Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155CEEB569
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:01:03 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88804.1767200431635644184
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: LROBhJHNQtCWGfNUqNXwtw==
X-CSE-MsgGUID: OCPJ3g7JTDW0e2vuaNduLA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:53 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 09E36402412E;
	Thu,  1 Jan 2026 02:00:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/17] arm64: dts: renesas: rzt2h-rzn2h-evk: Enable SD card slot
Date: Wed, 31 Dec 2025 17:00:23 +0000
Message-ID: <20251231170026.17006-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:01:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21293

commit d065453e5ee097193e3da3f7a8aafcdfabbaf78f upstream.

Enable SD card slot which is connected to SDHI0 on the RZ/T2H and
RZ/N2H EVKs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-10-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  5 ++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  9 ++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     | 51 +++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index e9c691d568448..7da3d23d2c0be 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -16,8 +16,13 @@
  * Lets by default enable the eMMC, note we need the below SW settings
  * for eMMC.
  * SW2[1] = ON; SW2[2] = ON
+ *
+ * To enable SD card and disable eMMC on SDHI0 disable the below macro
+ * and set the below switch setting:
+ * SW2[1] = OFF; SW2[2] = ON
  */
 #define SD0_EMMC	1
+#define SD0_SD		(!SD0_EMMC)
 
 /*
  * P17_4 = SD1_CD; SW2[3] = ON
diff --git a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
index 87178933bee8d..80f358fb2d742 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g087m44-rzn2h-evk.dts
@@ -15,8 +15,17 @@
  * for eMMC.
  * DSW5[1] = ON; DSW5[2] = ON
  * DSW17[5] = OFF; DSW17[6] = ON
+ *
+ * To enable SD card and disable eMMC on SDHI0 disable the below macro
+ * and set the below switch setting:
+ * DSW5[1] = OFF; DSW5[2] = ON
+ * P22_6 = SD0_WP; DSW15[1] = OFF; DSW15[2] = ON
+ * P22_5 = SD0_CD; DSW15[3] = OFF; DSW15[4] = ON
+ * P02_6 = SD0_IOVS; DSW17[5] = OFF; DSW17[6] = ON
+ * P02_5 = SD0_PWEN; DSW17[7] = OFF; DSW17[8] = ON
  */
 #define SD0_EMMC       1
+#define SD0_SD		(!SD0_EMMC)
 
 /*
  * P17_4 = SD1_CD; DSW5[3] = ON; DSW19[1] = OFF; DSW19[2] = ON
diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 34572630ecbe7..8b9d04dce8ae0 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -40,6 +40,18 @@ reg_3p3v: regulator-3p3v {
 		regulator-always-on;
 	};
 
+#if SD0_SD
+	vqmmc_sdhi0: regulator-vqmmc-sdhi0 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI0 VqmmC";
+		gpios = <&pinctrl RZT2H_GPIO(2, 6) GPIO_ACTIVE_HIGH>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios-states = <0>;
+		states = <3300000 0>, <1800000 1>;
+	};
+#endif
+
 #if SD1_MICRO_SD
 	vccq_sdhi1: regulator-vccq-sdhi1 {
 		compatible = "regulator-gpio";
@@ -107,6 +119,31 @@ ctrl-pins {
 		};
 	};
 
+#if SD0_SD
+	sdhi0-pwen-hog {
+		gpio-hog;
+		gpios = <RZT2H_GPIO(2, 5) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "SD0_PWEN";
+	};
+#endif
+
+	sdhi0_sd_pins: sd0-sd-group {
+		data-pins {
+			pinmux = <RZT2H_PORT_PINMUX(12, 2, 0x29)>, /* SD0_DATA0 */
+				 <RZT2H_PORT_PINMUX(12, 3, 0x29)>, /* SD0_DATA1 */
+				 <RZT2H_PORT_PINMUX(12, 4, 0x29)>, /* SD0_DATA2 */
+				 <RZT2H_PORT_PINMUX(12, 5, 0x29)>; /* SD0_DATA3 */
+		};
+
+		ctrl-pins {
+			pinmux = <RZT2H_PORT_PINMUX(12, 0, 0x29)>, /* SD0_CLK */
+				 <RZT2H_PORT_PINMUX(12, 1, 0x29)>, /* SD0_CMD */
+				 <RZT2H_PORT_PINMUX(22, 5, 0x29)>, /* SD0_CD */
+				 <RZT2H_PORT_PINMUX(22, 6, 0x29)>; /* SD0_WP */
+		};
+	};
+
 #if SD1_MICRO_SD
 	sdhi1-pwen-hog {
 		gpio-hog;
@@ -153,6 +190,20 @@ &sdhi0 {
 };
 #endif
 
+#if SD0_SD
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_sd_pins>;
+	pinctrl-1 = <&sdhi0_sd_pins>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&vqmmc_sdhi0>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};
+#endif
+
 #if SD1_MICRO_SD
 &sdhi1 {
 	pinctrl-0 = <&sdhi1_pins>;
-- 
2.43.0


