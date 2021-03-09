Return-Path: <SRS0=eipP=IH=lists.cip-project.org=bounce+64572+6237+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E652AC433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A675764FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A675764FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6237+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 60nVYY4521723xf4eH34oKqV; Tue, 09 Mar 2021 08:37:28 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:27 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591025"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:27 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4451440A2DC7;
	Wed, 10 Mar 2021 01:37:26 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 21/40] arm64: dts: renesas: r8a774c0-cat874: Add support for AISTARVISION MIPI Adapter V2.1
Date: Tue,  9 Mar 2021 16:36:37 +0000
Message-Id: <20210309163656.20944-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: AvdTwH3DTjTfJbLDcIeMo2Ilx4520388AA=
Content-Type: multipart/mixed; boundary="bxIiybUfrRjMYd5OU9jm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307848;
 bh=ATclpILJENGrH41JjbsUlWG7yrP/aGBC9FmVh5R0VWs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g9HBCCc3Bvl0J6PvhD+npRGq1BeDTeTAesnyEM0YUU8fqH3QWVcekNXrYQGfTkUAl/y
 mr6DsH3yQ+5GhpaL+yFSItpvX6dg9Li8VcSWc69hQqe7ye1Edap0LDt/Pxduk+ChLUPzV
 9LzkE5ZTi/18LgawEnZCnDE/4+vo9QxvTgg=

--bxIiybUfrRjMYd5OU9jm

commit 0e36587c0832af5df894f5e5fcc45fb5a05cea5b upstream.

This patch adds support for AISTARVISION MIPI Adapter V2.1 board connected
to G2E board. Common file aistarvision-mipi-adapter-2.1.dtsi is created
which have the camera endpoint nodes for imx219 and ov5645 so that this can
be re-used with other G2x platforms.

r8a774c0-ek874-mipi-2.1.dts file enables the required VIN/CSI nodes and by
default ties ov5645 camera endpoint to CSI2.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1587397794-11237-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied changes to Makefile file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  3 +-
 .../aistarvision-mipi-adapter-2.1.dtsi        | 94 +++++++++++++++++++
 .../dts/renesas/r8a774c0-ek874-mipi-2.1.dts   | 72 ++++++++++++++
 3 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 16d63679f358..0783033209d9 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -12,7 +12,8 @@ dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb \
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb \
 			       r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
-			       r8a774c0-ek874-idk-2121wr.dtb
+			       r8a774c0-ek874-idk-2121wr.dtb \
+			       r8a774c0-ek874-mipi-2.1.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
diff --git a/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
new file mode 100644
index 000000000000..dac6ff49020f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/aistarvision-mipi-adapter-2.1.dtsi
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the AISTARVISION MIPI Adapter V2.1
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/ {
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
+	imx219_vana_2v8: 2p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vana";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		regulator-always-on;
+	};
+
+	imx219_vdig_1v8: 1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vdig";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+	};
+
+	imx219_vddl_1v2: 1p2v {
+		compatible = "regulator-fixed";
+		regulator-name = "camera_vddl";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+	};
+
+	osc25250_clk: osc25250_clk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+};
+
+&MIPI_PARENT_I2C {
+	ov5645: ov5645@3c {
+		compatible = "ovti,ov5645";
+		reg = <0x3c>;
+		clock-names = "xclk";
+		clocks = <&osc25250_clk>;
+		clock-frequency = <24000000>;
+		vdddo-supply = <&ov5645_vdddo_1v8>;
+		vdda-supply = <&ov5645_vdda_2v8>;
+		vddd-supply = <&ov5645_vddd_1v5>;
+
+		port {
+			ov5645_ep: endpoint {
+			};
+		};
+	};
+
+	imx219: imx219@10 {
+		compatible = "sony,imx219";
+		reg = <0x10>;
+		clocks = <&osc25250_clk>;
+		VANA-supply = <&imx219_vana_2v8>;
+		VDIG-supply = <&imx219_vdig_1v8>;
+		VDDL-supply = <&imx219_vddl_1v2>;
+
+		port {
+			imx219_ep: endpoint {
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
new file mode 100644
index 000000000000..f0829e905506
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-mipi-2.1.dts
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Silicon Linux RZ/G2E 96board platform (CAT874)
+ * connected with aistarvision-mipi-v2-adapter board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774c0-ek874.dts"
+#define MIPI_PARENT_I2C i2c3
+#include "aistarvision-mipi-adapter-2.1.dtsi"
+
+/ {
+	model = "Silicon Linux RZ/G2E evaluation kit EK874 (CAT874 + CAT875) with aistarvision-mipi-v2-adapter board";
+	compatible = "si-linux,cat875", "si-linux,cat874", "renesas,r8a774c0";
+};
+
+&i2c3 {
+	status = "okay";
+};
+
+&vin4 {
+	status = "okay";
+};
+
+&vin5 {
+	status = "okay";
+};
+
+&csi40 {
+	status = "okay";
+
+	ports {
+		port {
+			csi40_in: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&ov5645_ep>;
+			};
+		};
+	};
+};
+
+&ov5645 {
+	enable-gpios = <&gpio5 5 GPIO_ACTIVE_HIGH>;
+	reset-gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
+
+	port {
+		ov5645_ep: endpoint {
+			clock-lanes = <0>;
+			data-lanes = <1 2>;
+			remote-endpoint = <&csi40_in>;
+		};
+	};
+};
+
+&imx219 {
+	port {
+		imx219_ep: endpoint {
+			clock-lanes = <0>;
+			data-lanes = <1 2>;
+			link-frequencies = /bits/ 64 <456000000>;
+			/* uncomment remote-endpoint property to tie imx219 to
+			 * CSI2 also make sure remote-endpoint for ov5645 camera
+			 * is commented and remote endpoint phandle in csi40_in
+			 * is imx219_ep
+			 */
+			/* remote-endpoint = <&csi40_in>; */
+		};
+	};
+};
-- 
2.17.1


--bxIiybUfrRjMYd5OU9jm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6237): https://lists.cip-project.org/g/cip-dev/message=
/6237
Mute This Topic: https://lists.cip-project.org/mt/81205369/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bxIiybUfrRjMYd5OU9jm--
