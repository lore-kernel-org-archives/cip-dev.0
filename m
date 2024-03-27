Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8943CD1292
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.32518.1711528523803034073
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Bm09GCB8;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3416a975840so4868948f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528522; x=1712133322; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+Hq2Scq0ORnlZyCyAOyivVEz7ED/K9AXWQbnXxXutw=;
        b=Bm09GCB8ufJmPnN8ygFJ6p+K3ErU6raFlgvhu/ifPDdvplzMaJC9tuf57I0MvalTwC
         YsnKMBBo9aEcuyGVT7HfcyJsfSltiwAc9r2e0DytwYy4iMgnFfFzXlZ0+trMvCtakskZ
         baaMEopJ5g9ZGTDjI55SMW3ANlBl5PGm9KY6lwm2pczF4HlkE7OeuEW7cu1U+jh1WW6w
         LNVc95GUYox3sGdBext90WBAUEH8YdBHvZHMhYa5nYk9eENdlXn/x6UmNzRqKBBd3BXq
         YC2NMHaxErg+k3RYz8zDSLju8ztomeA1AKI9vdSb6wAKiTOOu4P/4tQf17V4QuM4tbKM
         OoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528522; x=1712133322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+Hq2Scq0ORnlZyCyAOyivVEz7ED/K9AXWQbnXxXutw=;
        b=ZCnIVXvxi/GUgo9KLl0qaW3UYCmnTfL8kazKXgjmzG5+CCVQuZ8R8vkHBaf3A6D/wY
         TErvGUp9SJkEOwvXVuRk4XPeM9z2fjyK5DW3IXcSfzGrHXxKnEhmz92awsXy0TIjRQfy
         BfoMLCLD7TGefMYlwRpZ5UMkqGUkGtDT6C3VqhxH6KkSLjtJlHbONBsmokN2R+DJhOnN
         jNeDcUr+skt1d9jg/ft5TRaVZiz71a5mR6sul+7+hV2jic3zQL8el99Mo+mkf5asz77v
         S3VXUnwjOfQwOtag3U/5F1IsRmp+0UmmpKP+0ppEw6inMtwv9kw+DD77hcOZ7V30TOeT
         63QQ==
X-Gm-Message-State: AOJu0Yyn90yRnlXsQ40BLuolnYD7gE6vpirQzfmIhZyKI0j9rok64GJR
	AR9IBn5KnbOF0PMVZOTlpavuVyOpAtFh/4ENjn/g6cIAsOdZYisYW5IsG76O3qk=
X-Google-Smtp-Source: AGHT+IEVjkkIL2QApLTLdpBafqz1i8qj9CBSzAnauTtMGDcYm8Tq7IeaMF2nFkJ2RHpT5cX00M//sw==
X-Received: by 2002:adf:f88a:0:b0:33e:6056:6b8b with SMTP id u10-20020adff88a000000b0033e60566b8bmr3808437wrp.7.1711528522276;
        Wed, 27 Mar 2024 01:35:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:21 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 11/13] irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
Date: Wed, 27 Mar 2024 10:35:06 +0200
Message-Id: <20240327083508.2229567-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15465

From: Biju Das <biju.das.jz@bp.renesas.com>

commit b4b5cd61a6fdd92ede0dc39f0850a182affd1323 upstream.

Rename rzg2l_irq_eoi()->rzg2l_clear_irq_int() and simplify the code by
removing redundant priv local variable.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 41b47572c294..fb04e5450497 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -72,10 +72,9 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
 	return data->domain->host_data;
 }
 
-static void rzg2l_irq_eoi(struct irq_data *d)
+static void rzg2l_clear_irq_int(struct rzg2l_irqc_priv *priv, unsigned int hwirq)
 {
-	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
-	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
+	unsigned int hw_irq = hwirq - IRQC_IRQ_START;
 	u32 bit = BIT(hw_irq);
 	u32 iitsr, iscr;
 
@@ -119,7 +118,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
-		rzg2l_irq_eoi(d);
+		rzg2l_clear_irq_int(priv, hw_irq);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
 		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
-- 
2.39.2


