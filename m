Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3809EC47DDF
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 20:34:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7270.1706646868602559981
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 12:34:37 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="192272240"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 31 Jan 2024 05:34:37 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C455A40A3D21;
	Wed, 31 Jan 2024 05:34:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [RFC PATCH 5.10.y-cip 23/39] soc: renesas: Identify RZ/Five SoC
Date: Tue, 30 Jan 2024 20:33:30 +0000
Message-Id: <20240130203346.94488-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240130203346.94488-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 20:34:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14535

commit ebd0e06f3063cc2e3a689112904b29720579c6d2 upstream.

Add support for identifying the (R9A07G043) RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220722141506.20171-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied changes for Kconfig]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig       | 10 ++++++++++
 drivers/soc/renesas/renesas-soc.c | 13 +++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index dcc0d2ae1b2c1..69f123f1b5f95 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -315,6 +315,16 @@ endif # ARM64
 config PWC_RZV2M
 	bool "Renesas RZ/V2M PWC support" if COMPILE_TEST
 
+if RISCV
+
+config ARCH_R9A07G043
+	bool "RISC-V Platform support for RZ/Five"
+	select ARCH_RZG2L
+	help
+	  This enables support for the Renesas RZ/Five SoC.
+
+endif # RISCV
+
 config RST_RCAR
 	bool "Reset Controller support for R-Car" if COMPILE_TEST
 
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index aa5e1b9c4da89..92584f5ab9678 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -46,6 +46,10 @@ static const struct renesas_family fam_rza2 __initconst __maybe_unused = {
 	.name	= "RZ/A2",
 };
 
+static const struct renesas_family fam_rzfive __initconst __maybe_unused = {
+	.name	= "RZ/Five",
+};
+
 static const struct renesas_family fam_rzg1 __initconst __maybe_unused = {
 	.name	= "RZ/G1",
 	.reg	= 0xff000044,		/* PRR (Product Register) */
@@ -102,6 +106,11 @@ static const struct renesas_soc soc_rmobile_a1 __initconst __maybe_unused = {
 	.id	= 0x40,
 };
 
+static const struct renesas_soc soc_rz_five __initconst __maybe_unused = {
+	.family = &fam_rzfive,
+	.id     = 0x847c447,
+};
+
 static const struct renesas_soc soc_rz_g1h __initconst __maybe_unused = {
 	.family	= &fam_rzg1,
 	.id	= 0x45,
@@ -335,8 +344,12 @@ static const struct of_device_id renesas_socs[] __initconst = {
 	{ .compatible = "renesas,r8a779a0",	.data = &soc_rcar_v3u },
 #endif
 #if defined(CONFIG_ARCH_R9A07G043)
+#ifdef CONFIG_RISCV
+	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_five },
+#else
 	{ .compatible = "renesas,r9a07g043",	.data = &soc_rz_g2ul },
 #endif
+#endif
 #if defined(CONFIG_ARCH_R9A07G044)
 	{ .compatible = "renesas,r9a07g044",	.data = &soc_rz_g2l },
 #endif
-- 
2.34.1


