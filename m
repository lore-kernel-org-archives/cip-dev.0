From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 20:52:28 +0200
Subject: [cip-dev] [PATCH 1/8] stmmac: Add support for SIMATIC IOT2000
	platform
In-Reply-To: <cover.1504119155.git.jan.kiszka@siemens.com>
References: <cover.1504119155.git.jan.kiszka@siemens.com>
Message-ID: <7b485935cf98525babb58689b7f9b10594cdca4e.1504119155.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Jan Kiszka <jan.kiszka@siemens.com>

commit 212c7fd614377fef4415d94856a59e9f484aa439 upstream.

The IOT2000 is industrial controller platform, derived from the Intel
Galileo Gen2 board. The variant IOT2020 comes with one LAN port, the
IOT2040 has two of them. They can be told apart based on the board asset
tag in the DMI table.

Based on patch by Sascha Weisenberger.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Signed-off-by: Sascha Weisenberger <sascha.weisenberger@siemens.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 26 +++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index d71a721ea61c..3491e98bffc5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -36,6 +36,7 @@
  */
 struct stmmac_pci_dmi_data {
 	const char *name;
+	const char *asset_tag;
 	unsigned int func;
 	int phy_addr;
 };
@@ -50,6 +51,7 @@ struct stmmac_pci_info {
 static int stmmac_pci_find_phy_addr(struct stmmac_pci_info *info)
 {
 	const char *name = dmi_get_system_info(DMI_BOARD_NAME);
+	const char *asset_tag = dmi_get_system_info(DMI_BOARD_ASSET_TAG);
 	unsigned int func = PCI_FUNC(info->pdev->devfn);
 	struct stmmac_pci_dmi_data *dmi;
 
@@ -61,8 +63,12 @@ static int stmmac_pci_find_phy_addr(struct stmmac_pci_info *info)
 		return 1;
 
 	for (dmi = info->dmi; dmi->name && *dmi->name; dmi++) {
-		if (!strcmp(dmi->name, name) && dmi->func == func)
+		if (!strcmp(dmi->name, name) && dmi->func == func) {
+			/* If asset tag is provided, match on it as well. */
+			if (dmi->asset_tag && strcmp(dmi->asset_tag, asset_tag))
+				continue;
 			return dmi->phy_addr;
+		}
 	}
 
 	return -ENODEV;
@@ -138,6 +144,24 @@ static struct stmmac_pci_dmi_data quark_pci_dmi_data[] = {
 		.func = 6,
 		.phy_addr = 1,
 	},
+	{
+		.name = "SIMATIC IOT2000",
+		.asset_tag = "6ES7647-0AA00-0YA2",
+		.func = 6,
+		.phy_addr = 1,
+	},
+	{
+		.name = "SIMATIC IOT2000",
+		.asset_tag = "6ES7647-0AA00-1YA2",
+		.func = 6,
+		.phy_addr = 1,
+	},
+	{
+		.name = "SIMATIC IOT2000",
+		.asset_tag = "6ES7647-0AA00-1YA2",
+		.func = 7,
+		.phy_addr = 1,
+	},
 	{}
 };
 
-- 
2.12.3
