Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C71CD128A
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.web11.32516.1711528520449403787
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TYvILXBw;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ececeb19eso4252456f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528519; x=1712133319; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mgz5IOTWnZ/x53u6wP29b38SXIQbKurIEUwiPvQMgbI=;
        b=TYvILXBwps/RptxcQZeC4RN4xNDzReDZbCiigKzu+sF3+2ogVrbHjq5FG2nBLVQhCv
         wr+7Mqdoaw4nNCWGEffYCVU2qk/PtCXtT5ZZ2/iP4QSVzWB4wR16UQiii7B6R47GVYTm
         fDR6WtSdDqbhcMtFnzC3dgMKXoOGg58619CQiMOl0Bi6GNvesuO3yFu2tTDAoa29bLUC
         yHciaNcnQCh29ju+P6cyX/R751gNgHTG1rKSV8RruqyfrU19o99/A7TbAAKFZcs9TbRP
         Zbd9PADyrItyIsjFR+9FhRx6Yh+bx7y5f0n98/EBhcxGxW4MSUBEkogYkar5NqdUhend
         qolg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528519; x=1712133319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mgz5IOTWnZ/x53u6wP29b38SXIQbKurIEUwiPvQMgbI=;
        b=tOt5gDCGvlEbBNPWz2/ynYpoTbAsXKxNrcP0VS47GebVK7zQEIMtMbUlySZV+7metZ
         OybIjnlCxA/i9Lvjde42m8QPj0LBurc2yFJTCMxhEKpGyQ3FpTNHmaWbbZoLXWtCeQKb
         ZR5gqQC3N7H0Ps7Hj4cRjzvroX6rkD/VX10ajYQ0oAoHRur2d/tyyN46Jh2P/6T4NCTl
         QQR22qIYHBqS3XOIu9HR+HQc0zpyXayQIHoFm7A8A3/4CadetsV/QgEiHQRIvYxNiT1A
         xAdAW/5KXkWAgNHjPUTaZKXIVpim0QEJT2Dyu+rvl72Nmu+BsA2QRillXAia3aBeSz1k
         TrUw==
X-Gm-Message-State: AOJu0YzCOZQ3P1OVZTqtlOwJ/xYvecJ9lMTaI2iWfv/73dXWn9tr71yH
	t3jy1d/hiNBl0ItiB+sDrOEnUKyGob9c4p7NPYhOZHqQuEd3a+C8mj4kGWX9mmAzvY0c0S/Wmx6
	v
X-Google-Smtp-Source: AGHT+IH2l4N2dp8Anf+h22DWO2hmsnDBhXvyOnGqfcJDNv9PZ64Dmvur5pwz7zLiZszG5WFRtbfYpQ==
X-Received: by 2002:adf:e3c9:0:b0:33e:38f1:77f6 with SMTP id k9-20020adfe3c9000000b0033e38f177f6mr1140472wrm.39.1711528518922;
        Wed, 27 Mar 2024 01:35:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 08/13] irqchip/renesas-rzg2l: Add macro to retrieve TITSR register offset based on register's index
Date: Wed, 27 Mar 2024 10:35:03 +0200
Message-Id: <20240327083508.2229567-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15462

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 2eca4731cc66563b3919d8753dbd74d18c39f662 upstream.

There are 2 TITSR registers available on the IA55 interrupt controller.

Add a macro that retrieves the TITSR register offset based on it's
index. This macro is useful in when adding suspend/resume support so both
TITSR registers can be accessed in a for loop.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20231120111820.87398-7-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index d450417948e4..34add75080e0 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -28,8 +28,7 @@
 #define ISCR				0x10
 #define IITSR				0x14
 #define TSCR				0x20
-#define TITSR0				0x24
-#define TITSR1				0x28
+#define TITSR(n)			(0x24 + (n) * 4)
 #define TITSR0_MAX_INT			16
 #define TITSEL_WIDTH			0x2
 #define TSSR(n)				(0x30 + ((n) * 4))
@@ -200,8 +199,7 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	unsigned int hwirq = irqd_to_hwirq(d);
 	u32 titseln = hwirq - IRQC_TINT_START;
-	u32 offset;
-	u8 sense;
+	u8 index, sense;
 	u32 reg;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
@@ -217,17 +215,17 @@ static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
-	offset = TITSR0;
+	index = 0;
 	if (titseln >= TITSR0_MAX_INT) {
 		titseln -= TITSR0_MAX_INT;
-		offset = TITSR1;
+		index = 1;
 	}
 
 	raw_spin_lock(&priv->lock);
-	reg = readl_relaxed(priv->base + offset);
+	reg = readl_relaxed(priv->base + TITSR(index));
 	reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
 	reg |= sense << (titseln * TITSEL_WIDTH);
-	writel_relaxed(reg, priv->base + offset);
+	writel_relaxed(reg, priv->base + TITSR(index));
 	raw_spin_unlock(&priv->lock);
 
 	return 0;
-- 
2.39.2


