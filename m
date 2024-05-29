Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F49C25B7C
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 08:15:38 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.8742.1716970532120902575
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 May 2024 01:15:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=J5Zbtj9h;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.169, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e73359b8fbso20732951fa.2
        for <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 01:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1716970530; x=1717575330; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnBNN3PgWKHPSKw0Rug35hv4j3+reBw0pVNmlqHpyCM=;
        b=J5Zbtj9hC7v37OqAY0qZRFVshw5vU+N+q5ojmQd20re8W8jJbtRbXmXHXnnQ+zHtv7
         QMDeWKFFz44vpoH9zar1ejjgPTHSxlT5C6iQ/8rdKByPQJTrgkv1o/5iITqOs1BpVfcC
         BLsZ9kn2irK7FO3xBGI/KeOTwA7VR09PxckXQcXWCnEJfAvpWm4JNHuHs8cFZKSDNvA+
         +pUza67jS8Pa1yceKqJNgF7BIMCFs2sDpG4gH0TLxcF3fb1TGWcOAkCFs05gTL2nH5DF
         dZ9gGwOAx/GmaVx/9zsB+Bol9RSBjvCAmDpR7RItGsudgufE/alYT+FPhVmZ6ddzx4uh
         GE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716970530; x=1717575330;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnBNN3PgWKHPSKw0Rug35hv4j3+reBw0pVNmlqHpyCM=;
        b=RtLDx4b3O7mHrqFkrNTv5kFsEPJbpWJTsqGDgK6ukloo9zc8U9mPyP92jkPe8pBl+D
         RidkS3zrP7R2wg/XTyOi0Aev2YMMjUAAimq2BsT9mvbjr2GKK2umli84wNlib/Ddq3at
         ukgWFuT7Xghu9daCpQiIy2CmD+vz6AMTqEbDw9TSgT5FbTDv5PrPSC0+Nrf3ZMvD4j6E
         mgR01pjC+x1gZo17fHvlhcGufAkjUGZtqVwOloiphppIxGCm1mKccSKOwgcfa0XE+qg1
         Ij4gfJIzXEiCLDrLLs//UmH3nW1liPPqXawwfMJdIEKB9Jzj1enwDaRTRAJ/abPi1Do8
         BO5g==
X-Gm-Message-State: AOJu0Yw8pWz+O7IUU8xMUid7Piert3eed13VtLVSJ+/mDfhdNT6VKW40
	Y0+wmy3AIpck5acL8ZD1uh82lZLkbTv+IjYb4i2iH9v5WggiAV39QNxb0xjdyDOUVJ4vYsuzoqr
	eByk=
X-Google-Smtp-Source: AGHT+IEgxQRYVvhE28Xfx5jfujfH1Bjj/U30/rMfOv8zJs+77REcEFl1gLtV7flijknCWFBpyD29UQ==
X-Received: by 2002:a2e:968c:0:b0:2e2:9416:a63f with SMTP id 38308e7fff4ca-2e95b27b963mr129979151fa.53.1716970530316;
        Wed, 29 May 2024 01:15:30 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089711e8sm171803935e9.18.2024.05.29.01.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 01:15:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	paul.barker.ct@bp.renesas.com
Subject: [PATCH 6.1.y-cip 33/33] arm64: dts: renesas: rzg3s-smarc-som: Guard Ethernet IRQ GPIO hogs
Date: Wed, 29 May 2024 11:14:34 +0300
Message-Id: <20240529081434.639519-34-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240529081434.639519-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 08:15:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16061

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


