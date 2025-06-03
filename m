Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F23C61CE7
	for <webhook@archiver.kernel.org>; Tue,  3 Jun 2025 09:19:17 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.web11.7096.1748942352155251743
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Jun 2025 02:19:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bRPNN5hx;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso1040011566b.3
        for <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 02:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748942350; x=1749547150; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYRHw0p58rIoFSTBkrz/NmMLdMXazS9OglZs0wF5U0I=;
        b=bRPNN5hx0cEnFmNrrO6CRaBnesknhvEx8c6eopS4t3uiRG8+vK1A53Phz4wekPlspu
         OAelS+wxG9OkIAWdZLlCfMs0qfQXd8KpIw+hG5ZMk/KG7ZZ6fbo7mX9dw/tJJ6zmyAwY
         lZkZ6BpcSi5Vqu5L9107+4mCXQfp4rvSg7Kvgg9ur7Tq4DcvPBeBddeMjOYsVsLUnesO
         moKij5ePcaHyeienT+yFoRj8QlsV1zXd+vacNYQg7pS4cSHm5W1DCc+WG/goKEs1FXK2
         Ssc+7DcVTjwrcQ6lq4mZbH3wYjl38CXekqs1+3abbi1y3KNqKr/0NHnLlBhv2Ywm7Dij
         PjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748942350; x=1749547150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYRHw0p58rIoFSTBkrz/NmMLdMXazS9OglZs0wF5U0I=;
        b=OFL3+Xriom8krVt4Zajw4i+0I4xdspRWKfYGPIV+6xohnFVatHanW2p++CN1SjyvB6
         UDLW3gOB/7xcWdb2Df0Q4ItUaF1MRirqgywKZ5X+U0f/C2lVNoOaIqg0YPgnZFugArTE
         5lxzTE8nPMYdow8t0HM3ARmIOfM632ST6PiAJmttvfj5ziXlfvO2+BbFN9zJByRk6La/
         95g2NsQdUMs0YdAIKr0GekWm1/J+74UGGPFO9/S4o7i9AD//uDMxxpL/1u68FvrZXeI5
         6pVT6oMtfCbF29GknDUlgaYkupEHK+KBcDnwQ38gtVj/Jt8Gy+8QCc0PtTv8e5Guj/RD
         eEqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQV561VbmOVVU67QkXqUqA6Ppl8qaaZmFchQ+uK9Nd1fThL9tX6bOE1u0g+PZr26jCjeZnuYy3@lists.cip-project.org
X-Gm-Message-State: AOJu0YyHQCC4JSwjfXTuYsYim/1NlonuUNFgFwz6MqtAepZO04JtW5mZ
	yIOsuhTbI+geVFoikynMLwk1xswRWK3wzQVOTpBYbiipIL9aXlkFKME0XnWtsPHfmVpK02ptyFd
	ELFnb
X-Gm-Gg: ASbGncuF2se2NiPumvOB94R3IkOieCVZzMaz3v2Pyuqj88qFU+64ACmK1tJNlm/qFDO
	jQXkTXapyJfY6ImqoaJPcdCgZePih0SG1q2IfLAgnY8kSM6tZxk/FRv5WlgpHKxcbLe+nZY6GtJ
	N4LeNTP79t9Khl1v4+2h0svnR3c9mMGuL0YezSvyO4euubdQ5fv78ewxKtZdxMg63zNCZ/UTOxw
	c3kgmTurb99cGTB3PhChexPzDIOE57jTgYVK/SSUEi6zzTDPCQLCsKZAfSV0/+I2iGpCITbVI7W
	wybAcDLyslo34jcxpUxkuZInguuIL5JUQepUpGBumnM/gMugjqe5mp3q8O3OSTmbLQ3Jh/loW7d
	rMSUHIw==
X-Google-Smtp-Source: AGHT+IHwxVvyVtoYPqwZT8kmcHTUXSrxv3ZhzQK3BZNx1B2Dd4wp/x6AOW/6HNa8TYXHmsAFN51RKw==
X-Received: by 2002:a17:907:9711:b0:ad8:9b16:58cc with SMTP id a640c23a62f3a-adb494e5aa2mr1113583366b.39.1748942350427;
        Tue, 03 Jun 2025 02:19:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7fecd2sm918093866b.36.2025.06.03.02.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 02:19:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 5/8] arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
Date: Tue,  3 Jun 2025 12:19:00 +0300
Message-ID: <20250603091903.3917202-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250603091903.3917202-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Jun 2025 09:19:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18970

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


