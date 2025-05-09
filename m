Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DDC3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:34:54 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web10.10406.1746783288761156321
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=iZZRXCwd;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac3b12e8518so385033766b.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783287; x=1747388087; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCpKVt35TPww4iR9H+6MhoWlNG3px6ATs6kInEdXI8I=;
        b=iZZRXCwdjsHq7j8w3KMhom2eDYLEK7kcMKnMmBxpCrGKXvYUb76NtRl4FvW15nsnbl
         d8pj6s10hNM0bUKgOl9P3dCXDDAeMmGWhpioX23fv7W2uY10SwiMK6s/J6N58Yvd4+a1
         /aLW6nygjmnSkWKBDDdIk5F3j3Hh1dJrZddBjt6EsU+bUGW4P7u1TGYHKirdob9NWs4a
         RdOQPllKdo6KvKsrCiaxEkDETevQhRdiJ0vNxfzBc+Jw6x5EbyyznomQ3nFN77BOVpGh
         4RcXOmWp5ddKxf4nD9JOYx50LoKQz1UJ8dY+HMqtWaB835ph4nircQnwiq/9JtCTnn7u
         Ponw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783287; x=1747388087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCpKVt35TPww4iR9H+6MhoWlNG3px6ATs6kInEdXI8I=;
        b=QNXQIEL2WTJvWVOo74UiG+/9G3OpdfHdXVWwLwywYop2yPwMp0pot10LaGSy0d/B9B
         mVs7CVqEZsPlXXkdeWpVeZr3XB5MF7j4ut42CnvS822UgJA/ZdqS8HGTMQvlGet7n8Mi
         zPimwhXXO/Woj7+N2MIwFRZP/gf06sh7oIiPkGNEZg9kktj5AefK0zJVXYqBSQGyFp/t
         Ikt5kS5SDSHfBu3Ww2XvMRBjfIwsRnumpGGriJl/PTSEV5H6392HSXvqa8bZiEgfxR0v
         UvLzEBelbhHwgtDb3ZMwkBw6semKv6G6hlN1bDlRYWtQUsPPyBJLMLKA8/4vwKOG8Wlv
         ycfA==
X-Forwarded-Encrypted: i=1; AJvYcCXmMJ1D01gV0WZ5v+XYFoPK/I3zl+/F5yz1ovPYh0+SUWLw8SLSC9QdU/vvYHqGyHL5QXR2VHo1@lists.cip-project.org
X-Gm-Message-State: AOJu0YwlxAggt4lX4fBj8vrjyVMBZNjDlStgkqrFDhGWx8dN9eTIWR1t
	wZLT1ZBtt/iLhpoibBz51LgTDMkR6LxECuxi4ZZ4f7FeZ7t4wVZ0lkUkYd2JGkQ=
X-Gm-Gg: ASbGncumZ2oeO4atFgLLHDoW3cubrg7YdO49PJ5IeD+Darx5RZxLzGo78SzTcMlceT5
	sDnphCQejyu+/2MI1kHC9aSR+6r+l9whHmDNYAuwbAlCztRITm2XhPP+qivKmywGG/cxuKMdY0s
	FgVJOPXpNbph4Ir7txtenTF+84A3LS32vGWMR+RLQoQRN63ekGuGSFO/PKdML2JqWDfA8c7WcI5
	xpBrKXv8F/6WBsfX1c6WY3CqfXMcKofM1sqqmIZ5/wQf5c+QTTcg8vNIQRO4aHl9TdlAPZGTN7t
	ic5wv4mRD5HnTy8sOV1wryO6rKD3m5QHmC7OxnWLB/f4hgmrDMZSb4+HKlMrJ+cT0fKWfg==
X-Google-Smtp-Source: AGHT+IGkyWUogK0Swia8LiKLUnhauBS/Z1PChsezUYN31pvXDx2laQOcvP2LxrrTKf2e7/Z3w7lWyw==
X-Received: by 2002:a17:907:9717:b0:ad2:db4:2a8f with SMTP id a640c23a62f3a-ad21929333fmr263024466b.48.1746783287072;
        Fri, 09 May 2025 02:34:47 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:46 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/37] ASoC: da7213.c: add missing pm_runtime_disable()
Date: Fri,  9 May 2025 12:34:07 +0300
Message-ID: <20250509093442.4015145-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:34:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18854

From: Duy Nguyen <duy.nguyen.rh@renesas.com>

commit 44378cd113e5f15bb0a89f5ac5a0e687b52feb90 upstream.

da7213.c is missing pm_runtime_disable(), thus we will get
below error when rmmod -> insmod.

	$ rmmod  snd-soc-da7213.ko
	$ insmod snd-soc-da7213.ko
	da7213 0-001a: Unbalanced pm_runtime_enable!"

[Kuninori adjusted to latest upstream]

Signed-off-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Khanh Le <khanh.le.xr@renesas.com>
Link: https://lore.kernel.org/r/87mt3xg2tk.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: fixed conflict by keeping both the .probe and .remove
 in da7213_i2c_driver, make da7213_i2c_remove() return int]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 89842d77e4f6..0a4b22a711b7 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2024,6 +2024,13 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 	return ret;
 }
 
+static int da7213_i2c_remove(struct i2c_client *i2c)
+{
+	pm_runtime_disable(&i2c->dev);
+
+	return 0;
+}
+
 static int __maybe_unused da7213_runtime_suspend(struct device *dev)
 {
 	struct da7213_priv *da7213 = dev_get_drvdata(dev);
@@ -2067,6 +2074,7 @@ static struct i2c_driver da7213_i2c_driver = {
 		.pm = &da7213_pm,
 	},
 	.probe		= da7213_i2c_probe,
+	.remove		= da7213_i2c_remove,
 	.id_table	= da7213_i2c_id,
 };
 
-- 
2.43.0


