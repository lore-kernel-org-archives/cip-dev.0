Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B71AC071DB
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 11:39:00 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
 by mx.groups.io with SMTP id smtpd.web11.18414.1713526732539635687
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 04:38:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=b5oHoVic;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so873825a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713526731; x=1714131531; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DfxzZeV2M7Ov3zftSJ4L5B8aFL7EklzMiuHIa/WXhA=;
        b=b5oHoVicrryaX5GK2svrZ2hLOhEAZ4IhtjXlzzHqKJyV7C4MlWWVd9WwC+08O4b//v
         aMQKteS1pHB8BS/+Eca/zNNZKszm16vEO7RpFIHQlSVW5+XQKj+oJTRQJr9f2BURkowH
         OUOssJ57fUtnzTvSeY8uOd8EJUVkI/vTbNrrIFWv6hIwFEzNQnKyFQUVJJID7MKmvmi+
         AlcX6IPqPCnMEhgBEgupA8FcU+mtl3XzOgTaz4dfiJFIQ7bTxXtBTmzSKg1hZYo/fZ98
         CWQy4WN7P4ESgEO+RHpqLokoGBbl7/K9DerWDFTBTp6Wp/dRqlGGMTix4dMMo83Nqj3E
         6yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713526731; x=1714131531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7DfxzZeV2M7Ov3zftSJ4L5B8aFL7EklzMiuHIa/WXhA=;
        b=Nbf53X/jovnBkPQNic37UZneASwNLJdotV90jZvNHOfVUu8lvasUoXYNdQPbe89CKS
         R1foUEgJdk0XYjq7xrsqqi2PXCkb617ODvy9ApwLBXfrvCvkG75GCFJ+MYwa2N1p+e7K
         1NktKRAG3+3deHd8xZtpuT4tvr7ZLebxnB+xMYGUnpUK1kJyALlBt/E5x8PydxlZHStr
         y/yG7VA6l6bgM8VWBfsfjO30Ir4RJkeQ2E5ESIMShz8JFDVhqDljUjl8DoWvuUwIjyVX
         yQfIhM1MRh7FVYF2u6+L5kqlYm1/Sam3g6FCBYnidSt3p5sCN5/9PNUYJ0AJ41s529jS
         Bi8Q==
X-Gm-Message-State: AOJu0Ywlszk+n0NtpWF6msOjc860p2rkXnr9e2Bw6aDDnGAAZzdVEgpd
	kkNhplaogz9xa6X0ZyCvH4euTREz4VghqjrOzlQsv3d7u5IS1iX7AXRGJo91QS8=
X-Google-Smtp-Source: AGHT+IFpPs84YCK4310AndxJBva61eVOL78MHxptLSnzVy88ApwolvOgezwBY0po+mzfkq3jkfshYw==
X-Received: by 2002:a05:6402:26d0:b0:56e:2a05:a0e3 with SMTP id x16-20020a05640226d000b0056e2a05a0e3mr2125820edd.21.1713526730768;
        Fri, 19 Apr 2024 04:38:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.89])
        by smtp.gmail.com with ESMTPSA id u20-20020aa7d994000000b005700fa834acsm2022992eds.45.2024.04.19.04.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 04:38:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [PATCH 6.1.y-cip 04/44] clk: renesas: rzg2l: Convert to readl_poll_timeout_atomic()
Date: Fri, 19 Apr 2024 14:38:02 +0300
Message-Id: <20240419113842.3675543-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419113842.3675543-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 11:39:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15655

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


