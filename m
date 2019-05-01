From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:07 +0100
Subject: [cip-dev] [PATCH 4.19.y 13/29] media: rcar-csi2: Add support for
	RZ/G2E
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-14-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 8809b8ceb0bd283c0528a0c7233656b12bcda2dc upstream.

According to the RZ/G2 User's manual, RZ/G2E and R-Car E3 CSI-2
blocks are identical, therefore use R-Car E3 definitions to add
RZ/G2E support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index d409ba3..007e238 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -975,6 +975,10 @@ static const struct rcar_csi2_info rcar_csi2_info_r8a77990 = {
 
 static const struct of_device_id rcar_csi2_of_table[] = {
 	{
+		.compatible = "renesas,r8a774c0-csi2",
+		.data = &rcar_csi2_info_r8a77990,
+	},
+	{
 		.compatible = "renesas,r8a7795-csi2",
 		.data = &rcar_csi2_info_r8a7795,
 	},
-- 
2.7.4
