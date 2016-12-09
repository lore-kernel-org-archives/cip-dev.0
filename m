From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 09 Dec 2016 00:39:23 +0000
Subject: [cip-dev] [PATCH 4.4-cip 19/23] pwm: samsung: Fix to use lowest div
 for large enough modulation bits
In-Reply-To: <1481243545.1860.156.camel@codethink.co.uk>
References: <1481243545.1860.156.camel@codethink.co.uk>
Message-ID: <1481243963.1860.176.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Seung-Woo Kim <sw0312.kim@samsung.com>

commit 04d68dea26b0a409d44e87ea573a131b6dc67e78 upstream.

>From pwm_samsung_calc_tin(), there is routine to find the lowest divider
possible to generate lower frequency than requested one. But it is
always possible to generate requested frequency with large enough
modulation bits except on s3c24xx, so this patch fixes to use lowest div
for the case. This patch removes following UBSAN warning:

   UBSAN: Undefined behaviour in drivers/pwm/pwm-samsung.c:197:13
   shift exponent 32 is too large for 32-bit type 'long unsigned int'
   [...]
   [<c0670248>] (ubsan_epilogue) from [<c06707b4>] (__ubsan_handle_shift_out_of_bounds+0xd8/0x120)
   [<c06707b4>] (__ubsan_handle_shift_out_of_bounds) from [<c0694b28>] (pwm_samsung_config+0x508/0x6a4)
   [<c0694b28>] (pwm_samsung_config) from [<c069286c>] (pwm_apply_state+0x174/0x40c)
   [<c069286c>] (pwm_apply_state) from [<c0b2e070>] (pwm_fan_probe+0xc8/0x488)
   [<c0b2e070>] (pwm_fan_probe) from [<c07ba8b0>] (platform_drv_probe+0x70/0x150)
   [...]

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
---
 drivers/pwm/pwm-samsung.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ada2d326dc3e..f113cda47032 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -193,9 +193,18 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *chip,
 	 * divider settings and choose the lowest divisor that can generate
 	 * frequencies lower than requested.
 	 */
-	for (div = variant->div_base; div < 4; ++div)
-		if ((rate >> (variant->bits + div)) < freq)
-			break;
+	if (variant->bits < 32) {
+		/* Only for s3c24xx */
+		for (div = variant->div_base; div < 4; ++div)
+			if ((rate >> (variant->bits + div)) < freq)
+				break;
+	} else {
+		/*
+		 * Other variants have enough counter bits to generate any
+		 * requested rate, so no need to check higher divisors.
+		 */
+		div = variant->div_base;
+	}
 
 	pwm_samsung_set_divisor(chip, chan, BIT(div));
 
-- 
2.10.2


-- 
Ben Hutchings
Software Developer, Codethink Ltd.
