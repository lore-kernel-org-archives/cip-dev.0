Return-Path: <SRS0=AGI8=BH=lists.cip-project.org=bounce+64572+5040+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D84BC433F4
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 612912070B
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="jR98xN3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612912070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5040+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id QYhxYY4521723xqjOAAutO6p; Tue, 28 Jul 2020 04:52:29 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9344.1595933031369313843
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:51 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53033337"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:50 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3615840062A4;
	Tue, 28 Jul 2020 19:43:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 9/9] ARM: dts: iwg22d-sodimm: Enable LCD panel
Date: Tue, 28 Jul 2020 11:43:30 +0100
Message-Id: <20200728104330.6182-10-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xtaYroVB2KXRJXPxFccUzpwWx4520388AA=
Content-Type: multipart/mixed; boundary="eqLGSYvuRJ1fttSaL2xF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937149;
 bh=gqLkpbo8vCBwM+k14dpjZMWRiWl/0qenjfn97prk68A=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jR98xN3yWPH89YiDz4oCe3ckRck+HVD6aRJHBBlJH8Sx7cIAk9biDN5VMubc0SIva+k
 yPtrFS+6Qr1VluMLyNE0VgQRyOU2jHisuHo/fAIGEu27p5bHiKdSF2MxAVUCj+4VEanoX
 EHCodUSAS7yPXqUxX9gQp1Vg78HiFrmB4ow=

--eqLGSYvuRJ1fttSaL2xF

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 7f61dff1ed915c44845d6865d295853b1c39b6d7 upstream.

On the Generic SODIMM Development Platform there is an RGB LCD panel
directly connected to the DU output. It uses the TPU0 as backlight, one
GPIO pull-up configuration for power enable, R[2:7], G[2:7], B[2:7],
VSYNC, HSYNC, DU0_DISP and, DU0_CLK as inputs.

There is no encoder between the DU and the panel, therefore the default
connector driver is used.

The two variants of the iW-G22D should be mutually exclusive, therefore
this patch also disables the RGB LCD display when the HDMI extension board
is used.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1583239490-8837-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
[Removed enable-active-high property to make backlight to work on 4.4.]
---
 .../dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts     |  6 ++
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts   | 59 +++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
index 654d28b629e5..b01405fc1b49 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm-dbhd-ca.dts
@@ -109,6 +109,12 @@
 	};
 };
 
+&lcd_panel {
+	status = "disabled";
+
+	/delete-node/ port;
+};
+
 &pfc {
 	can1_pins: can1 {
 		groups = "can1_data_b";
diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 94e9088f6b40..1e331d1e414b 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -33,6 +33,7 @@
 
 /dts-v1/;
 #include "r8a7745-iwg22m.dtsi"
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "iWave Systems RainboW-G22D-SODIMM board based on RZ/G1E";
@@ -82,6 +83,48 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	vccq_panel: regulator-vccq-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "Panel VccQ";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+
+	backlight_lcd: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpu 3 5000000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
+
+	lcd_panel: lcd {
+		compatible = "edt,etm043080dh6gp";
+		power-supply = <&vccq_panel>;
+		backlight = <&backlight_lcd>;
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&du_out_rgb0>;
+			};
+		};
+	};
+};
+
+&du {
+	pinctrl-0 = <&du0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			endpoint {
+				remote-endpoint = <&lcd_in>;
+			};
+		};
+	};
 };
 
 &can0 {
@@ -117,11 +160,21 @@
 };
 
 &pfc {
+	backlight_pins: backlight {
+		groups = "tpu_to3_c";
+		function = "tpu";
+	};
+
 	can0_pins: can0 {
 		groups = "can0_data";
 		function = "can0";
 	};
 
+	du0_pins: du0 {
+		groups = "du0_rgb666", "du0_sync", "du0_disp", "du0_clk0_out";
+		function = "du0";
+	};
+
 	hscif1_pins: hscif1 {
 		groups = "hscif1_data", "hscif1_ctrl";
 		function = "hscif1";
@@ -233,6 +286,12 @@
 	shared-pin;
 };
 
+&tpu {
+	pinctrl-0 = <&backlight_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.17.1


--eqLGSYvuRJ1fttSaL2xF
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5040): https://lists.cip-project.org/g/cip-dev/message=
/5040
Mute This Topic: https://lists.cip-project.org/mt/75842045/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--eqLGSYvuRJ1fttSaL2xF--
