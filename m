Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71385CD12AE
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web11.32292.1711527491797665936
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fPJTIVHZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso7053863e87.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527490; x=1712132290; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNdJcT/r3Etvi39EvpZvevHsdOmLdQOuqaGvUrg/Uso=;
        b=fPJTIVHZ9otcLv64uYc6F7S7elOdd+zjrpHt9LMoXgSzwa7dOs+2n1PpdbtNyD631D
         t68gc/bvF5mA5nPYM06vby4wp1RDdCN7tVlQ6NBAkPATN7hH2kxazCjjlwek3xqnBdYI
         zYjvPMB8jjvoyT3AC3SUxUJc5LahPR1UnvSlZHajZIrt7vH3XMVGEPy1v4K42CLJNEEP
         7rExatsl3s8VkJteDUCNGAq7PfZ0jmwrcewSwKuTaGOUsbcAzcSu4x0hcxMegN91/TD/
         TFzZvsGsRT7hAcNJZp7Lt00U3iGDFSVtPL+DM/cX0kHVGwhmkM51icIErpaJ1I3SbtMu
         k93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527490; x=1712132290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RNdJcT/r3Etvi39EvpZvevHsdOmLdQOuqaGvUrg/Uso=;
        b=kwHBlzOIGneDquCsiQp4eUmHjdLAmY0pMQIRQayyfMU/WZfaMhoOwz9zRXlGx/w1Nz
         F2aC9bwKmJMhd9GPRtFyOrnvAuZGbL0+FJ0sOxk0O1jj5d9fFl0ljpvDEh3L1A2foq9y
         Gwz9xI1cOaIAesvBzcmeYrInPSQn0olSGztxNcI0hZYh4xrE6MFPPQJxau/oyqXownFh
         DRTRKeMbHQWu4wfq3Ubnn71IwkG17yFouiMeMiDAW/ke+dixArgZCXk5PX4JiHOzIwA1
         MJpujAnxqyAsSXldUQbeMRxTLcZpc71nLgtyWD3e1RmCZ5SzKdnv9aihsmQUseGlwGdS
         T7Fg==
X-Gm-Message-State: AOJu0YyWx6d1be5qeUUwp8YUaV8XvsuyPOn8D9vU9AFP8JX7fcDDUpr0
	OTkIaaaf118h9rQL9JbizvjFWEW24CmT0UKqY54h9v/O3CWUGtHqtBRNqPa7IV8=
X-Google-Smtp-Source: AGHT+IHf8UmbTn8aI1W5et6XE4GSXCRVIxANYyWY/egMXdMOahWAgmi5BUKQjQJya282vvj/fubgkQ==
X-Received: by 2002:a19:e01d:0:b0:513:cb0a:9632 with SMTP id x29-20020a19e01d000000b00513cb0a9632mr3717051lfg.50.1711527489995;
        Wed, 27 Mar 2024 01:18:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 10/36] of: platform: Skip populating IRQ to device resource table
Date: Wed, 27 Mar 2024 10:17:30 +0200
Message-Id: <20240327081756.2228036-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15427

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

IA55 IRQ controller is connected to GIC and pin controller, the topology
being the following:

                                     ┌──────────┐          ┌──────────┐
                                     │          │ SPIX     │          │
                                     │          ├─────────►│          │
                                     │          │          │          │
                                     │          │          │          │
             ┌────────┐IRQ0-7        │  IA55    │          │  GIC     │
Pin0 ───────►│        ├─────────────►│          │          │          │
             │        │              │          │ PPIY     │          │
...          │  GPIO  │              │          ├─────────►│          │
             │        │GPIOINT0-127  │          │          │          │
PinN ───────►│        ├─────────────►│          │          │          │
             └────────┘              └──────────┘          └──────────┘

where:
 - Pin0 is the first GPIO controller pin
 - PinN is the last GPIO controller pin

 - SPIX is the SPI interrupt with identifier X
 - PPIY is the PPI interrupt with identifier Y

While the initial driver has been developed it has been discovered that
there are issues with this kind of topology because the
platform_get_resource(pdev, IORESOURCE_IRQ, ...) relies on static
allocation of IRQ resources in DT core code (though of_device_alloc()).

When hierarchical interrupt domains with "interrupts" property in the node
are present the usage of platform_get_resource(pdev, IORESOURCE_IRQ, ...),
relying on IRQ resource allocation in DT core, bypasses the hierarchical
setup and breaks the IRQ chaining.

In the mainline kernel this has been addressed by converting all the IRQ
drivers to use platform_get_irq() instead of
platform_get_resource(pdev, IORESOURCE_IRQ, ...) and removing the
of_irq_to_resource_table() and associated code from of_device_alloc()
with commit a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource
from DT core")"

To keep the same driver code and device tree bindings for IA55 IRQC the
of_device_alloc() has been adjusted to not allocate and parse the IA55
IRQ resources.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/of/platform.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 43748c6480c8..f7ce5f0faf85 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -119,7 +119,10 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	/* count the io and irq resources */
 	while (of_address_to_resource(np, num_reg, &temp_res) == 0)
 		num_reg++;
-	num_irq = of_irq_count(np);
+	if (of_device_is_compatible(np, "renesas,rzg2l-irqc"))
+		num_irq = 0;
+	else
+		num_irq = of_irq_count(np);
 
 	/* Populate the resource table */
 	if (num_irq || num_reg) {
-- 
2.39.2


