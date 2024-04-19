Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BFFC05052
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:19:08 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
 by mx.groups.io with SMTP id smtpd.web10.15328.1713514742955740319
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:19:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=O43N6V8U;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5557e3ebcaso290943666b.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514741; x=1714119541; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0nlrfxotDpFG/L+MwE4rqUWNkO4KHNQlNXxnwoPv7o=;
        b=O43N6V8UY1LlEuL+bC0Sxa/JXIkl1W4WTqxhE3ARusOW5qM5wpa1Lj/HDu76yYiFbw
         OWLA+SL7uSKnO6DyMY4bmThzkJgg8IeBhE4pbeEHf5PAyLmv/y1+gmyt6o+/bWm8BXPx
         hb51F3jDCg6QY/Lxe3Mc196W8up8UtEN0sgTJEcWePjhXdfI+3dF1TFXaA+m51tb8QXh
         jR1IwHKrizA78V2V/YTwx2+t3Etp+bPheHl3jJhkSqTqBBGF4CT0h0REs6/zMiB0k58x
         4eXcvxL3VMJo9DTUPbEyolkQAq6kJTXSphE6Mcy6U397Zx0gO6dUCNUg55nDsU3VkbuP
         B+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514741; x=1714119541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0nlrfxotDpFG/L+MwE4rqUWNkO4KHNQlNXxnwoPv7o=;
        b=TbHvth9OR1GZI1F+1y8zKpV2w3QchZgc0+sMiUPxuD3r5WWiSOanzHXzsQzGJmYXhx
         ofbGsh2si17SqXmqwxeX932G3Dj/V4VHkxAqJqmZkRA0GAyslNPLWJF1ce/Wsxo/1KMv
         25BIGuu/obX5Y6PPwFk1R0khFMPylPUZva0UhqoNH5rL7llcLZNZAvtRP+VIvGPdyTWl
         HQSGXSyK1znFn4J3OuDaz2C1tCwzlz1TiUhoOfd7c2PM84AGjBtB06gsBsJ3bhyQWGMq
         mldv9hyzm7VlXo6EHZ9IW+SwxTqNMPPfJ7+C+Tt6LZJdW3iwfG07curm4BTOBqQkEMnT
         gZsw==
X-Gm-Message-State: AOJu0Yx/sdWmHjOwf00JRKdjVfr7skVVjiOVxx5k3shjcG4KIBlBfuzi
	/U8iYj1BDPFv2vrPXY7ezQvm76NtOEK/UtAPAHAJ+Ah1Ypbl44hbowLBX6PeZL4=
X-Google-Smtp-Source: AGHT+IFibLJ8wLF/F/dyAumZ6T0MnHcCt8MDe1+K3h9muiuDln/KXwHFICJcow0IgUHHsE2JpTEbbw==
X-Received: by 2002:a17:906:c141:b0:a55:7614:fa44 with SMTP id dp1-20020a170906c14100b00a557614fa44mr4142616ejc.3.1713514741383;
        Fri, 19 Apr 2024 01:19:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:19:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 51/53] arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
Date: Fri, 19 Apr 2024 11:17:40 +0300
Message-Id: <20240419081742.3496709-52-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15638

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 00cbba479142a3c962a44b127db4ab6cdc2b2b70 upstream.

Add SDHI2 to RZ/G3S Smarc SoM.  SDHI2 pins are multiplexed with SCIF1,
SSI0, IRQ0, IRQ1.  The selection b/w SDHI2 and SCIF1, SSI0, IRQ0, IRQ1
is done with a switch button.  To be able to select b/w these a
compilation flag has been added (SW_SD2_EN) at the moment being
instantiated to select SDHI2.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231016105344.294096-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index a199de8f8b02..01a4a9da7afc 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -13,14 +13,21 @@
  * @SW_SD0_DEV_SEL:
  *	0 - SD0 is connected to eMMC
  *	1 - SD0 is connected to uSD0 card
+ * @SW_SD2_EN:
+ *	0 - SCIF1, SSI0, IRQ0, IRQ1 connected to SoC
+ *	1 - SD2 is connected to SoC
  */
 #define SW_SD0_DEV_SEL	1
+#define SW_SD2_EN	1
 
 / {
 	compatible = "renesas,rzg3s-smarcm", "renesas,r9a08g045s33", "renesas,r9a08g045";
 
 	aliases {
 		mmc0 = &sdhi0;
+#if SW_SD2_EN
+		mmc2 = &sdhi2;
+#endif
 	};
 
 	chosen {
@@ -63,6 +70,15 @@ reg_1p8v: regulator1 {
 		regulator-always-on;
 	};
 #endif
+
+	vcc_sdhi2: regulator2 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(8, 1) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
 };
 
 &extal_clk {
@@ -100,6 +116,17 @@ &sdhi0 {
 };
 #endif
 
+#if SW_SD2_EN
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+	vmmc-supply = <&vcc_sdhi2>;
+	bus-width = <4>;
+	max-frequency = <50000000>;
+	status = "okay";
+};
+#endif
+
 &pinctrl {
 	sdhi0_pins: sd0 {
 		data {
@@ -139,4 +166,26 @@ sdhi0_emmc_pins: sd0-emmc {
 		       "SD0_CLK", "SD0_CMD", "SD0_RST#";
 		power-source = <1800>;
 	};
+
+	sdhi2_pins: sd2 {
+		data {
+			pins = "P11_2", "P11_3", "P12_0", "P12_1";
+			input-enable;
+		};
+
+		ctrl {
+			pins = "P11_1";
+			input-enable;
+		};
+
+		mux {
+			pinmux = <RZG2L_PORT_PINMUX(11, 0, 8)>, /* SD2_CLK */
+				 <RZG2L_PORT_PINMUX(11, 1, 8)>, /* SD2_CMD */
+				 <RZG2L_PORT_PINMUX(11, 2, 8)>, /* SD2_DATA0 */
+				 <RZG2L_PORT_PINMUX(11, 3, 8)>, /* SD2_DATA1 */
+				 <RZG2L_PORT_PINMUX(12, 0, 8)>, /* SD2_DATA2 */
+				 <RZG2L_PORT_PINMUX(12, 1, 8)>, /* SD2_DATA3 */
+				 <RZG2L_PORT_PINMUX(14, 1, 7)>; /* SD2_CD# */
+		};
+	};
 };
-- 
2.39.2


