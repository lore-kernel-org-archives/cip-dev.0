Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDD6C77B78
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 07:18:00 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.6206.1682061466156625619
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Apr 2023 00:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,214,1677510000"; 
   d="scan'208";a="160252362"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Apr 2023 16:17:52 +0900
Received: from localhost.localdomain (unknown [10.226.93.14])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B7A3241AA3F4;
	Fri, 21 Apr 2023 16:17:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 08/33] soc: renesas: Identify RZ/V2M SoC
Date: Fri, 21 Apr 2023 08:17:04 +0100
Message-Id: <20230421071729.130347-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
References: <20230421071729.130347-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Apr 2023 07:18:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11281

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 7e20044052317d5f2942b061c4cacdb6790790a2 upstream.

Add support for identifying the RZ/V2M (R9A09G011) SoC.
Note that the SoC does not have a identification register.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
[biju: removed config changes ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20221116102140.852889-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 70e5b7c2fc8b..aa5e1b9c4da8 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -68,6 +68,10 @@ static const struct renesas_family fam_rzv2l __initconst __maybe_unused = {
 	.name	= "RZ/V2L",
 };
 
+static const struct renesas_family fam_rzv2m __initconst __maybe_unused = {
+	.name	= "RZ/V2M",
+};
+
 static const struct renesas_family fam_shmobile __initconst __maybe_unused = {
 	.name	= "SH-Mobile",
 	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
@@ -158,6 +162,10 @@ static const struct renesas_soc soc_rz_v2l __initconst __maybe_unused = {
 	.id     = 0x8447447,
 };
 
+static const struct renesas_soc soc_rz_v2m __initconst __maybe_unused = {
+	.family = &fam_rzv2m,
+};
+
 static const struct renesas_soc soc_rcar_m1a __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen1,
 };
@@ -335,6 +343,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #if defined(CONFIG_ARCH_R9A07G054)
 	{ .compatible = "renesas,r9a07g054",	.data = &soc_rz_v2l },
 #endif
+#if defined(CONFIG_ARCH_R9A09G011)
+	{ .compatible = "renesas,r9a09g011",	.data = &soc_rz_v2m },
+#endif
 #ifdef CONFIG_ARCH_SH73A0
 	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
 #endif
@@ -360,6 +371,11 @@ static const struct renesas_id id_rzg2l __initconst = {
 	.mask = 0xfffffff,
 };
 
+static const struct renesas_id id_rzv2m __initconst = {
+	.offset = 0x104,
+	.mask = 0xff,
+};
+
 static const struct renesas_id id_prr __initconst = {
 	.offset = 0,
 	.mask = 0xff00,
@@ -370,6 +386,7 @@ static const struct of_device_id renesas_ids[] __initconst = {
 	{ .compatible = "renesas,r9a07g043-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g044-sysc",	.data = &id_rzg2l },
 	{ .compatible = "renesas,r9a07g054-sysc",	.data = &id_rzg2l },
+	{ .compatible = "renesas,r9a09g011-sys",	.data = &id_rzv2m },
 	{ .compatible = "renesas,prr",			.data = &id_prr },
 	{ /* sentinel */ }
 };
@@ -440,6 +457,11 @@ static int __init renesas_soc_init(void)
 			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u",
 							   eshi);
 			rev_prefix = "Rev ";
+		} else if (id == &id_rzv2m) {
+			eshi = ((product >> 4) & 0x0f);
+			eslo = product & 0xf;
+			soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u.%u",
+							   eshi, eslo);
 		}
 
 		if (soc->id &&
-- 
2.25.1


