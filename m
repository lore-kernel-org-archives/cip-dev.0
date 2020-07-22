Return-Path: <SRS0=8EuT=BB=lists.cip-project.org=bounce+64572+4977+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F82C433FB
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9829D207E8
	for <cip-dev@archiver.kernel.org>; Wed, 22 Jul 2020 17:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="BzbKHCNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9829D207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4977+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id FkeXYY4521723xoJK7edLnjZ; Wed, 22 Jul 2020 10:47:09 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.23023.1595435721535782356
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2020 09:35:25 -0700
X-IronPort-AV: E=Sophos;i="5.75,383,1589209200"; 
   d="scan'208";a="52832269"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2020 01:35:25 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 83E7240078CA;
	Thu, 23 Jul 2020 01:35:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 17/17] arm64: dts: renesas: Add EK874 board with idk-2121wr display support
Date: Wed, 22 Jul 2020 17:34:49 +0100
Message-Id: <20200722163449.3513-18-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
References: <20200722163449.3513-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kp97zxHiOdXIhUYCiBnyVUFrx4520388AA=
Content-Type: multipart/mixed; boundary="VzFAlZxNB9lzWY1MvaRh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595440029;
 bh=xtD3q5AgdP9bF4Zc/YlbKurk+pDc9jDZ9X+Qg9u6o+0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=BzbKHCNdJrXonbHss6OOvwDw8mI86oIQDL9pZ0Os0jLXJzZr6nv4iWLEq4ld4/dG1A0
 qx21bd6AkQT+QxkOJbtc24CmCXK3OJH22FAYWm3X92QOy0BRqLTpGsz8uPzW/4Hevj4oX
 J6eV4oUT2/7UEW7pbNRgXvwHBKV37ijU7IU=

--VzFAlZxNB9lzWY1MvaRh

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit ae56c940f188c1dde440c8456229adaad733908e upstream.

The EK874 is advertised as compatible with panel IDK-2121WR from
Advantech, however the panel isn't sold alongside the board.
A new dts, adding everything that's required to get the panel to
to work with the EK874, is the most convenient way to support the
EK874 when it's connected to the IDK-2121WR.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/1576590361-28244-7-git-send-email-fabrizio.castro@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |   3 +-
 .../dts/renesas/r8a774c0-ek874-idk-2121wr.dts | 116 ++++++++++++++++++
 2 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index c05feec80636..d22ede9e3ee4 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -4,7 +4,8 @@ dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb
-dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb
+dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
+			       r8a774c0-ek874-idk-2121wr.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts
new file mode 100644
index 000000000000..a7b27d09f6c2
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-ek874-idk-2121wr.dts
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Silicon Linux RZ/G2E evaluation kit (EK874),
+ * connected to an Advantech IDK-2121WR 21.5" LVDS panel
+ *
+ * Copyright (C) 2019 Renesas Electronics Corp.
+ */
+
+#include "r8a774c0-ek874.dts"
+
+/ {
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm5 0 50000>;
+
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+
+		power-supply = <&reg_12p0v>;
+		enable-gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
+	};
+
+	panel-lvds {
+		compatible = "advantech,idk-2121wr", "panel-lvds";
+
+		width-mm = <476>;
+		height-mm = <268>;
+
+		data-mapping = "vesa-24";
+
+		panel-timing {
+			clock-frequency = <148500000>;
+			hactive = <1920>;
+			vactive = <1080>;
+			hsync-len = <44>;
+			hfront-porch = <88>;
+			hback-porch = <148>;
+			vfront-porch = <4>;
+			vback-porch = <36>;
+			vsync-len = <5>;
+		};
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				dual-lvds-odd-pixels;
+				panel_in0: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				dual-lvds-even-pixels;
+				panel_in1: endpoint {
+					remote-endpoint = <&lvds1_out>;
+				};
+			};
+		};
+	};
+};
+
+&gpio0 {
+	/*
+	 * When GP0_17 is low LVDS[01] are connected to the LVDS connector
+	 * When GP0_17 is high LVDS[01] are connected to the LT8918L
+	 */
+	lvds-connector-en-gpio{
+		gpio-hog;
+		gpios = <17 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "lvds-connector-en-gpio";
+	};
+};
+
+&lvds0 {
+	ports {
+		port@1 {
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in0>;
+			};
+		};
+	};
+};
+
+&lvds1 {
+	status = "okay";
+
+	clocks = <&cpg CPG_MOD 727>, <&x13_clk>, <&extal_clk>;
+	clock-names = "fck", "dclkin.0", "extal";
+
+	ports {
+		port@1 {
+			lvds1_out: endpoint {
+				remote-endpoint = <&panel_in1>;
+			};
+		};
+	};
+};
+
+&pfc {
+	pwm5_pins: pwm5 {
+		groups = "pwm5_a";
+		function = "pwm5";
+	};
+};
+
+&pwm5 {
+	pinctrl-0 = <&pwm5_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.17.1


--VzFAlZxNB9lzWY1MvaRh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4977): https://lists.cip-project.org/g/cip-dev/message=
/4977
Mute This Topic: https://lists.cip-project.org/mt/75730039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--VzFAlZxNB9lzWY1MvaRh--
