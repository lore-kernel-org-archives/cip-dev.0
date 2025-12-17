Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7DD65546
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:25 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11316.1765967541195199813
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dzBylroB;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-649728a2228so7522762a12.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967539; x=1766572339; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8By2cRPsKr47vEE3P+ljqib2v5rLskcRzPww1T/FuQ=;
        b=dzBylroB9Ecfr0v++dgTUDDhsln2vxzffPRKWqbex9rWFzHncc6w1q8/hesBfevrRO
         8Y3ry675VYLjCa5LzFck17XmaSylIFBfEaENqvmEjNovSuaGtn9OVkjhp4UNHIosFZcu
         oBRrrRJMVz0aJ4TtmhofwKW9gFqaFRpf2eRr2tkqngf6VwsgFno5Vf2MqE88V76Bf8BI
         Mxpah8jbL1lrMLlW+PHMF8xlU3CDxNdYeAjVBR2MySK0KJCX0xj0wRJcHHcq463oC+k3
         y1zg8cKqXVLeXTGum+kfBR+B/eNGnIQLpWqrkK6pq8b8jtiCbeRdAHyfW3/PDu0AbtgW
         1uRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967539; x=1766572339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W8By2cRPsKr47vEE3P+ljqib2v5rLskcRzPww1T/FuQ=;
        b=t/WEXfNwrtR8wxyHRTLNa5MRxwsNOq+W3k1ZzhwwtVVcuHtzie0u9ukko+0WDNKkLC
         I24Bc1sodxhikIaAXO+Ih0nwHtXqBIE4A4qNUD0CqJr+e5W8+QWP44pPNPL8bkyEya3T
         ZXeTXOwo61GcF2F4LVyGRL7qIygeZYvRuy7NckViJCKLA8OqUnzpV+pOIkUJuxT2Wckm
         XtTlVl2HMiPshTFkr3EOYnEi1FC2dlNzKJbwSMXpT6uPyOdL7rOe5NTWcqnc1Y7wxrrW
         5PxwDfFG4RbF/595oNEWGAKOTZxy8ICuINVSiPgZfR1Q+6rXLu3fUsX8qLIcsyAGoTkJ
         36Tw==
X-Forwarded-Encrypted: i=1; AJvYcCV58oUHwihJeXjwm8NT1DOVtWbnON+Ql8NNVBOqoG6V4bY1o7W56eXn3BmqJIsZJBn/3JAetsC/@lists.cip-project.org
X-Gm-Message-State: AOJu0Yzhz0qGVAuh5UYSSzPHqyEVdQAkR8DZJzQfstI9VoIEYTVuS3tl
	tmP0MmpvlXA7rORW8AKsvODctWpVPfMjXQC2N5hhWA95rMVu2/swXdq+qyJdxB7vOac=
X-Gm-Gg: AY/fxX5Grk2juTzBD7hUm4CCY7M7h/Tp1MyAVefyd3W2a5/tmIchDLxytS8Fhdr/y0I
	L96GzKeHAQzBH+DGDGXXg0qbdbK46EH/YTwPhlUlJbiGeGhtrS8ypG1S7osKn4MqRpPYYe5p/Z9
	pN2xubreilvIMLh8k0RTmnGRn9iKzRTr9sVbBlScmdhgv+I3h8q/DqK/TWeaqfTmG2+tvlo9lIG
	edwc1NVXxsn10iR1uLY7gNCYwQv0N7LZhBe6mVU9B6pqFk3kMq21F0TLqobuTmb6NVeISbQTRf2
	IwU9JVcJhGHP69CCxSQANmaUsdJO38QYWX7kpM8rF7zQzZSBxzK7u8iJU37nLns7S8VNP5bWM1V
	IcGn9qIxikNfU+mZupL4lKitf8ejdzSz7+f/h0J7NBJ+ydB+5wgZY56iSnOxicJIc6iAnJBHtWF
	1b4jzFtAOSaQGABaiBr9eY7PUFebZmHUgiuRvO3yca
X-Google-Smtp-Source: AGHT+IFe5boaAR3KBpqcw0YnZcmfehzXMCdTYDhnToMeEC3rfb+L3LncocZ2e/3zGnKma+U0//D9yw==
X-Received: by 2002:a17:906:c147:b0:b73:2b08:ac70 with SMTP id a640c23a62f3a-b7d23a62e5emr1792634466b.49.1765967539510;
        Wed, 17 Dec 2025 02:32:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa29eb76sm1930249166b.12.2025.12.17.02.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 6/7] arm64: dts: renesas: r9a08g045: Add TSU node
Date: Wed, 17 Dec 2025 12:32:09 +0200
Message-ID: <20251217103210.4183025-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103210.4183025-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21111

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
 v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 49 ++++++++++++++++++-
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |  4 --
 2 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
index 854b7a1d4eb2..b9255a7d52c6 100644
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
@@ -714,6 +724,43 @@ timer {
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


