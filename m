Return-Path: <SRS0=kex6=7P=lists.cip-project.org=bounce+64572+4661+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB186C433DF
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 08:44:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79DFF206A2
	for <cip-dev@archiver.kernel.org>; Tue,  2 Jun 2020 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="RBHfk5Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79DFF206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4661+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id n5g7YY4521723xyHXBn3T2Oe; Tue, 02 Jun 2020 01:44:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.6480.1591087450769064707
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jun 2020 01:44:11 -0700
X-IronPort-AV: E=Sophos;i="5.73,463,1583161200"; 
   d="scan'208";a="48412612"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 02 Jun 2020 17:44:09 +0900
X-Received: from marian-VirtualBox.ree.adwin.renesas.com (unknown [10.226.36.164])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F517423F933;
	Tue,  2 Jun 2020 17:44:08 +0900 (JST)
From: "Marian-Cristian Rotariu" <marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	fabrizio.castro.jz@renesas.com
Subject: [cip-dev] [PATCH v2 v4.4.y-cip] ARM: dts: iwg20d-q7-common: Add LCD support
Date: Tue,  2 Jun 2020 09:43:24 +0100
Message-Id: <1591087404-7118-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: PX9EmXqKbeXprlw5OjhG5R7Jx4520388AA=
Content-Type: multipart/mixed; boundary="s71qJqVVmgJBGVWne70z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591087452;
 bh=5AMD90P/bCj4ZeiOPI9ZP/vlzMLQqZl61MsvBTh9wv0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RBHfk5PaMjGkbBhGZEKbgyUkl7HnImX9USm3qHdKcPT0ghLJlkQodtFidaeZ/gV4fUd
 kiPh7oHL3lfyJVpaT0By4oEfrVvn2lZkdcvoYNUGK9K07VGI9ZHBL7R9EbLAYfnnp3kcE
 ozU9iVKZa2FIwBB3nmRE+puwgJAmLNc9XOs=

--s71qJqVVmgJBGVWne70z

commit 6f89dd9e9325d05b1f54d860dbbc84b42aa40759 upstream.

The iwg20d comes with a 7" capacitive touch screen, therefore
add support for it.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/1573660292-10629-11-git-send-email-fabrizio.castro@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(remove the LVDS decoder as there is no driver for it;
 add panel timings to panel node since the LVDS driver reads them off the
 panel DT node)
Signed-off-by: Marian-Cristian Rotariu <marian.c.rotariu@gmail.com>
---
 arch/arm/boot/dts/iwg20d-q7-common.dtsi  | 81 ++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi |  1 -
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/iwg20d-q7-common.dtsi b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
index 011dbab..52c1787 100644
--- a/arch/arm/boot/dts/iwg20d-q7-common.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-common.dtsi
@@ -49,6 +49,40 @@
 		clock-frequency = <26000000>;
 	};
 
+	lcd_backlight: backlight {
+		compatible = "pwm-backlight";
+
+		pwms = <&pwm3 0 5000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+		enable-gpios = <&gpio5 14 GPIO_ACTIVE_HIGH>;
+	};
+
+	panel {
+	    compatible = "edt,etm0700g0dh6", "simple-panel";
+	    backlight = <&lcd_backlight>;
+
+	    port {
+		    panel_in: endpoint {
+			    remote-endpoint = <&du_out_lvds0>;
+		    };
+	    };
+
+	    panel-timing {
+		    clock-frequency = <33260>;
+		    hactive = <800>;
+		    vactive = <480>;
+
+		    hfront-porch = <40>;
+		    hback-porch = <88>;
+		    hsync-len = <128>;
+
+		    vback-porch = <33>;
+		    vfront-porch = <10>;
+		    vsync-len = <2>;
+	    };
+	};
+
 	reg_1p5v: 1p5v {
 		compatible = "regulator-fixed";
 		regulator-name = "1P5V";
@@ -123,6 +157,35 @@
 	status = "okay";
 };
 
+&du {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+			du_out_rgb: endpoint {
+			};
+		};
+		port@1 {
+			reg = <1>;
+			du_out_lvds0: endpoint {
+			       remote-endpoint = <&panel_in>;
+			};
+		};
+	};
+};
+
+&gpio2 {
+	touch-interrupt {
+		gpio-hog;
+		gpios = <12 GPIO_ACTIVE_LOW>;
+		input;
+	};
+};
+
 &hsusb {
 	status = "okay";
 	pinctrl-0 = <&usb0_pins>;
@@ -150,6 +213,13 @@
 		VDDIO-supply = <&reg_3p3v>;
 		VDDD-supply = <&reg_1p5v>;
 	};
+
+	touch: touchpanel@38 {
+		compatible = "edt,edt-ft5406";
+		reg = <0x38>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+	};
 };
 
 &pci0 {
@@ -183,6 +253,11 @@
 		function = "i2c2";
 	};
 
+	pwm3_pins: pwm3 {
+		groups = "pwm3";
+		function = "pwm3";
+	};
+
 	scif0_pins: scif0 {
 		groups = "scif0_data_d";
 		function = "scif0";
@@ -215,6 +290,12 @@
 	};
 };
 
+&pwm3 {
+	pinctrl-0 = <&pwm3_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &rcar_sound {
 	pinctrl-0 = <&sound_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
index e643064..ec4c29a 100644
--- a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
+++ b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
@@ -42,7 +42,6 @@
 &du {
 	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
-	status = "okay";
 
 	ports {
 		port@0 {
-- 
2.7.4


--s71qJqVVmgJBGVWne70z
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4661): https://lists.cip-project.org/g/cip-dev/message=
/4661
Mute This Topic: https://lists.cip-project.org/mt/74623758/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--s71qJqVVmgJBGVWne70z--
