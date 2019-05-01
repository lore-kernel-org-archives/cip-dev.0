From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:02 +0100
Subject: [cip-dev] [PATCH 4.19.y 08/29] media: rcar-vin: Add support for
	RZ/G2E
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit f74e5a32fa0c03d9f4bb84ea20d0c7be34fe3725 upstream.

According to the RZ/G2 User's manual, RZ/G2E and R-Car E3 VIN
blocks are identical, therefore use R-Car E3 definitions to add
RZ/G2E support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index fe03007..a6d1a46 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -1115,6 +1115,10 @@ static const struct rvin_info rcar_info_r8a77995 = {
 
 static const struct of_device_id rvin_of_id_table[] = {
 	{
+		.compatible = "renesas,vin-r8a774c0",
+		.data = &rcar_info_r8a77990,
+	},
+	{
 		.compatible = "renesas,vin-r8a7778",
 		.data = &rcar_info_m1,
 	},
-- 
2.7.4
