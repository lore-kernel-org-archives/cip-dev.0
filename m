Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA02BCD128E
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web10.32665.1711528523352686860
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iEvA/e8D;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.177, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so88033891fa.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528521; x=1712133321; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrYgqeVdwYnOeWQIz1CrzpPUetGM+bBopl7k6wIVYc8=;
        b=iEvA/e8DSXw2/S6sT/G2/HOu3BScAf2COPcizt0XobinS78Z3jTD5Lh/xYSLL5AIKm
         lScrcPEhmdwLu03s9pkjLqMO/OOd18rek8ZqdNs2TUzVtqwpa/h94bAu1jirnqjCH9aV
         uKzl5xek4S76gs+TbT/ckNoiZRyzRnH9eo3YzWd/s8eFq2ToOeZ98bRoPG8RbcSm/HQ5
         gf/iWddfTgE8/AE8G2UF7TVjmjeVjwmWlq2MpxjMZPnak7NY1n2+Vugw2J7dK7HWjGfv
         xkSjEiH+FsLnI2OhvesHiaRjOUEhSrnAt8fAk8/Mdkv2tzF/I7TcjuheIrFpC63dvjZ2
         /iTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528521; x=1712133321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrYgqeVdwYnOeWQIz1CrzpPUetGM+bBopl7k6wIVYc8=;
        b=p/9woTQhnOXeYoZICPRJ/moKScrsYFqAD3Ag8zSybM4GKXnFKRLYG/mnw3Uryu9gam
         HttL8riNyAlFAHO0Xl1tiirTUxeaLHYqQAn7K0r7JEWpph6kawq670mWC7hALjprTIgL
         I/rhwp7sx/JaqeZLsaiyK5HZ84s9RcmlMWQMYiaaObxsgl8w2SregyY/ppbmAXY7F1v4
         60jje9++7aGoshrpybXo/5lMD757r8YMrbP/gv6EzGqx0USXqb+cIt9Bq3p5At5oYViU
         mHwRk3bmuUpWvoDo6jjxWyNh/xRrMU45BaBHCqK3v72UEJpgre1qz314PrUU3D2nel2s
         0q7Q==
X-Gm-Message-State: AOJu0YyEONx55+phRGzwJLkmdV7zI+cG9Weqd/SJSUH6m6YZ9Au7Ooqe
	UsdXVnUyeKdGCvHDGN1JFga+gfRzypZLsGMqy/uUrF5fYwB3wjRAGLlLy9ebfEM=
X-Google-Smtp-Source: AGHT+IGhEBonEAdqFyDfXHcMHGOkILKizatj9SMVw3ye9oti7jh/Id9myLXNwI4/PFU0OYij16lk6A==
X-Received: by 2002:a2e:2e1a:0:b0:2d4:8fd0:b5f2 with SMTP id u26-20020a2e2e1a000000b002d48fd0b5f2mr397465lju.7.1711528521123;
        Wed, 27 Mar 2024 01:35:21 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:20 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 10/13] irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
Date: Wed, 27 Mar 2024 10:35:05 +0200
Message-Id: <20240327083508.2229567-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15464

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 7cb6362c63df233172eaecddaf9ce2ce2f769112 upstream.

Rename rzg2l_tint_eoi()->rzg2l_clear_tint_int() and simplify the code by
removing redundant priv and hw_irq local variables.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 552bc7fa7cff..41b47572c294 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -96,11 +96,9 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	}
 }
 
-static void rzg2l_tint_eoi(struct irq_data *d)
+static void rzg2l_clear_tint_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-	u32 bit = BIT(hw_irq);
+	u32 bit = BIT(hwirq - IRQC_TINT_START);
 	u32 reg;
 
 	reg = readl_relaxed(priv->base + TSCR);
@@ -123,7 +121,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
 		rzg2l_irq_eoi(d);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
-		rzg2l_tint_eoi(d);
+		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
 	irq_chip_eoi_parent(d);
 }
-- 
2.39.2


