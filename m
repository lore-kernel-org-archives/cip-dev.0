From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:31:56 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 27/83] mmc: sh_mobile_sdhi: make
	clk_update function more compact
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-28-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 3072ba8cd95bd0e7fbe9a3a1c9b61fb190257855 upstream.

Save a few lines, the codebase is large enough.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index f7317cf..efa4fca 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -169,12 +169,9 @@ static unsigned int sh_mobile_sdhi_clk_update(struct tmio_mmc_host *host,
 					      unsigned int new_clock)
 {
 	struct sh_mobile_sdhi *priv = host_to_priv(host);
-	unsigned int freq, best_freq, diff_min, diff;
+	unsigned int freq, diff, best_freq = 0, diff_min = ~0;
 	int i;
 
-	diff_min = ~0;
-	best_freq = 0;
-
 	/*
 	 * We want the bus clock to be as close as possible to, but no
 	 * greater than, new_clock.  As we can divide by 1 << i for
-- 
2.7.4
