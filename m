From: biju.das@bp.renesas.com (Biju Das)
Date: Thu,  7 Nov 2019 08:32:32 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 63/83] mmc: tmio: always get number of
	taps
In-Reply-To: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573115572-13513-64-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>

commit 43b0b361b0170030603cf76f70b099f3323edcf3 upstream.

Current code gets number of taps only once and keeps the value. This is
not correct, we need to obtain it every time before executing tuning,
so remove the outer if-block.

Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
[wsa: extracted from a larger patch and reworded commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 35dbeb5..4764f96 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -819,16 +819,14 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 	int i, ret = 0;
 
-	if (!host->tap_num) {
-		if (!host->init_tuning || !host->select_tuning)
-			/* Tuning is not supported */
-			goto out;
+	if (!host->init_tuning || !host->select_tuning)
+		/* Tuning is not supported */
+		goto out;
 
-		host->tap_num = host->init_tuning(host);
-		if (!host->tap_num)
-			/* Tuning is not supported */
-			goto out;
-	}
+	host->tap_num = host->init_tuning(host);
+	if (!host->tap_num)
+		/* Tuning is not supported */
+		goto out;
 
 	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
 		dev_warn_once(&host->pdev->dev,
-- 
2.7.4
