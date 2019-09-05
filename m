From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  5 Sep 2019 09:37:12 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip repost 1/6] mmc: renesas_sdhi: Change
	HW adjustment register according to speed mode
In-Reply-To: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567672637-29449-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Takeshi Saito <takeshi.saito.xv@renesas.com>

commit f0c8234cb9230e3fc128ab4739f65e30bb00ceb5 upstream.

SCC is used for SDR104/HS200/HS400. We need to change SCC_DT2FF
according to the mode. If it is inappropriate, CRC error tends to occur.

This adds variable "tap_hs400" for HS400 mode and configures SCC_DT2FF
as needed.

Signed-off-by: Takeshi Saito <takeshi.saito.xv@renesas.com>
[wsa: rebased to upstream and updated commit message]
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Niklas S?derlund <niklas.soderlund@ragnatech.se>
Tested-by: Marek Vasut <marek.vasut@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi.h               | 2 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 8 ++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index f13f798..d58fcfa 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -18,6 +18,7 @@
 struct renesas_sdhi_scc {
 	unsigned long clk_rate;	/* clock rate for SDR104 */
 	u32 tap;		/* sampling clock position for SDR104 */
+	u32 tap_hs400;		/* sampling clock position for HS400 */
 };
 
 struct renesas_sdhi_of_data {
@@ -52,6 +53,7 @@ struct renesas_sdhi {
 	struct pinctrl_state *pins_default, *pins_uhs;
 	void __iomem *scc_ctl;
 	u32 scc_tappos;
+	u32 scc_tappos_hs400;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 45baf5d..8ed44ad 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -297,6 +297,10 @@ static void renesas_sdhi_hs400_complete(struct tmio_mmc_host *host)
 	/* Set HS400 mode */
 	sd_ctrl_write16(host, CTL_SDIF_MODE, 0x0001 |
 			sd_ctrl_read16(host, CTL_SDIF_MODE));
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF,
+		       priv->scc_tappos_hs400);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       (SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
 			SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) |
@@ -356,6 +360,9 @@ static void renesas_sdhi_reset_hs400_mode(struct tmio_mmc_host *host,
 	/* Reset HS400 mode */
 	sd_ctrl_write16(host, CTL_SDIF_MODE, ~0x0001 &
 			sd_ctrl_read16(host, CTL_SDIF_MODE));
+
+	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_DT2FF, priv->scc_tappos);
+
 	sd_scc_write32(host, priv, SH_MOBILE_SDHI_SCC_TMPPORT2,
 		       ~(SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN |
 			 SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL) &
@@ -699,6 +706,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 			if (taps[i].clk_rate == 0 ||
 			    taps[i].clk_rate == host->mmc->f_max) {
 				priv->scc_tappos = taps->tap;
+				priv->scc_tappos_hs400 = taps->tap_hs400;
 				hit = true;
 				break;
 			}
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index fb7adcb..07669d3 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -81,6 +81,7 @@ static struct renesas_sdhi_scc rcar_gen3_scc_taps[] = {
 	{
 		.clk_rate = 0,
 		.tap = 0x00000300,
+		.tap_hs400 = 0x00000704,
 	},
 };
 
-- 
2.7.4
