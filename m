Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E9AC433EF
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:22:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3865.1657869771063039530
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:22:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955775"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:22:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 40D1240083E1;
	Fri, 15 Jul 2022 16:22:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/24] soc: renesas: Consolidate product register
 handling
Date: Fri, 15 Jul 2022 08:22:21 +0100
Message-Id: <20220715072244.2298757-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:22:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8787

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 05b22caa7490e4f4c94bbde33c61cf72d187b8f7 upstream.

Currently renesas_soc_init() scans the whole device tree up to three
times, to find a device node describing a product register.
Furthermore, the product register handling for the different variants is
very similar, with the major difference being the location of the
product bitfield inside the product register.

Reduce scanning to a single pass using of_find_matching_node_and_match()
instead.  Switch to a common handling of product registers, by storing
the intrinsics of each product register type in the data field of the
corresponding match entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/057721f46c7499de4133135488f0f3da7fb39265.1636570669.git.geert+renesas@glider.be
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 115 +++++++++++++++---------------
 1 file changed, 56 insertions(+), 59 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 8310fce7714e..95d5e7063ef4 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -317,94 +317,92 @@ static const struct of_device_id renesas_socs[] __initconst = {
 	{ /* sentinel */ }
 };
 
+struct renesas_id {
+	unsigned int offset;
+	u32 mask;
+};
+
+static const struct renesas_id id_bsid __initconst = {
+	.offset = 0,
+	.mask = 0xff0000,
+	/*
+	 * TODO: Upper 4 bits of BSID are for chip version, but the format is
+	 * not known at this time so we don't know how to specify eshi and eslo
+	 */
+};
+
+static const struct renesas_id id_rzg2l __initconst = {
+	.offset = 0xa04,
+	.mask = 0xfffffff,
+};
+
+static const struct renesas_id id_prr __initconst = {
+	.offset = 0,
+	.mask = 0xff00,
+};
+
+static const struct of_device_id renesas_ids[] __initconst = {
+	{ .compatible = "renesas,bsid",			.data = &id_bsid },
+	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
+	{ .compatible = "renesas,prr",			.data = &id_prr },
+	{ /* sentinel */ }
+};
+
 static int __init renesas_soc_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
+	unsigned int product, eshi = 0, eslo;
 	const struct renesas_family *family;
 	const struct of_device_id *match;
 	const struct renesas_soc *soc;
+	const struct renesas_id *id;
 	void __iomem *chipid = NULL;
 	struct soc_device *soc_dev;
 	struct device_node *np;
-	unsigned int product, eshi = 0, eslo;
+	const char *soc_id;
 
 	match = of_match_node(renesas_socs, of_root);
 	if (!match)
 		return -ENODEV;
 
+	soc_id = strchr(match->compatible, ',') + 1;
 	soc = match->data;
 	family = soc->family;
 
-	np = of_find_compatible_node(NULL, NULL, "renesas,bsid");
+	np = of_find_matching_node_and_match(NULL, renesas_ids, &match);
 	if (np) {
+		id = match->data;
 		chipid = of_iomap(np, 0);
 		of_node_put(np);
-
-		if (chipid) {
-			product = readl(chipid);
-			iounmap(chipid);
-
-			if (soc->id && ((product >> 16) & 0xff) != soc->id) {
-				pr_warn("SoC mismatch (product = 0x%x)\n",
-					product);
-				return -ENODEV;
-			}
-		}
-
-		/*
-		 * TODO: Upper 4 bits of BSID are for chip version, but the
-		 * format is not known at this time so we don't know how to
-		 * specify eshi and eslo
-		 */
-
-		goto done;
+	} else if (soc->id && family->reg) {
+		/* Try hardcoded CCCR/PRR fallback */
+		id = &id_prr;
+		chipid = ioremap(family->reg, 4);
 	}
 
-	np = of_find_compatible_node(NULL, NULL, "renesas,r9a07g044-sysc");
-	if (np) {
-		chipid = of_iomap(np, 0);
-		of_node_put(np);
+	if (chipid) {
+		product = readl(chipid + id->offset);
+		iounmap(chipid);
 
-		if (chipid) {
-			product = readl(chipid + 0x0a04);
-			iounmap(chipid);
+		if (id == &id_prr) {
+			/* R-Car M3-W ES1.1 incorrectly identifies as ES2.0 */
+			if ((product & 0x7fff) == 0x5210)
+				product ^= 0x11;
+			/* R-Car M3-W ES1.3 incorrectly identifies as ES2.1 */
+			if ((product & 0x7fff) == 0x5211)
+				product ^= 0x12;
 
-			if (soc->id && (product & 0xfffffff) != soc->id) {
-				pr_warn("SoC mismatch (product = 0x%x)\n",
-					product);
-				return -ENODEV;
-			}
+			eshi = ((product >> 4) & 0x0f) + 1;
+			eslo = product & 0xf;
 		}
 
-		goto done;
-	}
-
-	/* Try PRR first, then hardcoded fallback */
-	np = of_find_compatible_node(NULL, NULL, "renesas,prr");
-	if (np) {
-		chipid = of_iomap(np, 0);
-		of_node_put(np);
-	} else if (soc->id && family->reg) {
-		chipid = ioremap(family->reg, 4);
-	}
-	if (chipid) {
-		product = readl(chipid);
-		iounmap(chipid);
-		/* R-Car M3-W ES1.1 incorrectly identifies as ES2.0 */
-		if ((product & 0x7fff) == 0x5210)
-			product ^= 0x11;
-		/* R-Car M3-W ES1.3 incorrectly identifies as ES2.1 */
-		if ((product & 0x7fff) == 0x5211)
-			product ^= 0x12;
-		if (soc->id && ((product >> 8) & 0xff) != soc->id) {
+		if (soc->id &&
+		    ((product & id->mask) >> __ffs(id->mask)) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
 			return -ENODEV;
 		}
-		eshi = ((product >> 4) & 0x0f) + 1;
-		eslo = product & 0xf;
 	}
 
-done:
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
 	if (!soc_dev_attr)
 		return -ENOMEM;
@@ -414,8 +412,7 @@ static int __init renesas_soc_init(void)
 	of_node_put(np);
 
 	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
-	soc_dev_attr->soc_id = kstrdup_const(strchr(match->compatible, ',') + 1,
-					     GFP_KERNEL);
+	soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
 	if (eshi)
 		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u", eshi,
 						   eslo);
-- 
2.25.1


