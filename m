Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8EBC27C6F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 14:09:21 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.42761.1717769354673788753
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 07:09:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oEPb9Mpz;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so274925666b.2
        for <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 07:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717769353; x=1718374153; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujgjGDj0/3vKuYGaqzVxDf1u6q6l/hgWjY2WzdxvGHw=;
        b=oEPb9MpzfOXM8mr5CmMzvxvDZC8V4tWfVgCKbfhwoemU49F7fdv2ma9He1wM/ELAuu
         9zJrOcrpgKoMUmCZPikE2h81Pni7lXA5TgKiobVFkEDOc1i7WDvQHGYQ6QMMTeegET0P
         z4D9B89OBwDBrTeH5YHSCFLXtDqWcAdTyytFSSgSt9X3DfcEhMLdI9+M2R/fyMVZfl5z
         grBrsairT9sfUlmd6GrK6XYlHGf4fbXvaGvcTLu4ZWOW2rPhA4SHA95tRFcPxqZdmGi6
         hniYxJaL+xgn9kFU3HTblEJyRw6gdh7C+tGgD2BdAtWwEGCj7OXajxXeNFqGOywQNen6
         iqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717769353; x=1718374153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujgjGDj0/3vKuYGaqzVxDf1u6q6l/hgWjY2WzdxvGHw=;
        b=VWgchIfH3SvsdH6JUTFK9+84M77MdWAytBLnQn6CBeyhy4GD8InMRGNNq1PqsAiLE0
         jdTGLurA7eScx/XmyVJMkVr4rHSDgLJBZyAEZJOiOTjZB3Uz+Q7M3ljlBtAhKzg0bESj
         QlrEFYMZ997QPYjH35FIptP1rrx6kvYIdppfl6KwnYXh9g52M7vBZi/rdDHdZYQ7FTjb
         Txex/+EYUS0ukG+7NUdvyMHZqpmPivOwYAHyeeMC2ppxsR2m1hTRTDupB9jid4tihzLP
         6LUgOU9+RRHv2xjnfoCDEoolc/opoQ2xwegRagvsT6iKh1uDvwvVlLqMoraAgvFXHORl
         AyKw==
X-Gm-Message-State: AOJu0YwUHrXkZoi0mgrploP9ECncELiQGDQFAv9gs+3r0QoSqxJcoIdD
	7tM3URUHu6M17x+IECpR5/+Z7snrB3phtKfCj2u1YonsenTrWvmKXnad0eoxgu4=
X-Google-Smtp-Source: AGHT+IFz33iLK8iXWW02wDhh0qpqMpgxFlyAso5lGBfYHGEtW6rJ9zLp246W7EgZAG+ITWQI9cNDyw==
X-Received: by 2002:a17:906:3e05:b0:a5a:88ff:fe81 with SMTP id a640c23a62f3a-a6cd6663f9fmr187582066b.20.1717769353103;
        Fri, 07 Jun 2024 07:09:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581870sm251987466b.25.2024.06.07.07.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 07:09:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 10/17] pinctrl: renesas: rzg2l: Select GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERARCHY
Date: Fri,  7 Jun 2024 17:08:49 +0300
Message-Id: <20240607140856.2497508-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240607140856.2497508-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 14:09:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16171

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
index 1ef875980261..5fc190fa2f68 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -192,9 +192,11 @@ config PINCTRL_RZG2L
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


