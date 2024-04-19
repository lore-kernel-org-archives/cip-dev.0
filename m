Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2123C41513
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:07 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web10.15294.1713514682963795522
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=l3Di59IB;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5565291ee7so189283566b.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514681; x=1714119481; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DfxzZeV2M7Ov3zftSJ4L5B8aFL7EklzMiuHIa/WXhA=;
        b=l3Di59IBWwvm+68DqKSRxYdUoEZrC5+60O8/1iGm1p9Hie0Vu0K2RaZuk46+UyaadO
         H7qVts3AwXMIRUiAsAoBxLVgB3fKeVVH4j+nwWEYGuEchS8xXOW0mf1Pxwjb9iVrJlc4
         jC8fAPRsbgkXWDTu56qlyvYjoN1LtxSIsXBHVbeUBkZKhRJE4d1h+SmLs3NRtieHiyAu
         kqjZF+3pS1+YJQiFXaCgMuLz8BITKGz5iV+4jiBwthPNwz6QdOVRJIYP1B7rh/z1KbdM
         g/pb+V9uubTT3KBpPiF+QUmfvlkdQ/YHd3ZkWi08Gq60hO/bwar5A222SWzbS+QO7JFD
         y76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514681; x=1714119481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DfxzZeV2M7Ov3zftSJ4L5B8aFL7EklzMiuHIa/WXhA=;
        b=TbEF88bOZaYKvvuYHS6wqxjDoHQXUkurH1D0Q3S5dClszC6AJVtsxxBU4+y0gm22Cj
         Isr2JUci3ZOthrMjFl1Eyx/QFvg+2PNcHtvLjY8uvcFXuHw0ob5VijHxD3KJ7G+ZeXeG
         cclpY1G3qnJpwxTb54G6vRwI/X5za8NmeQaInBHRMq3+DkiHnEHGXTt5POXITfqofueW
         xrZGlK0e3NH2hVhx6iBGkp+f2xdGimKg+8oc77JsicvxKcr+lwnBl8t88SjiiuHN16Kz
         eU2ayhVfcFmm8FuKoS1TCVkgo3Wz45KrjoesgryH/wDRy6ZeXkoe7eUW9Nv6hF/1WSTD
         50yA==
X-Gm-Message-State: AOJu0YyZPn9tVsd1oPxBOUurkznwxprtuuH24y3kNDprA+2Dzna/jn4C
	W/kEORG+EMzqaJiiuzumkBjmOkwLWIgnLE3zEkvSRMOugcLg7hmS2hVL7SQp65s=
X-Google-Smtp-Source: AGHT+IECzicwoUdOIdBK/+I/jmx1tkAagrmmo7q2c29/EwfVfhfra657UA0fOdCO71EJjHdrVx77Sg==
X-Received: by 2002:a17:906:2a8c:b0:a53:4cae:e40 with SMTP id l12-20020a1709062a8c00b00a534cae0e40mr936762eje.25.1713514681263;
        Fri, 19 Apr 2024 01:18:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 11/53] clk: renesas: rzg2l: Convert to readl_poll_timeout_atomic()
Date: Fri, 19 Apr 2024 11:17:00 +0300
Message-Id: <20240419081742.3496709-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15598

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 7df8eea64a417f1db6777cddc1d7eda3634b7175 upstream.

Use readl_poll_timeout_atomic() instead of open-coding the same
operation.

As typically no retries are needed, 10 µs is a suitable timeout value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/900543d4b9abc1004e6aecdb676f23e5508ae96f.1685692810.git.geert+renesas@glider.be
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 2262c70fb383..cf6337fa5e7a 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -903,9 +903,9 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	unsigned int reg = clock->off;
 	struct device *dev = priv->dev;
 	unsigned long flags;
-	unsigned int i;
 	u32 bitmask = BIT(clock->bit);
 	u32 value;
+	int error;
 
 	if (!clock->off) {
 		dev_dbg(dev, "%pC does not support ON/OFF\n",  hw->clk);
@@ -930,19 +930,13 @@ static int rzg2l_mod_clock_endisable(struct clk_hw *hw, bool enable)
 	if (!priv->info->has_clk_mon_regs)
 		return 0;
 
-	for (i = 1000; i > 0; --i) {
-		if (((readl(priv->base + CLK_MON_R(reg))) & bitmask))
-			break;
-		cpu_relax();
-	}
-
-	if (!i) {
+	error = readl_poll_timeout_atomic(priv->base + CLK_MON_R(reg), value,
+					  value & bitmask, 0, 10);
+	if (error)
 		dev_err(dev, "Failed to enable CLK_ON %p\n",
 			priv->base + CLK_ON_R(reg));
-		return -ETIMEDOUT;
-	}
 
-	return 0;
+	return error;
 }
 
 static int rzg2l_mod_clock_enable(struct clk_hw *hw)
-- 
2.39.2


