Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10009C43334
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.3820.1657869776363423762
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:22:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="126267407"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Jul 2022 16:22:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 65B4D40104F7;
	Fri, 15 Jul 2022 16:22:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/24] soc: renesas: Add support for reading
 product revision for RZ/G2L family
Date: Fri, 15 Jul 2022 08:22:24 +0100
Message-Id: <20220715072244.2298757-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8790

commit cb5508e47e60b85ac033edd8c52245ad51360eb4 upstream.

As per RZ/G2L HW manual (Rev.1.00 Sep, 2021) DEV_ID [31:28] indicates
product revision. Use this information to populate the revision info
for RZ/G2L family.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220121014117.21248-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 55 ++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index f06a6a160215..1ab78deaa239 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -370,9 +370,11 @@ static int __init renesas_soc_init(void)
 	const struct renesas_soc *soc;
 	const struct renesas_id *id;
 	void __iomem *chipid = NULL;
+	const char *rev_prefix = "";
 	struct soc_device *soc_dev;
 	struct device_node *np;
 	const char *soc_id;
+	int ret;
 
 	match = of_match_node(renesas_socs, of_root);
 	if (!match)
@@ -393,6 +395,17 @@ static int __init renesas_soc_init(void)
 		chipid = ioremap(family->reg, 4);
 	}
 
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	of_node_put(np);
+
+	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
+	soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
+
 	if (chipid) {
 		product = readl(chipid + id->offset);
 		iounmap(chipid);
@@ -407,41 +420,39 @@ static int __init renesas_soc_init(void)
 
 			eshi = ((product >> 4) & 0x0f) + 1;
 			eslo = product & 0xf;
+			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
+							   eshi, eslo);
+		}  else if (id == &id_rzg2l) {
+			eshi =  ((product >> 28) & 0x0f);
+			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u",
+							   eshi);
+			rev_prefix = "Rev ";
 		}
 
 		if (soc->id &&
 		    ((product & id->mask) >> __ffs(id->mask)) != soc->id) {
 			pr_warn("SoC mismatch (product = 0x%x)\n", product);
-			return -ENODEV;
+			ret = -ENODEV;
+			goto free_soc_dev_attr;
 		}
 	}
 
-	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
-	if (!soc_dev_attr)
-		return -ENOMEM;
-
-	np = of_find_node_by_path("/");
-	of_property_read_string(np, "model", &soc_dev_attr->machine);
-	of_node_put(np);
-
-	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
-	soc_dev_attr->soc_id = kstrdup_const(soc_id, GFP_KERNEL);
-	if (eshi)
-		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u", eshi,
-						   eslo);
-
-	pr_info("Detected Renesas %s %s %s\n", soc_dev_attr->family,
-		soc_dev_attr->soc_id, soc_dev_attr->revision ?: "");
+	pr_info("Detected Renesas %s %s %s%s\n", soc_dev_attr->family,
+		soc_dev_attr->soc_id, rev_prefix, soc_dev_attr->revision ?: "");
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
-		kfree(soc_dev_attr->revision);
-		kfree_const(soc_dev_attr->soc_id);
-		kfree_const(soc_dev_attr->family);
-		kfree(soc_dev_attr);
-		return PTR_ERR(soc_dev);
+		ret = PTR_ERR(soc_dev);
+		goto free_soc_dev_attr;
 	}
 
 	return 0;
+
+free_soc_dev_attr:
+	kfree(soc_dev_attr->revision);
+	kfree_const(soc_dev_attr->soc_id);
+	kfree_const(soc_dev_attr->family);
+	kfree(soc_dev_attr);
+	return ret;
 }
 early_initcall(renesas_soc_init);
-- 
2.25.1


