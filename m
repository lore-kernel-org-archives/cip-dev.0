Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8CDCD1299
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web11.32297.1711527501834518356
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=rCbbKZBC;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41495d16568so722485e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527500; x=1712132300; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ltpkKQ2RPJir58v2TFUhK3ylb98qqSPKNSRYqXM9iYE=;
        b=rCbbKZBCPGNqfHZjpgz7Miv2eHq1UNPCD2/DnjUMyjvQpZo1wcwR6tQ3ZwdpTSvs/Y
         mgYVUwLMkLrHevGECma2yIK7iQkdSZA4d9XPx7z7ZBoc/5qxR6yrOhkYXkae65QRmavf
         WgcHY1fq+slFeoF57S1MPER95Ddl5spltWE93mA7C0Va5rwskZm1ksha4rNwcq2oqub+
         /ZGzRx8LfqVIm5/pqv0JyoLL0U8gSWk2VM6WXDPocbkDPBhwpGcDqLUdg6Zy3e7S0M6v
         jtKykwdR5MC1xNOOdqX3FlVppePW/bqKVW/S+AmAV31vhPr+g2W5trg5yTbspOXs0nyp
         +pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527500; x=1712132300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ltpkKQ2RPJir58v2TFUhK3ylb98qqSPKNSRYqXM9iYE=;
        b=USvbi45TRhEkvdfQ2qh+GFLH3FKmqoRscJyBY1a7v1ZcsHd6pi4NsHGFMOYMU8k3H/
         9FnRc/0c10ECF2UpiIR5Hw7UBFuzIXdfYKzBRbnjSlFcmVA+zhlf+NQmBsLclpyYl6aJ
         bt/PseTiF4EGgbJgdSPqzf9MbQTILU4tLaOHMvzLGw6Twa3m08Zlh9qcGe4SLFNSi31S
         VG66zd//3V/eqPjJgGyl34IppC80wfAIa2/zy2NAD34yDhR79VdQAAi4xnIa0F85+PhG
         PYe2kxu2MxXvUIwPDpg4FGLzk5K3HsykDF+TZ8kaEDSUUWeFxGEttRBL8fazzYJKyDNT
         JQmQ==
X-Gm-Message-State: AOJu0Yy7astSyD4M2Xv5vumPUOdV/4+dNuGEzbzSYgkmRIYLEML8tKVW
	D1kA5XRaXHow+nxhHCSfjaxe3ONaZJD9lUAsDnHqIA9AUqSBnK8N4hiSxBh6xjQ=
X-Google-Smtp-Source: AGHT+IHYKq6lRQb5LST9o6+LbhZRyRAwnKa3ZPFmgEEEuW3fMUGD/41H15tLegO86qFA9vUgHJvJMg==
X-Received: by 2002:a05:600c:310a:b0:414:9242:e249 with SMTP id g10-20020a05600c310a00b004149242e249mr476056wmo.3.1711527500361;
        Wed, 27 Mar 2024 01:18:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 19/36] irqchip/renesas-rzg2l: Implement restriction when writing ISCR register
Date: Wed, 27 Mar 2024 10:17:39 +0200
Message-Id: <20240327081756.2228036-20-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15436

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
index 92f8d7eeb44b..b87d7ea46b40 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -79,11 +79,17 @@ static void rzg2l_irq_eoi(struct irq_data *d)
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


