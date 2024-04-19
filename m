Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E0BC41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:17 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
 by mx.groups.io with SMTP id smtpd.web10.15298.1713514690662157340
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ZSdvQyh0;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso1582854a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514689; x=1714119489; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jcjlWpfMaOSzcHVY4DDGDPiSAq/wIEEWtp+0+XY2Bg=;
        b=ZSdvQyh0h3ACXEvRW7zdgTHcf74uqC8XdMm0bQrcLo1aWREhJrD4UzU0YVuPaKzFSH
         KKHEX4ZAQV6hLxBUMFxpT9+nnGS1/SEyeNicT4/vO7n/BFs1YLqxyFl7AADCGmo/gqHe
         ziBSvZSWlIM7iF+qzO4exxZOWx8CzXBJWVKTy6cdvHj5kSxXiT7vvfEeO1h3weiRjpx5
         RBvJfbX1TD79UhgnEN6zx6BLRhncfmq6mYlGtY4exPbi0pYlrv6/+SvJXdAiL/wiww3g
         TpO/NithA+hXFjcdq00YzzAiUFJjPOi1y/y/L6iBcFc2MGxdiITLaADOvXCwYCsK2Sp+
         q2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514689; x=1714119489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jcjlWpfMaOSzcHVY4DDGDPiSAq/wIEEWtp+0+XY2Bg=;
        b=N0hnu3v22EPz+RfQuetmTvZoJg4nEL3JvKKqas4/ZHNm/THDoqzr0VYnFGVxznYcMU
         U/7348aQ0L5I8Y7Ts/BbcwCY8B8z5CH+RiGyQCyHPb/VDh6Neb9AGMpMfw5Epq5i9bcB
         UEzq1ufLUxYIkCvO33KmfTZTKOtjeQE6u3pOEqOKYuJAyT03RCBZXdqCiyTJ5y9FFsFl
         EpyMyFBRnOO6R4ByuToxfGrxsjr6HlX6qChA8oVuQjsQm3/giETiwHN+xhAK+EadB7/+
         l5KwEo+2AEmD6kslUGlmcvsmR/pQoXAsj5qPdOd29xknz3nFH40iLUCe9sZKzGEzYdJT
         XHZg==
X-Gm-Message-State: AOJu0YyXZwEmYyu9aZx2z4MumO9PZdctO93f+UI9/FVTRi5M4A4YC1rJ
	883YNloxFqKjzP4Ieqxty2EjMm6r8RnfIxKoFhYysrxq+hwyLsWwFwjOGz65lk1b3huxlUjsfMv
	y
X-Google-Smtp-Source: AGHT+IEWqQiRJpwcP5kqa+fJUx8pCeXQ4Jdym0WO3epCDuvyLmsBk1rylF25fmWGpr/PUNEak2AjJA==
X-Received: by 2002:a17:906:2bd7:b0:a52:c873:a66 with SMTP id n23-20020a1709062bd700b00a52c8730a66mr943280ejg.34.1713514689087;
        Fri, 19 Apr 2024 01:18:09 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:08 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 16/53] clk: renesas: rzg2l: Remove critical area
Date: Fri, 19 Apr 2024 11:17:05 +0300
Message-Id: <20240419081742.3496709-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15603

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5f710e3bc5987373737470f98798bbd49134a2e0 upstream.

The spinlock in rzg2l_mod_clock_endisable() is intended to protect
RMW-accesses to the hardware register.  There is no need to protect
instructions that set temporary variables which will be written
afterwards to a hardware register.  With this only one write to one
clock register is executed thus locking/unlocking rmw_lock is removed.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929053915.1530607-7-claudiu.beznea@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 572a7e86ef44..b280a468c4a8 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -896,7 +896,6 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	struct rzg2l_cpg_priv *priv = clock->priv;
 	unsigned int reg = clock->off;
 	struct device *dev = priv->dev;
-	unsigned long flags;
 	u32 bitmask = BIT(clock->bit);
 	u32 value;
 	int error;
@@ -908,14 +907,12 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 
 	dev_dbg(dev, "CLK_ON %u/%pC %s\n", CLK_ON_R(reg), hw->clk,
 		enable ? "ON" : "OFF");
-	spin_lock_irqsave(&priv->rmw_lock, flags);
 
 	value = bitmask << 16;
 	if (enable)
 		value |= bitmask;
-	writel(value, priv->base + CLK_ON_R(reg));
 
-	spin_unlock_irqrestore(&priv->rmw_lock, flags);
+	writel(value, priv->base + CLK_ON_R(reg));
 
 	if (!enable)
 		return 0;
-- 
2.39.2


