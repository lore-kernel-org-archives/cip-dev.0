Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF880C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:53 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
 by mx.groups.io with SMTP id smtpd.web11.10270.1746783167839917267
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Jrrb/s+S;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad21a5466f6so136008866b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783166; x=1747387966; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=020rLkMllm7FtifGeoEl/JV3yEgdgnMG4AB2/+GJDvk=;
        b=Jrrb/s+SRQ8OohI3Yt88S+hy+5/RDAXUnODqtJZiDQ+z+lT9YYhIC7lrM0taa8vjXh
         BzG+QPR7k1oZ9pNc+t9/jwnzKatwFuGGp6j8l0Y6wuYu+0PvupVXPKcjdK9Npzcbtzrc
         UDbPr2HIcGRUTuQDXfw4p1k6i+8DBvZ2Jy6VPekAioniGge0nBLirrclJWSE82eoaafu
         BWMd4a/ogWG8xX/Dj6KvEJFpMsi4kdzcXjB1TYO+ssqxHuCgkC3gs+QSzUWRqv2JQ83x
         GhIvyaLQfSLjVZ+yTxVog8BqeNTvE/s7WLEfxOHAnbQZQLnjkpMXIXMwvphUhH6tVXrM
         0iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783166; x=1747387966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=020rLkMllm7FtifGeoEl/JV3yEgdgnMG4AB2/+GJDvk=;
        b=KFM5iBdIcMhOTO/xJ8KJ1e/mfC7Cu8ZZx+hJug6dJk3z57qC1v+/UPFB87NkGnZX1p
         cvV40nnuuqXlMSclQjZKvieK7+djDvB/My7H7AVsFQmFuP3QzYB+RrxwiF6JtPNh9cU1
         qYac3JcD0zZT6oszIMXW0xV70LHkDyRzdqYO8EnvprZT+LSzuLQ8WrDzLdn0E1orYnXZ
         7qBlqMsZfgOol9lQvSDkft1+6IXZrh8qngYX9IjmAFiOaU/fAbfGZHrpeufd22JL2keS
         btTnu+eNEkwIKbQYe44+iVCRxS6LbZW4fUEQW0/p5zypC7F7gnSPSfy/1e7DsnzprZpL
         rp1A==
X-Forwarded-Encrypted: i=1; AJvYcCX4DFoa9MqU1Lwlf3xgqN5a7UgEvh0gDMMUbwD2cb73mDt6OlfSA8RsPSH3MKhIQBeF3BICdJaZ@lists.cip-project.org
X-Gm-Message-State: AOJu0YzQe7b7xYPgUFafId9j2kh9UnPdHRwi0JgH3PKIuke0XbS+koxl
	jZMCzfnl5sEJLyY5n72SiP1nEW9X96SK4+BzmW+696SJWpPcUvhvc644VJ4DxwI=
X-Gm-Gg: ASbGncvL6hu96RGrRiacS4zCECA+SOu2DTQNFKNhOhlb+cjzkswFPK44VPhXx8tBiZm
	ujK3iTWDxQTauijpGCmjwfxUNsLxLBYGHbOc0yx35YF/Nfc89jFwnjQlwdL9ykmVrA4cYCAfCvi
	0O8GC+ITGra1llrOhL/U0688ynOW+dMvlTBnUVMXQ+Fzz0jwbDaWdDYUAp7Ae4YEYt1vV9pndBL
	s8Yr+WrwP0EvqUf1e/5A6H4pKG8YH8o6RmonR4DJXObvj3FI+XmIRh7FqXTwTZAH52uHusVyjPA
	r9ymp9efMXNukjtUVI9xb9eOQEOtFtpUK0Yx5mHGi4+Wa9W7IjVMEtvc4NgVq2hYB4Pxgw==
X-Google-Smtp-Source: AGHT+IGeKoMdMufxxxFB8Fj0KLxNrWlLOWSv0HnVAJJNnw/R2MJievu32dJkS/TtPDEEnq5pS9EGNA==
X-Received: by 2002:a17:907:7f87:b0:ac7:b1eb:8283 with SMTP id a640c23a62f3a-ad1fcbdb0afmr600434666b.17.1746783166153;
        Fri, 09 May 2025 02:32:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 28/29] arm64: dts: renesas: rzg3s-smarc: Enable SSI3
Date: Fri,  9 May 2025 12:32:02 +0300
Message-ID: <20250509093203.4014750-29-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18815

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 558a25c2ee3815c3d59d4dd9440a1cb3a78d20ab upstream.

Enable SSI3.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241210170953.2936724-24-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi | 25 ++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 154a360c4527..68dd3b608516 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -72,6 +72,10 @@ vccq_sdhi1: regulator-vccq-sdhi1 {
 	};
 };
 
+&audio_clk2 {
+	clock-frequency = <12288000>;
+};
+
 &i2c0 {
 	status = "okay";
 
@@ -100,6 +104,11 @@ da7212: codec@1a {
 };
 
 &pinctrl {
+	audio_clock_pins: audio-clock {
+		pins = "AUDIO_CLK1", "AUDIO_CLK2";
+		input-enable;
+	};
+
 	key-1-gpio-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(18, 0) GPIO_ACTIVE_LOW>;
@@ -157,6 +166,13 @@ cd {
 			pinmux = <RZG2L_PORT_PINMUX(0, 2, 1)>; /* SD1_CD */
 		};
 	};
+
+	ssi3_pins: ssi3 {
+		pinmux = <RZG2L_PORT_PINMUX(18, 2, 8)>, /* BCK */
+			 <RZG2L_PORT_PINMUX(18, 3, 8)>, /* RCK */
+			 <RZG2L_PORT_PINMUX(18, 4, 8)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(18, 5, 8)>; /* RXD */
+	};
 };
 
 &scif0 {
@@ -177,3 +193,12 @@ &sdhi1 {
 	max-frequency = <125000000>;
 	status = "okay";
 };
+
+&ssi3 {
+	clocks = <&cpg CPG_MOD R9A08G045_SSI3_PCLK2>,
+		 <&cpg CPG_MOD R9A08G045_SSI3_PCLK_SFR>,
+		 <&versa3 2>, <&audio_clk2>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssi3_pins>, <&audio_clock_pins>;
+	status = "okay";
+};
-- 
2.43.0


