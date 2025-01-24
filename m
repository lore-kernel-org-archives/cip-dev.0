Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6291EC0218E
	for <webhook@archiver.kernel.org>; Fri, 24 Jan 2025 09:00:31 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.7437.1737709229559378118
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Jan 2025 01:00:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=f0m5DWw3;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.46, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so1811584f8f.1
        for <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 01:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1737709228; x=1738314028; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=avEm0xWoaPOuBqma5bKPsWNEysSf4Ic0Xdn9jpjXkLw=;
        b=f0m5DWw3YFATjCJ6oldRZbbjOt4bKBKEOj8JCG+pyLqJJKEHY2834E4Fe3H+W7WXkL
         KU7OVVlSVXG+y/PCg4lrV7ieZQwYHzg5KxwsBXc8HwIyzizV/mQCevjVUJbDEzmhfFNl
         dvRLJuVetRqYmtJ8RoRXrvg1RrO2jhmHECAK0yJE437697V7K4CKIg0t7vNVdLAWD9Wh
         2ZHF4PHSk/Q+489om99ZYM/y0yPytzruSV63Eu2H0LFTBUI5EGXWk6YvNk6C26cU9Qvh
         AgwnH8e3O7jS5KtNE7EpLqkQj25uNaU5nJU1Poa/XWBkLLQ2R6rZG6j33eI56kh4xl+f
         8J2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737709228; x=1738314028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avEm0xWoaPOuBqma5bKPsWNEysSf4Ic0Xdn9jpjXkLw=;
        b=IO5PwZCtpy3h39EZaO9/2d8bubJCcJWRiadmG7Mu7xEE8ik5f0sf/RrIa5d2F4CT8a
         ixyryrsSxNJYnngTIoDEkoehht9rSZcXku91dfYtXlRMd43ISahPaEwWJIdSuGIvfWFD
         kHkaApxCIztbNBPgyKwcxbV/oMj27qAk5EI3FGBibrzk1WL0ynrzGXFKdGP7TZ6rTxWx
         JTLeJGuk6gSdu0jw+y+pWA8HzvHGB8VhxPcRgNIioimLsoJIZ5+KCO/SJi1CT/AnAhUQ
         jbTi1Ch0n0XNjsPX0OEIuwbB8phx/Vaqj062/XVO4mPpC7v0iuwwciPPPGdgZ1muT6sL
         MHZg==
X-Forwarded-Encrypted: i=1; AJvYcCWzROuwPbVYDyA2M27KcdGu/WeYo5I0Jar4qF6RGOY8O5IA5xKdyutT9q1F5nPQRzrfPJwA0Cax@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz643CLFzDcB86NXYAxMGSbOlwl/CgL0pui5k4r7p3ifGy+juPj
	lTn+rB//g8djxwTM5JJGTyNR5KcjLaJ5XmYLlRgNGsRSSRJp+66mD0WPbgJlRss=
X-Gm-Gg: ASbGncvcQ4NmUk3w0NAPtRXbeAUl9mQCYX/L4b9Forl0fzafhpLaK+RgeUk4hdncnX6
	Iw9Q0Idy4FV64Did4yef1MOTdo8rL4WYDQNeskI7nznV4DhmPM2Kcb3UozMyh8meLOGxjs0f96Y
	bvTiWKizbMEO6wRnmPNCxjBKcC1ppSXbJVkG1F63zk1eDNnbP6+0t4LifKNc1TDJNkolg3Qa+VA
	MlBHDmP8W//NolHQlqCcXtx7gl9ES91z94r12LCPg0lGKrHPBfIcRrDVGXTgnMol0ZYqfYRQ1Jj
	DBTT/snX57govTp8i8R0+p503hfKAyHZJg==
X-Google-Smtp-Source: AGHT+IFuuUumaBRNTEHo5GBwPOe4hfaz3YAEHlfQDb5O6M8GPW+b0glNFIdDCng7PCIicGmGAMwhnw==
X-Received: by 2002:a5d:47c9:0:b0:386:416b:9c69 with SMTP id ffacd0b85a97d-38bf5662912mr30219617f8f.16.1737709227819;
        Fri, 24 Jan 2025 01:00:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47f25csm19410935e9.1.2025.01.24.01.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 01:00:26 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v6.1.y-cip v2 11/14] arm64: dts: renesas: rzg3s-smarc-som: Enable VBATTB
Date: Fri, 24 Jan 2025 11:00:02 +0200
Message-ID: <20250124090008.1401077-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250124090008.1401077-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jan 2025 09:00:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17633

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


