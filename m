Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABA6C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:17 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.15263.1713514688743516672
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=gdIvThNI;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a53f131d9deso197458166b.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514687; x=1714119487; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDuQ98tfmN2EWJiGV2dZFGuLoSvlTK5HZ9tG0EzvMFw=;
        b=gdIvThNISx8/BS5xJ1mNkiVyS+ts3IzuHHUgx2/sc4Ver0NVMTUo18n5EfK3VrldM9
         KXI8oawi12yLFooepnV/EnRjKwA8O2Ty3OaAIkBn7V+3dU5F37NtQx0XaddERaeAdQuT
         UrS5/X5azVx1mE5TkD82kl9YNCI+F7mpJDrIsZB1Rp+4TdCq9snHp5ekeY+JoMo7Cl+H
         7jiyq5Sn0jDJwHnN5auBaSvnakyPU5SulxR9YWT6IluIAd29MJcLogfapCWtRhWK+fOZ
         HNhq1qhvZmNN3w0tURP7YUP3LBfLCpBtkvtuv+8mFFyYpL379LOzZqyCQykBWJWDZ3DT
         0SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514687; x=1714119487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDuQ98tfmN2EWJiGV2dZFGuLoSvlTK5HZ9tG0EzvMFw=;
        b=ddjgaUmi1PrrnK7ZHv3TP/DcrtuUlANZVeZUqxr4S0kBSMQeB37O0w975rvTP0SCSW
         CJzQq5rEsEi7nSH2HpY1LLEhYb7S+3RUFT42XBuyk4DL17L6/4891DN+vqJXOZRBgCad
         hXz+WK5y7MY/OS8psOUOQSHbwI3A1WHAgVXSYfdP4ZPSE/hsNrQgXCjJXm4VTU9T2YTY
         0ln2BrfIAMC4TjqfqlG8p/G/PFQx7NSWOM2pVJRdFBAKL8PZ7MOx1LYWGfR6Nyl0J10g
         BH8Tu/szEt/pLLzh9fIIkzmEA15e2YqzyNXVcs8L1FTSgmxGll7icTZcPnPDwaioh0Dt
         Z3Cw==
X-Gm-Message-State: AOJu0Yw7Rv1eCS39xhKQLU3gm4x+rchMcqbzw8Yc+uqXmQ+xbY9fqSKS
	VzAj7Uj5pKMbvp7XTCeZkuj2eCICQyQAcU8oZ4E/afBUj3gLdVmLd9SfzxgGFeo7a4JywfUOEil
	T
X-Google-Smtp-Source: AGHT+IGxAYWtKQe1XpnIAUBCV1FfBTveInH5wwO1S1TQfp0W+1hHYzguBejcA4iQp4LFiaXI3j3d7w==
X-Received: by 2002:a17:906:164f:b0:a51:d522:13d5 with SMTP id n15-20020a170906164f00b00a51d52213d5mr879711ejd.40.1713514687219;
        Fri, 19 Apr 2024 01:18:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:06 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 15/53] clk: renesas: rzg2l: Simplify the logic in rzg2l_mod_clock_endisable()
Date: Fri, 19 Apr 2024 11:17:04 +0300
Message-Id: <20240419081742.3496709-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15602

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit becf4a771a12b52dc5b3d2b089598d5603f3bbec upstream.

The bitmask << 16 is anyway set on both branches of if thus move it
before the if and set the lower bits of registers only in case clock is
enabled.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230912045157.177966-12-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index cb31efab2cce..572a7e86ef44 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -910,10 +910,9 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 		enable ? "ON" : "OFF");
 	spin_lock_irqsave(&priv->rmw_lock, flags);
 
+	value = bitmask << 16;
 	if (enable)
-		value = (bitmask << 16) | bitmask;
-	else
-		value = bitmask << 16;
+		value |= bitmask;
 	writel(value, priv->base + CLK_ON_R(reg));
 
 	spin_unlock_irqrestore(&priv->rmw_lock, flags);
-- 
2.39.2


