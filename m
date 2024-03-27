Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A053CD12A2
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.32301.1711527506948044536
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=mHJLGiC7;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.41, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41495ac5b91so916565e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527505; x=1712132305; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPv1Y9B0fxu0PozBK8+dqYxasHT8vQsQOUiTA2Kx3bY=;
        b=mHJLGiC74ajPUOZp6IQLl5FRdHbKEym7FPsciGhFDr2AmLTtObUi4fLwmWv+mQW5oo
         EVwuuYsItl1AdLyC0SsQvwkIySqAPUuloc1XcUSC2WPHRtEvW4ESjhp0WDPCQzIgtv+w
         PJ39orxi4gwAigm5xUPWJYuYm6Xe0VRobIhocIKRQUdkGJQdyCgVnntFsNEuLNzHRs/o
         Bb2toddXeCh4AIIyWpSITnty+hCAwNhfw9d38gIGn5ECBi8Rvw7OhFpUkvMxn8U0ocR0
         OqVNCxhtgEYYMdK4QiUYKb9vuCeeD72rfm4QTjNrXg7nj7c33YSXoaV6jK5+LNSY3FUh
         /XVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527505; x=1712132305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPv1Y9B0fxu0PozBK8+dqYxasHT8vQsQOUiTA2Kx3bY=;
        b=jUxhSF2BAV1vXlimjepL1VvMMi+NEKywEZZmgr2NTgu/qgcP0PBaOge47uDwSMbfIX
         yDNbe/zah2HeayW1v0wzMtclfMB1R5nEd4mPu/iAUykLw7q87J/Wi/X1JM9C0wartuCJ
         12wAHI+WQ/iRupyLXj4D89NrB/PxZw5u4Bgmf3W2ZX8o9Sy4TQIDphg6mwIGKiL8v7Ei
         oQatHKujRDtjyEoBDwz08ba+6oMrCTORphxs0EHCDmgupWz5wrDigg14mj/HBYT4iQ6V
         aHkjTmJuy8p3FUkSqSFPIB+qditffsJoRhtmL+gU8LVZQe83Ay3xS+bxeHgl87cZTSFC
         Dt9Q==
X-Gm-Message-State: AOJu0YxofWUG2OZqpCP2XnLNAq5N42pRC4FKgVdQ4u0inU7nFE6SxIuG
	UkvRsqFyRm8aJR/Tq0VVoTnckfPyGn8PcQPzn87rZ2ztCAMu5L3ejNBcB+GXaiBvmjeY0MdpKVu
	N
X-Google-Smtp-Source: AGHT+IHsKLqqiT+AqslCifFalutnlNUDiMBFtCuiiK2wGBU7xHCdPqgWv9gW+c/flHVAuE7m1FD+uA==
X-Received: by 2002:a05:600c:4994:b0:414:12b6:7315 with SMTP id h20-20020a05600c499400b0041412b67315mr479826wmp.17.1711527505465;
        Wed, 27 Mar 2024 01:18:25 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 23/36] irqchip/renesas-rzg2l: Rename rzg2l_irq_eoi()
Date: Wed, 27 Mar 2024 10:17:43 +0200
Message-Id: <20240327081756.2228036-24-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15440

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
index 315c58d99376..09bae23e5c8f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -73,10 +73,9 @@ static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
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
 
@@ -120,7 +119,7 @@ static void rzg2l_irqc_eoi(struct irq_data *d)
 
 	raw_spin_lock(&priv->lock);
 	if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
-		rzg2l_irq_eoi(d);
+		rzg2l_clear_irq_int(priv, hw_irq);
 	else if (hw_irq >= IRQC_TINT_START && hw_irq < IRQC_NUM_IRQ)
 		rzg2l_clear_tint_int(priv, hw_irq);
 	raw_spin_unlock(&priv->lock);
-- 
2.39.2


