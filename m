Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62309CD12AA
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.32437.1711527495978523115
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Gk3apxAX;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-414936696b8so2566105e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527494; x=1712132294; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTFTYyPxK41THmzzwQ+3qPSzWk1QcNohDxoAJus3/kQ=;
        b=Gk3apxAXb1SgLVOrFlWMPxAKMpGL4/uwh31vgTk/4Mg4tYwAVmsswgnxnq4WGUYM8v
         A5pcA6qs76zDviBMgpZWkF8DXy+q9q+AdfEbeYa5G+65TsGDCEV0A93iY7zD7zcLmeJi
         2Zmcu3entJSXcLflG+EdSkpnJvkiFquW8RWf51W3SMisu28X3zmV7NU2wzyAUcW40+ZK
         SSobvkF4G9A3tsrOOCsD1ncbdgdug6xypXWTL9eJf3zi0hLw1tYjhImqhExd7deiayOH
         m5MIMnGK7I13OFGF3R9YMCZge/+JlM8uWiA95qfbgvoT9DRxL+1kyyOOu26vuoG3dfSA
         TyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527494; x=1712132294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTFTYyPxK41THmzzwQ+3qPSzWk1QcNohDxoAJus3/kQ=;
        b=Z6gpnsTJlzCWnLJi7S0RaFwaD7y5FJi0bUv79zjamABmiuWyKXcKZWFzqo10B8RkvM
         NG2uCOnXZkH78FMaDKA/ya3DNzT/sPw+rM/4v41gN8/AR+HsjpHV0mHxZrwp5yrDumyg
         6sz81zVtmpMEiT2tqpGwia414VljP6qj37BzpXNrXA09L7BETmgjrVoVP/JyVkizC+Wg
         Nn8AaFkqttuGueeS/c7ddlsMQCTKIN6la5honOcsAcX3+SXzjK/zjZkQXwxYQgWDTunY
         +IRdUsjdjyL6St0joNDubdEYux1/RPldZV+H3VFwZxEqicivlJ2SXC/hqrNhWRB3jEWP
         euFg==
X-Gm-Message-State: AOJu0Yx3bxNL9hRVHXctFFboB4BpqLRdTAnlILcFqHMxGRAW9+wGsKSB
	amkzqUkq9ctrWGwopXXH2YxLOKjb8MDZSq9QU/S8ACn3Z32brPzm88O8P/EyGaZhuDgGyFz91uv
	l
X-Google-Smtp-Source: AGHT+IGFs9oP1Ik3jkAROJnKk7mX1V9vSavVTxF9sl5Pcy78Q/eMedlzrRZII9T7EZEdIqK+X8EQcw==
X-Received: by 2002:a05:600c:3d90:b0:414:90ea:34ad with SMTP id bi16-20020a05600c3d9000b0041490ea34admr2417652wmb.6.1711527494503;
        Wed, 27 Mar 2024 01:18:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 14/36] irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()
Date: Wed, 27 Mar 2024 10:17:34 +0200
Message-Id: <20240327081756.2228036-15-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15431

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8a4f44f3e9b05c38606b2ae02f933d6b64a340dd upstream.

Use the existing irq_data_get_irq_chip_data() helper instead of
open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/8e47cc6400e5a82c854c855948d2665a3a3197e3.1695819391.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 24701d38c022..67856b865e98 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -131,8 +131,8 @@ static void rzg2l_irqc_irq_enable(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d);
 
 	if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ) {
+		unsigned long tint = (uintptr_t)irq_data_get_irq_chip_data(d);
 		struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
-		unsigned long tint = (uintptr_t)d->chip_data;
 		u32 offset = hw_irq - IRQC_TINT_START;
 		u32 tssr_offset = TSSR_OFFSET(offset);
 		u8 tssr_index = TSSR_INDEX(offset);
-- 
2.39.2


