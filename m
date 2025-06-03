Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C6EC61DB2
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:57 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.6982.1748942389378991434
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KH0SbHY0;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60179d8e65fso106143a12.0
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942388; x=1749547188; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYRHw0p58rIoFSTBkrz/NmMLdMXazS9OglZs0wF5U0I=;
        b=KH0SbHY0e0WFIbXZtJMmbdKyMWf439bGpFK50ydlyRAvsupbZmmhqFCilvcOPSalIM
         wx8aCZYIlUWS1TkSWXcnesVOnYrEdv2yuGmGwjK0GePUas3fDBek/ssHHqzrDkgJL7J9
         Kv3QrbxV6P6nlmg268AH6yGKEI55h6XNe7d1XZqAzv4+uxqDxqjtdMX2Aj4r7I0YS05P
         o704bppc/1JWDExecSTP5q8pkK0W4Tyc0HY4qsMTtI+CzXVE+7n8Im/4TjL93D+zb2hY
         /tgKHGt0XLjrMpZIJMgZUM7MImcRovJym3z2RTcgY06Yz2PN40hWiJ2Y/re6obnTPVPD
         Rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942388; x=1749547188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYRHw0p58rIoFSTBkrz/NmMLdMXazS9OglZs0wF5U0I=;
        b=tgblQwADrPoHiszY4knOda6vEYNO/T1JMfMFUZL+hnteBEUSMV1ZtUhJKoiO09PX6x
         PwAiHYboFn/WELBn7NUurgf6/V+m0bsM5g1EoBr+FjAo3sRnNUfvT94RjyySBwFa8HQV
         suHQEeagis0ZYbJzaWPW8B2ekG7WlOcEzUrLC6DOyp0cpiV57A16UVlRSemqmMdjRpfr
         7ae40dPeSrjy4AjizdnLzy7/uoHd1pwL7iTD+Ykd6nRS0DxmV14VKEz/STnyK8/jOi6+
         pBsxoppmSKxvKvxKviOPp5aJd2znE+1Ltv0z7w6N6QG87905qCTPAkZ9OX1Wo21QMzJj
         isHg==
X-Forwarded-Encrypted: i=1; AJvYcCXrfjs3E4VZP9SVP9SMYQ4DoNaeG8DYNCVc5PrMBsUsDbvyYlB0y0tNzwp/aekazVcbxLGzMOuI@lists.cip-project.org
X-Gm-Message-State: AOJu0YwUCn3wyD/oOkYsC/U7ksqpe4gy7EseYUP2VksYSx8/5XYx1I4/
	R3IPZHb2phn9DdJtWX0opfQEUUGXp6FT5RvJR2Q9U2TQccR5Worma6A82pw0Oahqh6k=
X-Gm-Gg: ASbGncvKtXQCW4u3l6rSriT2oFYBAhb3v/L+QwIZzym15Clk3zpKV6Ca1aPVPQXTk5j
	AxUEsRQlcCEwmm7YJBuFe83XKWOTIYD85hkb+yOtlUHwBFfyNktbcxYhkl1KK7FEWNPmuSJoMin
	c38bhalABicWGWgwA63RmyLuZX5DThTAdIv94tMggVRSpaNVYJx5U/HkNmO+/pjgMCmCeZlQ1jw
	pQI/4YWsSgEx4Wtl9npDBPACv9e/rF6Uh78swktAgOgKbQsapjdU34vQfBfC+/0x1VZwwfc3YRs
	dCTmyYZo1UZyi0JZku6dlQe1+bLXd8VYWvDvEyIcv1EHxrGc1bPVVf1gGPQ5LEXGLgd3ND6OO/m
	pLG2zcg==
X-Google-Smtp-Source: AGHT+IEn9B3cqgG34L0Ctyt+uo1cEa3c6V1+UDyDF7g7XmjsiG5OtPu84fLykCEmhv4yOmSJlkfYog==
X-Received: by 2002:a05:6402:90c:b0:602:4405:7779 with SMTP id 4fb4d7f45d1cf-6056dc394bfmr14454575a12.20.1748942387803;
        Tue, 03 Jun 2025 02:19:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60566c5c5casm7301944a12.25.2025.06.03.02.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:47 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 5/8] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Tue,  3 Jun 2025 12:19:37 +0300
Message-ID: <20250603091940.3917581-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18979

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 08811b984f5af8eeda4fb157894fe9bf230ec1e1 upstream.

The debug serial of the RZ/G3S is SCIF0 which is routed on the Renesas
RZ SMARC Carrier II board on the SER3_UART. Use serial3 alias for it for
better hardware description. Along with it, the chosen properties were
moved to the device tree corresponding to the RZ SMARC Carrier II board.

Fixes: adb4f0c5699c ("arm64: dts: renesas: Add initial support for RZ/G3S SMARC SoM")
Fixes: d1ae4200bb26 ("arm64: dts: renesas: Add initial device tree for RZ SMARC Carrier-II Board")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241115134401.3893008-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 -----
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi     | 7 ++++++-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 4c594773c4b8..bdf1507fd2d0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -43,11 +43,6 @@ aliases {
 #endif
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	memory@48000000 {
 		device_type = "memory";
 		/* First 128MB is reserved for secure area. */
diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
index 244f77925239..3c810db81861 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi
@@ -12,10 +12,15 @@
 / {
 	aliases {
 		i2c0 = &i2c0;
-		serial0 = &scif0;
+		serial3 = &scif0;
 		mmc1 = &sdhi1;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial3:115200n8";
+	};
+
 	keys {
 		compatible = "gpio-keys";
 
-- 
2.43.0


