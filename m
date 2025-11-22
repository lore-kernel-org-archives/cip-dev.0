Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A97CFC526
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:39 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7143.1763808692837995651
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EzYZpacw;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b38de7940so1390510f8f.3
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808691; x=1764413491; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bV0E/z4v5oTlQPlpQzOSls/wJ21C106wrtaimLblYWY=;
        b=EzYZpacwEHs8L/sEbkj2fQzE8/58CbXYa5FJ+U1NguwNmVd+6wxTrPrhFblu/pVvxX
         LXAOVDeppyUXwj7qcE377kcrJi3AecU3EaZCOVB+XZUxGSfk7yZKaBsFVSh2hIXld89q
         aKsS4mOSvk5xIIrnLK4ckzqViFCFIbkzgeZsW6ZiZrwipsc4THRrp1wZKsj9rKqz6h/6
         VxiEQDMZYZNO+/dlpo8dxzXPyCECzdkniVPFiDhEoHdGjQXToJxki83lSBwDunfdPISB
         9vWQFYc2VTP6e63lYapme2dMCMGSfD/kRtzz2QTbpOJzuErrVWI0nEWdcXJcvC7zWrhi
         ftRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808691; x=1764413491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bV0E/z4v5oTlQPlpQzOSls/wJ21C106wrtaimLblYWY=;
        b=RhcZdEzR1ifPQd/946tOy2KIIOIuYpmpezerg2uGMj4Hs51AklZapF/GbN7f47XWoJ
         GGkvDRzc67VjsreVJA71/xYkRa1ksDAANIs03NK7KyBCFjUJqUJJ18sOD7A15Z6FCE8X
         eX/TrBPfhlKydgitvbsY+sPLxcxrTLfw4UETSKuqUGHg+PppikklDeRaMN98tX1oWDxC
         qAxqfJv6pzyt2dr3tbN76GJeKccZ2td9dr5N+kjV5RaurzDyQ9Fr+tYs2oYexJGu5Gjg
         YDRqXCv6V9y9GadttO2iFt+DePyHScRLRyR4PShbj0EdFhUFGYUgblRnLE/MVywmxAXp
         ogzw==
X-Forwarded-Encrypted: i=1; AJvYcCUW+lJzLSDYRcVnmf0lJaQGyBZrfI8aeGXOPG3rJM3lqkbrxBymdTUUjsbn5gaDRnTwKUj33tMP@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw0QTarhTm6c1lLZ6v9PJXrcQdbZQ2vTEf+Q7KxAM2kYLDmfP5J
	7jneJGPG3S/05E3eBJjrqiInRpcHq2fh0mn1YWu68/9LqYfwWrTWDy2jWI7HRVlaS6g=
X-Gm-Gg: ASbGncuOEw+fPAJwMcPuENfK9FqTEviVlf1HZho2hnKIiv3LmZPQhEc/7Xap135dhDG
	UTJeLuf7uaMF3jGCa45Ir+mhIpVq9y91W+0H1GiCBngucoOa9vl+Iuu3/sWUJrRK4UbQYSpAM5U
	td20Ju+eYY8Qx88mbJtjn4IpIggtfwJW31Uwh8FrCrzULKp3WT6S3LlXSB6iFF+iLAHvdt97etA
	bAvtfklzU/9aLwaluw9NPppFQjJ2AkZEoY3IwlItfDpDAh+Oku+QIo5YLQsuAwN0VoW0d6X0T/6
	ruIcnUWT+1LYXzxA/scXmkgNLvBsVZIH9WRdxlfo9Djizlr9XiJCS68/xWupLsyOMgOXKz6vI74
	TGNrHP4waLWLUXhOUXKMfrezyG3AG/1iQH4fdklvi3rQPHGSmTQJfm5HielJt+Q51IhPqLoQIcZ
	eDvy+6pDqhtUaVlamjCVv7i5Jgsz+e1FD1cKN1tG5sEQwZxcf/RFs=
X-Google-Smtp-Source: AGHT+IHIdY4lmf/ThNG/wLtAd/J/zT8WgGebj1zeX31Iy4Ho2l2YmfYcVfcxwg5wDeTSuAmBVSLoaA==
X-Received: by 2002:a5d:5f51:0:b0:42b:3bfc:d5dd with SMTP id ffacd0b85a97d-42cc1d19359mr5642967f8f.54.1763808691210;
        Sat, 22 Nov 2025 02:51:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8baesm16335859f8f.39.2025.11.22.02.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 1/2] ASoC: da7213: Use component driver suspend/resume
Date: Sat, 22 Nov 2025 12:51:26 +0200
Message-ID: <20251122105127.2783085-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251122105127.2783085-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20691

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
index 702047dd3ba0..17f4befe5bb4 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2110,11 +2110,50 @@ static int da7213_probe(struct snd_soc_component *component)
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
@@ -2161,6 +2200,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 	if (!da7213->fin_min_rate)
 		return -EINVAL;
 
+	da7213->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, da7213);
 
 	/* Get required supplies */
@@ -2210,32 +2251,8 @@ static void da7213_i2c_remove(struct i2c_client *i2c)
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


