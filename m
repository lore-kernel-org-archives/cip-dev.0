Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C84105D287
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:08 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18635.1773227043022340282
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=TPwvON89;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-485392de558so20251025e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227041; x=1773831841; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKs953QmDG/z9PzvCh/rIE5/xd9zH0mmzmZO3wAugtc=;
        b=TPwvON89BX6RgVxMRJPbGns00bDVSjRJhp1zM9/NYo9rhHpSBJbfVByW8/RPM0KynB
         8+aIPzkIwzYJ/un1Nc0eq1K9h+yNaXtAQ0dtOuI+sQVL0q/5oX/LGJdQeFsn58qm/wvA
         nJXUetRDuG6uANUqJktaXo9eMBFv4ROsBo8wWjH0xkQIo96jT3rmcnRru/6fmIsvkNPk
         cW3svj1RieIqUNkPeVwfOOKkQ04BV5m7ns4UOhrE5M2wEN1rA1sM0055W9U7NB/OjnMb
         jCsUuizf2B0v3s35n5X3T5A9KYhE8wbHIYRrS+DPKBnHHoU0bUEkDXLYTvhCg1XF3E07
         5jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227041; x=1773831841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKs953QmDG/z9PzvCh/rIE5/xd9zH0mmzmZO3wAugtc=;
        b=h1rdQ40qTlYhXGDeulop9r4M7pktPWNEn5h29UXtGdHF/LI49b/XzCjCQieEzWtkem
         7KrzXc8qsOHkSXkasZH9nurx1pBlk/6Zj56jbxNrbqsQ7nL1tYtWnq+o0DbIVX8rQ7Q0
         Dv/NInog+/5J83mEW49JET96aGmx0PUQnVCkrnSPkhbLb9AOWHtI7R/w4cBKXXVknfJc
         GogdG3I/3wYyOx+O1iVfz6UreVBLSQjhEAbgHkUQl+gOF+a6x8jsQlZN+BD9bVM91FXF
         QjpEuy3bujlPW/B5gnwXtRAPAKjI+QQ3nl8QfnwVKc9eL/7zkQJTh/vc9qA8Qq5UiY6R
         HNbw==
X-Gm-Message-State: AOJu0YyM2a1yMjuwAjx78rDsCa4kqIic+qUn3Fn/xFZySKLqjuvWF6fk
	Qf6GVw53Q0y8NeDtDnWKHKU6nmcR8CxOB7TRmxbxsSQCOHtyI/ZUtdP1EMUTsnEnCIg=
X-Gm-Gg: ATEYQzzbskejIQRb86BjQSWH4vrH1vqmyOv1EwKyw/xf9l1+bSyfPqpzKGRjfHR7BHq
	pTj7bwfy1ZwobgWNgVLnWRdmIxy7dU8jpEXnEdb4MFd8pb0wPCXJDBnBXjHj1R7p+2c5AXd9G3V
	2qb+NPihKUNwwQNKHGETxZ0JyWFpZgpef2ZvAvzuWJHOzcJ9pH0Hj1SdyDsSvckhAcYd9Dq4515
	XKfnlkdu7/tSG8vLwgrTvfGXaFBmnahq+gbZoA+sO+LlUWENA9RE/AprBJOoWgTEHWq9sN4v5r9
	IV5CaoGjzhajyWs0Su0nbBHW361tpbpO5bUeCgPHBLkj/HplZsFGBBnAugVsLeHJLHQkpNBa7m6
	Y0LWiiM9HlDULcR92nbi+VdVQLwPhV4w4UL1sLiHUk7afCkRE5eEWaJ+1LWTyCfwyZy+H7DFJfZ
	y1XpwYiicIoRo2VpHoOT1MIMEFSpay+ieMkHYrbfki6+aII8uORKCg
X-Received: by 2002:a05:600c:1f8e:b0:485:3f1c:d897 with SMTP id 5b1f17b1804b1-4854b0bc6d4mr35175635e9.9.1773227041248;
        Wed, 11 Mar 2026 04:04:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 01/28] soc: renesas: Add SYSC driver for Renesas RZ family
Date: Wed, 11 Mar 2026 13:03:30 +0200
Message-ID: <20260311110357.1938200-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22280

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit c1aca5588279fc341a2e12d61e853bb1fd4c72d5 upstream.

The RZ/G3S system controller (SYSC) has various registers that control
different functionalities.  One of the exposed register offers
information about the SoC identification.

Add a driver that identifies the SoC.  Later the driver will be extended
with other functionalities.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250128031342.52675-2-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea:
 - fixed conflict in Makefile and Kconfig by keeping the
   code from v5.10 CIP and from this patch
 - include linux/module.h to avoid compilation errors]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig   |   3 +
 drivers/soc/renesas/Makefile  |   1 +
 drivers/soc/renesas/rz-sysc.c | 124 ++++++++++++++++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.h |  37 ++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 drivers/soc/renesas/rz-sysc.c
 create mode 100644 drivers/soc/renesas/rz-sysc.h

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index f9aed9eb9f43..f5dc9e425dff 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -430,4 +430,7 @@ config SYSC_R8A774B1
 	bool "System Controller support for RZ/G2N" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_RZ
+	bool "System controller for RZ SoCs" if COMPILE_TEST
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index c571e8ef9192..4a84f1945b3f 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
 obj-$(CONFIG_RST_RCAR)		+= rcar-rst.o
 obj-$(CONFIG_SYSC_RCAR)		+= rcar-sysc.o
 obj-$(CONFIG_SYSC_RMOBILE)	+= rmobile-sysc.o
+obj-$(CONFIG_SYSC_RZ)		+= rz-sysc.o
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
new file mode 100644
index 000000000000..e00ec20298db
--- /dev/null
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ System controller driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/sys_soc.h>
+
+#include "rz-sysc.h"
+
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
+/**
+ * struct rz_sysc - RZ SYSC private data structure
+ * @base: SYSC base address
+ * @dev: SYSC device pointer
+ */
+struct rz_sysc {
+	void __iomem *base;
+	struct device *dev;
+};
+
+static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *match)
+{
+	const struct rz_sysc_init_data *sysc_data = match->data;
+	const struct rz_sysc_soc_id_init_data *soc_data = sysc_data->soc_id_init_data;
+	struct soc_device_attribute *soc_dev_attr;
+	const char *soc_id_start, *soc_id_end;
+	u32 val, revision, specific_id;
+	struct soc_device *soc_dev;
+	char soc_id[32] = {0};
+	size_t size;
+
+	soc_id_start = strchr(match->compatible, ',') + 1;
+	soc_id_end = strchr(match->compatible, '-');
+	size = soc_id_end - soc_id_start + 1;
+	if (size > 32)
+		size = sizeof(soc_id);
+	strscpy(soc_id, soc_id_start, size);
+
+	soc_dev_attr = devm_kzalloc(sysc->dev, sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	soc_dev_attr->family = devm_kstrdup(sysc->dev, soc_data->family, GFP_KERNEL);
+	if (!soc_dev_attr->family)
+		return -ENOMEM;
+
+	soc_dev_attr->soc_id = devm_kstrdup(sysc->dev, soc_id, GFP_KERNEL);
+	if (!soc_dev_attr->soc_id)
+		return -ENOMEM;
+
+	val = readl(sysc->base + soc_data->devid_offset);
+	revision = field_get(soc_data->revision_mask, val);
+	specific_id = field_get(soc_data->specific_id_mask, val);
+	soc_dev_attr->revision = devm_kasprintf(sysc->dev, GFP_KERNEL, "%u", revision);
+	if (!soc_dev_attr->revision)
+		return -ENOMEM;
+
+	if (soc_data->id && specific_id != soc_data->id) {
+		dev_warn(sysc->dev, "SoC mismatch (product = 0x%x)\n", specific_id);
+		return -ENODEV;
+	}
+
+	dev_info(sysc->dev, "Detected Renesas %s %s Rev %s\n", soc_dev_attr->family,
+		 soc_dev_attr->soc_id, soc_dev_attr->revision);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev))
+		return PTR_ERR(soc_dev);
+
+	return 0;
+}
+
+static const struct of_device_id rz_sysc_match[] = {
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rz_sysc_match);
+
+static int rz_sysc_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct rz_sysc *sysc;
+
+	match = of_match_node(rz_sysc_match, dev->of_node);
+	if (!match)
+		return -ENODEV;
+
+	sysc = devm_kzalloc(dev, sizeof(*sysc), GFP_KERNEL);
+	if (!sysc)
+		return -ENOMEM;
+
+	sysc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sysc->base))
+		return PTR_ERR(sysc->base);
+
+	sysc->dev = dev;
+	return rz_sysc_soc_init(sysc, match);
+}
+
+static struct platform_driver rz_sysc_driver = {
+	.driver = {
+		.name = "renesas-rz-sysc",
+		.suppress_bind_attrs = true,
+		.of_match_table = rz_sysc_match
+	},
+	.probe = rz_sysc_probe
+};
+
+static int __init rz_sysc_init(void)
+{
+	return platform_driver_register(&rz_sysc_driver);
+}
+subsys_initcall(rz_sysc_init);
+
+MODULE_DESCRIPTION("Renesas RZ System Controller Driver");
+MODULE_AUTHOR("Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
new file mode 100644
index 000000000000..c9ef7e83de59
--- /dev/null
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Renesas RZ System Controller
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#ifndef __SOC_RENESAS_RZ_SYSC_H__
+#define __SOC_RENESAS_RZ_SYSC_H__
+
+#include <linux/types.h>
+
+/**
+ * struct rz_syc_soc_id_init_data - RZ SYSC SoC identification initialization data
+ * @family: RZ SoC family
+ * @id: RZ SoC expected ID
+ * @devid_offset: SYSC SoC ID register offset
+ * @revision_mask: SYSC SoC ID revision mask
+ * @specific_id_mask: SYSC SoC ID specific ID mask
+ */
+struct rz_sysc_soc_id_init_data {
+	const char * const family;
+	u32 id;
+	u32 devid_offset;
+	u32 revision_mask;
+	u32 specific_id_mask;
+};
+
+/**
+ * struct rz_sysc_init_data - RZ SYSC initialization data
+ * @soc_id_init_data: RZ SYSC SoC ID initialization data
+ */
+struct rz_sysc_init_data {
+	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
+};
+
+#endif /* __SOC_RENESAS_RZ_SYSC_H__ */
-- 
2.43.0


