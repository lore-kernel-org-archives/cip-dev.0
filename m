Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC40C5516F
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:26 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2463.1785575715256713045
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=LQWJmjIl;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so5229705e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575713; x=1786180513; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNcYytwFcl27Wx63udt4MZVY0qj9udIZB0+4Q7Ekeso=;
        b=LQWJmjIlg9Qs9V34DmaQzm1QauGKhgH7l7bgyreGrHVfMOjApr3nk2bXper2ePCnsk
         ZZUOeGFzUqve2mH9R4bkPemq6Z7euEY8x89FGYtszwPyWh+RfJfIBtnsclquYVOzmIc0
         bLxQl5Zzhz/OQ0CYwD6N13d9DDqjftiYbqyP25OfslkrmT+xjVaz06d76Eb0Lyp5zpm+
         ewb1Y5kNvELgXaGt2/sCqYpjGSPyMUZkRBRbIaRWrEtofw28J+Sc+IL6iVHcuen8wj4f
         i+57cYsXTEIM9v7RoNI9cbHV1szqPS7UsWiu+kBMMtJD+NTNtjcfTcj+spwYf3MZN8KX
         FVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575713; x=1786180513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNcYytwFcl27Wx63udt4MZVY0qj9udIZB0+4Q7Ekeso=;
        b=oY3Nuxxmo5oHU1DTtxkbbTIS2ZSwElqwQ5R2FGrl/qxOfYE9NX7p7n3lUTMutWhZ/c
         GsoDyKfznS8khOdh6j3HeoNdY13ZBzUCeQiuAwxj10WVLVi+e8ozMdism4B4QD1Hn6aI
         jRCu6UM/ojL9uoGBzeUYwwOu4gUpd7SWWBZhv98p/CC9muGqIASFgW54/RtONTayCoSS
         f7GGu3D5/xEw2REaPK/5mxbHOQYDOMIJ3Z/eKbOpnC9jcMZBcKAFCLJyg5wDyayVBvnv
         Wb4f9zR7kqPm+qx6+U3M4qS13QwIYMwoCEmgzhPHkFFS3u41xIJbci9JdDmArumqY1ou
         qXvA==
X-Gm-Message-State: AOJu0YyIrq6qTsfwgezca81uSJqdXOOaAKNTgAC8tPA822lGqCdhILmI
	5yB8sU52tacMKkqmZCJBszavTlBMtss50qqSJapmvmsTRcimGNVfhEJIlavGkg==
X-Gm-Gg: AR+sD13dqcLYtZBJFBfePUzmpSrQdYXNwzEVy0H1hGJ/TpzwQq/wkcz2lNN/GdPrQ4t
	zv90bgaunPGwXon7wg5pPpsX+WfznbS/DKC2At+YKUpZXeGH+/vxeXcJoVlYCg72JPxohmgD7nC
	Dvy19ymX1kaWT2V/oBS4G77/AuozigHVWQKpIo4i46v/+jFB+6ls3qbVsp6D2qBA0kxqVpNWwJI
	Z6E+ixvZ/5d3EeAcYSvB6uJE7bvCZ0SiWJqf0XF7dVEZKLYXPuXG+Tl4U5i+h97edtKPkziLmLV
	/Y2YodeMpYwa5JtLvPgXpKuIGla8gmqb9BvHBGu8IbxL4i4fn9iKPIvDgIKiSmcEfw1ST00ahhU
	ByPSy8EylotRQHYLRRlri7v/AtXsfdpRnZSaRPpO94/a2Xtvb7hE7mKAVOqznFQPWVVmAsNvHAR
	0rvXJq2Y9eZlPuHq1qPsK0UfDOVSpRppTxJHwGpEc/YS1Wc38+HiggsqyR945SQ/rq02MdIjOVP
	zKUcYpS3hsEng==
X-Received: by 2002:a05:600c:19cf:b0:495:7a04:b006 with SMTP id 5b1f17b1804b1-4980c66b572mr28408115e9.8.1785575713404;
        Sat, 01 Aug 2026 02:15:13 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:12 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 17/19] arm64: dts: renesas: r9a08g046l48-smarc: Enable audio
Date: Sat,  1 Aug 2026 10:14:48 +0100
Message-ID: <20260801091458.14026-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23844

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 0d4ed954061efc3e47fa889d3de0675f933f438f ]

Enable audio on the RZ/G3L SMARC EVK by linking SSI0 with the DA7212
audio CODEC.  The SSI0 signals are multiplexed with SD2 and are selected
by switch SW_SD2_EN#.  Add regulator nodes regulator-{1p8v,3p3v} to the
SoM DTSI for reuse by eMMC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260528074615.91110-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 72 +++++++++++++++++++
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 22 ++++++
 2 files changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
index 1512b7df39bd..32d3b08a3cf3 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -9,6 +9,7 @@
 
 /* Switch selection settings */
 #define RZ_BOOT_MODE3		1
+#define SW_SD2_EN		0
 #define SW_DPI_EN		0
 #define SW_GPIO4		1
 #define SW_I3C_EN		0
@@ -38,6 +39,32 @@ aliases {
 		i2c3 = &i2c3;
 		serial3 = &scif0;
 	};
+
+#if !SW_SD2_EN && !SW_I3C_EN
+	snd_rzg3l: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "snd_rzg3l";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ssi_link_play: simple-audio-card,dai-link@0 {
+			reg = <0>;
+			format = "i2s";
+			bitclock-master = <&cpu_dai>;
+			frame-master = <&cpu_dai>;
+			mclk-fs = <256>;
+
+			cpu_dai: cpu {
+				sound-dai = <&ssi0>;
+			};
+
+			codec_dai: codec {
+				sound-dai = <&da7212>;
+				clocks = <&versa3 1>;
+			};
+		};
+	};
+#endif
 };
 
 &i2c2 {
@@ -53,6 +80,27 @@ &i2c3 {
 	pinctrl-names = "default";
 
 	status = "okay";
+
+	da7212: codec@1a {
+		compatible = "dlg,da7212";
+		reg = <0x1a>;
+
+		clocks = <&versa3 1>;
+		clock-names = "mclk";
+
+		#sound-dai-cells = <0>;
+
+		dlg,micbias1-lvl = <2500>;
+		dlg,micbias2-lvl = <2500>;
+		dlg,dmic-data-sel = "lrise_rfall";
+		dlg,dmic-samplephase = "between_clkedge";
+		dlg,dmic-clkrate = <3000000>;
+
+		VDDA-supply = <&reg_1p8v>;
+		VDDSP-supply = <&reg_3p3v>;
+		VDDMIC-supply = <&reg_3p3v>;
+		VDDIO-supply = <&reg_1p8v>;
+	};
 };
 #endif
 
@@ -71,6 +119,11 @@ &keys {
 };
 
 &pinctrl {
+	audio_clk_pins: audio-clock {
+		pinmux = <RZG3L_PORT_PINMUX(H, 4, 6)>, /* AUDIO_CLK_B */
+			 <RZG3L_PORT_PINMUX(H, 5, 6)>; /* AUDIO_CLK_C */
+	};
+
 	i2c2_pins: i2c2 {
 		pinmux = <RZG3L_PORT_PINMUX(A, 4, 4)>, /* RIIC2_SCL */
 			 <RZG3L_PORT_PINMUX(A, 5, 4)>; /* RIIC2_SDA */
@@ -85,9 +138,28 @@ scif0_pins: scif0 {
 		pins = "SCIF0_TXD", "SCIF0_RXD";
 		power-source = <1800>;
 	};
+
+	ssi0_pins: ssi0 {
+		pinmux = <RZG3L_PORT_PINMUX(H, 0, 9)>, /* SSIF0_RXD */
+			 <RZG3L_PORT_PINMUX(H, 1, 9)>, /* SSIF0_BCK */
+			 <RZG3L_PORT_PINMUX(H, 2, 9)>, /* SSIF0_RCK */
+			 <RZG3L_PORT_PINMUX(H, 3, 9)>; /* SSIF0_TXD */
+	};
 };
 
 &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
 };
+
+#if !SW_SD2_EN
+&ssi0 {
+	clocks = <&cpg CPG_MOD R9A08G046_SSI0_PCLK2>,
+		 <&cpg CPG_MOD R9A08G046_SSI0_PCLK_SFR>,
+		 <&versa3 2>, <&versa3 3>;
+	pinctrl-0 = <&audio_clk_pins>, <&ssi0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#endif
diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index 5e58e08e7fad..091a227233cb 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -13,6 +13,10 @@
  *      0 - SMARC_I2C_GP is enabled
  *      1 - I3C is enabled
  *
+ * Switch position SYS.4, Macro SW_SD2_EN:
+ *      0 - Select I2S0
+ *      1 - Select SD2
+ *
  * Switch position SYS.5, Macro SW_DPI_EN:
  *      0 - Select multiple SMARC signals active
  *      1 - Select LCD
@@ -41,6 +45,24 @@ memory@48000000 {
 		reg = <0x0 0x48000000 0x0 0x78000000>;
 	};
 
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	x2_clk: x2-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.43.0


