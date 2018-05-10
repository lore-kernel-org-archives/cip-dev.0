From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:00 +0100
Subject: [cip-dev] [PATCH 11/62] PCI: rcar: Add runtime PM support to
	pcie-rcar
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-12-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Phil Edworthy <phil.edworthy@renesas.com>

If runtime PM is enabled in the kernel config, simply enable the clocks
once during probe.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
(cherry picked from commit de1be9a8897cb35bee7617da8b6ddd7d144db332)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 44 ++++++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 83ba747..1468e04 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -26,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 
 #define DRV_NAME "rcar-pcie"
@@ -995,32 +996,51 @@ static int rcar_pcie_probe(struct platform_device *pdev)
 	 if (err)
 		return err;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		err = rcar_pcie_enable_msi(pcie);
-		if (err < 0) {
-			dev_err(&pdev->dev,
-				"failed to enable MSI support: %d\n",
-				err);
-			return err;
-		}
-	}
-
 	of_id = of_match_device(rcar_pcie_of_match, pcie->dev);
 	if (!of_id || !of_id->data)
 		return -EINVAL;
 	hw_init_fn = of_id->data;
 
+	pm_runtime_enable(pcie->dev);
+	err = pm_runtime_get_sync(pcie->dev);
+	if (err < 0) {
+		dev_err(pcie->dev, "pm_runtime_get_sync failed\n");
+		goto err_pm_disable;
+	}
+
 	/* Failure to get a link might just be that no cards are inserted */
 	err = hw_init_fn(pcie);
 	if (err) {
 		dev_info(&pdev->dev, "PCIe link down\n");
-		return 0;
+		err = 0;
+		goto err_pm_put;
 	}
 
 	data = rcar_pci_read_reg(pcie, MACSR);
 	dev_info(&pdev->dev, "PCIe x%d: link up\n", (data >> 20) & 0x3f);
 
-	return rcar_pcie_enable(pcie);
+	if (IS_ENABLED(CONFIG_PCI_MSI)) {
+		err = rcar_pcie_enable_msi(pcie);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"failed to enable MSI support: %d\n",
+				err);
+			goto err_pm_put;
+		}
+	}
+
+	err = rcar_pcie_enable(pcie);
+	if (err)
+		goto err_pm_put;
+
+	return 0;
+
+err_pm_put:
+	pm_runtime_put(pcie->dev);
+
+err_pm_disable:
+	pm_runtime_disable(pcie->dev);
+	return err;
 }
 
 static struct platform_driver rcar_pcie_driver = {
-- 
2.7.4
