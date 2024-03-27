Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E827CD1296
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:06 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web10.32442.1711527500838037412
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nMiB3SDN;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.178, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so84120091fa.0
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527499; x=1712132299; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwutIGGUJFh3y/lTfjIK6tU0gE3xHO0OjrBTqmbpC+s=;
        b=nMiB3SDNwttVoiobiTMOrPd3EaPMyGR3ni2ZbOPlH7I0zPpF6QLM5DdlXzwyRT45GN
         AlCR09lWpv8jjkz5GeIuHYOSFg5wK4I0yAW2tB3fJ/wwP2Dg8ieuL/t2ElFs3+Lz3Hl3
         TdGEiKUL7StneUdpMaUZqhf0fcUqsrCHPwyV1nJ/C3AZFIEC0AgYSI9DCntBVGqO8osK
         0Mo+accQq4QFmWvfF3Zo05mCxQpjtvhgZfOg/T6/XfbP1RqQWoEsWB//y8hL5l8dkwl0
         LIi5a2t0GMgOceoKQSL5smSPvil/HYQ657XF7gvyE8yt2OFqbl0HWA/+SWkPXaC8rO+y
         aRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527499; x=1712132299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwutIGGUJFh3y/lTfjIK6tU0gE3xHO0OjrBTqmbpC+s=;
        b=Un/Sdv+IFZo5wYTxktOuAfU+JNGOk/0DaCTb7w0Z06bR93O6jA8pFiTxLO8EkIsrDq
         j6bjSUyVSu/xxzUv+oHdB8wFCiW/LH1rmO1cgoobeHY4sH/+D25COS4TwUG+Gi0T8Mj1
         Wz+0OlObyBmVTeaSCl1pgVN02JbZI0FpeIBZVolAo9mqmuOUkgpxhIhK66XtXMy3Hv8/
         HSkP+LgT4r9MSSQOIEKtd7lCJowaKpnwYJ7jwsI8hPPy6og0UTEaEGZou/i8cP9rU0uQ
         ECwbAPH1KFMAdZotiDt//uthM0xn7MJx4K3je0INUJNDs1EU45Fun/GohPYw2W4QsrtA
         MDYw==
X-Gm-Message-State: AOJu0Yy+3TXOUXlMSF5XOon2TwjIf32pFblpmoRyD6E0gCPkBUxkXsBJ
	XViXDTGAblN7ymEaPYcE5Yg218Z8YNMUZgbMUInEcWvDldKygC1+vxrwrUP7FwcJbsH/cqS/KaZ
	f
X-Google-Smtp-Source: AGHT+IGMIrCwATf5p3V8B5HGWCCH6ple92KtzDNR06Q+KdmcFvaWhxc85+HUIjuO0ZmJhn4G/o/Uvw==
X-Received: by 2002:a2e:9ad1:0:b0:2d6:dba1:6d37 with SMTP id p17-20020a2e9ad1000000b002d6dba16d37mr379800ljj.11.1711527499197;
        Wed, 27 Mar 2024 01:18:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 18/36] irqchip/renesas-rzg2l: Document structure members
Date: Wed, 27 Mar 2024 10:17:38 +0200
Message-Id: <20240327081756.2228036-19-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15435

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
index 23492927e8bc..92f8d7eeb44b 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -57,6 +57,12 @@
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


