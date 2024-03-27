Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD28CD12A6
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web11.32303.1711527509969048704
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=C+WsW5pz;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-414911fa3edso6111915e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527508; x=1712132308; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96ExSf+tuNZxOLDwW1zKAG18AoHs3Ye6k0i86zxw7TM=;
        b=C+WsW5pzCBJimN2oZplS185HMiKz40/p0Mq4yaTNJJsepV1C5d6cBDWSo86oLa1Onm
         sks51jiYCqYW51Mu/nly/D/HmnOpED28/Padc+5vxWdCQIpgMMqp7SAZ4vQDEahz7kFi
         xhUpjiQgh5LSRysi/MxbrvOGjL7VYI3WBL/FrZNvIkz8w/es7WrD5VB3B+JcgWLMVT7/
         fpzRuRf3cH4Q3ETEAHBeK6vnJBFrSk0GLWYNKU+Xx76lrtS262dtWpAwyzJ2Fse/ywKZ
         n7z+17h5wp48tU/qB0ey7GjqyH5Eo/6ssBUFaOgern516FvwMMGX6NwF+vLlHExI08zF
         cAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527508; x=1712132308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96ExSf+tuNZxOLDwW1zKAG18AoHs3Ye6k0i86zxw7TM=;
        b=dSDEuokBsLYO2wvIz77pAyhUv4D17DpdkTsbuXoTPXc1ol8zc4ZQHf+okVedMML401
         jTugYlHDwJ98XGDUPye/K/eQxr/cpCGv+CI0n6WLeVUkAHsTpohSkMASu47LiOYjrVkG
         YPcjWwX5Yum3+CXxSOXKKYl66PnQLKji460sXOj28jqgH2HXtr6VnZ48ot/C5xpwbpLA
         VZQwupzYG0qGJ2w1m8NVxJj8RMIufEnJ0UMo+LlZK7fT19mZhvZLunjJmxp7WiTa4KKn
         kMcqDHc65rm5lv6V1AnmsW+06jG3XhDkTtM7h2x4te3KAHEgIqzT4Tybrlrn/PtvxYkq
         wdXQ==
X-Gm-Message-State: AOJu0YwTDXMTNQDsGaSX+yaK32bGmUNXkffBtSwGx8bLGFOqHei2EmIG
	4+yskMEtXOLrLugzQUUaM9ilCfgYrD+ylkot7o7gtMHV71hZkmvvJxmKcGmGel0=
X-Google-Smtp-Source: AGHT+IEwcQVevZmBAGi4r2MrAHtEsjVAw87x+EL08oW4kSs5elShTSxUXNyig0puqelzZuoehd1ESQ==
X-Received: by 2002:a05:600c:4450:b0:413:1ae3:8dd2 with SMTP id v16-20020a05600c445000b004131ae38dd2mr1302347wmn.37.1711527508417;
        Wed, 27 Mar 2024 01:18:28 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 25/36] irqchip/renesas-rzg2l: Do not set TIEN and TINT source at the same time
Date: Wed, 27 Mar 2024 10:17:45 +0200
Message-Id: <20240327081756.2228036-26-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15442

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
index 7b20af3886c7..628b1c606bcf 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -139,7 +139,7 @@ static void rzg2l_irqc_irq_disable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg &= ~(TSSEL_MASK << TSSEL_SHIFT(tssr_offset));
+		reg &= ~(TIEN << TSSEL_SHIFT(tssr_offset));
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
@@ -151,7 +151,6 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
-		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
@@ -160,7 +159,7 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 
 		raw_spin_lock(&priv->lock);
 		reg = readl_relaxed(priv->base + TSSR(tssr_index));
-		reg |= (TIEN | tint) << TSSEL_SHIFT(tssr_offset);
+		reg |= TIEN << TSSEL_SHIFT(tssr_offset);
 		writel_relaxed(reg, priv->base + TSSR(tssr_index));
 		raw_spin_unlock(&priv->lock);
 	}
-- 
2.39.2


