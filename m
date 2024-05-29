Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331BEC25B75
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:12:07 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.8670.1716970320128321465
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:12:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=c2iDYhVz;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4201986d60aso14194085e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970318; x=1717575118; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnBNN3PgWKHPSKw0Rug35hv4j3+reBw0pVNmlqHpyCM=;
        b=c2iDYhVzLhM+NSr1DcsTXxtwC8p/d94adjQjCCnJRoKnJsKZiF6FajHrnTApbBmNn4
         /gxh9wpx19QcWDzuO+D1y9OMZ1xpJIexW8H/UmBVfZHYGzfj3ovD2GK55HxvVq9pBpt/
         svE+4IEpjkwDe6IVxaZwqjKTLKvbQh9H+0G5rRn3W0BUfp+1PbZMhKoAIRVEDK2oeOqw
         uVaJXOVqnNZiNJ/eD9Ar9ECMkrTCgJzLRgs9AY7cTudcx9TpGKlxqyqswkFoKIpBqCy3
         YOs5Jg3Xa0QHj9Vz7TvBhBwylOkuTJ6sXTOqoljjEZDnoRJdiBPn+HShox0HuKlVt201
         DY+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970318; x=1717575118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnBNN3PgWKHPSKw0Rug35hv4j3+reBw0pVNmlqHpyCM=;
        b=Iyg9O5kJ5I3a3jXoQBe9OkCLxjyRbKQ2S2wsxq8Zdhs5b5nozVKtF3gxSSW0H2l6pT
         HgEuvVvF0nfJgAY4orSQ97K/ZbgvUP8ThgDveanVzXQ1WxvVmp4193WMNfE8rMaQ4Ts5
         f3FCFdUCVRebwiZPgd8LQBcVWEeoXHKMPpNDkp3uoP7n6ikV17I/883w8bg6AFDn76WT
         P9nVcnB/MdtHhh2boV4RiMZOlZi3gCa8DDsK9z+wEpYQBm/vlCgLetu4KKH/QYbBhGIb
         LbgBLroFL1AnO9ln1SfaZ1z/yGvXqZQLmDEHCQCQezGgS8kK0ICXgu1cwbMl4M97Yd8h
         Kgzw==
X-Gm-Message-State: AOJu0YxD6Sl4vUYUJahvo3/D5IJLVr2gijryemCiCBwMdNX69TeAlqaB
	+sbQIs4DWBv7HLsWhqooE+0qvJbMyuqjuGz8pBGOCE5uG9AP7xfJSW83vdrlkkctPqk1PMWHPcs
	ZwZ8=
X-Google-Smtp-Source: AGHT+IFhtXJt2uc8ola/2CIpEtuvvXuvE0fMWEC06K3zyZfp8MBY0sE4UT1ws6EJWQTAnvqVqgkX8Q==
X-Received: by 2002:a05:600c:5110:b0:421:15f:186a with SMTP id 5b1f17b1804b1-42108a12b4fmr99687975e9.39.1716970318619;
        Wed, 29 May 2024 01:11:58 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108966b63sm171973865e9.1.2024.05.29.01.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:11:58 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 5.10.y-cip 47/47] arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
Date: Wed, 29 May 2024 11:10:39 +0300
Message-Id: <20240529081039.639010-48-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081039.639010-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:12:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16027

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 150d81f7a260f36c118cbec253fdd493c671dc29 upstream.

Ethernet IRQ GPIOs are marked as GPIO hogs.  Thus, these GPIOs are
requested at probe time without considering if there are other
peripherals that need them.  The Ethernet IRQ GPIOs are shared with
SDHI2.  Selection between Ethernet and SDHI2 is done through a hardware
switch.  To avoid scenarios where one wants to boot with SDHI2 support
and some SDHI pins are not propertly configured because of the GPIO
hogs, guard the Ethernet IRQ GPIO hogs with the proper build flag.

Fixes: 932ff0c802c6 ("arm64: dts: renesas: rzg3s-smarc-som: Enable the Ethernet interfaces")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240208124300.2740313-13-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index f062d4ad78b7..d33ab4c88787 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -193,12 +193,14 @@ &sdhi2 {
 #endif
 
 &pinctrl {
+#if SW_CONFIG3 == SW_ON
 	eth0-phy-irq-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(12, 0) GPIO_ACTIVE_LOW>;
 		input;
 		line-name = "eth0-phy-irq";
 	};
+#endif
 
 	eth0_pins: eth0 {
 		txc {
@@ -234,12 +236,14 @@ mux {
 		};
 	};
 
+#if SW_CONFIG3 == SW_ON
 	eth1-phy-irq-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(12, 1) GPIO_ACTIVE_LOW>;
 		input;
 		line-name = "eth1-phy-irq";
 	};
+#endif
 
 	eth1_pins: eth1 {
 		txc {
-- 
2.39.2


