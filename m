Return-Path: <SRS0=iOR2=F2=lists.cip-project.org=bounce+64572+5971+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B850C433E0
	for <cip-dev@archiver.kernel.org>; Tue, 22 Dec 2020 11:27:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC98022A83
	for <cip-dev@archiver.kernel.org>; Tue, 22 Dec 2020 11:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC98022A83
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5971+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id HozYYY4521723xNtoDSgioK5; Tue, 22 Dec 2020 03:27:21 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.10450.1608636439416372525
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Dec 2020 03:27:20 -0800
X-IronPort-AV: E=Sophos;i="5.78,438,1599490800"; 
   d="scan'208";a="66596275"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2020 20:27:16 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E3582400092B;
	Tue, 22 Dec 2020 20:27:15 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] ARM: dts: iwg22d-sodimm: Fix dt nodes sorting
Date: Tue, 22 Dec 2020 11:27:14 +0000
Message-Id: <20201222112714.24595-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: WismUIQjioSZbGJ858QaUi1Zx4520388AA=
Content-Type: multipart/mixed; boundary="SCRsWQiglmd4WA2HMlGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608636441;
 bh=b59mAnfHMRsYEq59YZcDjiUZMNY8D2ChF1eotV55HGA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sm/IoVlxdGlpgIcZzmGf4GWAlnQGUKYHKUZzHxCM5rn86cBO3DSAi2oHSKyde8Cwvw6
 J/m2iORP4+WurL1E2HahgocAqeyn+U21aUJGFl546XTnxn1vbyWGIAw5K2zDjP5y9AFW4
 2YFDPBhLeA3AzQqc3615xXVw7SCeUSgrmnU=

--SCRsWQiglmd4WA2HMlGt

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 73aa5b7c941145b7a1a53f31b6a71dfe98007870 upstream.

Some r8a7745-iwg22d-sodimm.dts device nodes are not sorted alphabetically.
This patch fixes the sorting of nodes and also fixes a typo in the stmpe
node.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20200805142634.12252-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied the changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 98 ++++++++++-----------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
index 5cd989556b60..5a1859446046 100644
--- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
+++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
@@ -56,21 +56,33 @@
 		clock-frequency = <26000000>;
 	};
 
-	rsnd_sgtl5000: sound {
-		compatible = "simple-audio-card";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,bitclock-master = <&sndcodec>;
-		simple-audio-card,frame-master = <&sndcodec>;
+	backlight_lcd: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&tpu 3 5000000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <7>;
+	};
 
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
+	lcd_panel: lcd {
+		compatible = "edt,etm043080dh6gp";
+		power-supply = <&vccq_panel>;
+		backlight = <&backlight_lcd>;
 
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&sgtl5000>;
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&du_out_rgb0>;
+			};
 		};
 	};
 
+	vccq_panel: regulator-vccq-panel {
+		compatible = "regulator-fixed";
+		regulator-name = "Panel VccQ";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio1 13 GPIO_ACTIVE_LOW>;
+	};
+
 	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
@@ -84,34 +96,29 @@
 			  1800000 0>;
 	};
 
-	vccq_panel: regulator-vccq-panel {
-		compatible = "regulator-fixed";
-		regulator-name = "Panel VccQ";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		gpio = <&gpio1 13 GPIO_ACTIVE_LOW>;
-	};
-
-	backlight_lcd: backlight {
-		compatible = "pwm-backlight";
-		pwms = <&tpu 3 5000000 PWM_POLARITY_INVERTED>;
-		brightness-levels = <0 4 8 16 32 64 128 255>;
-		default-brightness-level = <7>;
-	};
+	rsnd_sgtl5000: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
 
-	lcd_panel: lcd {
-		compatible = "edt,etm043080dh6gp";
-		power-supply = <&vccq_panel>;
-		backlight = <&backlight_lcd>;
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
 
-		port {
-			lcd_in: endpoint {
-				remote-endpoint = <&du_out_rgb0>;
-			};
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
 		};
 	};
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &du {
 	pinctrl-0 = <&du0_pins>;
 	pinctrl-names = "default";
@@ -127,13 +134,6 @@
 	};
 };
 
-&can0 {
-	pinctrl-0 = <&can0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-
 &hscif1 {
 	pinctrl-0 = <&hscif1_pins>;
 	pinctrl-names = "default";
@@ -149,6 +149,15 @@
 	status = "okay";
 	clock-frequency = <400000>;
 
+	sgtl5000: codec@a {
+		compatible = "fsl,sgtl5000";
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		clocks = <&audio_clock>;
+		VDDA-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+
 	stmpe811@44 {
 		compatible = "st,stmpe811";
 		reg = <0x44>;
@@ -157,7 +166,7 @@
 
 		/* 3.25 MHz ADC clock speed */
 		st,adc-freq = <1>;
-		/* ADC converstion time: 80 clocks */
+		/* ADC conversation time: 80 clocks */
 		st,sample-time = <4>;
 		/* 12-bit ADC */
 		st,mod-12b = <1>;
@@ -181,15 +190,6 @@
 			st,touch-det-delay = <5>;
 		};
 	};
-
-	sgtl5000: codec@a {
-		compatible = "fsl,sgtl5000";
-		#sound-dai-cells = <0>;
-		reg = <0x0a>;
-		clocks = <&audio_clock>;
-		VDDA-supply = <&reg_3p3v>;
-		VDDIO-supply = <&reg_3p3v>;
-	};
 };
 
 &pfc {
-- 
2.17.1


--SCRsWQiglmd4WA2HMlGt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5971): https://lists.cip-project.org/g/cip-dev/message=
/5971
Mute This Topic: https://lists.cip-project.org/mt/79146851/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--SCRsWQiglmd4WA2HMlGt--
