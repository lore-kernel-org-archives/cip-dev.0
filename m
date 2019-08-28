From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 12:03:01 +0100
Subject: [cip-dev] [PATCH 4.19.y 30/60] ravb: Avoid unsupported internal
	delay mode for R-Car E3/D3
In-Reply-To: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566990211-24785-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566990211-24785-31-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

commit 0a5d329ffd1be394e3e4176eb11ca51dfde03c40 upstream.

According to the R-Car Gen3 Hardware Manual Rev 1.50 of Nov 30, 2018, the
TX clock internal delay mode isn't supported on R-Car E3 (r8a77990) or D3
(r8a77995). And by extension it is also not supported by RZ/G2E (r9a774c0).

This matches all ES versions of the affected SoCs as it is
not clear if this problem will be resolved in newer chips.
This can be revisited, as necessary.

This patch does not error-out if PHY_INTERFACE_MODE_RGMII_ID or
PHY_INTERFACE_MODE_RGMII_TXID are used on SoCs where TX clock delay
mode is not supported as there is a risk of introducing a regression
when used in conjunction with older DT blobs present in the field.
Rather, a warning is logged in such cases.

Based on work by Kazuya Mizuguchi.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/net/ethernet/renesas/ravb_main.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 037a0ad..7ed70b7 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1980,6 +1980,13 @@ static void ravb_set_config_mode(struct net_device *ndev)
 	}
 }
 
+static const struct soc_device_attribute ravb_delay_mode_quirk_match[] = {
+	{ .soc_id = "r8a774c0" },
+	{ .soc_id = "r8a77990" },
+	{ .soc_id = "r8a77995" },
+	{ /* sentinel */ }
+};
+
 /* Set tx and rx clock internal delay modes */
 static void ravb_set_delay_mode(struct net_device *ndev)
 {
@@ -1991,8 +1998,12 @@ static void ravb_set_delay_mode(struct net_device *ndev)
 		set |= APSR_DM_RDM;
 
 	if (priv->phy_interface == PHY_INTERFACE_MODE_RGMII_ID ||
-	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID)
-		set |= APSR_DM_TDM;
+	    priv->phy_interface == PHY_INTERFACE_MODE_RGMII_TXID) {
+		if (!WARN(soc_device_match(ravb_delay_mode_quirk_match),
+			  "phy-mode %s requires TX clock internal delay mode which is not supported by this hardware revision. Please update device tree",
+			  phy_modes(priv->phy_interface)))
+			set |= APSR_DM_TDM;
+	}
 
 	ravb_modify(ndev, APSR, APSR_DM, set);
 }
-- 
2.7.4
