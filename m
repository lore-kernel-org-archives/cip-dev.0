Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205BFC433FE
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 00:46:26 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.34561.1639529184154515582
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 16:46:25 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,206,1635174000";
   d="scan'208";a="103952857"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 15 Dec 2021 09:46:24 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2313741657F4;
	Wed, 15 Dec 2021 09:46:22 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 6/7] soc: renesas: Add support to read LSI DEVID
 register of RZ/G2{L,LC} SoC's
Date: Wed, 15 Dec 2021 00:46:11 +0000
Message-Id: <20211215004612.13289-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211215004612.13289-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Dec 2021 00:46:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7106

commit 187cd57db09355fd169c661fa1c44bda06b013e8 upstream.

Add support for reading the LSI DEVID register which is present in
SYSC block of RZ/G2{L,LC} SoC's.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210609163717.3083-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/renesas-soc.c | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 0f8eff4a641a..8310fce7714e 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -56,6 +56,10 @@ static const struct renesas_family fam_rzg2 __initconst __maybe_unused = {
 	.reg	= 0xfff00044,		/* PRR (Product Register) */
 };
 
+static const struct renesas_family fam_rzg2l __initconst __maybe_unused = {
+	.name	= "RZ/G2L",
+};
+
 static const struct renesas_family fam_shmobile __initconst __maybe_unused = {
 	.name	= "SH-Mobile",
 	.reg	= 0xe600101c,		/* CCCR (Common Chip Code Register) */
@@ -64,7 +68,7 @@ static const struct renesas_family fam_shmobile __initconst __maybe_unused = {
 
 struct renesas_soc {
 	const struct renesas_family *family;
-	u8 id;
+	u32 id;
 };
 
 static const struct renesas_soc soc_rz_a1h __initconst __maybe_unused = {
@@ -131,6 +135,11 @@ static const struct renesas_soc soc_rz_g2h __initconst __maybe_unused = {
 	.id	= 0x4f,
 };
 
+static const struct renesas_soc soc_rz_g2l __initconst __maybe_unused = {
+	.family = &fam_rzg2l,
+	.id     = 0x841c447,
+};
+
 static const struct renesas_soc soc_rcar_m1a __initconst __maybe_unused = {
 	.family	= &fam_rcar_gen1,
 };
@@ -299,6 +308,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A779A0
 	{ .compatible = "renesas,r8a779a0",	.data = &soc_rcar_v3u },
 #endif
+#if defined(CONFIG_ARCH_R9A07G044)
+	{ .compatible = "renesas,r9a07g044",	.data = &soc_rz_g2l },
+#endif
 #ifdef CONFIG_ARCH_SH73A0
 	{ .compatible = "renesas,sh73a0",	.data = &soc_shmobile_ag5 },
 #endif
@@ -348,6 +360,25 @@ static int __init renesas_soc_init(void)
 		goto done;
 	}
 
+	np = of_find_compatible_node(NULL, NULL, "renesas,r9a07g044-sysc");
+	if (np) {
+		chipid = of_iomap(np, 0);
+		of_node_put(np);
+
+		if (chipid) {
+			product = readl(chipid + 0x0a04);
+			iounmap(chipid);
+
+			if (soc->id && (product & 0xfffffff) != soc->id) {
+				pr_warn("SoC mismatch (product = 0x%x)\n",
+					product);
+				return -ENODEV;
+			}
+		}
+
+		goto done;
+	}
+
 	/* Try PRR first, then hardcoded fallback */
 	np = of_find_compatible_node(NULL, NULL, "renesas,prr");
 	if (np) {
-- 
2.17.1


