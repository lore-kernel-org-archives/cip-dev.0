Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D41CCD129F
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
 by mx.groups.io with SMTP id smtpd.web10.32443.1711527505815165073
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=dqDWVkoq;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-513d212f818so7295113e87.2
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527504; x=1712132304; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XcPdoCzowqFBnTUG3qfKJATd6js+MqTUX5WcMQpHJE=;
        b=dqDWVkoqcJBc/MJpCT9QAgnwPjK7DrANgq6Ol//vli1VgUp3kR81n7PNxI8VFtNWog
         jAnVWKKJLqQqvmJMrJm2p+N+vGS9QsXYKJ3v44E590GMiwuP1ebNQjA2DLG2+kZXBVtf
         XOfGnPNkDQ59olCXQQLxn1xYMQ0O0O+sQ1N7pPGw0EKO01Tz840B2VHmFetIi4g6hdaT
         ok25lXsTWRcJSlNAG4KEnv6BNmZOqFQLU2BsnN1IO6LRLuNKO8E0nQvoMwzgv+ugBG/A
         p8ui4Kw5RMvKTENzFGQ3Fl6zwh+4hYU6kT/LGTAekoZNSH9mW7p2ZSp9Zz8oi5Mz8pTx
         0x8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527504; x=1712132304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XcPdoCzowqFBnTUG3qfKJATd6js+MqTUX5WcMQpHJE=;
        b=ASnlIVgEVc1BeIrPYTfMxrxoiWBSR401qdWlgSW5Iqpj2pb+UoZPRI3X7cRwk83YGP
         eLF6wbMG2/kRwic56ctjNe7BLygnDuBRJkt3/vtDCgMdFlNn5vITO/cPRXU1W2BTMO1a
         VJLPb8/m7cLEpu+CBo/WAboswPTyKp2eflqI2GWtxljnyy9XGwFPYcW7CoM6739QRZQr
         ERMn9RSCN8u46yKqYrHIuHFeFF63l82Qw99zhIAy6uSX7+QXCjYAAmpsKMkZdJOsYHab
         Y23DElVh+6ljnGHQWpH/h1YJKmuuPrmuEUSlv5YyBZZzg5iIdp8MEOcE29JkvXgBIceg
         4LSA==
X-Gm-Message-State: AOJu0YxMqY+ug8IxFd87aaH+aGSZNhU9boCzCfg8RtFkX2S/kKLWK3eP
	zVIYdpkKUyqJ7AUVmHMKTY52u3B2jE2d93k5nh4p3fZp/e5v0NygZO2vxrBjO2U=
X-Google-Smtp-Source: AGHT+IEpQyNhEj++J21pssEAY68+/WJYYsnN5EBk91CKPtEHAqp0mEd8tqVqlu9qIuxtZI5Aac7RtA==
X-Received: by 2002:ac2:48a4:0:b0:515:a6dd:9657 with SMTP id u4-20020ac248a4000000b00515a6dd9657mr1117013lfg.16.1711527504121;
        Wed, 27 Mar 2024 01:18:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 22/36] irqchip/renesas-rzg2l: Rename rzg2l_tint_eoi()
Date: Wed, 27 Mar 2024 10:17:42 +0200
Message-Id: <20240327081756.2228036-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15439

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
index 79ce7ab4d164..315c58d99376 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -97,11 +97,9 @@ static void rzg2l_irq_eoi(struct irq_data *d)
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
@@ -124,7 +122,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
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


