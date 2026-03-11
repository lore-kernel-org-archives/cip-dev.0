Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44C3105D28C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:08 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18636.1773227044090491901
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=kUMogKna;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so37660115e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227042; x=1773831842; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RBznLAkQFtyCGplQDHcVlyjCGg8Rvzgi5O0Q/hdzBM=;
        b=kUMogKnaiX/4kS3Ss6PZMkAcDBBDM8GCpu92BqECB7/6Lz2k4v4I+Fw45HSgUh5ceP
         k63OY3OXbA9dnsGXTCDu9tdeQuqmf7DqcI5uuh0aYjh6v/4fJmoC8QOj+E7qtmJRKwXa
         jJet1ZqLLDfLL4q1+roc7QSKUwow2xvH9D2VgJjPCSGtWRFHQrxneys2Eiv+38vv/eSG
         GZwIGTpG3awXJarmK6lNMYr9XhJjHxm/x8F4JajQ1q7DqJZa8AsdS/WyFWrMlQqra4us
         u1JE338qc1LvtFS4T+qJ89YZcAhU5G06rZiJrYICtvUa6bVxWumxef7IyoDMpVPAZ65D
         eBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227042; x=1773831842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5RBznLAkQFtyCGplQDHcVlyjCGg8Rvzgi5O0Q/hdzBM=;
        b=hfYy4jZSOnkcnrNr0vmuztqFw35tOAvrMqBY8iotSb+5cC71wop82AFTtOzUzAVhHe
         oMbToyP+Z5rQiC3kNZsDgBCS9OIezFG+jamNts9/sv/bXEzPhnudI6apUBaZiQrYPu5S
         X+xIoubH5CxqE3JdvudbzbQEDYIb0GV4BuDTdSRo4w1Rvyht49vDksJBgOAWhIxnivjn
         cedYVWQRHn0CzH2FybZjWX5ZehEzdOHFjUo0AVsNvOiqKom3vQNoqYAmI61iGbfjL1xA
         26HmazWeDzr5iHBMH+5dXQ3LapZQZOumzf0loMaz+cMNRNQpvgJYK5KVmNxSi3ViAr5o
         FjOw==
X-Gm-Message-State: AOJu0YzdPtfy6YIHOB0u9hDl6OSfGC7Ww/xpqAOKt2qgWeAzx6nQu4/D
	vNNNTHP+urryZSCb5vuKx6NhHZMUQQbtlWYpa+rrlKry0SbbjsmuG2SzprGWeB4WnlIJAaBDrYn
	VGcuR
X-Gm-Gg: ATEYQzzvi87DzNbqMFLGToMz3lYdNnwsNNqx4GRgTpUsCzhKprUO5OE7klO8BynDcQh
	2ou2yxbcTm55ofdsjpSdtYJTVI1/q67YhiVBTI1f7Ko5YYGoOf5MUGum78NYNcVPdV+cAp4COFl
	Tmg4en+ti+/s7w7N6S84roQjoVxlZZ7wzETTW6bPHeMQ2ROsrHU0TBxKqImlCAxrFmHFcB/rv0P
	Xz7qTugIpt8qW1sJusNyIBMIb7lOejxr6iJxfxjMKoYJjOOl2wSFWNY/a2nnNIMcqCxFUJTgcCQ
	zW9+rMLwdlb0jemV4QctK0tBZf6wqOUOX7M133pulPqAStp1kz6rUC//bJ7Cp5qAVcT5dilMCO2
	IkcZUD5+uC/W7Bg4xPuq06mDSMHUE5Z+yG63RVuAmgsbLsa89tOM4CvrNL1rGth0xNF/0QTkSTP
	RNXieP9WQ3g2upNJewXVcwBxlfU5G8UkMB5CbyhiwdOlVqFCViiwJ5
X-Received: by 2002:a05:600c:46d3:b0:483:79ad:f3b9 with SMTP id 5b1f17b1804b1-4854b12c247mr33452665e9.28.1773227042418;
        Wed, 11 Mar 2026 04:04:02 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:01 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 02/28] soc: renesas: rz-sysc: Move RZ/G3S SoC detection to the SYSC driver
Date: Wed, 11 Mar 2026 13:03:31 +0200
Message-ID: <20260311110357.1938200-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22281

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 0704de89eee60e2f968973c7b4ccd8cd219b2d97 upstream.

Now that we have SoC detection in the RZ SYSC driver, move the RZ/G3S
SoC detection to it. The SYSC provides SoC ID in its own registers.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Link: https://lore.kernel.org/20250128031342.52675-3-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[claudiu.beznea: fixed conflict in renesas-soc.c by dropping the RZ/V2H
 code as this is not present in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig          |  5 +++++
 drivers/soc/renesas/Makefile         |  1 +
 drivers/soc/renesas/r9a08g045-sysc.c | 23 +++++++++++++++++++++++
 drivers/soc/renesas/renesas-soc.c    |  3 ---
 drivers/soc/renesas/rz-sysc.c        |  3 +++
 drivers/soc/renesas/rz-sysc.h        |  2 ++
 6 files changed, 34 insertions(+), 3 deletions(-)
 create mode 100644 drivers/soc/renesas/r9a08g045-sysc.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index f5dc9e425dff..be8cdebce46d 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -306,6 +306,7 @@ config ARCH_R9A07G054
 config ARCH_R9A08G045
 	bool "ARM64 Platform support for RZ/G3S"
 	select ARCH_RZG2L
+	select SYSC_R9A08G045
 	help
 	  This enables support for the Renesas RZ/G3S SoC variants.
 
@@ -433,4 +434,8 @@ config SYSC_R8A774B1
 config SYSC_RZ
 	bool "System controller for RZ SoCs" if COMPILE_TEST
 
+config SYSC_R9A08G045
+	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST
+	select SYSC_RZ
+
 endif # SOC_RENESAS
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 4a84f1945b3f..1013a7a18afb 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_SYSC_R8A779A0)	+= r8a779a0-sysc.o
 ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
+obj-$(CONFIG_SYSC_R9A08G045)	+= r9a08g045-sysc.o
 
 # Family
 obj-$(CONFIG_PWC_RZV2M)		+= pwc-rzv2m.o
diff --git a/drivers/soc/renesas/r9a08g045-sysc.c b/drivers/soc/renesas/r9a08g045-sysc.c
new file mode 100644
index 000000000000..f4db1431e036
--- /dev/null
+++ b/drivers/soc/renesas/r9a08g045-sysc.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3S System controller driver
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+#include <linux/bits.h>
+#include <linux/init.h>
+
+#include "rz-sysc.h"
+
+static const struct rz_sysc_soc_id_init_data rzg3s_sysc_soc_id_init_data __initconst = {
+	.family = "RZ/G3S",
+	.id = 0x85e0447,
+	.devid_offset = 0xa04,
+	.revision_mask = GENMASK(31, 28),
+	.specific_id_mask = GENMASK(27, 0),
+};
+
+const struct rz_sysc_init_data rzg3s_sysc_init_data __initconst = {
+	.soc_id_init_data = &rzg3s_sysc_soc_id_init_data,
+};
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 854020afd1ab..ffdc8625a63f 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -365,9 +365,6 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R9A07G054
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
-#ifdef CONFIG_ARCH_R9A08G045
-	{ .compatible = "renesas,r9a08g045",	.data = &soc_rz_g3s },
-#endif
 #ifdef CONFIG_ARCH_R9A09G011
 	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
 #endif
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index e00ec20298db..d716542a7a4a 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -78,6 +78,9 @@ static int rz_sysc_soc_init(struct rz_sysc *sysc, const struct of_device_id *mat
 }
 
 static const struct of_device_id rz_sysc_match[] = {
+#ifdef CONFIG_SYSC_R9A08G045
+	{ .compatible = "renesas,r9a08g045-sysc", .data = &rzg3s_sysc_init_data },
+#endif
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rz_sysc_match);
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index c9ef7e83de59..908f09fa4fc9 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -34,4 +34,6 @@ struct rz_sysc_init_data {
 	const struct rz_sysc_soc_id_init_data *soc_id_init_data;
 };
 
+extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
+
 #endif /* __SOC_RENESAS_RZ_SYSC_H__ */
-- 
2.43.0


