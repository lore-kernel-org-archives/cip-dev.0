Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65ABCFC528
	for <webhook@archiver.kernel.org>; Sat, 22 Nov 2025 10:51:29 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7141.1763808680544143862
 for <cip-dev@lists.cip-project.org>;
 Sat, 22 Nov 2025 02:51:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eWI3cu2L;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so18088805e9.1
        for <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 02:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763808679; x=1764413479; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjH0N5r2GHnR9DKLB5FqN2rI8xhkKj3tclD4sjXIoig=;
        b=eWI3cu2L3GLZtX9GvoLRpPQPKLfh5WPewOpwa9y4c9Yd87U2JUHYoE5Sd5iM3fruzO
         06UMtV9odVThn4sAInhVzPdJQMijiUFxSDIW0n32SQe69oyWszogPu2SroCnaU+40KXV
         8ZJxFkaYAZ3tIF5V5a359M1akvXuFlMcHsnizxOOaSEsxKMeY3frQx7v4aGRYrJhoS4+
         vte+sUu5iS2tw5BTNRRsNDsifjyw2qc7BvnCiJKgCp3/xZJanYbUMvu3JQ05vfuMw4BI
         tLovJcrmpoZu7CW/eytFNdJBh5ly0n9erTyAxmnMcks3r5nfc2Mgft+hjKzr+lCpTI+8
         avIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763808679; x=1764413479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bjH0N5r2GHnR9DKLB5FqN2rI8xhkKj3tclD4sjXIoig=;
        b=K3nPqTC7inLujw0Ey6x0VtPFR6yQ+8nZmQO69wOEODZ645iCT78djwp2j/t6E4Wk+1
         umAnB59UeP/h1ZR2RG4s2H8gWZ2q6m2iEIH4U6QJ6dQ7FqfjMM4hZWBQwcS12ysU36/+
         BysAbMVC7xU6AykmTf7zwaDMS66lvEL0+jgURDGKKU+aDRg/ZUH1J1C1w8QSBrpjUMGB
         PdPnuEDN9IsErs8ZhMmBY3m4KIc+IbzHqR5Ld6xJYBTtVHXRBMN5++PsGY+z/9rucHPp
         08S1HuMmbXYAbm5ZhhyW5vc6u3lYS9lhXnLMi5cIz5WosCWjfNwFNtgGgLdz2SABPr2b
         GbPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUacqxD7ynPqx/H4laBiQNSTx6+ODSGwAqaMyAFBMcui1rKKrSvgCkIWZlqM687uP4Clbf3vIL@lists.cip-project.org
X-Gm-Message-State: AOJu0Yyy8u0Iio/VgXmjCzxMkszYw6uhUhthjFT/uHr+V7H4z0BUdX04
	eDo7UDTpNdK/+l7Z7BOnfXfgW+PrzvFT59w/DoKx1PXWJB9f0fup1LxYSijb1OWGzKH1bZ/Otiw
	RLJ677lI=
X-Gm-Gg: ASbGncsWspq7kKi9nDJyE9bgHpctnnTHpRc7FqtY9NKqDwPjDo+4tzLg22rHDfd51BM
	VBmxf/FkinEDuBMpPGthTTiyLK3KEFhvIAE2RmIHqJ/6xI4xYjUE6a3ZBB8we5o3mrsK+Qd1x4B
	B3zw1npOqpI/MnprXkJ8gqcTUlPbJp2cedT7JVCWp1vuchNS1bU3kvRmy7s6Fc/oPm4GOMBEixX
	8PHZjfbhWqy+STepbqaauzFFLGUNuWnyxTgPlnrTc/y/5cchVMdUmN26xGlXYsDuUh1IKVGtoor
	vr2ixMu3nFazZF+oMppe7HoYMSCOFmNgilaA1z2FYP/Cd2lTnJzTBpL8CVaAlRBsnxG8VXncfMR
	NqlWxUJMTHDPiVKWi7WHgawR1VR5f45cY9p2vJsg3YkzL2N0jBoZkt1hx/87PBgicwxP/TGbDqj
	crQlxmqHvNZB0ARkhvHxKWT3mIW/SQJ8tib6oZxDFG
X-Google-Smtp-Source: AGHT+IHm2A0980vlUDaV1FN7ufmc9QxHrhIf43Jv5nvQxT0k2QX39V1yoSgLrm5VWhAp581hXJ+O0A==
X-Received: by 2002:a05:600c:1c13:b0:471:786:94d3 with SMTP id 5b1f17b1804b1-477c01b201fmr53217465e9.22.1763808678938;
        Sat, 22 Nov 2025 02:51:18 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf227ae2sm88105385e9.9.2025.11.22.02.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:51:18 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 1/2] ASoC: da7213: Use component driver suspend/resume
Date: Sat, 22 Nov 2025 12:51:15 +0200
Message-ID: <20251122105116.2782841-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251122105116.2782841-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 22 Nov 2025 10:51:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20688

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
[claudiu.beznea: fixed conflict by keeping the code from this patch and
 using SET_RUNTIME_PM_OPS() instead of RUNTIME_PM_OPS()]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 65 ++++++++++++++++++++++++---------------
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 6d32026ae69f..b4f4f4ebafaf 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2106,11 +2106,50 @@ static int da7213_probe(struct snd_soc_component *component)
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
@@ -2159,6 +2198,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 	if (!da7213->fin_min_rate)
 		return -EINVAL;
 
+	da7213->dev = &i2c->dev;
+
 	i2c_set_clientdata(i2c, da7213);
 
 	/* Get required supplies */
@@ -2210,32 +2251,8 @@ static int da7213_i2c_remove(struct i2c_client *i2c)
 	return 0;
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
 	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
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


