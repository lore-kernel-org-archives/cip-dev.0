From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:37 +0100
Subject: [cip-dev] [PATCH 48/62] pwm: rcar: Improve accuracy of frequency
	division setting
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-49-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Ryo Kodama <ryo.kodama.vz@renesas.com>

When period_ns is set to the same value of RCAR_PWM_MAX_CYCLE in
rcar_pwm_get_clock_division(), this function should allow such value
for improving accuracy of frequency division setting.

Signed-off-by: Ryo Kodama <ryo.kodama.vz@renesas.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
(cherry picked from commit 72c16a9f98afad073b4a9c947c1c89bfb886ffcb)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pwm/pwm-rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 6e99a63..7b8ac06 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -81,7 +81,7 @@ static int rcar_pwm_get_clock_division(struct rcar_pwm_chip *rp, int period_ns)
 		max = (unsigned long long)NSEC_PER_SEC * RCAR_PWM_MAX_CYCLE *
 			(1 << div);
 		do_div(max, clk_rate);
-		if (period_ns < max)
+		if (period_ns <= max)
 			break;
 	}
 
-- 
2.7.4
