Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB167C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:33 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.10366.1746783211595372597
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=djUuKdgZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5fab81d6677so3587406a12.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783210; x=1747388010; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eIZkw+8AXzbRH5uBd+KhqF94M+SOMJCaVmzPywAL3g=;
        b=djUuKdgZj0yxno2ZNwKp4dCvCGCnHi3a/uWOH9yaW56VoFGKh7/zZkOuPF17i+Qnhb
         W0mByyEsh7S5M3hHoC1TIqOftkkgWRFqDQoTr+kAFLlgcqTtfh1t7COc/SckZC7bVxki
         9ZZrfpzbRVXAvQ0nbWE9nwEqUsj4Pd60RSyYr5QjcnRLgdL8tSAxaGvfngBv95otNC9J
         z5dz6XRfDtyDHVK6P3mdhskKcIrk49lXGZ4tlubHFGVUy92TDtS+oetARE/2Gee33HoF
         1/RjuNq9BTKx3Zu7f6+e1WiwbypVcGcJDSBPpMISC003k3emHUtivq4a8w/sI/aon+zD
         wvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783210; x=1747388010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eIZkw+8AXzbRH5uBd+KhqF94M+SOMJCaVmzPywAL3g=;
        b=kqyXn5V/KWQ9fYx2lUWAi6fhmtV+9wHbZe8RY7lcl9otr7VpuQcGWfJCTbnnoo07Qx
         7cc4+9BaehR5e4yyM+W56QoZ5+++pwMYxstgQ1+HAsjBgDPnNL0Nw7NHAs2BZqVYyHOB
         EAK5V0fVGZ4BhunhSbfNJ2UBqXT0ZOowJPh+UcOa2LMICyA/2mIyo+fGXnjk0kfNzzWT
         WFLf3LX4RhH0+7yuhP949EeY9Yuh8f3Hj/cJ0/4C6xqFRT13KYrywrsYXpQJBWH3kVeZ
         6PtKgjmBizqnuU5iOX4mJ7eR8tbHx+iOiS6KAi/HDypCZxNTktUNITU/Kp8nXmfxIwVE
         b4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWoVN5BObGkSfHVq0iGNkPTYwy6uUWoynMI6fL1ffJfBy3NqnIBTU6mQ3c5zmg7jegkgnKAfpUl@lists.cip-project.org
X-Gm-Message-State: AOJu0YwCPX+bSiKIARyEr6Uf79t2Mmql0CHaNR1V5TPY8vCIdticFsLx
	Hrven0HfFkoNs2jxU7mkkGCrc4/wzFDOBbhcR0s5SvNcquRwHc7GdIUy9nDGTbU=
X-Gm-Gg: ASbGncu1qMtJIcSTTztmlE/SsmrcrLxsF7yi23I+l+z3rLPoZRdgeRK2JwPYaLi8nvM
	6cfciCEZ2gJjBQsQuhJih42K9JHk82cvv9d5sj4YpAvq+CA/KamYdCZvwp0Zsma1+gFksGXtvIn
	04uUW9cY+/Wc5VI7wkHH3vE1AXx0pgQX3vKusUi6Thifuwi+aAQfB6ortLZD+WGt1cyfTZqTa2y
	oKf2sqTnZBqB69mGnEDlQL0CReatoiS+LStrvm9GYa+lv5EEr5NB2u3DkqL+BWQ/z6qnfuXXsIg
	A5uMgEk+sEvrdEPqlIqNGAHiInHBGMwtmAvGdOPbq6Sknqk4MvTr1mwgoQoJ/YMb8MN6+XcCvMn
	JGuTW
X-Google-Smtp-Source: AGHT+IHB/5CmkuHHMptrt3WPzQT+fkvXeMUWoglsiz4TAkBf2iLYk50QPVcQsYfoy+gU8J7BIVW/oA==
X-Received: by 2002:a05:6402:1ed3:b0:5e5:b388:2a0e with SMTP id 4fb4d7f45d1cf-5fca0731390mr2229822a12.7.1746783209967;
        Fri, 09 May 2025 02:33:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:29 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 08/34] ASoC: da7213: Extend support for the MCK in range [2, 50] MHz
Date: Fri,  9 May 2025 12:32:52 +0300
Message-ID: <20250509093318.4014916-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18825

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
index 3e1ae89305db..702047dd3ba0 100644
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
@@ -2153,6 +2157,10 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
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


