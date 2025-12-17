Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BA5D65538
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:15 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11306.1765967527011823219
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=QNMj60Ku;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6492e7891d2so7552304a12.2
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967525; x=1766572325; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTeWoEwqzQuY+J7y7Bdy+Hp+XQUw0wstVWpokrSyaJY=;
        b=QNMj60KucHePQoqti4PXbLaL8p0otgVaZ+galI1AhiocqA6jRZjEgokKqQcHH8kWuM
         7Dg2R6ibQuQM0BVwzdqQuQHB7VDGuXewB97uwYn4NTmsveZLctSUn7JAWhRX1IwSbp6z
         Ihfp0cdcYv6xaeUBdAIxKv/UKl/t5wcxOFB4tZi0w5p6qY5+cETWPSKR6xPe7UHLym+p
         YzKY0ZxWZEjzT09LCxVYHHAfuXAnFnJxzLDwunXwQkgBRQjlBSTtPN7/NC0prPh1UHoM
         YS4A16rq0yUnc+S0rtkxfEUvF1HlcvnGWyLf+op/iZ+LRbURd+LSbdun8yWc4iGg6Od2
         1U+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967525; x=1766572325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTeWoEwqzQuY+J7y7Bdy+Hp+XQUw0wstVWpokrSyaJY=;
        b=wG5aWfGPFecbLa9NN+/csiV3z1T6jTz9CDl6uwivoM2Eciv4mHcmMiLasccaK+glwn
         DOlQFr9jN1+d8S09Bdmz3wVX6kT6eqWdi2WGP0Tojf8t2QwcsICRD5Fl5KnB8jt4WLF6
         B3qmGe29p4NBFggKwJQCV1XaL6TQ18aVsnHsJfJFN2vIdHftY396dB3uZjlK5PI36HBi
         0rX8+OlNxTS97TKI3Kl+G2yAsTKHJ0N3EWGVqWcTYHA1p8TH438LdJN8oY/mxjBgEc2z
         9dOqEK9pcaTGRW+ee26j1KeLKlJDGmCzY9udBh3PBzOUyOQIGgTvzDemAQNLd/p8aa/U
         tYfw==
X-Forwarded-Encrypted: i=1; AJvYcCW5OySIKyQRLPuQ0h6/nPdrNg8YUFeRaDENQOh7DGyBB9g2N3z3AZS4rrHPjjIaiQVTjif9KemD@lists.cip-project.org
X-Gm-Message-State: AOJu0YyUV2TrDULwMcxwYXkoEPmzZT83CSQyv5OQ9cVoIQ2XZ0cJ+gF4
	m8DiTekDFbgt6uATpY7Jm2ntGHHx1tAs2kyqzM4dwfWRa0Xs6L8BI2spnPAnN2LfeuQ=
X-Gm-Gg: AY/fxX5ISlBFPHPEtxoD6gYB0fISVdjUax+gDvdgkxMrZUnRo2IP9GiDx3DlAOanHjX
	hzSXgyWNZLQchcfGxDDJxtVoIqpVT2BR0ualjntewT5j0ijMWOZqqvsrJrOvM28TJeNkiHTbH3n
	zt4Pld9Wh7ow9ixKR0LpJr12wxsIlngrfRnOvHRfj7S7yMgLFutN3hah+CBS0m+FYJxM62thiRO
	x6d5FsBrqetAD3DpJ39CcCZvsZ4TpmmIpOfktX1zQozBQIpYkBRJZLy0SEZ5k5nKURUFOLUDR6Q
	o0XyseHyOkElN11i+cX6DPrp7v01J4f0e2eKE/c2xO1zM/oQOtlhtVR5KdphvkNB10Yd5kTF1SE
	hi89pmNyTwM/A+1/ddEOshVBa3ZkaHJHXy8hQEBGwdOTs0Hp5aMnujSHqIji+1eQmpyjZz/ty95
	cav03k6UR1J8DVPtkTBfqxIrGqLbbaQMtfj9Av5KKA
X-Google-Smtp-Source: AGHT+IHqdmoRANxrplt/K6/8jUq/QA3moS8T81dfLbfoBAAxbJSCLhvjrYkf3pWYwKUYdeE/6YamWw==
X-Received: by 2002:a05:6402:1452:b0:649:2d0d:e258 with SMTP id 4fb4d7f45d1cf-6499b3277b5mr16271055a12.29.1765967525323;
        Wed, 17 Dec 2025 02:32:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b3f584800sm2050292a12.30.2025.12.17.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 6/7] arm64: dts: renesas: r9a08g045: Add TSU node
Date: Wed, 17 Dec 2025 12:31:47 +0200
Message-ID: <20251217103149.4182935-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103149.4182935-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21103

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
 v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 49 ++++++++++++++++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  4 --
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 69c9a7d24a20..e56f1bf311ec 100644
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
@@ -715,6 +725,43 @@ timer {
 				      <&gic GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
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
index 3d707c9c6e46..7c40532fc869 100644
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


