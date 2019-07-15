From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:04 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 19/23] clk: renesas: rcar-gen3: Correct
	parent clock of SYS-DMAC
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-20-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit 3c772f71a552d343a96868ed9a809f9047be94f5 upstream.

The clock sources of the AXI BUS clock (266.66 MHz) used for SYS-DMAC
DMA transfers are:

    Channel      R-Car H3    R-Car M3-W    R-Car M3-N
    -------------------------------------------------
    SYS-DMAC0    S0D3        S0D3          S0D3
    SYS-DMAC1    S3D1        S3D1          S3D1
    SYS-DMAC2    S3D1        S3D1          S3D1

As a result, change the parent clocks of the SYS-DMAC{1,2} module clocks
on R-Car H3, R-Car M3-W, and R-Car M3-N to S3D1.

NOTE: This information will be reflected in a future revision of the
      R-Car Gen3 Hardware Manual.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Update RZ/G2M]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 4 ++--
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 4 ++--
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 4 ++--
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 676e6a1..13bf726 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -123,8 +123,8 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("msiof2",		 209,	R8A774A1_CLK_MSO),
 	DEF_MOD("msiof1",		 210,	R8A774A1_CLK_MSO),
 	DEF_MOD("msiof0",		 211,	R8A774A1_CLK_MSO),
-	DEF_MOD("sys-dmac2",		 217,	R8A774A1_CLK_S0D3),
-	DEF_MOD("sys-dmac1",		 218,	R8A774A1_CLK_S0D3),
+	DEF_MOD("sys-dmac2",		 217,	R8A774A1_CLK_S3D1),
+	DEF_MOD("sys-dmac1",		 218,	R8A774A1_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A774A1_CLK_S0D3),
 	DEF_MOD("cmt3",			 300,	R8A774A1_CLK_R),
 	DEF_MOD("cmt2",			 301,	R8A774A1_CLK_R),
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 9b3c0cb..428d9c7 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -131,8 +131,8 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("msiof2",		 209,	R8A7795_CLK_MSO),
 	DEF_MOD("msiof1",		 210,	R8A7795_CLK_MSO),
 	DEF_MOD("msiof0",		 211,	R8A7795_CLK_MSO),
-	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S0D3),
-	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S0D3),
+	DEF_MOD("sys-dmac2",		 217,	R8A7795_CLK_S3D1),
+	DEF_MOD("sys-dmac1",		 218,	R8A7795_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7795_CLK_S0D3),
 	DEF_MOD("sceg-pub",		 229,	R8A7795_CLK_CR),
 	DEF_MOD("cmt3",			 300,	R8A7795_CLK_R),
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 6fcf789..29d913d 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -128,8 +128,8 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("msiof2",		 209,	R8A7796_CLK_MSO),
 	DEF_MOD("msiof1",		 210,	R8A7796_CLK_MSO),
 	DEF_MOD("msiof0",		 211,	R8A7796_CLK_MSO),
-	DEF_MOD("sys-dmac2",		 217,	R8A7796_CLK_S0D3),
-	DEF_MOD("sys-dmac1",		 218,	R8A7796_CLK_S0D3),
+	DEF_MOD("sys-dmac2",		 217,	R8A7796_CLK_S3D1),
+	DEF_MOD("sys-dmac1",		 218,	R8A7796_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		 219,	R8A7796_CLK_S0D3),
 	DEF_MOD("cmt3",			 300,	R8A7796_CLK_R),
 	DEF_MOD("cmt2",			 301,	R8A7796_CLK_R),
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index de2c935..64777d3 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -120,8 +120,8 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("msiof2",		209,	R8A77965_CLK_MSO),
 	DEF_MOD("msiof1",		210,	R8A77965_CLK_MSO),
 	DEF_MOD("msiof0",		211,	R8A77965_CLK_MSO),
-	DEF_MOD("sys-dmac2",		217,	R8A77965_CLK_S0D3),
-	DEF_MOD("sys-dmac1",		218,	R8A77965_CLK_S0D3),
+	DEF_MOD("sys-dmac2",		217,	R8A77965_CLK_S3D1),
+	DEF_MOD("sys-dmac1",		218,	R8A77965_CLK_S3D1),
 	DEF_MOD("sys-dmac0",		219,	R8A77965_CLK_S0D3),
 
 	DEF_MOD("cmt3",			300,	R8A77965_CLK_R),
-- 
2.7.4
