From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 27 Nov 2019 13:46:41 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/22] mmc: sh_mobile_sdhi: simplify
	code for voltage switching
In-Reply-To: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
References: <1574862420-42606-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574862420-42606-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2272c841ee301402ea7a01fc727619af1f97f0cc upstream.

A last minute fix applied by Ulf made room for some simplification.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index ebeaab6..626c894 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -289,11 +289,7 @@ static int sh_mobile_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (ret)
 		return ret;
 
-	ret = pinctrl_select_state(priv->pinctrl, pin_state);
-	if (ret)
-		return ret;
-
-	return 0;
+	return pinctrl_select_state(priv->pinctrl, pin_state);
 }
 
 /* SCC registers */
-- 
2.7.4
