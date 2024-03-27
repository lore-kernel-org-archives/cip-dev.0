Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59051CD12A7
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web11.32288.1711527488365563536
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EcHg27hf;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41494714fd1so2171615e9.2
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527487; x=1712132287; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVEyDplVIpP9cdWkq05qf2SYfw8rH6B38WcrbtKAotA=;
        b=EcHg27hfqjh+3M3X63nV0WuUPDKhh99E6G+J48HPkx2A3tuT1KzPXx3D9k9qw5u4Wz
         i6/+InJcpPYbl+JH2ifp7+aqhQhvPCGmsC+ifExWoe215vXQE3FoSV5+ESVuoVlUsfcZ
         9pzyo6KtshqbZKzUcLRGyC1SYozQuUKE+2JspweQ0YmUPu38CB9KOw3nEBlfIU2phoH4
         5yj+DG1BuqxWYakaFQ0O4cgCLK6CDe6Meut6RLMatZ9OgUg6nekiJjbugNnGprmZNk98
         CWEW7fvBndH4lOmiSWPlk+jkvrkX09flPUcSrEST6equCr6qjJF2H3Pw/9deKNxneLYZ
         z3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527487; x=1712132287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVEyDplVIpP9cdWkq05qf2SYfw8rH6B38WcrbtKAotA=;
        b=StVD4D7UM9Pj9n149tjxCtdj+7lBKQt0+YiiGTvs4onvSGx1H1yEQbNf6I7Bflvgxl
         e6sVFODgvXA9gbp34cWDzfNtyomugcITif+QAgY5iMa8Bgaz0dcscaUt23UpJePh3EP+
         biJhOqAZVXyLB5TbMCZkoTHqknf6eQsPNNUu4RYXuKNGH6kqwBW6/4RFWeVUn44TGto3
         BV+Gp8iGMbnNzqzlEiqWxsILbxfd0W6XwwMjwD2kw3MSbZDDkPIBTs+qZUYvvjounhFg
         JSZw6408f+jsAPBqiHmBLlVAXDlQzf2xfjwJq5y09L4MxOf9vhJVXYzwm1VEH8L/cwVa
         SJgQ==
X-Gm-Message-State: AOJu0YyPj4+DY2XuozYfvo82QsLltUswlgOaeu0tJvwcsXzCwG91SNeT
	vbDf7LiC0B04HO7fIecG0aQYnzLvENcUZoI9HC/AtUf/iTxCU41NlQesJZGcKpM=
X-Google-Smtp-Source: AGHT+IETQ2ouWa1W0GcfCGVx+Ik4psJWhNc5n0IwuQkl83f1vEc2ngbQyJZ+SnGUKFg1e9gEbDMPkg==
X-Received: by 2002:a05:600c:4510:b0:414:1351:8662 with SMTP id t16-20020a05600c451000b0041413518662mr2650359wmo.12.1711527486830;
        Wed, 27 Mar 2024 01:18:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 07/36] pinctrl: renesas: rzg2l: Enhance driver to support interrupt affinity setting
Date: Wed, 27 Mar 2024 10:17:27 +0200
Message-Id: <20240327081756.2228036-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15424

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e4c3a81ab88f3230713f4678deb9dd3cb8d0382c upstream.

Implement irq_set_affinity callback so that we can set affinity
for GPIO IRQs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231011195923.67404-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict by removing IRQCHIP_IMMUTABLE and
 GPIOCHIP_IRQ_RESOURCE_HELPERS as these are not available in v5.10]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index a0a704449caf..2965c67d8ad0 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1242,6 +1242,7 @@ static const struct irq_chip rzg2l_gpio_irqchip = {
 	.irq_set_type = rzg2l_gpio_irq_set_type,
 	.irq_eoi = rzg2l_gpio_irqc_eoi,
 	.irq_print_chip = rzg2l_gpio_irq_print_chip,
+	.irq_set_affinity = irq_chip_set_affinity_parent,
 };
 
 static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
-- 
2.39.2


