Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909A0C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 11:53:00 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.41716.1737546770537758660
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 03:52:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Fo4j5HB8;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43618283d48so48740235e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 03:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737546769; x=1738151569; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avEm0xWoaPOuBqma5bKPsWNEysSf4Ic0Xdn9jpjXkLw=;
        b=Fo4j5HB8XZ3ngO3qmCfaC2mXY4j6FR/airBupD74Kz1K5hd/9DlDIH92JbKhqVVH+K
         acqbkX5d16C83MikdOWSsIRyTGUjlTerorRy14rHsc/IpTo/LkBaB4VbzdrIvgy63ra5
         X7DArPFHK0KLGVyaU6BvILypkVzbFeNWCeTiINOI4kk+U+QrU4NIJc0wq/avGyfcly9d
         sFxwHVe2VTpjxXA0zGabzygJ51u3OfnauQECeRWHqXpCS+Mo47K8az7x1D9TkU/XgSOj
         B0gKSADPxh366hPt1i5woC5FZjjzmZPwdKOh0PkrOZ86PLSwYH9lHyuj07sJ/CUpftPU
         I30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737546769; x=1738151569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avEm0xWoaPOuBqma5bKPsWNEysSf4Ic0Xdn9jpjXkLw=;
        b=bTMm3gf4XrIuJ9Xgwx3wsNdCvdliCzM1ZYg0bh7rOl7Zt76gsWCsYUANJfHWSsHfQx
         cIhHFy4mFmRpy6Ms4CB6kqE47ZiJ6iyhFKW5ieD5DFutWSWW++RQ4sW4Rjj81Q1TOgCG
         rK/IqrCrueBFDyQAz1Ewsae9/kbIE5eBVcykNQQIP4Gji94YaXf0ZHbi/UiV1Qh3vBQu
         rE0sUpADY1iT1aZKpKCLDhDoDPy5toj2eGDNbEEXL6ZYCKVYzbmDesMYJFVHX5se4EGG
         MqGqDEltMC8fICygtr6drkPPipLbCrYlj2z+nJKwcUbmN0eG2GwyzZs6L8mbDy2+QTX+
         UjkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2QWRDQVaffcmGH/mkSgtCWBeonEn6R9seQiT7hsqD2o+HlUIBiizF+qSx2rROE0eq/LPtew1p@lists.cip-project.org
X-Gm-Message-State: AOJu0YyDDfT8zokIAI+oOM7A46Zlpf/vAbKzbfkxyTpN2B4VwueBmIv2
	HjjaDnwN+c0R2HAqx0qv9efDzqI/8BfMIqf/1B853OZptBDUoGB+1CtfYb2tBGM=
X-Gm-Gg: ASbGnctpTW5CwgSGQc//2CPjN0Y56x82kurfVFDYfDoeWuz7okS3+klPGuTA9jHoPxk
	/Wy1+wSFVGM+nXRNbEhkHeh1SQ5G9r4HSatxy4UkAczrwUAoc/j0hEkde89/v2hLwihEmX1S5y9
	Q7h2Dz+pXfN1v45h0Mf/dQBlq9lj3wGE9Gw7nX5VV5bb6KTE8IGyrQdokBm3xYk/88iMZEyNhJh
	aHY/32g/OtwZngvVf/888hjxiApI2krQz6Wag7m0nTdYhMk1QuPQsex2HcX/s2ehw4J3P49iSMS
	u8qbOexmpUWD7mdCzDgpXMY=
X-Google-Smtp-Source: AGHT+IHgrl8GicoUYf+PQ5aXmXNuuno74Fo+6b5NVLzvjXpHKWJrsJoVDyzSe+rwrI/FJKZOZuTJ3A==
X-Received: by 2002:a05:600c:3420:b0:436:f3f6:9582 with SMTP id 5b1f17b1804b1-438913cb729mr206286335e9.8.1737546768989;
        Wed, 22 Jan 2025 03:52:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b318990esm22887415e9.7.2025.01.22.03.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 03:52:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 13/16] arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
Date: Wed, 22 Jan 2025 13:52:27 +0200
Message-ID: <20250122115230.2885344-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250122115230.2885344-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 11:53:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17591

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


