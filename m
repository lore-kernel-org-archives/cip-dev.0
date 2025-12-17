Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1840D6554D
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:35 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11774.1765967553277969105
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HkYCeKYx;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7cee045187so82723066b.0
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967552; x=1766572352; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCrbZ4Ua4zv3UBgXJD9JjFfC1WmrpN40VT3m+rc4xOQ=;
        b=HkYCeKYxlG8W172YA81ZMuPSUWa7zWgWSq0tga7eLE02QMSEnAj+tKKahC6vLRDJjp
         FxYfhZu6C6mMuc7OXShlqbGteztS6o8WLXg/it8Hv2IisBHN+oML5hu98zXgULFNGkPZ
         HwRpD4+wmRn8Qg2rBOWDjI0KvxZp0wVnfasCZzRZsW/EAGprhSI9XDtdBPsUeni6V/fW
         6zKgen5WjQVITv048hntJ3RGn746SISAQUzqgOyNssT5yR2/9mtBY9v5UWSYHny5Vv74
         H5ODLulZPDnMRnssBTykQXOnWZ27ujtnSwVmbsMLlYYlAXoPcDyRZQbsRh7A9CdHIabI
         Vf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967552; x=1766572352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gCrbZ4Ua4zv3UBgXJD9JjFfC1WmrpN40VT3m+rc4xOQ=;
        b=Kj6x9D2zNJVff1/FqZQBEOHPuTjiOnmmBVFc+0quJUf9V3DUegGFTbj6cO2t7khiC1
         MbNAaf58X3v+pkT5AA7ZgPCpVdGNGTQlUPotIz9j3ZViSRpE5xk3kopy8mint3dYQEDM
         UsC20h8w7teiZkn9ShyG7YMo5h45I+z8HixLyYVLgLxkN5L1xxgHbrONtzfVvaPoFKH/
         H70C5fPPojFY5WtCIMw6ReTfeS3BBR5zytsOEAm9v8efRzuc5YiwKxbVBoJMVxWJhRRu
         ia6SjfyO+Xz7eY7MLRI1Kg34wIz5LIkc4vsWSiYxHccQU/2/yZGjNDjnuq78Krq6y9eH
         tzHA==
X-Forwarded-Encrypted: i=1; AJvYcCVW6ny71q0ZPj2Xincs0kVW1HgUkwz3kJ7V01W0qXnaHDgukFdnhOMi6gTk+Fhz4JUtbhiqP7Jg@lists.cip-project.org
X-Gm-Message-State: AOJu0YwIdntGaGepg20dLSiyctz8t5JSQjbmZN9xS+0WzX8vumf6DY5g
	IXSRYxjNYCjeOrt6WcSg/d7A15Him4CCch7qi1Yx6hAiFMqm4bF5jrivyA36h1Hhj2g=
X-Gm-Gg: AY/fxX7BJjK5ykCqYfnGHgx37Bk+BQLPDXVwsXtuLjE7V3tvaiDSbHvIXKN4RYs/a7/
	UwdeP3s2kA6psKO6QYYiukKWVlq3NdjLKiQN9aOUVibThXTFFbnj+onsB5ys8OdDaKSG74DyRzT
	rx97Sb+rhIdmiRAB7HWphr/Q7w58FVsXizaaDpbAWL3o1MTTaiOp6H2TPhtH4xoiXzzoZ9eUz1z
	PBdwBFRXjUO2foWC7UeDGoG/14HTeoFn1Gv4FaYCB0KMZgF+2Ivxfr0B5+em5kMPOQYdGklaMVH
	hJ0E9Gfxqmlrkw0IfdsRbwfcQczM2O8rBId5WYgV/d/hMmHbkRczKr0bx69hCNFi56q8QIFq+jx
	fw0CK8hrXhZfqymQiwfoNL9xcFCRnmHf8QR9+U6ZBB/rM0VnBOg/OvNR1nxFeTCL41irzd7W4mJ
	z8aNk3Lc8OxOTAzK/V/Oy7aSa5YXLI7ea/BHqe3jYZ
X-Google-Smtp-Source: AGHT+IFwiYkRCMETn0L1aGSQwMvADQXiw+r1T14tQAi2/NX5hO9v2jEpufClPYAJJVAdElDUAkP3JQ==
X-Received: by 2002:a17:907:3fa5:b0:b79:ff60:8205 with SMTP id a640c23a62f3a-b7d217ed002mr2105881966b.19.1765967551611;
        Wed, 17 Dec 2025 02:32:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e6edesm1955414166b.18.2025.12.17.02.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:29 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 5/6] arm64: dts: renesas: r9a08g045: Add TSU node
Date: Wed, 17 Dec 2025 12:32:21 +0200
Message-ID: <20251217103222.4183089-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21118

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ee9bfab464247edd9a3f0f65e7ed96053e4b1095 upstream.

Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
The temperature reported by the TSU can only be read through channel 8 of
the ADC. Therefore, enable the ADC by default.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250810122125.792966-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict around the i3c node as this is not yet in
 v6.12 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 49 ++++++++++++++++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  4 --
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 0364f89776e6..3f56fff7d9b0 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
@@ -233,7 +233,6 @@ adc: adc@10058000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			status = "disabled";
 
 			channel@0 {
 				reg = <0>;
@@ -272,6 +271,17 @@ channel@8 {
 			};
 		};
 
+		tsu: thermal@10059000 {
+			compatible = "renesas,r9a08g045-tsu";
+			reg = <0 0x10059000 0 0x1000>;
+			clocks = <&cpg CPG_MOD R9A08G045_TSU_PCLK>;
+			resets = <&cpg R9A08G045_TSU_PRESETN>;
+			power-domains = <&cpg>;
+			#thermal-sensor-cells = <0>;
+			io-channels = <&adc 8>;
+			io-channel-names = "tsu";
+		};
+
 		vbattb: clock-controller@1005c000 {
 			compatible = "renesas,r9a08g045-vbattb";
 			reg = <0 0x1005c000 0 0x1000>;
@@ -717,6 +727,43 @@ timer {
 				  "hyp-virt";
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&tsu>;
+			sustainable-power = <423>;
+
+			cooling-maps {
+				map0 {
+					trip = <&cpu_alert0>;
+					cooling-device = <&cpu0 0 2>;
+					contribution = <1024>;
+				};
+			};
+
+			trips {
+				cpu_crit: cpu-critical {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+
+				cpu_alert1: trip-point1 {
+					temperature = <90000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				cpu_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+			};
+		};
+	};
+
 	vbattb_xtal: vbattb-xtal {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..6f25ab617982 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -84,10 +84,6 @@ x3_clk: x3-clock {
 	};
 };
 
-&adc {
-	status = "okay";
-};
-
 #if SW_CONFIG3 == SW_ON
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
-- 
2.43.0


