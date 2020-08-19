Return-Path: <SRS0=I9pr=B5=lists.cip-project.org=bounce+64572+5142+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A3EC433EB
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CF91208B3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="r5ygU8vJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CF91208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5142+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id t8AtYY4521723xYNRhD6VEcn; Wed, 19 Aug 2020 09:45:12 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.92110.1597854998224602430
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:43 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54984476"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:42 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1915C400B9C0;
	Thu, 20 Aug 2020 01:36:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 03/12] arm64: dts: renesas: hihope-common: Separate out Rev.2.0 specific into hihope-rev2.dtsi file
Date: Wed, 19 Aug 2020 17:36:25 +0100
Message-Id: <20200819163634.5430-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FRJQTi7TNGB5v8ylzRtnPAsRx4520388AA=
Content-Type: multipart/mixed; boundary="xm5oi6VVnIElHeaFpiZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855512;
 bh=0CwmK7vnyrkUZkQIccShRUrbv5T2kHMy5JEoHq9Ieic=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=r5ygU8vJxKv07CmbkRw4hRM4KcBZ642TmplX1RZ41T6b851XPnHhwPzhWH+owx6Xyrh
 HaGxajKnwHzAYe5muRLiYXpuk7OW8grcQG6fZIDpjyqiYnznpX1jePmh2eKn6GveSSm9K
 apTm9Pf9ygfACucoyu/dgGKT9u0m+6Gf8UA=

--xm5oi6VVnIElHeaFpiZf

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 99167613db6e439d877131e1fbe617e4420b954f upstream.

Separate out Rev.2.0 specific hardware changes into hihope-rev2.dtsi
file so that hihope-common.dtsi can be used by all the variants for
RZ/G2M[N] boards.

LED node names have been updated according to Rev.4.0 schematics.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../arm64/boot/dts/renesas/hihope-common.dtsi | 71 +--------------
 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi  | 86 +++++++++++++++++++
 .../renesas/r8a774a1-hihope-rzg2m-rev2.dts    |  2 +-
 .../renesas/r8a774b1-hihope-rzg2n-rev2.dts    |  2 +-
 4 files changed, 92 insertions(+), 69 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rev2.dtsi

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 2c942a7eaeeb..3132c2cc99c4 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2[MN] main board common parts
+ * Device Tree Source for the HiHope RZ/G2[MN] main board
+ * Rev.[2.0/3.0/4.0] common parts
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
@@ -32,17 +33,6 @@
 	leds {
 		compatible = "gpio-leds";
 
-		bt_active_led {
-			label = "blue:bt";
-			gpios = <&gpio7  0 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "hci0-power";
-			default-state = "off";
-		};
-
-		led0 {
-			gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
-		};
-
 		led1 {
 			gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
 		};
@@ -55,11 +45,8 @@
 			gpios = <&gpio0  0 GPIO_ACTIVE_HIGH>;
 		};
 
-		wlan_active_led {
-			label = "yellow:wlan";
-			gpios = <&gpio7  1 GPIO_ACTIVE_HIGH>;
-			linux,default-trigger = "phy0tx";
-			default-state = "off";
+		led4 {
+			gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
@@ -113,17 +100,6 @@
 			  1800000 0>;
 	};
 
-	wlan_en_reg: regulator-wlan_en {
-		compatible = "regulator-fixed";
-		regulator-name = "wlan-en-regulator";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		startup-delay-us = <70000>;
-
-		gpio = <&gpio_expander 1 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	x302_clk: x302-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -195,11 +171,6 @@
 
 	uart-has-rtscts;
 	status = "okay";
-
-	bluetooth {
-		compatible = "ti,wl1837-st";
-		enable-gpios = <&gpio_expander 2 GPIO_ACTIVE_HIGH>;
-	};
 };
 
 &hsusb {
@@ -211,13 +182,6 @@
 	clock-frequency = <400000>;
 	status = "okay";
 
-	gpio_expander: gpio@20 {
-		compatible = "onnn,pca9654";
-		reg = <0x20>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
-
 	versaclock5: clock-generator@6a {
 		compatible = "idt,5p49v5923";
 		reg = <0x6a>;
@@ -282,11 +246,6 @@
 		power-source = <1800>;
 	};
 
-	sound_clk_pins: sound_clk {
-		groups = "audio_clk_a_a";
-		function = "audio_clk";
-	};
-
 	usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
@@ -310,28 +269,6 @@
 	};
 };
 
-&rcar_sound {
-	pinctrl-0 = <&sound_clk_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-
-	/* Single DAI */
-	#sound-dai-cells = <0>;
-
-	rsnd_port: port {
-		rsnd_endpoint: endpoint {
-			remote-endpoint = <&dw_hdmi0_snd_in>;
-
-			dai-format = "i2s";
-			bitclock-master = <&rsnd_endpoint>;
-			frame-master = <&rsnd_endpoint>;
-
-			playback = <&ssi2>;
-		};
-	};
-};
-
 &rwdt {
 	timeout-sec = <60>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/renesas/hihope-rev2.dtsi b/arch/arm64/boot/dts/renesas/hihope-rev2.dtsi
new file mode 100644
index 000000000000..8e2db1d6ca81
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/hihope-rev2.dtsi
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2[MN] main board Rev.2.0 common
+ * parts
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include "hihope-common.dtsi"
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+
+		bt_active_led {
+			label = "blue:bt";
+			gpios = <&gpio7  0 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "hci0-power";
+			default-state = "off";
+		};
+
+		wlan_active_led {
+			label = "yellow:wlan";
+			gpios = <&gpio7  1 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tx";
+			default-state = "off";
+		};
+	};
+
+	wlan_en_reg: regulator-wlan_en {
+		compatible = "regulator-fixed";
+		regulator-name = "wlan-en-regulator";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		startup-delay-us = <70000>;
+
+		gpio = <&gpio_expander 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&hscif0 {
+	bluetooth {
+		compatible = "ti,wl1837-st";
+		enable-gpios = <&gpio_expander 2 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&i2c4 {
+	gpio_expander: gpio@20 {
+		compatible = "onnn,pca9654";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
+
+&pfc {
+	sound_clk_pins: sound_clk {
+		groups = "audio_clk_a_a";
+		function = "audio_clk";
+	};
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_clk_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	/* Single DAI */
+	#sound-dai-cells = <0>;
+
+	rsnd_port: port {
+		rsnd_endpoint: endpoint {
+			remote-endpoint = <&dw_hdmi0_snd_in>;
+
+			dai-format = "i2s";
+			bitclock-master = <&rsnd_endpoint>;
+			frame-master = <&rsnd_endpoint>;
+
+			playback = <&ssi2>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
index 276f449ad14e..bb18f6ee2048 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 #include "r8a774a1.dtsi"
-#include "hihope-common.dtsi"
+#include "hihope-rev2.dtsi"
 
 / {
 	model = "HopeRun HiHope RZ/G2M main board (Rev.2.0) based on r8a774a1";
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
index eb1206b2d97a..c69ca5cf6f77 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2.dts
@@ -7,7 +7,7 @@
 
 /dts-v1/;
 #include "r8a774b1.dtsi"
-#include "hihope-common.dtsi"
+#include "hihope-rev2.dtsi"
 
 / {
 	model = "HopeRun HiHope RZ/G2N main board (Rev.2.0) based on r8a774b1";
-- 
2.17.1


--xm5oi6VVnIElHeaFpiZf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5142): https://lists.cip-project.org/g/cip-dev/message=
/5142
Mute This Topic: https://lists.cip-project.org/mt/76290771/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xm5oi6VVnIElHeaFpiZf--
