Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E3FCD128C
	for <webhook@archiver.kernel.org>; Wed, 27 Mar 2024 10:37:05 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.32439.1711527498380819569
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Mar 2024 01:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JZvb+UGx;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414953ec671so1214775e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1711527497; x=1712132297; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFOTOp0aKjgoYGUwcM6aU8kOf5TopuefAIC2xIUX4GE=;
        b=JZvb+UGx6XRn6aGPadBhhFkuzRs5ep2JDkprKpFQR9us23spQIFLSpa5XPr42hnS5L
         Cs4ktcWMbi66H6W1yvrb1S+A5wGxJ4oxY0LX1uUSjIqeRiz7VrOKmG+kLmp6SlbrIsdt
         AWvDv0RSAs4/6zeritRnbX96FSL5K4kjo+0Nxfs8qaGlcFDLp6YYhK4ciUL2XYTW8UX9
         kfladCgp2y5k0vtZdotROuR429TZk/AOmzS4Tyh21DuPPCt+8+aIcg3QCQxK7lExLZBt
         td2t4zFz2QnBLsi5cRZIlUrWR2BYaMjATcw90fxz9iBRtU10qEo1TwLVRAyilGy9plW2
         SU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711527497; x=1712132297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mFOTOp0aKjgoYGUwcM6aU8kOf5TopuefAIC2xIUX4GE=;
        b=eG0CB56TjboUQoPb+scpNT/ra17a5I4FGVL//k1W+oux/4dOWCbvs9lYTSTIahsIsv
         9M1Dzpt0NjYN13A6Kx/bvSjWMlhZ+p4D26PTMXBFx33enpvIisFF9k0mtKEOtim3e8ae
         dHI0IzULjYHs8jUaOQ5J970RJYq1+vcimpz4oA5cdexMRjcK/2gCI4JgCwuuTXHzdwpW
         gfc6+gJKpzST3XoZuy5a5Xg/SwcsIDQ+RxFfGVC8T+0Q9GUjvQq+D1y2n2/X/gyrpwJM
         Usm0u/sJ2Vtbxl6Kht46LJtmb97Eom9SZrJmzfymady+qZE92l3sUoLLRWd3XpcBReDP
         kT6Q==
X-Gm-Message-State: AOJu0YwjhuJ/JCWuSYgosx+AGoN5jzebVZiFqUipFariGoNhVJgB/2PC
	XNV6NuBEwfqAqcnyWlNLYJzQ8ET0FHxsxtxYdvg4CiUlCWPdwrJxG7OVf4I6mdc=
X-Google-Smtp-Source: AGHT+IEwOAUP2AhDqBSKORV8JcRH1kjgL1ry0+ovmXGjWygrQmOui9JEguqYoVmvXucULlRfF4WTbQ==
X-Received: by 2002:a05:600c:35cd:b0:414:9467:53c6 with SMTP id r13-20020a05600c35cd00b00414946753c6mr687481wmq.40.1711527496914;
        Wed, 27 Mar 2024 01:18:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.144])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc2a9000000b0041493615585sm1353783wmk.39.2024.03.27.01.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:18:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 16/36] irqchip/renesas-rzg2l: Use tabs instead of spaces
Date: Wed, 27 Mar 2024 10:17:36 +0200
Message-Id: <20240327081756.2228036-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240327081756.2228036-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 Mar 2024 10:37:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15433

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c90b5c4e6554c1194d5f7cfe13dfd710a7661cab upstream.

Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
and TINT_EXTRACT_GPIOINT() macros to align with coding style
requirements described in Documentation/process/coding-style.rst,
"Indentation" chapter.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 93c0d2707fcf..520200292eb9 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -54,8 +54,8 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
-#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
-#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
 	void __iomem *base;
-- 
2.39.2


