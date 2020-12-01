Return-Path: <SRS0=o74c=FF=lists.cip-project.org=bounce+64572+5916+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021EC64E7A
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:51 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48312054F
	for <cip-dev@archiver.kernel.org>; Tue,  1 Dec 2020 08:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NPvtoFpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48312054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5916+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sZkNYY4521723xBMsaIs24nU; Tue, 01 Dec 2020 00:39:48 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.7146.1606811983019624389
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Dec 2020 00:39:45 -0800
X-IronPort-AV: E=Sophos;i="5.78,383,1599490800"; 
   d="scan'208";a="64471860"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2020 17:39:44 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 953F14256977;
	Tue,  1 Dec 2020 17:39:43 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v2 4.4.y-cip 03/11] soc: renesas: Identify SoC and register with the SoC bus
Date: Tue,  1 Dec 2020 08:39:30 +0000
Message-Id: <20201201083938.32688-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201201083938.32688-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Goa2scX2qU3h4xPUyORV4eiax4520388AA=
Content-Type: multipart/mixed; boundary="cY591MxNzM7kMWlyRPzS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606811988;
 bh=8ZeiL6d3VELawdt7C0whEX7fFtL5E2miAgt3pn2MVAU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NPvtoFpeIlrWoj/h6CDzYAEn66SC0xHdjxhQ2KiYkSJHiahW6EW/nUpsvL2TqZgzDs2
 obUx34o3lh57sOwFmoMFcAh2D2TlJky43Ech+3rIXSHRrE6pMxLo07PYND5+Pk7w2Kvd5
 0KPNZvVjtURg3+HiMOzocqTpC3vPh6i8j5g=

--cY591MxNzM7kMWlyRPzS

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 8d6799a9ba23acd675f3243580ee6f1756fb4381 upstream.

Identify the SoC type and revision, and register this information with
the SoC bus, so it is available under /sys/devices/soc0/, and can be
checked where needed using soc_device_match().

Identification is done using the Product Register or Common Chip Code
Register, as declared in DT (PRR only for now), or using a hardcoded
fallback if missing.

Example:

    Detected Renesas R-Car Gen2 r8a7791 ES1.0
    ...
    # cat /sys/devices/soc0/{machine,family,soc_id,revision}
    Koelsch
    R-Car Gen2
    r8a7791
    ES1.0

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[PL: Dropped references to other platforms apart from RZ/G1{ME},
dropped SOC_BUS config option from arm64, enabled SOC_BUS config
option for ARCH_R8A7743 and ARCH_R8A7745]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/mach-shmobile/Kconfig    |   2 +
 drivers/soc/renesas/Makefile      |   2 +
 drivers/soc/renesas/renesas-soc.c | 123 ++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
 create mode 100644 drivers/soc/renesas/renesas-soc.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a51df53f0914..3f1e27b76d59 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -72,6 +72,7 @@ config ARCH_R8A7742
 config ARCH_R8A7743
 	bool "RZ/G1M (R8A77430)"
 	select ARCH_RCAR_GEN2
+	select SOC_BUS
 
 config ARCH_R8A7744
 	bool "RZ/G1N (R8A77440)"
@@ -81,6 +82,7 @@ config ARCH_R8A7744
 config ARCH_R8A7745
 	bool "RZ/G1E (R8A77450)"
 	select ARCH_RCAR_GEN2
+	select SOC_BUS
 
 config ARCH_R8A77470
 	bool "RZ/G1C (R8A77470)"
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 87517569af13..77e8f953f4c8 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1 +1,3 @@
 obj-$(CONFIG_ARCH_RCAR_GEN2)	+= rcar-rst.o
+
+obj-$(CONFIG_SOC_BUS)		+= renesas-soc.o
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
new file mode 100644
index 000000000000..e36b51a52dfc
--- /dev/null
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -0,0 +1,123 @@
+/*
+ * Renesas SoC Identification
+ *
+ * Copyright (C) 2014-2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+struct renesas_family {
+	const char name[16];
+	u32 reg;			/* CCCR or PRR, if not in DT */
+};
+
+static const struct renesas_family fam_rzg __initconst __maybe_unused = {
+	.name	= "RZ/G",
+	.reg	= 0xff000044,		/* PRR (Product Register) */
+};
+
+struct renesas_soc {
+	const struct renesas_family *family;
+	u8 id;
+};
+
+static const struct renesas_soc soc_rz_g1m __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x47,
+};
+
+static const struct renesas_soc soc_rz_g1e __initconst __maybe_unused = {
+	.family	= &fam_rzg,
+	.id	= 0x4c,
+};
+
+static const struct of_device_id renesas_socs[] __initconst = {
+#ifdef CONFIG_ARCH_R8A7743
+	{ .compatible = "renesas,r8a7743",	.data = &soc_rz_g1m },
+#endif
+#ifdef CONFIG_ARCH_R8A7745
+	{ .compatible = "renesas,r8a7745",	.data = &soc_rz_g1e },
+#endif
+	{ /* sentinel */ }
+};
+
+static int __init renesas_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const struct renesas_family *family;
+	const struct of_device_id *match;
+	const struct renesas_soc *soc;
+	void __iomem *chipid = NULL;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+	unsigned int product;
+
+	match = of_match_node(renesas_socs, of_root);
+	if (!match)
+		return -ENODEV;
+
+	soc = match->data;
+	family = soc->family;
+
+	/* Try PRR first, then hardcoded fallback */
+	np = of_find_compatible_node(NULL, NULL, "renesas,prr");
+	if (np) {
+		chipid = of_iomap(np, 0);
+		of_node_put(np);
+	} else if (soc->id) {
+		chipid = ioremap(family->reg, 4);
+	}
+	if (chipid) {
+		product = readl(chipid);
+		iounmap(chipid);
+		if (soc->id && ((product >> 8) & 0xff) != soc->id) {
+			pr_warn("SoC mismatch (product = 0x%x)\n", product);
+			return -ENODEV;
+		}
+	}
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	of_node_put(np);
+
+	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
+	soc_dev_attr->soc_id = kstrdup_const(strchr(match->compatible, ',') + 1,
+					     GFP_KERNEL);
+	if (chipid)
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
+						   ((product >> 4) & 0x0f) + 1,
+						   product & 0xf);
+
+	pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
+		soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree_const(soc_dev_attr->soc_id);
+		kfree_const(soc_dev_attr->family);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	return 0;
+}
+core_initcall(renesas_soc_init);
-- 
2.17.1


--cY591MxNzM7kMWlyRPzS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5916): https://lists.cip-project.org/g/cip-dev/message=
/5916
Mute This Topic: https://lists.cip-project.org/mt/78628861/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--cY591MxNzM7kMWlyRPzS--
