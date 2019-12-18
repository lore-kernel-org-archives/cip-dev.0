From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:14 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 04/39] soc: renesas: Identify RZ/G2N
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 574cb721729fccbc252b0caa5ee401393d06c49e upstream.

This patch adds support for identifying the RZ/G2N (r8a774b1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1567675844-19247-3-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/soc/renesas/renesas-soc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index ac9f253..1a40c1e 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -115,6 +115,11 @@ static const struct renesas_soc soc_rz_g2m __initconst __maybe_unused = {
 	.id	= 0x52,
 };
 
+static const struct renesas_soc soc_rz_g2n __initconst __maybe_unused = {
+	.family = &fam_rzg2,
+	.id     = 0x55,
+};
+
 static const struct renesas_soc soc_rz_g2e __initconst __maybe_unused = {
 	.family	= &fam_rzg2,
 	.id	= 0x57,
@@ -223,6 +228,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
 #ifdef CONFIG_ARCH_R8A774A1
 	{ .compatible = "renesas,r8a774a1",	.data = &soc_rz_g2m },
 #endif
+#ifdef CONFIG_ARCH_R8A774B1
+	{ .compatible = "renesas,r8a774b1",	.data = &soc_rz_g2n },
+#endif
 #ifdef CONFIG_ARCH_R8A774C0
 	{ .compatible = "renesas,r8a774c0",	.data = &soc_rz_g2e },
 #endif
-- 
2.7.4
