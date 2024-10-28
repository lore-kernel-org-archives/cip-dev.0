Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65BD5B144
	for <webhook@archiver.kernel.org>; Mon, 28 Oct 2024 20:04:55 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.2590.1730145893157259107
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Oct 2024 13:04:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,239,1725289200"; 
   d="scan'208";a="227219335"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Oct 2024 05:04:52 +0900
Received: from Ubuntu-22.. (unknown [10.226.93.179])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 29932408CD26;
	Tue, 29 Oct 2024 05:04:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 26/27] arm64: dts: renesas: rzg2l-smarc: Enable CRU, CSI support
Date: Mon, 28 Oct 2024 20:03:48 +0000
Message-ID: <20241028200349.9620-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20241028200349.9620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Oct 2024 20:04:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17109

commit 3d52973db7457362e54b5b62242671eee80b2c14 upstream.

Enable CRU, CSI on RZ/G2L SMARC EVK and tie the CSI to OV5645 sensor
using Device Tree overlay. rz-smarc-cru-csi-ov5645.dtsi is created so
that RZ/G2L alike EVKs can make use of it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230322125648.24948-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: dropped overlay support and enabled directly in board dts]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/rz-smarc-cru-csi-ov5645.dtsi  | 80 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  8 ++
 2 files changed, 88 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
new file mode 100644
index 0000000000000..c5bb63c63b470
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-cru-csi-ov5645.dtsi
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Common Device Tree for the RZ/G2L SMARC EVK (and alike EVKs) with
+ * OV5645 camera connected to CSI and CRU enabled.
+ *
+ * Copyright (C) 2023 Renesas Electronics Corp.
+ */
+
+&{/} {
+	ov5645_vdddo_1v8: 1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdddo";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	ov5645_vdda_2v8: 2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdda";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	ov5645_vddd_1v5: 1p5v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	ov5645_fixed_clk: osc25250-clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+};
+
+&cru {
+	status = "okay";
+};
+
+&csi2 {
+	status = "okay";
+
+	ports {
+		port@0 {
+			csi2_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&ov5645_ep>;
+			};
+		};
+	};
+};
+
+&OV5645_PARENT_I2C {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ov5645: camera@3c {
+		compatible = "ovti,ov5645";
+		reg = <0x3c>;
+		clocks = <&ov5645_fixed_clk>;
+		clock-frequency = <24000000>;
+		vdddo-supply = <&ov5645_vdddo_1v8>;
+		vdda-supply = <&ov5645_vdda_2v8>;
+		vddd-supply = <&ov5645_vddd_1v5>;
+
+		port {
+			ov5645_ep: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&csi2_in>;
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index ee3d96fdb6168..90ae3259fd825 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -8,6 +8,9 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
+#define OV5645_PARENT_I2C i2c0
+#include "rz-smarc-cru-csi-ov5645.dtsi"
+
 / {
 	aliases {
 		serial1 = &scif2;
@@ -159,6 +162,11 @@ &spi1 {
 };
 #endif /* PMOD_MTU3 */
 
+&ov5645 {
+	enable-gpios = <&pinctrl RZG2L_GPIO(2, 0) GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&pinctrl RZG2L_GPIO(40, 2) GPIO_ACTIVE_LOW>;
+};
+
 /*
  * To enable SCIF2 (SER0) on PMOD1 (CN7)
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.43.0


