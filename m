Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB76C4450D
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:57 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19422.1782820127041702898
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=nH+0dizO;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47488efcf30so1036391f8f.3
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820125; x=1783424925; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqbxmSvgs0ndAvDLphLxGPFE+PAwxZ0gs5FhxrLKf3U=;
        b=nH+0dizOl+8fmd3z0C8j03aEtVxplW11TL733ZPebUV2xJjS/pruyruDUBcTlyRLu9
         PsQyhIqYEtL4hnc/cZwg4p2ji61lEZkLScZbz9Sg7aPATCcb9K5+MuEnOzq5HzikNnLJ
         DF2lLV2HZZm2pRHcZgmzuAKsfdeSmnEgIYS7+yG+Fsy6DCayNM9UICj9Hkj5VkmlpUDI
         CprrV4E5M/W8/gUzT9zh6MUpuQZcnzVrjW9KTkOeiYf9CwodxhlVMNkHd4CxQ5PDoNOg
         4Cjeo4GDQeGw85FQpTFujfnhNbEVUYkWWI0kmnC2hrJ1+JLjW9oerxkwRxwm/OGBGhxZ
         nzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820125; x=1783424925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqbxmSvgs0ndAvDLphLxGPFE+PAwxZ0gs5FhxrLKf3U=;
        b=ejD6BxP1ntqufIxQKcBUF0hhrpFkBpJj/fDIp5ocgy4qkatB6ejUWXHnENnzanJRA1
         NafGI78HYFonL8C+FhXoj/dW6nKdEvyJGLFhTZ/9KLCggD2PNtrpNG9gMkRx66YshNMd
         MpWP1Rs2RgzB+Q+uTB9O9XHg52NOPrYc9k3d5VjE8Ep058w9zbGEauTeLIll5x0dzbsj
         hWTDLP3S7zA2EpBu2z3w0z25sx/0jgLu2WNvieYt82Il3gy+41xF7FW0ylDbDXwOswxu
         isWneFyA7VLisOk7Nn/McNRtlm04DXyp/deAI3EK/0d6mpM+oBNIk2ok5H5+hdVgbpMC
         PyRg==
X-Gm-Message-State: AOJu0Yyk+4MxOyXqYUgdHyrCgCpFIwhwkKWXrPzyyWSGiPhC76q3/Kkg
	6O06smf+B7RKnqiAsCDS5qiEs+7aDJtJjSb5RLED3VzmmfVbne88iaKdFy3sT7Fx
X-Gm-Gg: AfdE7cknXKWrMOaK6acuWSW5ouZL52nJuV01FFuppN8qaTXA/XKEWai7GFjcdUeabib
	srs1d8+6W3zhVDGL4w6x01jvLK9SfhM4xuYx2brifpUVRmnWj81H1TQKPyjg5qDk67bmiUn1ZLz
	4aOPuask0ZlwTx7nyaLzUZlF7x8yXreXVm94B5vdJwOPplF7U44G1W3avYoTusOacdKmpI/Hs1i
	CQh2SMtwZPM08lgNIgNBNjJ0uUyh6lr93ZKiChz/NHIYVDvKB12j9qPdb7Ymq+yfhiSPj6Q7z4V
	T8AzOlbclOcVBhTe1mkEkzS5DiL8tx02+kOFDhKhV0cCwl0hTLzp7516ThynnS4Yowk6bZJEZ3J
	paWFBTXBGNLH7/FMzgdyqgVIJns/gJcGSdMgPhFqor/dGdivsLLK54A2Net/i9/Zvqtt90qxvMm
	iqxQaukqXuB9qnZKzhdORq5/E1fTubvvqW0nEf2A==
X-Received: by 2002:a05:600c:310d:b0:493:b646:e90d with SMTP id 5b1f17b1804b1-493b82c1436mr51039595e9.36.1782820125192;
        Tue, 30 Jun 2026 04:48:45 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:44 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/39] soc: renesas: rz-sysc: Add SoC identification for RZ/G3L SoC
Date: Tue, 30 Jun 2026 12:47:28 +0100
Message-ID: <20260630114813.92739-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23333

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit b1de9823fdc67a8e9cd0dcf1f6f0e9780d425d4e ]

Add SoC identification for the RZ/G3L SoC using the System Controller
(SYSC) block.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260203103031.247435-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig          | 12 ++++
 drivers/soc/renesas/Makefile         |  1 +
 drivers/soc/renesas/r9a08g046-sysc.c | 91 ++++++++++++++++++++++++++++
 drivers/soc/renesas/rz-sysc.c        |  3 +
 drivers/soc/renesas/rz-sysc.h        |  1 +
 5 files changed, 108 insertions(+)
 create mode 100644 drivers/soc/renesas/r9a08g046-sysc.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 728eddf69085..90ba65072af2 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -338,6 +338,14 @@ config ARCH_R9A08G045
 	help
 	  This enables support for the Renesas RZ/G3S SoC variants.
 
+config ARCH_R9A08G046
+	bool "ARM64 Platform support for R9A08G046 (RZ/G3L)"
+	default y if ARCH_RENESAS
+	select ARCH_RZG2L
+	select SYSC_R9A08G046
+	help
+	  This enables support for the Renesas RZ/G3L SoC variants.
+
 config ARCH_R9A09G011
 	bool "ARM64 Platform support for RZ/V2M"
 	select PM
@@ -413,6 +421,10 @@ config SYSC_R9A08G045
 	bool "Renesas RZ/G3S System controller support" if COMPILE_TEST
 	select SYSC_RZ
 
+config SYSC_R9A08G046
+	bool "Renesas System controller support for R9A08G046 (RZ/G3L)" if COMPILE_TEST
+	select SYSC_RZ
+
 config SYS_R9A09G047
 	bool "Renesas RZ/G3E System controller support" if COMPILE_TEST
 	select SYSC_RZ
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 3bdcc6a395d5..47b82be38284 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -7,6 +7,7 @@ ifdef CONFIG_SMP
 obj-$(CONFIG_ARCH_R9A06G032)	+= r9a06g032-smp.o
 endif
 obj-$(CONFIG_SYSC_R9A08G045)	+= r9a08g045-sysc.o
+obj-$(CONFIG_SYSC_R9A08G046)	+= r9a08g046-sysc.o
 obj-$(CONFIG_SYS_R9A09G047)	+= r9a09g047-sys.o
 obj-$(CONFIG_SYS_R9A09G056)	+= r9a09g056-sys.o
 obj-$(CONFIG_SYS_R9A09G057)	+= r9a09g057-sys.o
diff --git a/drivers/soc/renesas/r9a08g046-sysc.c b/drivers/soc/renesas/r9a08g046-sysc.c
new file mode 100644
index 000000000000..fd98df196d0a
--- /dev/null
+++ b/drivers/soc/renesas/r9a08g046-sysc.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3L System controller (SYSC) driver
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+#include <linux/bits.h>
+#include <linux/device.h>
+#include <linux/init.h>
+
+#include "rz-sysc.h"
+
+#define SYS_XSPI_MAP_STAADD_CS0		0x348
+#define SYS_XSPI_MAP_ENDADD_CS0		0x34c
+#define SYS_XSPI_MAP_STAADD_CS1		0x350
+#define SYS_XSPI_MAP_ENDADD_CS1		0x354
+#define SYS_GETH0_CFG			0x380
+#define SYS_GETH1_CFG			0x390
+#define SYS_PCIE_CFG			0x3a0
+#define SYS_PCIE_MON			0x3a4
+#define SYS_PCIE_PHY			0x3b4
+#define SYS_I2C0_CFG			0x400
+#define SYS_I2C1_CFG			0x410
+#define SYS_I2C2_CFG			0x420
+#define SYS_I2C3_CFG			0x430
+#define SYS_I3C_CFG			0x440
+#define SYS_PWRRDY_N			0xd70
+#define SYS_IPCONT_SEL_CLONECH		0xe2c
+
+static bool rzg3l_regmap_readable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SYS_XSPI_MAP_STAADD_CS0:
+	case SYS_XSPI_MAP_ENDADD_CS0:
+	case SYS_XSPI_MAP_STAADD_CS1:
+	case SYS_XSPI_MAP_ENDADD_CS1:
+	case SYS_GETH0_CFG:
+	case SYS_GETH1_CFG:
+	case SYS_PCIE_CFG:
+	case SYS_PCIE_MON:
+	case SYS_PCIE_PHY:
+	case SYS_I2C0_CFG:
+	case SYS_I2C1_CFG:
+	case SYS_I2C2_CFG:
+	case SYS_I2C3_CFG:
+	case SYS_I3C_CFG:
+	case SYS_PWRRDY_N:
+	case SYS_IPCONT_SEL_CLONECH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool rzg3l_regmap_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case SYS_XSPI_MAP_STAADD_CS0:
+	case SYS_XSPI_MAP_ENDADD_CS0:
+	case SYS_XSPI_MAP_STAADD_CS1:
+	case SYS_XSPI_MAP_ENDADD_CS1:
+	case SYS_PCIE_CFG:
+	case SYS_PCIE_PHY:
+	case SYS_I2C0_CFG:
+	case SYS_I2C1_CFG:
+	case SYS_I2C2_CFG:
+	case SYS_I2C3_CFG:
+	case SYS_I3C_CFG:
+	case SYS_PWRRDY_N:
+	case SYS_IPCONT_SEL_CLONECH:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static const struct rz_sysc_soc_id_init_data rzg3l_sysc_soc_id_init_data __initconst = {
+	.family = "RZ/G3L",
+	.id = 0x87d9447,
+	.devid_offset = 0xa04,
+	.revision_mask = GENMASK(31, 28),
+	.specific_id_mask = GENMASK(27, 0),
+};
+
+const struct rz_sysc_init_data rzg3l_sysc_init_data __initconst = {
+	.soc_id_init_data = &rzg3l_sysc_soc_id_init_data,
+	.readable_reg = rzg3l_regmap_readable_reg,
+	.writeable_reg = rzg3l_regmap_writeable_reg,
+	.max_register = 0xe2c,
+};
diff --git a/drivers/soc/renesas/rz-sysc.c b/drivers/soc/renesas/rz-sysc.c
index 19c1e666279b..dafbf7aa3f97 100644
--- a/drivers/soc/renesas/rz-sysc.c
+++ b/drivers/soc/renesas/rz-sysc.c
@@ -89,6 +89,9 @@ static const struct of_device_id rz_sysc_match[] = {
 #ifdef CONFIG_SYSC_R9A08G045
 	{ .compatible = "renesas,r9a08g045-sysc", .data = &rzg3s_sysc_init_data },
 #endif
+#ifdef CONFIG_SYSC_R9A08G046
+	{ .compatible = "renesas,r9a08g046-sysc", .data = &rzg3l_sysc_init_data },
+#endif
 #ifdef CONFIG_SYS_R9A09G047
 	{ .compatible = "renesas,r9a09g047-sys", .data = &rzg3e_sys_init_data },
 #endif
diff --git a/drivers/soc/renesas/rz-sysc.h b/drivers/soc/renesas/rz-sysc.h
index 88929bf21cb1..921ee0d26c47 100644
--- a/drivers/soc/renesas/rz-sysc.h
+++ b/drivers/soc/renesas/rz-sysc.h
@@ -46,6 +46,7 @@ struct rz_sysc_init_data {
 };
 
 extern const struct rz_sysc_init_data rzg3e_sys_init_data;
+extern const struct rz_sysc_init_data rzg3l_sysc_init_data;
 extern const struct rz_sysc_init_data rzg3s_sysc_init_data;
 extern const struct rz_sysc_init_data rzv2h_sys_init_data;
 extern const struct rz_sysc_init_data rzv2n_sys_init_data;
-- 
2.43.0


