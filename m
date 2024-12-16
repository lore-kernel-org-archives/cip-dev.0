Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD0AE7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:06:29 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web10.56094.1734354385302277748
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:06:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YDH/rqlI;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-388cae9eb9fso1059380f8f.3
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354384; x=1734959184; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx5ysSmZoGIWzAkovcFbgV8YILFrZUEHkRYUUn/vqqg=;
        b=YDH/rqlIbcLeowt1M49h0S5QeL/pGbtpQUWnB2isdJvYkrP0wPgBAAGpCLpJtsRPFZ
         f19oTd4oGTZNHv2kEVudzDZ76QYQ/mmeimT+X+MrEqgcoIGO1fLpKJnMZOVilY32esAU
         8b1qxKr8HhUAs1Rb9OUIBdBxNEfZ+mQo5bN5gBYjA2EW/HCwujksPEM+B4dQSr2iBkvC
         iT3lLsSeJ3caszjWOAMafNQJAYReC+bx2jzfdy/39NZTeS/4xVw9NDbpxAPj7q2Hn6Wa
         6WsFUccOC3VCkvyHJrQn2yShWkhzuVP61Yf6XcQLRZbKJMSZ3nrNcYNs868KNij0Bshg
         KaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354384; x=1734959184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx5ysSmZoGIWzAkovcFbgV8YILFrZUEHkRYUUn/vqqg=;
        b=F+d4ZPiDbiJcqKkYwoPn9ttCKmpptPnfveAXUgWbzdtdeAaLg1EhdziT4N+Cw17HOJ
         USV0O6f2MWCgLw/sN18EhMYWtxnSLxTosVTrEJfraOF553ducSsBocYywBAB7G7xRuzE
         AQloXY/35eE/iF0uaNlCScB8ArJBvaQd3WHp88xyIbUX86x3EvEFQn9igAAGxFai3PrE
         N0dbBaQzQNZQ/m6QocPO+Wc+Xaa1QiWZBA0pMC3IG73rEb1kuqS5gcVDCU0MTrdxyhPk
         MgP9FPbSwiBOUEfE7Xz2GZBxgTZtNJHbROg3ToxyFLr1AD5t5EslG81o5oc30jYGIUBG
         XXQg==
X-Forwarded-Encrypted: i=1; AJvYcCV+NrzMlWNEsmX3s4d4yu/JgHM3SeJC4J05Br9OlmOJ4P6v3tG1wbNUjljIQCyZCUkR0HhJdDmA@lists.cip-project.org
X-Gm-Message-State: AOJu0YznaqUNyirrVDOyUGwA1fZwPWfBLSm9X96vcejLpucpimYPW5a3
	KrHvd6Iwai9AGi8aA0s+zPpcdBxcGx6GHFrWkBCl2gcFk+7UkODi/J5Q6g0lekE=
X-Gm-Gg: ASbGncu9ODELw3u6c30j4iExJnQJcHLo3SNViiOEvke4BYLp7agc7VXzzpksgc036LR
	2EchDm3J83m3elomQLigcYNVzutsblIPGACqUfl2xZsn9M0wRM2PwEhkqi/9QJjZyZommWLqVfy
	ZuVzgGFp+5dK0Bjn8W5ULdO9RXA2BYsw/JsVS3xId5yFh+ha2tx4RVY8URROhosI0Fvbs8MT1ye
	Da60VUVDmelYvdsVpuZSWg06af61UsevDhF6IZJeMWAVFnbapbl22USZoFAwIUvxhCDYedth0Zr
	joC5KHQnJpU=
X-Google-Smtp-Source: AGHT+IHJd2Sb5fVrBv4TmG9SD93ozLgSAb3rYgdFxBp+CcEGutnqfVRjGLUt5X6eNhwNd+NnWuKKrA==
X-Received: by 2002:a5d:610f:0:b0:388:caf4:e909 with SMTP id ffacd0b85a97d-388caf4e9c5mr5853559f8f.25.1734354383636;
        Mon, 16 Dec 2024 05:06:23 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801233asm8346252f8f.9.2024.12.16.05.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:23 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 2/3] pinctrl: renesas: rzg2l: Configure the interrupt type on resume
Date: Mon, 16 Dec 2024 15:06:18 +0200
Message-ID: <20241216130619.321397-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17425

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 02cd2d3be1c31a3fd328ee83e576340d34bc57d9 upstream.

Commit dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT
source at the same time") removed the setup of TINT from
rzg2l_irqc_irq_enable().  To address the spurious interrupt issue the
setup of TINT has been moved in rzg2l_tint_set_edge() through
rzg2l_disable_tint_and_set_tint_source().  With this, the interrupts are
not properly re-configured after a suspend-to-RAM cycle.  To address
this issue and avoid spurious interrupts while resumming set the
interrupt type before enabling it.

Fixes: dce0919c83c3 ("irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240419063822.3467424-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c2a0340ca945..517868e4c289 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2044,7 +2044,9 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 
 	for (unsigned int i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
 		struct irq_data *data;
+		unsigned long flags;
 		unsigned int virq;
+		int ret;
 
 		if (!pctrl->hwirq[i])
 			continue;
@@ -2062,17 +2064,18 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 			continue;
 		}
 
-		if (!irqd_irq_disabled(data)) {
-			unsigned long flags;
-
-			/*
-			 * This has to be atomically executed to protect against a concurrent
-			 * interrupt.
-			 */
-			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		/*
+		 * This has to be atomically executed to protect against a concurrent
+		 * interrupt.
+		 */
+		raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
+		ret = rzg2l_gpio_irq_set_type(data, irqd_get_trigger_type(data));
+		if (!ret && !irqd_irq_disabled(data))
 			rzg2l_gpio_irq_enable(data);
-			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
-		}
+		raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
+
+		if (ret)
+			dev_crit(pctrl->dev, "Failed to set IRQ type for virq=%u\n", virq);
 	}
 }
 
-- 
2.43.0


