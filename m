Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59406C0218E
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:51:40 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web11.41689.1737546698441085452
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:51:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=CHgu8T+B;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361815b96cso47380915e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546697; x=1738151497; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avEm0xWoaPOuBqma5bKPsWNEysSf4Ic0Xdn9jpjXkLw=;
        b=CHgu8T+B+e+NfW/fIXcaFQDJJIcwXMsgOgkMVVxWx4KZgQEVG6g9rkaGv26nLURBu5
         dOm5RnrGCIgtwWU0cFowyOOEycRvtbQyPYFhPFMNVIuLDtzSwWQyrXRxUJbzKRfflgej
         FB657qSaLbBdLZWcMRT9UUn+RONVGFN8gxz8HRKsybsK0OSaLzYSToo0UeFtUPvnua9u
         14IeiVCWHFyvfGlLylr8EoYgfCUmpQuHWtCSSf2X+h+2AiiZr2ajNAOYguZGiBeSM2vJ
         IC9uVwCVK1Xje4mOaNgqPG94TF1mhwLASes8n7uVEqZVIUNT3n+G8u49pNZDN66CezTk
         Gf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546697; x=1738151497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avEm0xWoaPOuBqma5bKPsWNEysSf4Ic0Xdn9jpjXkLw=;
        b=dL1FXmUzcXHnMJrHtTzRSxFjUABtysz/yuOeiPWoDuttdFXQej5/jMlC68Nag4K18K
         gVOHk+yTtTXeDwLylcK5CgwiplbKlPzZiUI08QhBPrw7pmA6cewJU507z8mQ14Enet0r
         7H0Foi4EzKJsml5hvs1qHwiKOoXJ5vMM1CtPIFYxP8+/2ojZqMMxDg0BkRjWSf9WplcS
         ghFlUYqQeVu7tLtCFK1IwBmyQ14HTk6smXM9HQoV9vGrZDIk9G0KdTRX5OWw1IFMA5uV
         cUeTk4AvYsE7wv4x7+EXmX0/CzFFZFTNMTpM4Poboq9P27+3ehWIDuLKxAqQI3/o3Jvk
         4ODg==
X-Forwarded-Encrypted: i=1; AJvYcCWMUJjRsI7eILCF/xY4q0VJWFR/QphnAxIvw8fIfdMCc0SVoFNDBvZjqDoUn2GMcxGYa6AfpeUF@lists.cip-project.org
X-Gm-Message-State: AOJu0YxGLIet2fdkMZ8xKvB5mMvL55IYXG9Y8g8biuxA4VgXM5iXWpRS
	RS01+GOepm2b1SnqChzOcfG7GYiTafPKTI/lExhRylvJKAganGT4uOfHXFIhEuE8thi4eyWHx42
	G
X-Gm-Gg: ASbGnct/Lfac+2Ma4mxQ65H+Z2pW18IRO6yMd+YOniARYSt9Qcyo9fES/B0kPbK4KFx
	JMan7OhsLVj1yKtvG6gj+JGtPflXSVu8x/JlHWBWln5yc6osbrjxaoSULMlWOLE0i37SfcEqmRY
	a+6BiMTSGTZ7WH2gMUHZPz8TDzhwJIonbmVGFp/HgUbECWdXNmzkvB3a2AR2eyeVAzt3Waa+UIK
	7hV6yYWWyl5oexzF5UDh+PW40y9c5lfFrMXkqjju7+iaZRk4OZ8eH8A11U6MrjlteprymvVIvch
	mJfVOZcZPaECyUaEkylygcpv3ojz9Jgv9Q==
X-Google-Smtp-Source: AGHT+IH8y6dZSl17jTQX2xsMeGRSQ+uOlTlnL/Hz3EDr+iLg8eLPThk/xjdl73KTTjpUFcz+jew2bg==
X-Received: by 2002:a05:600c:63d5:b0:438:a46b:1a6 with SMTP id 5b1f17b1804b1-438a46b0388mr136574905e9.18.1737546696882;
        Wed, 22 Jan 2025 03:51:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31aea72sm21474765e9.21.2025.01.22.03.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:51:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip 11/14] arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
Date: Wed, 22 Jan 2025 13:51:16 +0200
Message-ID: <20250122115120.2885015-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115120.2885015-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:51:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17574

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ac948eb8ead1265ff034955bdbbb081744f1e7ed upstream.

Enable the VBATTB controller. It provides the clock for RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index acac4666ae59..67178d8c4108 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -5,6 +5,7 @@
  * Copyright (C) 2023 Renesas Electronics Corp.
  */
 
+#include <dt-bindings/clock/renesas,r9a08g045-vbattb.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
@@ -341,6 +342,17 @@ mux {
 	};
 };
 
+&vbattb {
+	assigned-clocks = <&vbattb VBATTB_MUX>;
+	assigned-clock-parents = <&vbattb VBATTB_XC>;
+	quartz-load-femtofarads = <12500>;
+	status = "okay";
+};
+
+&vbattb_xtal {
+	clock-frequency = <32768>;
+};
+
 &wdt0 {
 	timeout-sec = <60>;
 	status = "okay";
-- 
2.43.0


