Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D7AC4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:51 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web10.18474.1713526790056362822
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:39:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=FDbW/rcH;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.172, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so26380861fa.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526788; x=1714131588; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0nlrfxotDpFG/L+MwE4rqUWNkO4KHNQlNXxnwoPv7o=;
        b=FDbW/rcHxlYA0kWYmT5zw7v4OO1awXMSUM4plQnxkvbGH8o30RABNQRcm4fNCN/1Uh
         v1zUJJ19Xp0LwvWRohTds3lliVhpchqriDkKGstq3ycKNAM+f02rkftryHb63EhqITOJ
         rofdKwRHxytdx8kdLdcHz8PdmTb65MKgi31NnEreVaJxj5AyRBCm+8ihQo0BD7u07k6p
         PsvW7vdUu9z6Pj2XxsmYQlJ2Oir3JmSZsyIg1ftDffy6gKmsKN/3CMZXZxN9cryYa1sz
         irWU51/kR7UbF4eIEDRAKqlBfB9fPIxU6y6ZW5bW1rT7Kx23Q97bHb3NeT5QUZ1cvg00
         voIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526788; x=1714131588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0nlrfxotDpFG/L+MwE4rqUWNkO4KHNQlNXxnwoPv7o=;
        b=UK7cGLVE+BoWMo1gpd8PziyUjZGAbrqX7rCIipQq7GZSKU2VHa9XX4QkvHkHNVvn1r
         b1Z8xzWRPD6I+piDUSNFmFlR1G7OOsMvNEyVKzU3YSYhAzglo7Gp4RBDnAzITiYlOuJl
         I433q5AFfvdvZCGb/mC9dHQQppk5xX7ADpqevSarkaDG+3l456cAqYT4e6Mjt3AZhKnX
         vsvueyGci4r83wpTtbZkKqsyl5ZVBoY1T9aTQf/Ste3oLmcMyta/AnKy1cmNObDZY5jg
         Eb9+/SShpm1qiLgrLSinT3bKgBdawAiYfQAoaz2F9au6YpADJ+y1PIYNxdxLqcUOMA3n
         RMqA==
X-Gm-Message-State: AOJu0YwHVCWpMayx4hqYVLGoaOn0izsvoxukRgAqzwYpPMYgZRaFYUrK
	H+joM8ieokkuWutW/jLN68frmzDC6wunW4JLPQY85+eFfv6QpvDHXrq9ORAB2dU=
X-Google-Smtp-Source: AGHT+IEj0EGq1J+0WSGwIwY5ef9PCLe7VFhjRdp403wK9v9q3m2jGkzldQoGuLjxSgC0dVmYSh9+aw==
X-Received: by 2002:a2e:a7d5:0:b0:2da:736d:3cf5 with SMTP id x21-20020a2ea7d5000000b002da736d3cf5mr1737863ljp.41.1713526788196;
        Fri, 19 Apr 2024 04:39:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:39:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 42/44] arm64: dts: renesas: rzg3s-smarc-som: Enable SDHI2
Date: Fri, 19 Apr 2024 14:38:40 +0300
Message-Id: <20240419113842.3675543-43-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15693

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


