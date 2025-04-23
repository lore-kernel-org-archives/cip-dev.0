Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A592C369D8
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 18:14:27 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1721.1745432058496503170
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 11:14:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 8bAXkf2cQ7iHW7BEF0Wn9A==
X-CSE-MsgGUID: AI28BdfiSwO5IQgKYTCbeA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Apr 2025 03:14:17 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 636E6401143E;
	Thu, 24 Apr 2025 03:14:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 07/10] soc: renesas: r9a09g057-sys: Add a callback to print SoC-specific extra features
Date: Wed, 23 Apr 2025 19:13:57 +0100
Message-ID: <20250423181400.13960-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423181400.13960-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 18:14:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18575

From: John Madieu <john.madieu.xa@bp.renesas.com>

commit 25a5246b0e564d238e917b5a3684171718c950fd upstream.

Some RZ/V2H SoC variants feature a Mali-G31 (GPU) and/or a Mali-C55
(ISP) IP(s).  Detect and inform about their presence during SoC
identification.  Also detect PLL frequency and warn in case of mismatch.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Link: https://lore.kernel.org/20250128031342.52675-6-john.madieu.xa@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/r9a09g057-sys.c | 42 +++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/soc/renesas/r9a09g057-sys.c b/drivers/soc/renesas/r9a09g057-sys.c
index 49a92de581b4..4c21cc29edbc 100644
--- a/drivers/soc/renesas/r9a09g057-sys.c
+++ b/drivers/soc/renesas/r9a09g057-sys.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2025 Renesas Electronics Corp.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -12,12 +13,53 @@
 
 #include "rz-sysc.h"
 
+/* Register Offsets */
+#define SYS_LSI_MODE		0x300
+/*
+ * BOOTPLLCA[1:0]
+ *	    [0,0] => 1.1GHZ
+ *	    [0,1] => 1.5GHZ
+ *	    [1,0] => 1.6GHZ
+ *	    [1,1] => 1.7GHZ
+ */
+#define SYS_LSI_MODE_STAT_BOOTPLLCA55	GENMASK(12, 11)
+#define SYS_LSI_MODE_CA55_1_7GHZ	0x3
+
+#define SYS_LSI_PRR			0x308
+#define SYS_LSI_PRR_GPU_DIS		BIT(0)
+#define SYS_LSI_PRR_ISP_DIS		BIT(4)
+
+static void rzv2h_sys_print_id(struct device *dev,
+				void __iomem *sysc_base,
+				struct soc_device_attribute *soc_dev_attr)
+{
+	bool gpu_enabled, isp_enabled;
+	u32 prr_val, mode_val;
+
+	prr_val = readl(sysc_base + SYS_LSI_PRR);
+	mode_val = readl(sysc_base + SYS_LSI_MODE);
+
+	/* Check GPU and ISP configuration */
+	gpu_enabled = !(prr_val & SYS_LSI_PRR_GPU_DIS);
+	isp_enabled = !(prr_val & SYS_LSI_PRR_ISP_DIS);
+
+	dev_info(dev, "Detected Renesas %s %s Rev %s%s%s\n",
+		 soc_dev_attr->family, soc_dev_attr->soc_id, soc_dev_attr->revision,
+		 gpu_enabled ? " with GE3D (Mali-G31)" : "",
+		 isp_enabled ? " with ISP (Mali-C55)" : "");
+
+	/* Check CA55 PLL configuration */
+	if (FIELD_GET(SYS_LSI_MODE_STAT_BOOTPLLCA55, mode_val) != SYS_LSI_MODE_CA55_1_7GHZ)
+		dev_warn(dev, "CA55 PLL is not set to 1.7GHz\n");
+}
+
 static const struct rz_sysc_soc_id_init_data rzv2h_sys_soc_id_init_data __initconst = {
 	.family = "RZ/V2H",
 	.id = 0x847a447,
 	.devid_offset = 0x304,
 	.revision_mask = GENMASK(31, 28),
 	.specific_id_mask = GENMASK(27, 0),
+	.print_id = rzv2h_sys_print_id,
 };
 
 const struct rz_sysc_init_data rzv2h_sys_init_data = {
-- 
2.43.0


