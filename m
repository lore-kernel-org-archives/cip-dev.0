Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827EFECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:48:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.1265.1661964487009489496
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:48:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240548"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:48:06 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0654540457D9;
	Thu,  1 Sep 2022 01:48:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 24/26] arm64: dts: renesas: rzg2ul-smarc: Enable
 microSD on SMARC platform
Date: Wed, 31 Aug 2022 17:46:43 +0100
Message-Id: <20220831164645.2134258-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9384

commit a74a0bf3f329415008c1a374118d27023a3d4735 upstream.

Enable the microSD card slot connected to SDHI1 on the RZ/G2UL SMARC
platform by removing the sdhi1 override which disabled it, and by adding
the necessary pinmux required for SDHI1.

This patch also adds gpios property to vccq_sdhi1 regulator.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402081328.26292-6-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 12 +-----
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi | 39 +++++++++++++++++++
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    |  9 +++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 14 +++++++
 4 files changed, 63 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 64370faf8f6d..08a0404c6f0b 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -7,9 +7,7 @@
 
 /dts-v1/;
 #include "r9a07g043.dtsi"
-#include "rzg2ul-smarc-som.dtsi"
-#include "rzg2ul-smarc-pinfunction.dtsi"
-#include "rz-smarc-common.dtsi"
+#include "rzg2ul-smarc.dtsi"
 
 / {
 	model = "Renesas SMARC EVK based on r9a07g043u11";
@@ -74,14 +72,6 @@ &phyrst {
 	status = "disabled";
 };
 
-&sdhi1 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-1;
-	/delete-property/ pinctrl-names;
-	/delete-property/ vmmc-supply;
-	status = "disabled";
-};
-
 &spi1 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-names;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index 2db9c92cf01f..b515748e6a9a 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -17,6 +17,45 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(6, 3, 6)>; /* RxD */
 	};
 
+	sd1-pwr-en-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(0, 3) GPIO_ACTIVE_HIGH>;
+		output-high;
+		line-name = "sd1_pwr_en";
+	};
+
+	sdhi1_pins: sd1 {
+		sd1_data {
+			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
+			power-source = <3300>;
+		};
+
+		sd1_ctrl {
+			pins = "SD1_CLK", "SD1_CMD";
+			power-source = <3300>;
+		};
+
+		sd1_mux {
+			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
+		};
+	};
+
+	sdhi1_pins_uhs: sd1_uhs {
+		sd1_data_uhs {
+			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
+			power-source = <1800>;
+		};
+
+		sd1_ctrl_uhs {
+			pins = "SD1_CLK", "SD1_CMD";
+			power-source = <1800>;
+		};
+
+		sd1_mux_uhs {
+			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
+		};
+	};
+
 	sound_clk_pins: sound_clk {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
 		input-enable;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 3bbb8fcd604c..8ecc650099a7 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -18,6 +18,15 @@ memory@48000000 {
 		/* first 128MB is reserved for secure area. */
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
+
+	reg_3p3v: regulator1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &extal_clk {
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
new file mode 100644
index 000000000000..f47b4e2e0feb
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2UL Type-1 SMARC EVK parts
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include "rzg2ul-smarc-som.dtsi"
+#include "rzg2ul-smarc-pinfunction.dtsi"
+#include "rz-smarc-common.dtsi"
+
+&vccq_sdhi1 {
+	gpios = <&pinctrl RZG2L_GPIO(6, 1) GPIO_ACTIVE_HIGH>;
+};
-- 
2.25.1


