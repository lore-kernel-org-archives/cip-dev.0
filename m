Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22F7C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:53 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web10.10343.1746783166571212609
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fXRo2v97;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5fbdf6973e7so2410227a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783165; x=1747387965; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8XdQwccjEmY3OdV99PVo5FOn6Y/j7vPp1Kwv3DZjS0=;
        b=fXRo2v97v3m8l6/0GFHWWY6aLNLmErEIvzu4E3R5x5ZlM0NJJuMFLPnVGQkanjZss7
         oRydjafSjLwHwYuttJG0yIQ7907JQbYkxObEJSikvsojgL+8CliZl/y3ynICE46+2n60
         tDur3SU9APL+9wAydapYk76uZkg4bn2U+r/u1ns4VkgoQohZfJkaFc97/cNGcg6GO2MR
         CoKR+PYULRzIIaKGRCOOiCAtIJISQLcon/LTdb+h5riOpyNWNGhCTGco9yxA0E8ugiR0
         dAD4ZrAAmrSszZ3FBe12oB+H8KllCnF0PC/MPVNAa2E5IkieiNt0sqOmrcvA09xAH+T3
         zpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783165; x=1747387965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8XdQwccjEmY3OdV99PVo5FOn6Y/j7vPp1Kwv3DZjS0=;
        b=pNkQKjynqo0ijRCjRBcxYi62swWFYxgZMoUyDF/5QXXTvmcUmpnKMHA9Tzy8aZWw6Z
         5X+xm2H8VX3lS/AYRwB2Rfh1tiBchnkh1uO/W6LgjPFJWNLM4ZH4jIOuSNZ+vFV0KqNL
         t6Ww5r31RxxxXTqetAAvlLNLcMVmHghxUZ7F0CWe1GByJwkmY9J+NAZ1Gwruc9e4dTJN
         5s1OA+4Bax7kRYfl3eJV8SlvZdny5PXcxrZ/4AjLCtY45ubSYBpKlxV0W7q+bR9OZmn0
         +mSfU01D7YcG0sz+23dkbotzE/qG24pxwEqIt4qAuQWfWWGto3w4XS0n2uvZdq3xb79w
         BWIA==
X-Forwarded-Encrypted: i=1; AJvYcCXQUL9LJlSrPF0B+o1uLm06Bs1S4kR+fAfBQOYyIHTinJ4U2nW5nlnLGM/2DekHydSJXJKIS/id@lists.cip-project.org
X-Gm-Message-State: AOJu0YycHez4h5TmXlXKhoQNwOdf3dTNbgyH1GrUYSipEHzjImgSOMTj
	IWsMgVfmCAXxWEl1+nd2Pw3oM+WtbimyuVGriJQT+3MAYrYTTQ3yS9eWiYWu7Go=
X-Gm-Gg: ASbGncsoEvgAQ2ozai3bJz7L8K7IuOmDhvXFaMJOXaZIYrLR59E7fWF+maJ1VeRWimy
	VPdY109AweSZeTjmCpVIQUDwJ6w0lIHDEzD8pa5TgOz3E2HeKcjKSfWE7/PlVyFfqgbTtkXW9aW
	goZNXf8A4zbM49SJquGEBSfrCEoIZ981Lroisox5dfZh9D/DsFATNd/tSXp7HUkfSfSttPUWXqw
	iZmwRA2v22FbfjyHTncQT1re6109c9ppY3vYm0SoRGI53LuR8LRr3VjLP50h2uTSxmkI0P+z/P8
	xjoRNebUA3nKgikeIhv9RqGm4lZD21k/bYlgkiOkhW6tG79jrbR5kSaA8OvkA0pgajLw5g==
X-Google-Smtp-Source: AGHT+IFzKCX02YvKq36r3i20esdi1I21GfB1dsnvkATWkYGPd11q6Fr8JQghHpqg3uFatdbp1V189g==
X-Received: by 2002:a05:6402:5201:b0:5f3:81a0:c3d7 with SMTP id 4fb4d7f45d1cf-5fca07eda79mr2176938a12.22.1746783164960;
        Fri, 09 May 2025 02:32:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 27/29] arm64: dts: renesas: Add da7212 audio codec node
Date: Fri,  9 May 2025 12:32:01 +0300
Message-ID: <20250509093203.4014750-28-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18814

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c3de00ac31f76b8e3af9f7a85c2da29c1b72babf upstream.

Add the da7212 audio codec node. Along with it regulators nodes were
reworked to be able to re-use them on da7212.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-23-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 17 ++++++++++-----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 21 +++++++++++++++++++
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index cfbee7f0b4a3..7ae319d941ac 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -58,7 +58,6 @@ vcc_sdhi0: regulator0 {
 		enable-active-high;
 	};
 
-#if SW_CONFIG2 == SW_ON
 	vccq_sdhi0: regulator1 {
 		compatible = "regulator-gpio";
 		regulator-name = "SDHI0 VccQ";
@@ -68,8 +67,8 @@ vccq_sdhi0: regulator1 {
 		gpios-states = <1>;
 		states = <3300000 1>, <1800000 0>;
 	};
-#else
-	reg_1p8v: regulator1 {
+
+	reg_1p8v: regulator2 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
 		regulator-min-microvolt = <1800000>;
@@ -77,9 +76,17 @@ reg_1p8v: regulator1 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
-#endif
 
-	vcc_sdhi2: regulator2 {
+	reg_3p3v: regulator3 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_sdhi2: regulator4 {
 		compatible = "regulator-fixed";
 		regulator-name = "SDHI2 Vcc";
 		regulator-min-microvolt = <3300000>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index af2ab1629104..154a360c4527 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -76,6 +76,27 @@ &i2c0 {
 	status = "okay";
 
 	clock-frequency = <1000000>;
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
 
 &pinctrl {
-- 
2.43.0


