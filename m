Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BA5CD1289
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web10.32664.1711528519390737639
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kSZO0CjP;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ed6078884so314196f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528518; x=1712133318; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4klHwwGvFefUrgbr/340K/aXWghF68u461LnquTd7wI=;
        b=kSZO0CjPSwNRv94+SZt7coPh5RxxhBJOcuR/bfbW9uxa10IgerjEamCeyMY5sKWU5o
         iHGuvTMGQCFWa3x9MgXb9zlecQCFvacXNyew1faR3Qvh45R0b9Sq+bovQclusm9XSzLY
         8sumJzBNJWAXJr4WiEENGYDCaCazNVmfca8sZWXS8eoKjzwYGcVhC6caqvxUb9RQESqn
         S93KbsyR6iv0XIxxYeZKNj2xqF/yHVWHtOF8Iac5QbvKjNNVYb3fwhmMQ+rjUlZ+lQLG
         7kH6dXZUaN+wG47RwpZZpyPsGF8ay5jMx9p/Wk58JdtFgLVkPFCasBNkYibDKlpa+gN0
         StEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528518; x=1712133318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4klHwwGvFefUrgbr/340K/aXWghF68u461LnquTd7wI=;
        b=AuzeIGedNs4EqqjXf9BMCMU/YVFwzMKrVk0l+HIi/a6VpF6zIjm/63vMH4Xy3N24V1
         iuM2UCPFhqKVZ3NBUB6BA6+mGbHL6GUnSU0D4j63Gzh9NsjR5kpd1Mka0x+vokNzccql
         eGCB0/Lk90gph1PCfHlNV7zAKZ5E2akuxUxJR9hTyDB/ORZF84aCADJFZfS50c37rddZ
         SG2w+CzmLLT09sT5QfXhH9SpDRBN4KTe2P95bcpTUjkxAPxzuW07JgEsIPwaJxQhZyaA
         OijNw2w+iNRHb0+i4qxA8259qIMfxa+G7gD91PLE8aynkZULaC/hVX7TkDuQXJUnuGa8
         1pTw==
X-Gm-Message-State: AOJu0YxTRkLgJT2ABXMRcIaKYbvpKxv++zM2F1R/7GyIsnN9uTouCM8z
	j7n4Tv7S3eKwZ53cEzvsLdU0GQqZv1Ocr7LmOGcOxe4YkDdV1Lo17ZWq+jEACtA=
X-Google-Smtp-Source: AGHT+IGcHsjxzelCiqCG5MyirHUlzF5LALJ0wmrjtPC2nAvI7EtYtyDtXnbFADejwPuVBXXjffp64A==
X-Received: by 2002:a05:6000:1376:b0:341:ab6c:71e4 with SMTP id q22-20020a056000137600b00341ab6c71e4mr3516331wrz.19.1711528517893;
        Wed, 27 Mar 2024 01:35:17 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 07/13] irqchip/renesas-rzg2l: Implement restriction when writing ISCR register
Date: Wed, 27 Mar 2024 10:35:02 +0200
Message-Id: <20240327083508.2229567-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15461

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit ef88eefb1a81a8701eabb7d5ced761a66a465a49 upstream.

The RZ/G2L manual (chapter "IRQ Status Control Register (ISCR)") describes
the operation to clear interrupts through the ISCR register as follows:

[Write operation]

  When "Falling-edge detection", "Rising-edge detection" or
  "Falling/Rising-edge detection" is set in IITSR:

    - In case ISTAT is 1
	0: IRQn interrupt detection status is cleared.
	1: Invalid to write.
    - In case ISTAT is 0
	Invalid to write.

  When "Low-level detection" is set in IITSR.:
        Invalid to write.

Take the interrupt type into account when clearing interrupts through the
ISCR register to avoid writing the ISCR when the interrupt type is level.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 0a77927b678b..d450417948e4 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -78,11 +78,17 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	u32 bit = BIT(hw_irq);
-	u32 reg;
+	u32 iitsr, iscr;
 
-	reg = readl_relaxed(priv->base + ISCR);
-	if (reg & bit)
-		writel_relaxed(reg & ~bit, priv->base + ISCR);
+	iscr = readl_relaxed(priv->base + ISCR);
+	iitsr = readl_relaxed(priv->base + IITSR);
+
+	/*
+	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
+	 * falling/rising-edge.
+	 */
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+		writel_relaxed(iscr & ~bit, priv->base + ISCR);
 }
 
 static void rzg2l_tint_eoi(struct irq_data *d)
-- 
2.39.2


