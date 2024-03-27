Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65078CD12AC
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.32514.1711528518426879478
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:35:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aYB0rq/i;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33ed7ba1a42so4349922f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711528517; x=1712133317; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x7g5fTc14qsP28r1k5RjYQCPW18M91Dr5/3NKQ3Cp/Q=;
        b=aYB0rq/i0QRMQyJWryjc55J1mGazhshg8Jauk0fn/0baLZ+4aAYs9hkhH3DEitI6iU
         Gb2zqfxXzBUMBodF6qEVGqothC8zYZVZbi+0Se/XcslYzZUCs+HIJs16c+V+EAMnG2sB
         kB5VrlqCxi4KVGI77g2/yBtcQ1BeZYCtXKWPiglBu4eZBH2Dfg7FM8YkZQTX1PzRtJkC
         RbFw9gQaioBJFnvPkPCFDPybje5O/Nc1v4vITNjFIEKm1xGdm0V5Le+/qixM+T8w6WDT
         oq7Gr/fKHaIAQsQG3W3WQvIdrWzPPO+ZiHmMw+g7kZMmvOluxJ++iciPTBFsOpmnmMXw
         fEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711528517; x=1712133317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7g5fTc14qsP28r1k5RjYQCPW18M91Dr5/3NKQ3Cp/Q=;
        b=OKVtBsBZLn/wjfFTekd0ICgmtvN9b7PImkIS3wIJYJXfLow6vLy90molQuF5Q6rLRW
         OU4sWqB9SmHejsO5e74pxir/MjVNCH5h3zatI5WAo8lvwoXnOpVzn6OCCEpnLCO+4a7w
         QQmW0BuCFVShkxT6b5oiiYpWxpMdWgw7Rr4alJWkqD/+AR8DYtMIm4svOg1NHxrs6NdB
         2Az1ro2CbjI3vx69G3oFHtUaOYIEM/2sypoaH7+KaV+C+pbX2ZE6hAHZVOOLy0fhSVVN
         dGoSC+sbOXmBQK3fC1BNT7eJm+KEPlMcvt5j66yerZweycHaOU6NZrG/vuKAKtQ7COrK
         VuXA==
X-Gm-Message-State: AOJu0Yx7A7zU+Z/Vah1/9tLrZMSBbP9CP+gfm2FYp7R5f7g18DDdWI3L
	gM3R8jNpc2XcwW7Mh9JN9iRATeBfM2MTCWPqzpP+iUc4rnyd3vB3dubROamJBgwPfkQmmM9ibbY
	L
X-Google-Smtp-Source: AGHT+IHsz5JIG6D73WGjO6IlaQh4qB7uRw4DE7sGTr5k5mI8HBNOZo3iRMwd5NrCR5haBFdzdo04UQ==
X-Received: by 2002:a05:6000:174a:b0:33d:d7be:3bec with SMTP id m10-20020a056000174a00b0033dd7be3becmr556117wrf.58.1711528516899;
        Wed, 27 Mar 2024 01:35:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm3591461wrb.8.2024.03.27.01.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:35:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 6.1.y-cip 06/13] irqchip/renesas-rzg2l: Document structure members
Date: Wed, 27 Mar 2024 10:35:01 +0200
Message-Id: <20240327083508.2229567-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327083508.2229567-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15460

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit b94f455372ad6e6b4da8e8ed9864d9c7daaf54b8 upstream.

Document structure members to follow the requirements specified in
maintainer-tip, section 4.3.7. Struct declarations and initializers.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 90971ab06f0c..0a77927b678b 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -56,6 +56,12 @@
 #define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
+/**
+ * struct rzg2l_irqc_priv - IRQ controller private data structure
+ * @base:	Controller's base address
+ * @fwspec:	IRQ firmware specific data
+ * @lock:	Lock to serialize access to hardware registers
+ */
 struct rzg2l_irqc_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
-- 
2.39.2


