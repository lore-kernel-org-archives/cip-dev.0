Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59127C3ABAB
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:47 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
 by mx.groups.io with SMTP id smtpd.web10.20304.1745934466021806334
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=aiOZP52u;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.44, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ace98258d4dso507946266b.2
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934464; x=1746539264; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ukqf8GxvSHbQKsQK72Czc4ie0Yh41dHcXSysqdY+FZc=;
        b=aiOZP52uNM+SDZeOWOaVCwgaOjdPgPS7T7mtFbOl0IDFtqiPMWhqkSYvVs9CjdDn6J
         AsRVReiIqmMOCL1q9AVLaa69gJSBT8zD3LEqAsa31rmuAj+CZwDe9TZvkCY1B/N46kJX
         sL011HMBKR+4ER0Zic+cWJH5emlpsywuHd0Xqt0extvbLgn0WIiXBEtH5XWbqSwgvwCi
         WRAhH6edp9DEJVYJ6AyS7Ul8Yn99aGvk6jSUakzhmP8/JG3xqwjOk2r62W1WozWa/x9Z
         d5M+WPBt9MdRutpMhZL7ke63Li55OWfAG7qFTeyDHBc6IFBo/DaryhKHp+ZMgsX5y3SF
         9Piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934464; x=1746539264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ukqf8GxvSHbQKsQK72Czc4ie0Yh41dHcXSysqdY+FZc=;
        b=rb/tugSwIh8uN4O0w3WPryeCwwpBNV0b3GOs6U64g9t68vI8X2QvXlCCP/R/0SA6Gl
         2JDZi74oBrZIS79JIPJUMBH6zCZX42bAmbORxZ77ef+jUgkRXCGfxgd+v3LuHkIxk9ir
         t3UTXYJV97jNFniFpD5uEsAwuwOb4RgNHoj2Lgq4evk8PwLzpvgTzBNUczmCBHMpI8xl
         La3crK9EPQ9B/VCbg7dqvVfrsIgqzFfQ6qnj8M8L5kJ6JRV0xoLxs8DwxMrT62niUktg
         jy855qaCOXShQNrJjj3HFB9eTUjNo+937KmvyhfUP2C43n52o6D/V2NAs/eK4w9VAUIj
         dXsw==
X-Forwarded-Encrypted: i=1; AJvYcCVHIS3skhSF6+vlCMy9ipK2cI2G92NJkUTQFBT29FrhNdP581lvM3U/SDe99ObEtLyvwNqSf5CF@lists.cip-project.org
X-Gm-Message-State: AOJu0YwU8cJOIWyntXNbCgGxLfRLw1CcSTvEDLRGviyeapOrPW+OBIcv
	b7eCGynRmfAwc+7u3ZLApc/md7SB8KIZkQr5RC5DCBJmRFqMhJx38xe+MSKEQy8KFGC6qNOncU+
	x
X-Gm-Gg: ASbGncvn31IkPD2rksgOQIaAevv+GynR8aftMm6LPxeTkGO08eVXMCzhz2dmkfbiV8/
	eiyS5p+3ap+8PTKpWmwJeuwAGG604+9iim/nbB/UMrj6bQODwpFoOKeDa8ChZ5bmkGdrvf37TJs
	G1NVCqL7iQVA13UM8vPqe85tMd5efmNyM/8QHf3lIWj+PJ7M1MI8xZKQGFD9FPLbifHBsIgMYgA
	UK9RF3XTQEZ4SNxkqLoc3vfbbytFR5A+PtTvxhGqtTH5rah0nB4L4v6OXeoZoNpCSuFd0UNseXW
	ZRUx12tZHCyD767cnORhsJxjoIbhKMYg1kqdTJ0aF3IofKvI+7tSgwY2iY3LixTfnDh3NgqBaQB
	wEINKFQ==
X-Google-Smtp-Source: AGHT+IFhQ5GKeVDrtMu2Sh51EzDlpfQfKAE1z0qoobKnl6xIVV5hDQ1B6+0ZhB9v8t4AiQy59Bd6Iw==
X-Received: by 2002:a17:906:f5a3:b0:ac7:eb12:dc69 with SMTP id a640c23a62f3a-acec8522a7emr281622766b.28.1745934464426;
        Tue, 29 Apr 2025 06:47:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:43 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 09/21] i2c: riic: Use pm_runtime_resume_and_get()
Date: Tue, 29 Apr 2025 16:47:15 +0300
Message-ID: <20250429134727.2429662-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18722

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 3149a9cf36cf17411e8564e22ec698b5aa2175c5 upstream.

pm_runtime_get_sync() may return with error. In case it returns with error
dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
takes care of this. Thus use it.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 531210f55aba..84f831635cd9 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -134,10 +134,12 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	struct riic_dev *riic = i2c_get_adapdata(adap);
 	struct device *dev = adap->dev.parent;
 	unsigned long time_left;
-	int i;
+	int i, ret;
 	u8 start_bit;
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
 		riic->err = -EBUSY;
@@ -302,6 +304,7 @@ static const struct i2c_algorithm riic_algo = {
 
 static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 {
+	int ret;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
 	struct device *dev = riic->adapter.dev.parent;
@@ -380,7 +383,9 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 		 t->scl_fall_ns / (1000000000 / rate),
 		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
 
-	pm_runtime_get_sync(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
 
 	/* Changing the order of accessing IICRST and ICE may break things! */
 	riic_writeb(riic, ICCR1_IICRST | ICCR1_SOWP, RIIC_ICCR1);
@@ -499,10 +504,13 @@ static int riic_i2c_remove(struct platform_device *pdev)
 {
 	struct riic_dev *riic = platform_get_drvdata(pdev);
 	struct device *dev = &pdev->dev;
+	int ret;
 
-	pm_runtime_get_sync(dev);
-	riic_writeb(riic, 0, RIIC_ICIER);
-	pm_runtime_put(dev);
+	ret = pm_runtime_resume_and_get(dev);
+	if (!ret) {
+		riic_writeb(riic, 0, RIIC_ICIER);
+		pm_runtime_put(dev);
+	}
 	i2c_del_adapter(&riic->adapter);
 	pm_runtime_disable(dev);
 
-- 
2.43.0


