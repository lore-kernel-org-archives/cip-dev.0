From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:30:05 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 20/23] clk: renesas: rcar-gen3: Correct
	parent clock of Audio-DMAC
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-21-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

commit b9df2ea2b8d09ad850afe4d4a0403cb23d9e0c02 upstream.

The clock sources of the AXI-bus clock (266.66 MHz) used for Audio-DMAC
DMA transfers are:

    Channel        R-Car H3    R-Car M3-W    R-Car M3-N    R-Car E3
    ---------------------------------------------------------------
    Audio-DMAC0    S1D2        S1D2          S1D2          S1D2
    Audio-DMAC1    S1D2        S1D2          S1D2          -

As a result, change the parent clocks of the Audio-DMAC{0,1} module
clocks on R-Car H3, R-Car M3-W, and R-Car M3-N to S1D2, and change the
parent clock of the Audio-DMAC0 module on R-Car E3 to S1D2.

NOTE: This information will be reflected in a future revision of the
      R-Car Gen3 Hardware Manual.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[geert: Update R-Car D3, RZ/G2M, and RZ/G2E]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/r8a774a1-cpg-mssr.c | 4 ++--
 drivers/clk/renesas/r8a774c0-cpg-mssr.c | 2 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c  | 4 ++--
 drivers/clk/renesas/r8a7796-cpg-mssr.c  | 4 ++--
 drivers/clk/renesas/r8a77965-cpg-mssr.c | 4 ++--
 drivers/clk/renesas/r8a77990-cpg-mssr.c | 2 +-
 drivers/clk/renesas/r8a77995-cpg-mssr.c | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/renesas/r8a774a1-cpg-mssr.c b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
index 13bf726..76ed7d1 100644
--- a/drivers/clk/renesas/r8a774a1-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774a1-cpg-mssr.c
@@ -143,8 +143,8 @@ static const struct mssr_mod_clk r8a774a1_mod_clks[] __initconst = {
 	DEF_MOD("rwdt",			 402,	R8A774A1_CLK_R),
 	DEF_MOD("intc-ex",		 407,	R8A774A1_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A774A1_CLK_S0D3),
-	DEF_MOD("audmac1",		 501,	R8A774A1_CLK_S0D3),
-	DEF_MOD("audmac0",		 502,	R8A774A1_CLK_S0D3),
+	DEF_MOD("audmac1",		 501,	R8A774A1_CLK_S1D2),
+	DEF_MOD("audmac0",		 502,	R8A774A1_CLK_S1D2),
 	DEF_MOD("hscif4",		 516,	R8A774A1_CLK_S3D1),
 	DEF_MOD("hscif3",		 517,	R8A774A1_CLK_S3D1),
 	DEF_MOD("hscif2",		 518,	R8A774A1_CLK_S3D1),
diff --git a/drivers/clk/renesas/r8a774c0-cpg-mssr.c b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
index c33d3b0..f91e7a4 100644
--- a/drivers/clk/renesas/r8a774c0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a774c0-cpg-mssr.c
@@ -158,7 +158,7 @@ static const struct mssr_mod_clk r8a774c0_mod_clks[] __initconst = {
 	DEF_MOD("intc-ex",		 407,	R8A774C0_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A774C0_CLK_S0D3),
 
-	DEF_MOD("audmac0",		 502,	R8A774C0_CLK_S3D4),
+	DEF_MOD("audmac0",		 502,	R8A774C0_CLK_S1D2),
 	DEF_MOD("hscif4",		 516,	R8A774C0_CLK_S3D1C),
 	DEF_MOD("hscif3",		 517,	R8A774C0_CLK_S3D1C),
 	DEF_MOD("hscif2",		 518,	R8A774C0_CLK_S3D1C),
diff --git a/drivers/clk/renesas/r8a7795-cpg-mssr.c b/drivers/clk/renesas/r8a7795-cpg-mssr.c
index 428d9c7..0e3df73 100644
--- a/drivers/clk/renesas/r8a7795-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7795-cpg-mssr.c
@@ -155,8 +155,8 @@ static struct mssr_mod_clk r8a7795_mod_clks[] __initdata = {
 	DEF_MOD("rwdt",			 402,	R8A7795_CLK_R),
 	DEF_MOD("intc-ex",		 407,	R8A7795_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A7795_CLK_S0D3),
-	DEF_MOD("audmac1",		 501,	R8A7795_CLK_S0D3),
-	DEF_MOD("audmac0",		 502,	R8A7795_CLK_S0D3),
+	DEF_MOD("audmac1",		 501,	R8A7795_CLK_S1D2),
+	DEF_MOD("audmac0",		 502,	R8A7795_CLK_S1D2),
 	DEF_MOD("drif7",		 508,	R8A7795_CLK_S3D2),
 	DEF_MOD("drif6",		 509,	R8A7795_CLK_S3D2),
 	DEF_MOD("drif5",		 510,	R8A7795_CLK_S3D2),
diff --git a/drivers/clk/renesas/r8a7796-cpg-mssr.c b/drivers/clk/renesas/r8a7796-cpg-mssr.c
index 29d913d..3453867 100644
--- a/drivers/clk/renesas/r8a7796-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a7796-cpg-mssr.c
@@ -148,8 +148,8 @@ static const struct mssr_mod_clk r8a7796_mod_clks[] __initconst = {
 	DEF_MOD("rwdt",			 402,	R8A7796_CLK_R),
 	DEF_MOD("intc-ex",		 407,	R8A7796_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A7796_CLK_S0D3),
-	DEF_MOD("audmac1",		 501,	R8A7796_CLK_S0D3),
-	DEF_MOD("audmac0",		 502,	R8A7796_CLK_S0D3),
+	DEF_MOD("audmac1",		 501,	R8A7796_CLK_S1D2),
+	DEF_MOD("audmac0",		 502,	R8A7796_CLK_S1D2),
 	DEF_MOD("drif7",		 508,	R8A7796_CLK_S3D2),
 	DEF_MOD("drif6",		 509,	R8A7796_CLK_S3D2),
 	DEF_MOD("drif5",		 510,	R8A7796_CLK_S3D2),
diff --git a/drivers/clk/renesas/r8a77965-cpg-mssr.c b/drivers/clk/renesas/r8a77965-cpg-mssr.c
index 64777d3..d32042e 100644
--- a/drivers/clk/renesas/r8a77965-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77965-cpg-mssr.c
@@ -143,8 +143,8 @@ static const struct mssr_mod_clk r8a77965_mod_clks[] __initconst = {
 	DEF_MOD("intc-ex",		407,	R8A77965_CLK_CP),
 	DEF_MOD("intc-ap",		408,	R8A77965_CLK_S0D3),
 
-	DEF_MOD("audmac1",		501,	R8A77965_CLK_S0D3),
-	DEF_MOD("audmac0",		502,	R8A77965_CLK_S0D3),
+	DEF_MOD("audmac1",		501,	R8A77965_CLK_S1D2),
+	DEF_MOD("audmac0",		502,	R8A77965_CLK_S1D2),
 	DEF_MOD("drif7",		508,	R8A77965_CLK_S3D2),
 	DEF_MOD("drif6",		509,	R8A77965_CLK_S3D2),
 	DEF_MOD("drif5",		510,	R8A77965_CLK_S3D2),
diff --git a/drivers/clk/renesas/r8a77990-cpg-mssr.c b/drivers/clk/renesas/r8a77990-cpg-mssr.c
index a35b814..5fa2546 100644
--- a/drivers/clk/renesas/r8a77990-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77990-cpg-mssr.c
@@ -144,7 +144,7 @@ static const struct mssr_mod_clk r8a77990_mod_clks[] __initconst = {
 	DEF_MOD("intc-ex",		 407,	R8A77990_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A77990_CLK_S0D3),
 
-	DEF_MOD("audmac0",		 502,	R8A77990_CLK_S3D4),
+	DEF_MOD("audmac0",		 502,	R8A77990_CLK_S1D2),
 	DEF_MOD("drif7",		 508,	R8A77990_CLK_S3D2),
 	DEF_MOD("drif6",		 509,	R8A77990_CLK_S3D2),
 	DEF_MOD("drif5",		 510,	R8A77990_CLK_S3D2),
diff --git a/drivers/clk/renesas/r8a77995-cpg-mssr.c b/drivers/clk/renesas/r8a77995-cpg-mssr.c
index ea4cafb..9fa6011 100644
--- a/drivers/clk/renesas/r8a77995-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a77995-cpg-mssr.c
@@ -128,7 +128,7 @@ static const struct mssr_mod_clk r8a77995_mod_clks[] __initconst = {
 	DEF_MOD("rwdt",			 402,	R8A77995_CLK_R),
 	DEF_MOD("intc-ex",		 407,	R8A77995_CLK_CP),
 	DEF_MOD("intc-ap",		 408,	R8A77995_CLK_S1D2),
-	DEF_MOD("audmac0",		 502,	R8A77995_CLK_S3D1),
+	DEF_MOD("audmac0",		 502,	R8A77995_CLK_S1D2),
 	DEF_MOD("hscif3",		 517,	R8A77995_CLK_S3D1C),
 	DEF_MOD("hscif0",		 520,	R8A77995_CLK_S3D1C),
 	DEF_MOD("thermal",		 522,	R8A77995_CLK_CP),
-- 
2.7.4
