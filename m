Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C0C47DD9
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web10.32668.1711528525917814058
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=S4+0imQ6;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so4541685f8f.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528524; x=1712133324; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tu1ep3xwK9ePtfWRWM4MUc7UF6/WFb2vOdcNpjVjdm4=;
        b=S4+0imQ68JdTqOQ4ajJiuA71XtDQC9oNywvHualmFhnAnlTASFtNdSH3cOnnHlaFtc
         5xcWTWPiob4pJChY256Pv3gYH7YG361bbT0yTPmWG7rX9LxNj1p43xOgKG20MHBBdG2c
         OJhVFejLree8veIp8kmFFKxD7DUPYNspa5DgO+59ViC9TBEwat3Yn8vaDheehG0Kx07K
         T9Dmrqanrnz8ifQfEYaD26EY3+RLkPttGQ4MQCNJ687OFmuR/KbfMRUjj/8Hktv6kyZq
         qEhxtG7rIrPEtXOF1wU7I82QJE6fWVGVqbS5Ci8d05eCPy7fX8EJyh9sxwWW037IHBSV
         aEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528524; x=1712133324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tu1ep3xwK9ePtfWRWM4MUc7UF6/WFb2vOdcNpjVjdm4=;
        b=Ke9LwtnZHzqvQzDmHE5eeJPR+yxYhrwdorfpay9+B6awuHhQZ4tMAkndDOQf0tzYeX
         Cg/I3FAZrxXQDTwW0/cG46mxO4HBCjf2SFVGMnlCPIUNPrJWml8rDkDURy65AmLYwzAT
         h3kexQTW4d5HpcI6O+yZhCb2ZUQJlw1zB+fAPCSrMqjNinnQPGW8+ceWomG4jOYEiY2j
         YsaQH0MDXHGzsVBwDivsToQgsYN4ME0HtcbkNAmTqc1gfC5z1aOIFRSoNtKvhr4vjCM1
         rN7KFD9Gxk9EsP2lfk0kmr1wpGQKV2y0YzyWZJWlAGZ8kLM3zqOKVmSU5ka6BoVlzvku
         Wg1A==
X-Gm-Message-State: AOJu0YxdU88vg3o06sLjLkeDNZ8rd+g08yTDy3rdkTzlgVjESao1fW0V
	QnuAbNUHmkiPZp1vD/zdnOdOJpfe/v9so/NJ8a2T3THYB+oBoxvzZ3jhjAPHoLKe9ilCGnzA+pW
	M
X-Google-Smtp-Source: AGHT+IGRLuRQ63iUcPuqu8Gbh60pEHe9PYm9bevX4FqONkoUS0DLgFCpeMB1Fgh+cmW1jr7GBw+BXg==
X-Received: by 2002:adf:fc0f:0:b0:33e:afec:e7d8 with SMTP id i15-20020adffc0f000000b0033eafece7d8mr2404094wrr.42.1711528524397;
        Wed, 27 Mar 2024 01:35:24 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:24 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 13/13] irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time
Date: Wed, 27 Mar 2024 10:35:08 +0200
Message-Id: <20240327083508.2229567-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15467

From: Biju Das <biju.das.jz@bp.renesas.com>

commit dce0919c83c325ac9dec5bc8838d5de6d32c01b1 upstream.

As per the hardware team, TIEN and TINT source should not set at the same
time due to a possible hardware race leading to spurious IRQ.

Currently on some scenarios hardware settings for TINT detection is not in
sync with TINT source as the enable/disable overrides source setting value
leading to hardware inconsistent state. For eg: consider the case GPIOINT0
is used as TINT interrupt and configuring GPIOINT5 as edge type. During
rzg2l_irq_set_type(), TINT source for GPIOINT5 is set. On disable(),
clearing of the entire bytes of TINT source selection for GPIOINT5 is same
as GPIOINT0 with TIEN disabled. Apart from this during enable(), the
setting of GPIOINT5 with TIEN results in spurious IRQ as due to a HW race,
it is possible that IP can use the TIEN with previous source value
(GPIOINT0).

So, just update TIEN during enable/disable as TINT source is already set
during rzg2l_irq_set_type(). This will make the consistent hardware
settings for detection method tied with TINT source and allows to simplify
the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 3acdecf39404..9b0a748ea2cb 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -138,7 +138,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -150,7 +150,6 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
@@ -159,7 +158,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
-- 
2.39.2


