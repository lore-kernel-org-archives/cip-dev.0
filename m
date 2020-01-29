From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:30:03 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 10/12] mmc: renesas_sdhi_internal_dmac:
	Add r8a774b1 support
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-11-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit c9af138c42f07a0d6d8554a9bed85ca395ed0511 upstream.

This patch adds SDHI support for RZ/G2N (R8A774B1) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 7b0bc15..d156158 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -300,6 +300,7 @@ static const struct soc_device_attribute gen3_soc_whitelist[] = {
 	  .data = (void *)BIT(SDHI_INTERNAL_DMAC_ONE_RX_ONLY) },
 	/* generic ones */
 	{ .soc_id = "r8a774a1" },
+	{ .soc_id = "r8a774b1" },
 	{ .soc_id = "r8a774c0" },
 	{ .soc_id = "r8a7795" },
 	{ .soc_id = "r8a7796" },
-- 
2.7.4
