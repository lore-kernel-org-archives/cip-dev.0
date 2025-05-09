Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A561C3ABCA
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:05 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.10343.1746783297323257225
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=HvlM5c4N;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fcab0243b5so599510a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783296; x=1747388096; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkvCcMXO9PNgz69ExAmoe2amI68HDMRaZNozPtVt3wQ=;
        b=HvlM5c4NLXz4l8iJZK1VMklNQP2DuEvZpuXFsL8XlV6u/3JUtrpaMdpOeQuye+KUhC
         qP7VrDm1yjKeA8Cgcbe3sGZ9vq6LqikIs9nJZDAjGB3I+62dNay56FnkKqcY1npWMXgy
         F6ShduGengR3E+bG82/pPJz187wTvDlD3nzIRySGh/VVC5bPc1DBJFMZ6uY6zPgCT+Ta
         kW9pCJMGtm57iFZ4i8H66TR7vfBUdMnh6+CwvAFT81pO9EruddNX084zeyyCLdkqdHGn
         lMjhdP5qvqZYrEvszqSPFDGntMZ4T+1/Alzksh/6iCqmK9kSUd1JYeTkehUCtbiw4S54
         QXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783296; x=1747388096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkvCcMXO9PNgz69ExAmoe2amI68HDMRaZNozPtVt3wQ=;
        b=l30vbJMWGrxUF/95sggjwHkvGUM4a3ceuh7r8PkNdVYmGmKUo4WPgmpkjjcXVEJbPW
         5+KMht2pj0YODmz6qwDGG7pWHOlrqyzvV93eVxt9QQ4jnP16GuXkfIVpArDfNda2qthV
         F0ZPC1qBKz+SDsYnmULdwFidL5IEUp6cv9hnSu4Ki9Pxu7DdtGRVvPoijyrPOXcB671o
         W2nshP7hGkkQfU0H+WG1ytrgVbo+cJOLyEiDuE8BX2oJJflcQE2tHNbW4gKC0DezkOYH
         PApgN7E05JtKI3t31tWdY6bxiC0cEkvObfO7kiljbOEe3GLrZcovlaiddZWlV86fsVIk
         Lz5A==
X-Forwarded-Encrypted: i=1; AJvYcCXmztcEUH1bkc+RCOlw6yctfW0qGadwo0IJW1H1rXIw+xW4bf40cwe+mekFzE1yLVGQrYMOuNav@lists.cip-project.org
X-Gm-Message-State: AOJu0YxlUbMnKVwRrS9t54L1RhqI8y7rELQVYX4xjde6fzCfUnjSErJI
	sJ6ablRtiUJOtJyGx8XSn9nuWz+olx8ytD9HuEqGXzDVKSA+nZ8SxqDGrk8ImwY=
X-Gm-Gg: ASbGnct/DT2hLN3inypcWyIL0X+ip7K7S3RcWXirX5qyKsh6qF0H/ZC7w0h58yL3BP2
	3W5tOVkRa9C8Kb8cw5lWnMjcF3O9XuTPClRXpYMRwJ0VqpIbkXgfr0Vn321RHtnNDDExwRGGWJ5
	cwgcTPzSI54e7SABvQXGpsboErgFSaF1JIVNXX/cpO+M6BZixWOPokgGeYj7idy9zWDNMF+bFZc
	4EiLSs4onCGH7Yb7gHDm1e18sedDG2RbCjp8OVn1iCoHrBXsamyRjgJog2RSByXHxoA2LQ/lss2
	gOU3xf/PgeZpjtA8rTHopp8AVDhndCB9dHgJiJBLwgLdUORFXCtTWNz5U06gekrd0YWzZg==
X-Google-Smtp-Source: AGHT+IH2EW7CQOYYtVGxBZZ9fL0Fmj9Z8R1DO+9DfMbS6Zp7GprkIuZi7KaV9Tsa56a4sOOCKhE/Rw==
X-Received: by 2002:a17:906:e092:b0:ad2:1cd7:cf05 with SMTP id a640c23a62f3a-ad21cd7d479mr131788466b.13.1746783295671;
        Fri, 09 May 2025 02:34:55 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 09/37] ASoC: da7213: Extend support for the MCK in range [2, 50] MHz
Date: Fri,  9 May 2025 12:34:14 +0300
Message-ID: <20250509093442.4015145-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18861

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
index 32d03f764e00..9a7ad34ae554 100644
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
@@ -1840,11 +1841,14 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
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
@@ -1852,8 +1856,8 @@ MODULE_DEVICE_TABLE(of, da7213_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id da7213_acpi_match[] = {
-	{ "DLGS7212", 0},
-	{ "DLGS7213", 0},
+	{ "DLGS7212", DA7212_FIN_MIN_RATE },
+	{ "DLGS7213", DA7213_FIN_MIN_RATE },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, da7213_acpi_match);
@@ -2151,6 +2155,10 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
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


