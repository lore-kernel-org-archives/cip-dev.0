Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1BBC3ABA5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:47 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.20302.1745934464383206139
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=XuPzbzJ4;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso245806a12.3
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934463; x=1746539263; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOFpnsDRGTe6JDYcbJmg/uGRqwhgALKcDwHqlDe84tk=;
        b=XuPzbzJ4aj4XcM3CFnf7m7ZxI+eSGJgByDIN8iSPR9SRqxeCZwVPRdBthfuKSWu1/N
         tjK1qYb62B+KPNLOWAhZIzk2UFDTIabtUQYl/BIxaHGhOV/vsdPymxSqD1YKj9Yjs6rK
         QrrlXiklyh37RkpU6AaaYFHq4PnG/ulVuawH/3pg0GZQHUdysmgXpTRhVrLUpVQ9Q8z5
         mf7QTDmB8koi7GBopkNCXi91tn6mjROGhF0HlER2KJhwCazoXpVjkvVqxt0GZ5XX2UtY
         of9GOU7blzS69NqEw3HwCs1BppojchPvcqOcz48Jjgbi/UB+FfOd3DsilUNHXJYJMYLJ
         QYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934463; x=1746539263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOFpnsDRGTe6JDYcbJmg/uGRqwhgALKcDwHqlDe84tk=;
        b=t0hSJd9nTTP3fyTp15bXxTzDNuUzIiSqdnv88KRc80LBD7iz3FX61E5SMgMJn/nhXb
         0QiYXqkbX+7DbWT7hgfZRdXK74Ok9Evxi15uta7LmGO+x+Ao9FDYECDPufNuqCzECINC
         T3B32vgrb93OBnwc5MqvSdVslarimV1zeUY2lwJmTQoRdH9MfqshpqvgM9VL7va05vlT
         MLQXO73oLDJtHqYLn90xOFJ7YRLD2zL9sZyTm1UydyoAH6EP4JnnjxC1ZxdEKy7x6VzL
         /cgeXPrldgwhf51uRKBtekfpclMIR3YJWgkd4GIygwcbwQ6syABPA/4Bt8kfLiuk4/fT
         H/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUk2VYZ1xu0QSatKcGaYErBl+VdD5j9MvWouuXNXZzb6UByUkmunHolSUSBsJ35yRHWMtAStIDR@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx38yOBhYbJdgdpXbc49qnPjoTAjZGZLaglgVsvm+9aRewNtD+2
	Fjky7l1n40TYi/HhoTC86N4rE2iJ2GmGiXwfjdnrK99P6oKMxAD0twW5HxHDWYg=
X-Gm-Gg: ASbGncuGn0Y463egkSldCOxM89jwc2apI+UACmVH8/dVnYCxIg0yY1l3AFNpPc3dHCn
	LJldsl0jIalHMaMCOV8soTzHQuWTBO+p+UwKYf+Z4dicOGaaSkiSz+BvKoOqlmzloxcGFvnqeie
	xC3xVq3yQSQbJHWs5dQtKM3V8MVmhYQyKXDwQclIgtfCpYBJGC75H9hLtEPYVjTr5FneHLTfRI9
	tYy/9jTCaNffwftVhIcwWdb8TU42l8mLDy7SMKr1Vg0rx3/aADEWM/F+zKzh2EGw2ce5t0TkCHs
	DXW20h5DAMifMJ+/uV5HGLTLOOMEDwqziQNa/jiLqXkEyKrk3vW0eVWQLGKHahwVL/EpQk15W1Y
	466YRGQ==
X-Google-Smtp-Source: AGHT+IF2kr2EkZfsuXVP9DvlTN//O65VekgHqi90npO145FGUcjTVzComEUs39QQ93WRfWxnm0OifA==
X-Received: by 2002:a17:906:4788:b0:ac7:19d3:1b2 with SMTP id a640c23a62f3a-acec4e04815mr396792566b.18.1745934462691;
        Tue, 29 Apr 2025 06:47:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:41 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 08/21] i2c: riic: Call pm_runtime_get_sync() when need to access registers
Date: Tue, 29 Apr 2025 16:47:14 +0300
Message-ID: <20250429134727.2429662-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18721

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit a1ecb041589017ce4e03d92f3b9a92a2a8a37ceb upstream.

There is no need to runtime resume the device as long as the IP registers
are not accessed. Calling pm_runtime_get_sync() at the register access
time leads to a simpler error path.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index ea2c894600d5..531210f55aba 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -302,19 +302,15 @@ static const struct i2c_algorithm riic_algo = {
 
 static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 {
-	int ret = 0;
 	unsigned long rate;
 	int total_ticks, cks, brl, brh;
 	struct device *dev = riic->adapter.dev.parent;
 
-	pm_runtime_get_sync(dev);
-
 	if (t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) {
 		dev_err(&riic->adapter.dev,
 			"unsupported bus speed (%dHz). %d max\n",
 			t->bus_freq_hz, I2C_MAX_FAST_MODE_FREQ);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	rate = clk_get_rate(riic->clk);
@@ -352,8 +348,7 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 	if (brl > (0x1F + 3)) {
 		dev_err(&riic->adapter.dev, "invalid speed (%lu). Too slow.\n",
 			(unsigned long)t->bus_freq_hz);
-		ret = -EINVAL;
-		goto out;
+		return -EINVAL;
 	}
 
 	brh = total_ticks - brl;
@@ -385,6 +380,8 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 		 t->scl_fall_ns / (1000000000 / rate),
 		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
 
+	pm_runtime_get_sync(dev);
+
 	/* Changing the order of accessing IICRST and ICE may break things! */
 	riic_writeb(riic, ICCR1_IICRST | ICCR1_SOWP, RIIC_ICCR1);
 	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
@@ -398,9 +395,8 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
-out:
 	pm_runtime_put(dev);
-	return ret;
+	return 0;
 }
 
 static struct riic_irq_desc riic_irqs[] = {
-- 
2.43.0


