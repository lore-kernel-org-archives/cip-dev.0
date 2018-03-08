From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  8 Mar 2018 17:28:07 +0000
Subject: [cip-dev] [PATCH 2/4] spi: sh-msiof: Add compatible strings for
	r8a774[35]
In-Reply-To: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520530089-4988-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520530089-4988-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit bdacfc7b6216dd30d07c10732fd4c0a660c62853)
(using r8a779x_data instead of rcar_gen2_data)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e190b33..dc5419d 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -975,6 +975,8 @@ static const struct sh_msiof_chipdata r8a779x_data = {
 
 static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
+	{ .compatible = "renesas,msiof-r8a7743",   .data = &r8a779x_data },
+	{ .compatible = "renesas,msiof-r8a7745",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
-- 
2.7.4
