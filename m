From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:38 +0100
Subject: [cip-dev] [PATCH  49/62] pwm: rcar: Make use of pwm_is_enabled()
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-50-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced
a new function to test whether a PWM device is enabled or not without
manipulating PWM internal fields.

Hiding this is necessary if we want to smoothly move to the atomic PWM
config approach without impacting PWM drivers. Fix this driver to use
pwm_is_enabled() instead of directly accessing the ->flags field.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
(cherry picked from commit 3587c260906259632df07652743269627f408d85)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 7b8ac06..1c85ecc 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -157,7 +157,7 @@ static int rcar_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return div;
 
 	/* Let the core driver set pwm->period if disabled and duty_ns == 0 */
-	if (!test_bit(PWMF_ENABLED, &pwm->flags) && !duty_ns)
+	if (!pwm_is_enabled(pwm) && !duty_ns)
 		return 0;
 
 	rcar_pwm_update(rp, RCAR_PWMCR_SYNC, RCAR_PWMCR_SYNC, RCAR_PWMCR);
-- 
2.7.4
