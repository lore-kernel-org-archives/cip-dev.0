Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964A9105D274
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:08 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18638.1773227046130385773
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=J9rT7b97;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48529c325f0so37123655e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227044; x=1773831844; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bH5Mum4kpcXLIBfmxG9fA/SWMlHkXIs1G30rYwCiLVo=;
        b=J9rT7b97+NYaoTJgiYrrW14wtyI69sZmdOFIkKDpl2rnwWVMvt5L8U2vB1VdBWzQFq
         kTEWFGRzuUaB8xvPFeMj+Mblk0P6DP6VmmjajggYHCqIeBluK9K5tIi8rwCbb4/Y/xz6
         z8tfqdXVhG8g3tpeCigXYyedgnhTU4W0pNguUFTUQ/TBVEtbROvJU0oR6qWN8i77Y8jw
         hq7y9iHrM9Z8Q+H6+hT7RNbxt9o/WmZNT7XFHPSqAV3X5ACYVf0uAtBTAo7Mw53Ne9hT
         OO9KMvlOD/AN92ITPOwEMlP9VZOgCfN8p1Uqa6yobJkq2NrqiYRumxfrGgvADcSnSPTe
         hj+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227044; x=1773831844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bH5Mum4kpcXLIBfmxG9fA/SWMlHkXIs1G30rYwCiLVo=;
        b=nOdYuxiOirz8lkubcU/og4i1YDbbaOsp07r1e+fvY6XOShMeTpcpKWlJSiUQBYprvb
         TIe17ipcmEIq6a5O5XMhutrLSZnxg0f2XmLEWabIzDOYpOvZAtr/3MQypU2XQ/iyRN//
         0u7+J6jOoWCy8o9/zUVUFSfkzedrwz1j2SEdEbzIIwBmZ1X9ylFFMGfhRgjzDSTw9fp8
         eDSHJznt+J1eu0eRb1+RkSxFGPy6JzYSjcQHyqKtui+C0L7Y74rAG0WRTrjr8k+JDMpV
         +jy4TiWDjx7x7jNR1FwkQwFAsJvJY5Xm7kenjQAVto2eubrCfvo/vGkvsCI6ZZsKgup7
         7xaA==
X-Gm-Message-State: AOJu0YyMMLlcIdyYfoDF+/oVo5GZ0o1sKROi8zpLlmTsf+hy76RNplXN
	xu7GMhtcvE04RXO+FdxvJfA0W8DdbzFhAQrwAf9sczm9O3BbPSdmCnbi15XyDT208uqIqRQJtnO
	7t1vu
X-Gm-Gg: ATEYQzzAmbKsrvgewc2exDARvFNs09bwkV+2Qf9qr+uc/PF/na5YJvPjcr0kVbSMfoo
	PwER+Xyo0oe6/IY0D+qqTVbyljA7ZFb71fyDvnO/AtHviu7mQ7RmBqFm6oaMYsV4OWs94hKx4iE
	u+gDS93FSq3GDNzCxoqg/j8DOyuXx7qNmCBNmYGdmNfNvoL3Bn7UZqObnZTwJkTWG/9A/zD9Wyt
	GlJ32ET8cSB9uWFAxj4mujsbUiI0TrKfz2EcOjrPEx9rSBOBKk+aXgEMUS14GJW5/R+++5FnDJW
	Jvgjs7BerGuSo9XdTK2KqdC9Ev8liZtmsgzRzrU0PZnnXTddpzce19GCXyk9uctwWqG7mtxK9w+
	/siQu2KSa3swpCwlEG1erd4RzYuLr84nZf2+Ys1n1I0VAkV5VwGEDSwFGlWPGLKWPUjR8ZNnV/2
	T7SSsT4Weln8VWg2CFK4gJq9DdxTh4qaDDfZjdkaj5rFibDs6U49fe
X-Received: by 2002:a05:600c:19cf:b0:485:3c2d:d02b with SMTP id 5b1f17b1804b1-4854b0fe9e4mr34368755e9.22.1773227044517;
        Wed, 11 Mar 2026 04:04:04 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:03 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 04/28] soc: renesas: rz-sysc: Add syscon/regmap support
Date: Wed, 11 Mar 2026 13:03:33 +0200
Message-ID: <20260311110357.1938200-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22283

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 2da2740fb9c8e26b6b5e20d74f2ed1d49824236d upstream.

The RZ/G3E system controller has various registers that control or report
some properties specific to individual IPs. The regmap is registered as a
syscon device to allow these IP drivers to access the registers through the
regmap API.

As other RZ SoCs might have custom read/write callbacks or max-offsets,
register a custom regmap configuration.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
[claudiu.beznea:
 - do not check the match->data validity in rz_sysc_probe() as it is
   always valid
 - dinamically allocate regmap_cfg]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250818162859.9661-2-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
 - drop references to RZ/V2H (r9a09g057-sys.c) and RZ/G3E
   (r9a09g047-sys.c) as these are not present in v5.10 CIP
 - fixed conflict in the include section of rz-sysc.c by keeping both
   conflicting lines alphanumerically sorted]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig          |  1 +
 drivers/soc/renesas/r9a08g045-sysc.c |  1 +
 drivers/soc/renesas/rz-sysc.c        | 30 +++++++++++++++++++++++++++-
 drivers/soc/renesas/rz-sysc.h        |  2 ++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index be8cdebce46d..407c76d952b9 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -433,6 +433,7 @@ config SYSC_R8A774B1
 
 config SYSC_RZ
 	bool "System controller for RZ SoCs" if COMPILE_TEST
+	select MFD_SYSCON
 
 config SYSC_R9A08G045
 	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST
diff --git a/drivers/soc/renesas/r9a08g045-sysc.c b/drivers/soc/renesas/r9a08g045-sysc.c
index f4db1431e036..0504d4e68761 100644
--- a/drivers/soc/renesas/r9a08g045-sysc.c
+++ b/drivers/soc/renesas/r9a08g045-sysc.c
@@ -20,4 +20,5 @@ static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initc
 
 const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
 	.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
+	.max_register = 0xe20,
 };
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index d716542a7a4a..115961483845 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -5,10 +5,14 @@
  * Copyright (C) 2024 Renesas Electronics Corp.
  */
 
+#include <linux/cleanup.h>
 #include <linux/io.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
 #include <linux/sys_soc.h>
 
 #include "rz-sysc.h"
@@ -87,14 +91,23 @@ MODULE_DEVICE_TABLE(of, rz_sysc_match);
 
 static int rz_sysc_probe(struct platform_device *pdev)
 {
+	const struct rz_sysc_init_data *data;
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
 	struct rz_sysc *sysc;
+	int ret;
+
+	struct regmap_config *regmap_cfg __free(kfree) = kzalloc(sizeof(*regmap_cfg), GFP_KERNEL);
+	if (!regmap_cfg)
+		return -ENOMEM;
 
 	match = of_match_node(rz_sysc_match, dev->of_node);
 	if (!match)
 		return -ENODEV;
 
+	data = match->data;
+
 	sysc = devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
 	if (!sysc)
 		return -ENOMEM;
@@ -104,7 +117,22 @@ static int rz_sysc_probe(struct platform_device *pdev)
 		return PTR_ERR(sysc->base);
 
 	sysc->dev = dev;
-	return rz_sysc_soc_init(sysc, match);
+	ret = rz_sysc_soc_init(sysc, match);
+	if (ret)
+		return ret;
+
+	regmap_cfg->name = "rz_sysc_regs";
+	regmap_cfg->reg_bits = 32;
+	regmap_cfg->reg_stride = 4;
+	regmap_cfg->val_bits = 32;
+	regmap_cfg->fast_io = true;
+	regmap_cfg->max_register = data->max_register;
+
+	regmap = devm_regmap_init_mmio(dev, sysc->base, regmap_cfg);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	return of_syscon_register_regmap(dev->of_node, regmap);
 }
 
 static struct platform_driver rz_sysc_driver = {
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index 908f09fa4fc9..8a3507989c04 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -29,9 +29,11 @@ struct rz_sysc_soc_id_init_data {
 /**
  * struct rz_sysc_init_data - RZ SYSC initialization data
  * @soc_id_init_data: RZ SYSC SoC ID initialization data
+ * @max_register: Maximum SYSC register offset to be used by the regmap config
  */
 struct rz_sysc_init_data {
 	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
+	u32 max_register;
 };
 
 extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
-- 
2.43.0


