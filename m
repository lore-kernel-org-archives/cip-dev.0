Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BF2C04FFF
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:19:08 +0000 (UTC)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
 by mx.groups.io with SMTP id smtpd.web11.15297.1713514744528017561
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:19:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=NslQCmZq;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso230280e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514743; x=1714119543; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JhGnexjjrSUz4tSsD3nUG33MJNdufwhBsCqIhPflCFw=;
        b=NslQCmZqhSmz/TqLGX9Dser6AIzykDzS6+GHKCRnap5JP0FFuFOFw0mjJ27FnQLM2J
         eV7XT8lUUcJVZLWznwc2a8f+avJFvV/VkdmsXze3BlmnGVe+a0ycQtwSogSZmmWZRimi
         1tkAYqCHG4Yu/RxvxOiQo0biHgrE0MTqBCjq7xi5sUtWnF6T9IThct2+kGaf0MuAgCHj
         24iRHk9pcmJU9NzPGXqaP53JKBi5lLFxHvhfpFD5qaaXoR3BxeqsikjJKOdZ7ldhCZGN
         gtdZPYV37Yy/lx0r0ZfdJSz9/BMjyfhgxb7EiB6pCJI8jHzHOU+ujjCcBPbwKD1jXlFo
         PA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514743; x=1714119543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JhGnexjjrSUz4tSsD3nUG33MJNdufwhBsCqIhPflCFw=;
        b=kX05YH8ufm1pfU7xpLOjXrunTVijEzKwY1WgHqnPLFAxmmxqU6C3fi60ftuEoQiQFD
         WQzjEmFrO+uXRxp4REnFWfuPNHWFh2L4CuXSBD7ETRkEOAyUuQLn6QhA9ym+qyeR9pC0
         mIY9aIv2vC5dBvlQ5XpUM20pgsl04Kjf6pNAn8l9kZRg32tD70wVFcP8NQVI2MfykmWv
         ww1bRiQdZ1mNSuXE+ttM9bG0ZhiZqQYmq28e0Xk4kNIWF63CQ0blPN1e9D0P+wcJT8x2
         ajJwC1z6iGsoD3smbJx7q23cBOcfNV3mLD4xFw/C4WCchyKD5o0ncPgDnzD63AQGP2d7
         yQlQ==
X-Gm-Message-State: AOJu0Yz9yP1wTsRGqfYaI/9xN7dxe0DlRsVkDfbR+kt+xicUShtsxrVn
	YA4zz4QideuFmginCgqY7UpmEpZOQOAc2Dzs3UXk4s5HAuSxe4hW+nB1Bk+rono=
X-Google-Smtp-Source: AGHT+IEJ4S20cWWjccob34CfQ4rLIycZ+J955NV7T8pNBjcvUt9dCPzkx4cyrbAsGM2PtYPvZz7LbA==
X-Received: by 2002:a05:6512:10c6:b0:51a:c44d:b95f with SMTP id k6-20020a05651210c600b0051ac44db95fmr634567lfg.28.1713514742687;
        Fri, 19 Apr 2024 01:19:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:19:02 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 52/53] arm64: dts: renesas: rzg3s-smarc: Enable SDHI1
Date: Fri, 19 Apr 2024 11:17:41 +0300
Message-Id: <20240419081742.3496709-53-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:19:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15639

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 993a207c114e137159c8d255576badfcd9defba8 upstream.

Add SDHI1 to RZ/G3S Smarc Carrier-II board. This is connected to a uSD
interface. Although Vccq doesn't cross the boundary of SoM it has
been added to RZ/G3S Smarc Carrier-II dtsi to have all the bits related to
SDHI1 in a single place. At the moment SoM is used only with RZ/G3S Smarc
Carrier-II board.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231016105344.294096-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 65 ++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index e7073a09ed2e..214520137230 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -11,6 +11,26 @@
 / {
 	aliases {
 		serial0 = &scif0;
+		mmc1 = &sdhi1;
+	};
+
+	vcc_sdhi1: regulator-vcc-sdhi1 {
+		compatible = "regulator-fixed";
+		regulator-name = "SDHI1 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(2, 3) GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi1: regulator-vccq-sdhi1 {
+		compatible = "regulator-gpio";
+		regulator-name = "SDHI1 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+		gpios = <&pinctrl RZG2L_GPIO(4, 2) GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1>, <1800000 0>;
 	};
 };
 
@@ -19,6 +39,38 @@ scif0_pins: scif0 {
 		pinmux = <RZG2L_PORT_PINMUX(6, 3, 1)>, /* RXD */
 			 <RZG2L_PORT_PINMUX(6, 4, 1)>; /* TXD */
 	};
+
+	sdhi1_pins: sd1 {
+		data {
+			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
+			power-source = <3300>;
+		};
+
+		ctrl {
+			pins = "SD1_CLK", "SD1_CMD";
+			power-source = <3300>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
+		};
+	};
+
+	sdhi1_pins_uhs: sd1-uhs {
+		data {
+			pins = "SD1_DATA0", "SD1_DATA1", "SD1_DATA2", "SD1_DATA3";
+			power-source = <1800>;
+		};
+
+		ctrl {
+			pins = "SD1_CLK", "SD1_CMD";
+			power-source = <1800>;
+		};
+
+		cd {
+			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
+		};
+	};
 };
 
 &scif0 {
@@ -26,3 +78,16 @@ &scif0 {
 	pinctrl-0 = <&scif0_pins>;
 	status = "okay";
 };
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-1 = <&sdhi1_pins_uhs>;
+	pinctrl-names = "default", "state_uhs";
+	vmmc-supply = <&vcc_sdhi1>;
+	vqmmc-supply = <&vccq_sdhi1>;
+	bus-width = <4>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	max-frequency = <125000000>;
+	status = "okay";
+};
-- 
2.39.2


