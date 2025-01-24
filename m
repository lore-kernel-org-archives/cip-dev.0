Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FBC0218D
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:01:11 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.7453.1737709263747351265
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:01:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=i/wcXiMW;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaec61d0f65so410622166b.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709262; x=1738314062; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXCpiqVyMDixgTZL5X7LC+i/BPq4PaBUIA0VzYmUtdY=;
        b=i/wcXiMWVgp2wf9V/4XU6QwfLD2A3YOfVR3plWcMM8haQghk7UbFXK7oz90gHayrPI
         GWSDF1oGrcgLQ1PQFsfTE/w7yqamMJ9QyH1pQrB+frAMSz7hBzz5y0TBovGsWoKRy6yW
         471IdGfoXDUU3hUWf/Du/qjbqZEfhl0jZ/TYbvNc2V7rzI+8KkODY0Lj8IGA+kD6xLXw
         SjJsGmTxwMa9uw6nPfBTgieeNPxmbpCa0lILZiHeceodWUPlYKigDMaoPPylp5iokkvC
         LUdp8RuCjw96COGe0ouuvwgUVPBfW7qQS3wJ/dorismdO0aRAASS1HPcBLSOJ0Jz+NgB
         s06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709262; x=1738314062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HXCpiqVyMDixgTZL5X7LC+i/BPq4PaBUIA0VzYmUtdY=;
        b=ggv27ogFlrDmu3PuKG5N3QgJ4F8I+C+ktIqD6LnKkbCjWhANZbLCHJtMfHWqPK8uhi
         CDi0TWzuxwUTo2MSaIaq3vPdTOX0ZB4CUfSBcdTc/eteKw9TW6Ii3COWaPmcJRrP6NVo
         WITkVp4PsuKYJFYyZRN/7JxLd+R+YXhwczcE4FaHmYEuP0BW8aoB/2+o8v+DFQKBMmT8
         u1aCBZjtKCJpzxpeEsTnkFptUCar3GhiZnYX2XWU1yygkxAB7h7yM6IawJRQLHhigs2u
         jOqYNQrCZB3AG+Z36xeQ4o4WHIm45o81hKeWUlESNt/8ZiB0qVraMnXREx5Oh7O26v0L
         lx7g==
X-Forwarded-Encrypted: i=1; AJvYcCVywKrttxzn2Ze6djJ4z7U1nTjgoO/ASeMw6iyqpPfGazIn2Jr5JMoReNWe62dIpBs/+hOtiRgc@lists.cip-project.org
X-Gm-Message-State: AOJu0Yy+xureW3Cr4DdhFyV9Fh3BAEMcAGReSei0Z5EMpKGMIa6Aj4st
	Sgnm3ZvMwkSHeFJ6nGTfZ0djgeBy0lNhBI+wI7m3UDMXDg9+4fWxBm3BK3FV7Ew=
X-Gm-Gg: ASbGncsbRIOv/aR0fchiLO6yySy2ZlFDMwpbkQpp/vDTBXe1iyVOkGbzCF2qGwzcNDi
	4+LaoBjKsEAGGd1LoVktHOj3noUoW7fRPsDUFtSBSq11v+2gP29JdSb1vhokJH3yUncew7wbZof
	xVfe3zf0hDNo/dFgHRfFkx8JtrUYbN4M8GA4L4X8CLC5nWbBwqLMci9mcjXqQmgAYL+U+ViU/kF
	EJM0spe9rr30GThHa53d69ZrFcmSkgI84d7LRUFKpTq3tes4QRuYuaxW/V/ahZ6qA5x/OsfLOC5
	bpmuPtnDidL+VWVIHJBbUy9J6gmAchJPBg==
X-Google-Smtp-Source: AGHT+IHfiha0Oi8YYgdb9EiJkbGcOyLvoU8dwkg5CpuDn0AFYp18QcDZaJ0AwT6jiZ8ZetOX9tFaCQ==
X-Received: by 2002:a17:907:2cc5:b0:ab2:c78f:e4ae with SMTP id a640c23a62f3a-ab38b12a246mr2835627366b.20.1737709262056;
        Fri, 24 Jan 2025 01:01:02 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm92200766b.127.2025.01.24.01.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:01:01 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip v2 13/16] arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
Date: Fri, 24 Jan 2025 11:00:38 +0200
Message-ID: <20250124090041.1401132-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090041.1401132-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:01:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17650

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ac948eb8ead1265ff034955bdbbb081744f1e7ed upstream.

Enable the VBATTB controller. It provides the clock for RTC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241101095720.2247815-8-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek <pavel@denx.de>
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


