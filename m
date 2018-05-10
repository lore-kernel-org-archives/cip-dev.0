From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:39 +0100
Subject: [cip-dev] [PATCH 50/62] pwm: rcar: Use PM Runtime to control module
	clock
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-51-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Hien Dang <hien.dang.eb@renesas.com>

Runtime PM API (pm_runtime_get_sync/pm_runtime_put) should be used
to control module clock instead of clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
(cherry picked from commit f2e6142cdc10b1b7edea8d65b07293f152e4d110)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pwm/pwm-rcar.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 1c85ecc..b942010 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -134,16 +134,12 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-
-	return clk_prepare_enable(rp->clk);
+	return pm_runtime_get_sync(chip->dev);
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct rcar_pwm_chip *rp = to_rcar_pwm_chip(chip);
-
-	clk_disable_unprepare(rp->clk);
+	pm_runtime_put(chip->dev);
 }
 
 static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.7.4
