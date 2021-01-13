Return-Path: <SRS0=c5H/=GQ=lists.cip-project.org=bounce+64572+6080+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA68EC433DB
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:17 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565D823434
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565D823434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6080+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RnKgYY4521723xTIVcMnqWki; Wed, 13 Jan 2021 08:01:17 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.10141.1610553666445693623
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:16 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68896958"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:16 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 19C39400F792;
	Thu, 14 Jan 2021 01:01:14 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 9/9] ARM: dts: r8a7742-iwg21d-q7: Add LCD support
Date: Wed, 13 Jan 2021 16:01:02 +0000
Message-Id: <20210113160102.16310-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Jim5Wfz27jH5BQuQkh4MwpkWx4520388AA=
Content-Type: multipart/mixed; boundary="2zGyuVcsbbnywJq24OQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553677;
 bh=2xnfcmvWoXIvkuqWLNzGeGgqO8t0ehMqcwB6tca7kMc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=cYf7sVJVTuDLj9i8dYGjYys2LWVAq5K2p4cUTphLDBzV56zxEbBhogQwCeUrtE+WAj/
 zrQ4K4IrEldBN4zdB9E1Dq95cytjdYqJoFFK0zMCF9tdAeZAJa2++QNpjeGGGkOfD2cng
 8EqAhAji6xJcMeSeR8CC6GMsnXkMeU+I848=

--2zGyuVcsbbnywJq24OQf

commit 9b533dc8f340f5e9e7f2ed610510b2191d5e447c upstream.

The iwg21d comes with a 7" capacitive touch screen, therefore
add support for it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20200929140502.16017-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: remove the LVDS decoder as there is no driver for it; add panel
timings to panel node since the LVDS driver reads them off the panel DT
node; dropped power-supply property from panel node; dropped vcc_3v3_tft1
node; dropped vcc-supply property from touch node]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 73 +++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
index 958edef2004c..e876ba63c8c3 100644
--- a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -51,6 +51,41 @@
 		clock-frequency = <26000000>;
 	};
 
+	lcd_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpu 2 5000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		pinctrl-0 = <&backlight_pins>;
+		pinctrl-names = "default";
+		default-brightness-level = <7>;
+		enable-gpios = <&gpio3 11 GPIO_ACTIVE_HIGH>;
+	};
+
+	panel {
+		compatible = "edt,etm0700g0dh6";
+		backlight = <&lcd_backlight>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&du_out_lvds0>;
+			};
+		};
+
+		panel-timing {
+			clock-frequency = <33260>;
+			hactive = <800>;
+			vactive = <480>;
+
+			hfront-porch = <40>;
+			hback-porch = <88>;
+			hsync-len = <128>;
+
+			vback-porch = <33>;
+			vfront-porch = <10>;
+			vsync-len = <2>;
+		};
+	};
+
 	reg_1p5v: 1p5v {
 		compatible = "regulator-fixed";
 		regulator-name = "1P5V";
@@ -128,6 +163,15 @@
 		VDDIO-supply = <&reg_3p3v>;
 		VDDD-supply = <&reg_1p5v>;
 	};
+
+	touch: touchpanel@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+		/* GP1_29 is also shared with audio codec reset pin */
+		reset-gpios = <&gpio1 29 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &can1 {
@@ -141,6 +185,26 @@
 	status = "okay";
 };
 
+&du {
+	status = "okay";
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&gpio0 {
+	touch-interrupt {
+		gpio-hog;
+		gpios = <24 GPIO_ACTIVE_LOW>;
+		input;
+	};
+};
+
 &gpio1 {
 	can-trx-en-gpio{
 		gpio-hog;
@@ -218,6 +282,11 @@
 		function = "avb";
 	};
 
+	backlight_pins: backlight {
+		groups = "tpu0_to2";
+		function = "tpu0";
+	};
+
 	can1_pins: can1 {
 		groups = "can1_data_b";
 		function = "can1";
@@ -303,6 +372,10 @@
 	shared-pin;
 };
 
+&tpu {
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.17.1


--2zGyuVcsbbnywJq24OQf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6080): https://lists.cip-project.org/g/cip-dev/message=
/6080
Mute This Topic: https://lists.cip-project.org/mt/79654008/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--2zGyuVcsbbnywJq24OQf--
