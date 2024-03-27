Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F523CD1287
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web10.32440.1711527499915789669
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=RmEOyJuH;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.171, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d23114b19dso94460211fa.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527498; x=1712132298; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ZL6C477gTW+NfISWalYHi/00eT8ywLVpfA/stvnenI=;
        b=RmEOyJuHFl3LGM/B3SpxO5nGHrvY81MKEQ8WMNxui65oy5gp0DY5u2qxp6MTeuNARP
         YBBBaUTMwUPK0GUip8noKfUk8q924dEB2omZkDzIEqWkBAlZnKczJ4hha9JbJsCFJ2Oo
         O3qsjbZtmI7FUsKuwtZpa1usCurZ9JIPUlu35BgucBX3uIFv3IzeR1JrbJMwAKX71ZkD
         oufFaI9tAijPu0Sp09HURUa4hQpUPLRuFW+XF6T6amEDFUnBvIo3RR6u58lr7vPUJWhB
         z97aw4j5yAobe8ZOcfLSryTjbW0U80NkdIruI/RAHyCaLI+RLvURiwswPPxv+SXnxj7j
         cBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527498; x=1712132298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ZL6C477gTW+NfISWalYHi/00eT8ywLVpfA/stvnenI=;
        b=rU0VCTITqt3cU8GdfVU4nyH7KuE0AVMOQP2BpLVj9aq5G8cPkOYNBNwysnRNA6A0By
         2cfdIVIT6ZpLVqRcqqFqjsMsNyyqAhWtnT1fcOAlxF4plemuEfNx3UVSlBGCaWe5oE7m
         kjmGrFqfwcNfbgpkTitPSutafY0RAMhGH2ynG5zd4hoX4+mJSNFvXd8K+VCTkKW1TQK+
         hiHWm9oLHdArCVRJIk11z8MTLU1KZB/SmkPT2TQx73DV7KVz5FK1iXO3xu27/I0nPfFM
         PIXEMobUjuho+E6aUpNQGR5PUr1pVvYfYqlhFQ8qZupgbBPZ4qO60WzKsrqPakjHp2dC
         1ElA==
X-Gm-Message-State: AOJu0YwblSr9AlW3gp655mZrzdgbQZ641ItoCFW1Yg8KBoHv5pIAKXV9
	NhM0FOjZM9PdfwM751nnQd1flU8vZNMv0k1tfQWhtnlmcsJMIdOAY5EX5GgmpmY=
X-Google-Smtp-Source: AGHT+IFPs2WRv60nUMafy5z4ykBdYBvuVrjX2oOyMSzhz64UfHT1Gm1UsQ2+hA6XZnBBu9EUc/Pjzw==
X-Received: by 2002:a2e:9013:0:b0:2d4:7532:92f2 with SMTP id h19-20020a2e9013000000b002d4753292f2mr2886201ljg.45.1711527498048;
        Wed, 27 Mar 2024 01:18:18 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:17 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 17/36] irqchip/renesas-rzg2l: Align struct member names to tabs
Date: Wed, 27 Mar 2024 10:17:37 +0200
Message-Id: <20240327081756.2228036-18-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15434

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 02f6507640173addeeb3af035d2c6f0b3cff1567 upstream.

Align struct member names to tabs to follow the requirements from
maintainer-tip file. 3 tabs were used at the moment as the next commits
will add a new member which requires 3 tabs for a better view.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-4-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 520200292eb9..23492927e8bc 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -58,9 +58,9 @@
 #define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
-	void __iomem *base;
-	struct irq_fwspec fwspec[IRQC_NUM_IRQ];
-	raw_spinlock_t lock;
+	void __iomem			*base;
+	struct irq_fwspec		fwspec[IRQC_NUM_IRQ];
+	raw_spinlock_t			lock;
 };
 
 static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
-- 
2.39.2


