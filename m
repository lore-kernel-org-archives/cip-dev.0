From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 14:29:48 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 03/23] clk: renesas: rcar-gen3: Add
	documentation for SD clocks
In-Reply-To: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
References: <1563197408-59548-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563197408-59548-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

commit e2f4dd1f5b51b4dab813aa6e4db44e87aa750393 upstream.

Document the known use cases of the different clock settings. This is
useful as different SoC and ES versions use different settings to do
the same thing as there is more than one combination to achieve the
same SDn clock speed.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/clk/renesas/rcar-gen3-cpg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index d6f5bd1..00e41de 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -235,13 +235,13 @@ struct sd_clock {
  *                     sd_srcfc   sd_fc   div
  * stp_hck   stp_ck    (div)      (div)     = sd_srcfc x sd_fc
  *-------------------------------------------------------------------
- *  0         0         0 (1)      1 (4)      4
- *  0         0         1 (2)      1 (4)      8
- *  1         0         2 (4)      1 (4)     16
- *  1         0         3 (8)      1 (4)     32
+ *  0         0         0 (1)      1 (4)      4 : SDR104 / HS200 / HS400 (8 TAP)
+ *  0         0         1 (2)      1 (4)      8 : SDR50
+ *  1         0         2 (4)      1 (4)     16 : HS / SDR25
+ *  1         0         3 (8)      1 (4)     32 : NS / SDR12
  *  1         0         4 (16)     1 (4)     64
  *  0         0         0 (1)      0 (2)      2
- *  0         0         1 (2)      0 (2)      4
+ *  0         0         1 (2)      0 (2)      4 : SDR104 / HS200 / HS400 (4 TAP)
  *  1         0         2 (4)      0 (2)      8
  *  1         0         3 (8)      0 (2)     16
  *  1         0         4 (16)     0 (2)     32
-- 
2.7.4
