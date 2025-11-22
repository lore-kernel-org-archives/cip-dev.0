Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52ABCFC52F
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:39 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7115.1763808698410307098
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ezIruKxP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.50, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso26828165e9.3
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808697; x=1764413497; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ryN5qGMVURXxiwa7f2JoUyzJiI2kLWkK5LJquCgP7ig=;
        b=ezIruKxPAWsttjApk1Ac9DgIV+dMw9KEwrZOI8m7qiczeKpCIw7vWbzJcqU0P4dtcT
         PBV4/u1Iimfp0dkqnbO4336PiFuHXfwhTGrZJWxSv4pFFrVQOA/SBiFYzZmC645Hj4Po
         pmoNlw1HSqGubrTGmcLoVHTk06j/XA0qJ3C5LLzKxhganiEUoPS2H4nUEWXQ6u/geoP4
         JkXmQH4j3rZefl6GM78EjJURkeIDcR3VYj038fTtOSRLs2R14+52kvl61mws5OEL0wCP
         WxCMmPj6E/BRT9hORPfxxRXc376ay8Q9vNeagXIm9FV3292inx0wukcwQ2lA6r9ibjnS
         QYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808697; x=1764413497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ryN5qGMVURXxiwa7f2JoUyzJiI2kLWkK5LJquCgP7ig=;
        b=JaEOLxoKPnGujjsQkwOreDJ9j5X3yLmwvKIRsRXAILx3D72C3GOjfExrC4S9tNPOAW
         pLg3OnsAKKzwfwICNVLDeCy1OMwxJsjRAbCOak6yFeNgL2sMYXwR1YgnPZL2ZcFAo3/g
         5+tBMKnbz08N5q9WrwEc6P2Zy0lE6h5rgFaPv84SQtfp7fXtB3M/zeWhx+yV9QFoeplW
         xKppSqFNdUbDoJSI71mTUpNUnNMJkMRYAkMkea+v1I7dyiA35/xYAxyOlw3CsJjX71ur
         b6Hq4cPF2tIuG5D8iCEQp9i3or1OGtHd6OQscAYxvir4boh3ssFLamJVC2C2StQ9W9oC
         Xx5A==
X-Forwarded-Encrypted: i=1; AJvYcCWAPxLgz4U+aFvAIjUs0VTPGUS0oYz/4dgaHlFcvhkUGzpjyP3fOcLKUuSjJ4xbDCFtemqZidDQ@lists.cip-project.org
X-Gm-Message-State: AOJu0Yygri7MezTSNxUM6VBjbPAEuYdNLS2b+tVZmEwkEqO+M/kNUKyP
	JSuKJzBFmrQ+aL48d4hUKcCF2De5HH2SSNy0HTGc1LWAHmaHgNlVhXCNn69sSc7DpEfs27Ulq5a
	uI0hUfGQ=
X-Gm-Gg: ASbGncvwnezWoL7Zn+rx3dBVZtFbONPqfINqp8fxR9zhF9UZG6r9sTNhSaT8sFdq0i8
	XRFNCFq6V2vRywbCLqXFAHhgiovKnSS6034NQmT7AF1BA8NA6xwUI1XAXP8vN7ynxaGesK1OVet
	dvTPg6hJhND+Hk5k6ZfsV08yD+7h04ckFu99tJxzl+9E50nQrPO1Wh+EWXtwdnp8V7Soj+OP4uC
	7dgjwvW/345VUivtso41dKVdVJfLaCyskAGsSTSbtB/0amver0nayI6xgEdWGpFmLqobmV2QArS
	koNbUA6e1yUK0RcCxHMgSb43iQxTXJJS9LvoeoZ/NxMEenKh1OC/22XNsHhPoyc+PyYu6yRFQau
	oZWl05nP4vAIfOr14Gb5a+APuPXE+j7cVb+SZgdhaUdB9XYhym+OVN6lQ+MO6fVZASc8/g6wNa0
	ftC4BN/RV4JDqacZKQR8oH5TbrKO5NcaeL4Xlk7gQD
X-Google-Smtp-Source: AGHT+IFbSmdQ9eImWbWTXecUj4VJYO2UkMrkvycKXEmwdJRtDjrJ8AYtgs/q39MgjDN0eB8A7daD+w==
X-Received: by 2002:a05:600c:4e88:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-477c01d4af2mr55575295e9.18.1763808696710;
        Sat, 22 Nov 2025 02:51:36 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e5a3sm16263356f8f.6.2025.11.22.02.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:36 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 1/2] ASoC: da7213: Use component driver suspend/resume
Date: Sat, 22 Nov 2025 12:51:32 +0200
Message-ID: <20251122105133.2783194-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251122105133.2783194-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20694

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 249d96b492efb7a773296ab2c62179918301c146 upstream.

Since snd_soc_suspend() is invoked through snd_soc_pm_ops->suspend(),
and snd_soc_pm_ops is associated with the soc_driver (defined in
sound/soc/soc-core.c), and there is no parent-child relationship between
the soc_driver and the DA7213 codec driver, the power management subsystem
does not enforce a specific suspend/resume order between the DA7213 driver
and the soc_driver.

Because of this, the different codec component functionalities, called from
snd_soc_resume() to reconfigure various functions, can race with the
DA7213 struct dev_pm_ops::resume function, leading to misapplied
configuration. This occasionally results in clipped sound.

Fix this by dropping the struct dev_pm_ops::{suspend, resume} and use
instead struct snd_soc_component_driver::{suspend, resume}. This ensures
the proper configuration sequence is handled by the ASoC subsystem.

Cc: stable@vger.kernel.org
Fixes: 431e040065c8 ("ASoC: da7213: Add suspend to RAM support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[claudiu.beznea: fixed conflict by keeping the code from this patch]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 67 ++++++++++++++++++++++++---------------
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 43 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index eb97ac73ec06..b194d8a5e9b0 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2124,11 +2124,50 @@ static int da7213_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static int da7213_runtime_suspend(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+
+	regcache_cache_only(da7213->regmap, true);
+	regcache_mark_dirty(da7213->regmap);
+	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
+
+	return 0;
+}
+
+static int da7213_runtime_resume(struct device *dev)
+{
+	struct da7213_priv *da7213 = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
+	if (ret < 0)
+		return ret;
+	regcache_cache_only(da7213->regmap, false);
+	return regcache_sync(da7213->regmap);
+}
+
+static int da7213_suspend(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	return da7213_runtime_suspend(da7213->dev);
+}
+
+static int da7213_resume(struct snd_soc_component *component)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+
+	return da7213_runtime_resume(da7213->dev);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_da7213 = {
 	.probe			= da7213_probe,
 	.set_bias_level		= da7213_set_bias_level,
 	.controls		= da7213_snd_controls,
 	.num_controls		= ARRAY_SIZE(da7213_snd_controls),
+	.suspend		= da7213_suspend,
+	.resume			= da7213_resume,
 	.dapm_widgets		= da7213_dapm_widgets,
 	.num_dapm_widgets	= ARRAY_SIZE(da7213_dapm_widgets),
 	.dapm_routes		= da7213_audio_map,
@@ -2175,6 +2214,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 	if (!da7213->fin_min_rate)
 		return -EINVAL;
 
+	da7213->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, da7213);
 
 	/* Get required supplies */
@@ -2224,32 +2265,8 @@ static void da7213_i2c_remove(struct i2c_client *i2c)
 	pm_runtime_disable(&i2c->dev);
 }
 
-static int __maybe_unused da7213_runtime_suspend(struct device *dev)
-{
-	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-
-	regcache_cache_only(da7213->regmap, true);
-	regcache_mark_dirty(da7213->regmap);
-	regulator_bulk_disable(DA7213_NUM_SUPPLIES, da7213->supplies);
-
-	return 0;
-}
-
-static int __maybe_unused da7213_runtime_resume(struct device *dev)
-{
-	struct da7213_priv *da7213 = dev_get_drvdata(dev);
-	int ret;
-
-	ret = regulator_bulk_enable(DA7213_NUM_SUPPLIES, da7213->supplies);
-	if (ret < 0)
-		return ret;
-	regcache_cache_only(da7213->regmap, false);
-	return regcache_sync(da7213->regmap);
-}
-
 static const struct dev_pm_ops da7213_pm = {
-	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
 };
 
 static const struct i2c_device_id da7213_i2c_id[] = {
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index b9ab791d6b88..29cbf0eb6124 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -595,6 +595,7 @@ enum da7213_supplies {
 /* Codec private data */
 struct da7213_priv {
 	struct regmap *regmap;
+	struct device *dev;
 	struct mutex ctrl_lock;
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
-- 
2.43.0


