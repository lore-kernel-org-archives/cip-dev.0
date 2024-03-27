Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86CCCD1288
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.32283.1711527482954111995
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=BK6z+HuB;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ed6078884so305059f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527481; x=1712132281; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQolqFCcDjdTWOh8MFa/SBd2767l/kjGKx7ZoC9R+AM=;
        b=BK6z+HuBn9t8h7c5pJgj8dFEZdzzWIrJEgM9I6OQP+EGrD7P0rq0O5Budy0zkM6CrM
         sH4rxgaiQCjVocoXhw+gGvpmLzwayJH87qvm4XgdfWcWY4v2HKX1hJOGtw4B6kmt+hj5
         517YOVvHjNyEwBRJLRRl7BqIpg9lWJDVhzg4x/FvznvmksMXyepHkoCm2DjEnGG/mxMF
         lnJHr+X9xuX/a1oYORF2S2MOg5L9hfBix9HMMgo417xj/8LbR8UZNyTp74o3dSR6fXWy
         ax1AW0npDE7r7udF0ngB1DSKTIxngTeR8F4OG1QSuSDEUQRe9Cd6PTjWgpDp+jsVy42s
         bAAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527481; x=1712132281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQolqFCcDjdTWOh8MFa/SBd2767l/kjGKx7ZoC9R+AM=;
        b=kwsxtwn6fXFHLW2XtH8kVdrGZz/q27zte6fM0mQYlNe0I1qiU6fPZYUqhsEsMAT3xA
         8l4pdGTtJIostQH2JpKH6XuaRjAtQTv3jATqCBUdzyL2husPDBrsDR2/nSNRVmOLYQ9Q
         u+JSo9nI6G1pi7jUueIeTLdlkUbRcei9o/29PpySI/eNMt2Q9RnxfqAdJCTKOex+AbGu
         XrTv95JdeVExNzIXRgFBQZiwq91n5Ym/kfrWquf/kIjWIMc+McXDxAl8R8IwUYM81vAX
         xRv41T4W6sj7HnO06FQU6ad0ooWEpwcOzBesO9xgiktn5dfJ+52wU0Dr4FaFMFG46xri
         yBzg==
X-Gm-Message-State: AOJu0YxY5xkm33DZ7lFeJAM3bptfq8wdr0IQhdOh+iqCl3mN7Baz+svV
	qkPGHbEV7rJ99kzWpkm7WvxmpQ67q4d6etNImhAJKjQfXTJVZQRjH+yTXWovAqk=
X-Google-Smtp-Source: AGHT+IHg4J3UDQty2kFqgcgxuPZ+a/9VAiJxBpwjxxLnaBE2XRWeEGqgJcnzm3nbpFJX0zn80XuUWw==
X-Received: by 2002:a05:6000:110b:b0:33e:9f16:33c with SMTP id z11-20020a056000110b00b0033e9f16033cmr3249542wrw.18.1711527481286;
        Wed, 27 Mar 2024 01:18:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 02/36] pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERARCHY
Date: Wed, 27 Mar 2024 10:17:22 +0200
Message-Id: <20240327081756.2228036-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15419

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit fda5edd7d66f091770b600f789dd4190ce6a7907 upstream.

The pinctrl-rzg2l driver accesses gpio_chip.irq, which is available only
if CONFIG_GPIOLIB_IRQCHIP=y, and uses APIs that are defined only if
CONFIG_IRQ_DOMAIN_HIERARCHY=y (irq_chip_*_parent() APIs).

On ARCH_RZG2L, CONFIG_IRQ_DOMAIN_HIERARCHY is selected anyway, e.g. by
CONFIG_ARM_GIC_V3, but CONFIG_GPIOLIB_IRQCHIP is not (it is on R-Car).
Make this explicit at the driver level for a clearer view of the
dependencies.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240215124112.2259103-2-claudiu.beznea.uj@bp.renesas.com
[geert: select GPIOLIB_IRQCHIP, too]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index 97dff258e257..f47cef140cb9 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -177,9 +177,11 @@ config PINCTRL_RZG2L
 	bool "pin control support for RZ/{G2L,G2UL,V2L}" if COMPILE_TEST
 	depends on OF
 	select GPIOLIB
+	select GPIOLIB_IRQCHIP
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	  This selects GPIO and pinctrl driver for Renesas RZ/{G2L,G2UL,V2L}
 	  platforms.
-- 
2.39.2


