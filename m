Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DC1C04FF6
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
 by mx.groups.io with SMTP id smtpd.web11.18418.1713526739245364139
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=oRsFCvcz;
 spf=pass (domain: tuxon.dev, ip: 209.85.167.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51ac9c6599bso472186e87.1
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526737; x=1714131537; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jcjlWpfMaOSzcHVY4DDGDPiSAq/wIEEWtp+0+XY2Bg=;
        b=oRsFCvczOZhKjqdzmK5fJehqfRNw3dRwFNSsAE2+26R324G6s+Put6y4QOsHMQigW9
         cfeRhJlufnJ2+8LpMSMe9gnHBpf8GAPFsK5F3Np8/UBSQheXU27V5tBBm6NrAv63jvL7
         NdKAzxvvoCHvoH7iPZ2pBTpFVKM52oKRoH5QLGZFkGgvsy9X7o61pWwwg3DLtXKc9aOT
         aXz4KTbT9OaEgF+r4odU2t79TFcRQ6YaoiTUwJ5M8GjZNRba/hYw4PobAmvf2+E4l9ov
         5+jXxFEoWyiYw8m1nAwmX3II1iXaR+WoiCArYp8o2zhWHbgq3Pg/UE4cpzOmY6E/FR2R
         qftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526737; x=1714131537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jcjlWpfMaOSzcHVY4DDGDPiSAq/wIEEWtp+0+XY2Bg=;
        b=vzrU8LUjtIVEeKT4SKSDg1SOHMKck5M0adnMCIE5f2SQArn4YxJ/rh1o9AA8u/q7gZ
         nzqdHNpjeweZ4+1U3rNKGhcRC/i2sqPfT/KU0x2a2Is/MqBKtpmfEW6fvWFK+aT+xUX2
         sBv9VCbs0MK4/RVPPzqtaV71LI4OCZ60ukqiKuyTjT+m7r2pqtxLN9TfCJp+stvl4gbr
         gN5J3G8/5E54/5phvS7TB4uxiAkmhnZ4jUhEI0xL8k6IK39XwF/U7cf0Gp5lB/r1BOei
         QMdibTt74C7QqHMNgWAMO+9OECa0ViOa9PfTA5Ub1da+tOXCl7q3hdmVEQVziqhYXoT4
         vpow==
X-Gm-Message-State: AOJu0YzBiycCy0CdPZJOkcIOtCd+E5yzoa37IgD3ii013SZv6KqiH3rl
	mrh/QynVAqrEx7wi9s3cvjjr+TDcGrIIz5ifil1DGSodvx1TFdaNvMtAOJmiMig=
X-Google-Smtp-Source: AGHT+IHLCni/anvTZno4atW4QVs4WFJm1NVpk0CObPCSGDXwUEB15Xg1IIOIg7CrsLPtRkCb6OkSwA==
X-Received: by 2002:a05:6512:475:b0:519:231:e4c0 with SMTP id x21-20020a056512047500b005190231e4c0mr1175317lfd.43.1713526737286;
        Fri, 19 Apr 2024 04:38:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 09/44] clk: renesas: rzg2l: Remove critical area
Date: Fri, 19 Apr 2024 14:38:07 +0300
Message-Id: <20240419113842.3675543-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15660

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


