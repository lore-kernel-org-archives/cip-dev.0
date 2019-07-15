From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:02 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 17/23] clk: renesas: rcar-gen3: Correct
	parent clock of EHCI/OHCI
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

commit 8d36fdcce21c1713eacf45380696f8cec3d724bf upstream.

According to the R-Car Gen3 Hardware Manual Rev. 1.00, and the RZ/G2
Hardware Manual Rev. 0.61, the parent clock of the EHCI/OHCI module
clocks on R-Car Gen3 and RZ/G2 SoCs is S3D2.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[takeshi: Update R-Car H3, M3-N, and E3]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Update RZ/G2M and RZ/G2E]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 4 ++--
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 2 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 8 ++++----
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 4 ++--
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 4 ++--
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 44161fd..bce0e6d 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -165,8 +165,8 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("vspd0",		 623,	R8A774A1_CLK_S0D2),
 	DEF_MOD("vspb",			 626,	R8A774A1_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A774A1_CLK_S0D1),
-	DEF_MOD("ehci1",		 702,	R8A774A1_CLK_S3D4),
-	DEF_MOD("ehci0",		 703,	R8A774A1_CLK_S3D4),
+	DEF_MOD("ehci1",		 702,	R8A774A1_CLK_S3D2),
+	DEF_MOD("ehci0",		 703,	R8A774A1_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A774A1_CLK_S3D4),
 	DEF_MOD("csi20",		 714,	R8A774A1_CLK_CSI0),
 	DEF_MOD("csi40",		 716,	R8A774A1_CLK_CSI0),
diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index 57098b7..d095787f 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -178,7 +178,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("vspb",			 626,	R8A774C0_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A774C0_CLK_S0D1),
 
-	DEF_MOD("ehci0",		 703,	R8A774C0_CLK_S3D4),
+	DEF_MOD("ehci0",		 703,	R8A774C0_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A774C0_CLK_S3D4),
 	DEF_MOD("csi40",		 716,	R8A774C0_CLK_CSI0),
 	DEF_MOD("du1",			 723,	R8A774C0_CLK_S1D1),
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 283a1b6..00b5dbd 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -196,10 +196,10 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("vspi2",		 629,	R8A7795_CLK_S2D1), /* ES1.x */
 	DEF_MOD("vspi1",		 630,	R8A7795_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A7795_CLK_S0D1),
-	DEF_MOD("ehci3",		 700,	R8A7795_CLK_S3D4),
-	DEF_MOD("ehci2",		 701,	R8A7795_CLK_S3D4),
-	DEF_MOD("ehci1",		 702,	R8A7795_CLK_S3D4),
-	DEF_MOD("ehci0",		 703,	R8A7795_CLK_S3D4),
+	DEF_MOD("ehci3",		 700,	R8A7795_CLK_S3D2),
+	DEF_MOD("ehci2",		 701,	R8A7795_CLK_S3D2),
+	DEF_MOD("ehci1",		 702,	R8A7795_CLK_S3D2),
+	DEF_MOD("ehci0",		 703,	R8A7795_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A7795_CLK_S3D4),
 	DEF_MOD("hsusb3",		 705,	R8A7795_CLK_S3D4),
 	DEF_MOD("csi21",		 713,	R8A7795_CLK_CSI0), /* ES1.x */
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index ace2196..c7abfca 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -178,8 +178,8 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("vspd0",		 623,	R8A7796_CLK_S0D2),
 	DEF_MOD("vspb",			 626,	R8A7796_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A7796_CLK_S0D1),
-	DEF_MOD("ehci1",		 702,	R8A7796_CLK_S3D4),
-	DEF_MOD("ehci0",		 703,	R8A7796_CLK_S3D4),
+	DEF_MOD("ehci1",		 702,	R8A7796_CLK_S3D2),
+	DEF_MOD("ehci0",		 703,	R8A7796_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A7796_CLK_S3D4),
 	DEF_MOD("csi20",		 714,	R8A7796_CLK_CSI0),
 	DEF_MOD("csi40",		 716,	R8A7796_CLK_CSI0),
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 2e1071b..9f18dfe 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -172,8 +172,8 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("vspb",			626,	R8A77965_CLK_S0D1),
 	DEF_MOD("vspi0",		631,	R8A77965_CLK_S0D1),
 
-	DEF_MOD("ehci1",		702,	R8A77965_CLK_S3D4),
-	DEF_MOD("ehci0",		703,	R8A77965_CLK_S3D4),
+	DEF_MOD("ehci1",		702,	R8A77965_CLK_S3D2),
+	DEF_MOD("ehci0",		703,	R8A77965_CLK_S3D2),
 	DEF_MOD("hsusb",		704,	R8A77965_CLK_S3D4),
 	DEF_MOD("csi20",		714,	R8A77965_CLK_CSI0),
 	DEF_MOD("csi40",		716,	R8A77965_CLK_CSI0),
diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index 9e14f14..f12bc3f 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -172,7 +172,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("vspb",			 626,	R8A77990_CLK_S0D1),
 	DEF_MOD("vspi0",		 631,	R8A77990_CLK_S0D1),
 
-	DEF_MOD("ehci0",		 703,	R8A77990_CLK_S3D4),
+	DEF_MOD("ehci0",		 703,	R8A77990_CLK_S3D2),
 	DEF_MOD("hsusb",		 704,	R8A77990_CLK_S3D4),
 	DEF_MOD("csi40",		 716,	R8A77990_CLK_CSI0),
 	DEF_MOD("du1",			 723,	R8A77990_CLK_S2D1),
-- 
2.7.4
