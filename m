Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB8DC3ABCC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:13 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.10256.1746783131962322489
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=g5Dq6V6M;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so3289531a12.3
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783130; x=1747387930; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cq2z+UgRzCG7b2y5ctNTbFbZqvenUDJTwnRuKYLkuHI=;
        b=g5Dq6V6MBBvwsyUu/21ku4rxyIOiqzmKTdSBs6yV4FsocDLXnHw0ZKi8nkptRLKI64
         T9bac5UJ2x++RcIS+T22l85YWR6KhGALvdAv7rVklHAMpjYKCFel8YiAj0xaIX9bSl9w
         0/hW9DA6bYqp9/v0EpxlgrP+aZHSAvAMef/kgKskd+ZFI8T0QXHdUrsUYXuQ2lhZ1R4H
         QVBrssUha0jFamPt77yRM3R70bEx6oiX96FHZfdDHSdfXbwH3tqwWi/zzsLIhLgfz6Zy
         9czLl5TZWFKXl3UjCVr1a/8JDxh1rgoB3kXdBZ31vlXY/koI59xv09JY5HwW6trXGAHf
         hjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783130; x=1747387930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cq2z+UgRzCG7b2y5ctNTbFbZqvenUDJTwnRuKYLkuHI=;
        b=iXCdE9VZVI4sHLwwr9Ivhr04X721GPcdXlyVqjVZjxEWCzqC0mMd1sYn/lXVRmIxmi
         Si8GuqXfQcuu/w/OlRix0AZF2qCpkQQretRiOgMRNX8EXD147DmGkfzhFUlydjHCOlUr
         3t7BB+Uxa+UysPrH5E02gaAElkhe8uXi7992syB0wIr41ucGNokvv24CHJ2dh9WyuHq4
         d+rO7gvLATO12VRLbNl1Vhd0liBK9nKxef7Z8Qbu4pGXwvbmN+e0Lf4S7Jn6zIMNQsT/
         BBWb7tNsYV+U+qdq0LaekGY83N1Ky7dYqO0ISkL3wFGdtz1VsgADO6lb9uTNRjJLTXxp
         aBzg==
X-Forwarded-Encrypted: i=1; AJvYcCX131ZjLoklCbdLQTO5DnMJ8lboBQraSnZj/a03oK4+AOlWz1T3yUyEkiBPGJoNrvLwxt8nn31d@lists.cip-project.org
X-Gm-Message-State: AOJu0YwldvO92hc7yBpfJD01PLJwyfMks460DE+QQrSoMcD150E3eIsV
	ZYJ1E6TVMXBuC11bRnFzxQ98M6jFe0wU1p/aaCZRaJ0RWpHjoL+O1+lf8W+RPdY=
X-Gm-Gg: ASbGncvRqbyf22F7nrj6qST8iQEo4Hi/WlrPXogXJXPbv6YdJDZ6fm4RfpQUzMi8HEk
	XziOZhEdIuEMy9pA7/O85IJ9UTmaMwY8xaq3O5wc7h6HBxPsc/4CZHBfWuJOV1iGDeoUAwMl/u1
	4oF3QiKLRdXT6Wq2+c4+4ZxBb0IjgOqf1QdNAUNM41TXLgYjr8v67rX/7oibSs9o3PsyI1LCRwO
	S5O7SuUV2v2poftGLsVk1R2Y/rAJehQWhrXcCMcLOn/sru8ZRY4AGFMyh2RPY96XSz6wzbl+jWW
	O6q2fxze9VqGNxQSoVTpH1MKVuIGkV2BDupVzIQAMouIS7QQldmH8kFvUwNMe0AXJCSsaA==
X-Google-Smtp-Source: AGHT+IHm5XE0OXL1QAX3A+2BZt1k4hzwcXNVWirF25FzlorDr70QiLdmB2jC5BRDMKB5X2bpxVjtlA==
X-Received: by 2002:a05:6402:2347:b0:5f3:4ac5:9e58 with SMTP id 4fb4d7f45d1cf-5fca07edbb0mr1996928a12.22.1746783130247;
        Fri, 09 May 2025 02:32:10 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:09 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 04/29] ASoC: da7213: Extend support for the MCK in range [2, 50] MHz
Date: Fri,  9 May 2025 12:31:38 +0300
Message-ID: <20250509093203.4014750-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18791

From: Hao Bui <hao.bui.yg@renesas.com>

commit b3296f9095d6ad24723e5ad89c28acc317d0c3cf upstream.

According to DA7212 HW manual, the codec's PLL input divider can operate
with MCLK range from 2MHz to 50MHz but current driver only set the
minimum supported MCLK frequency to 5MHz. That cause 11.025kHz audio
which is corresponding to MCLK of 2.8224MHz (11.025kHz * 256) unable to
play in case audio-simple-card is used.

Signed-off-by: Hao Bui <hao.bui.yg@renesas.com>
Co-developed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-27-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 18 +++++++++++++-----
 sound/soc/codecs/da7213.h |  1 +
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 5ec51537ece5..eb97ac73ec06 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -20,6 +20,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <linux/pm_runtime.h>
+#include <linux/units.h>
 #include <sound/soc.h>
 #include <sound/initval.h>
 #include <sound/tlv.h>
@@ -1559,7 +1560,7 @@ static int da7213_set_component_sysclk(struct snd_soc_component *component,
 	if (freq == 0)
 		return 0;
 
-	if (((freq < 5000000) && (freq != 32768)) || (freq > 54000000)) {
+	if (((freq < da7213->fin_min_rate) && (freq != 32768)) || (freq > 54000000)) {
 		dev_err(component->dev, "Unsupported MCLK value %d\n",
 			freq);
 		return -EINVAL;
@@ -1858,11 +1859,14 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 	return 0;
 }
 
+#define DA7213_FIN_MIN_RATE	(5 * MEGA)
+#define DA7212_FIN_MIN_RATE	(2 * MEGA)
+
 #if defined(CONFIG_OF)
 /* DT */
 static const struct of_device_id da7213_of_match[] = {
-	{ .compatible = "dlg,da7212", },
-	{ .compatible = "dlg,da7213", },
+	{ .compatible = "dlg,da7212", .data = (void *)DA7212_FIN_MIN_RATE },
+	{ .compatible = "dlg,da7213", .data = (void *)DA7213_FIN_MIN_RATE },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da7213_of_match);
@@ -1870,8 +1874,8 @@ MODULE_DEVICE_TABLE(of, da7213_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id da7213_acpi_match[] = {
-	{ "DLGS7212", 0},
-	{ "DLGS7213", 0},
+	{ "DLGS7212", DA7212_FIN_MIN_RATE },
+	{ "DLGS7213", DA7213_FIN_MIN_RATE },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, da7213_acpi_match);
@@ -2167,6 +2171,10 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 	if (!da7213)
 		return -ENOMEM;
 
+	da7213->fin_min_rate = (uintptr_t)i2c_get_match_data(i2c);
+	if (!da7213->fin_min_rate)
+		return -EINVAL;
+
 	i2c_set_clientdata(i2c, da7213);
 
 	/* Get required supplies */
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 505b731c0adb..b9ab791d6b88 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -600,6 +600,7 @@ struct da7213_priv {
 	struct clk *mclk;
 	unsigned int mclk_rate;
 	unsigned int out_rate;
+	unsigned int fin_min_rate;
 	int clk_src;
 	bool master;
 	bool alc_calib_auto;
-- 
2.43.0


