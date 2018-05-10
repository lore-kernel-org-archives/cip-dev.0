From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:01 +0100
Subject: [cip-dev] [PATCH 12/62] PCI: rcar: Add Gen2 PHY setup to pcie-rcar
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Phil Edworthy <phil.edworthy@renesas.com>

For PCIe compliance, the PHY registers need setting as per the manual.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
(cherry picked from commit 581d9434aa56b465c5abd82caf18937e9973ca42)
(removed gen3 devices)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 drivers/pci/host/pcie-rcar.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 1468e04..848f9bf 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -95,6 +95,11 @@
 #define H1_PCIEPHYDOUTR		0x040014
 #define H1_PCIEPHYSR		0x040018
 
+/* R-Car Gen2 PHY */
+#define GEN2_PCIEPHYADDR	0x780
+#define GEN2_PCIEPHYDATA	0x784
+#define GEN2_PCIEPHYCTRL	0x78c
+
 #define INT_PCI_MSI_NR	32
 
 #define RCONF(x)	(PCICONF(0)+(x))
@@ -568,6 +573,26 @@ static int rcar_pcie_hw_init_h1(struct rcar_pcie *pcie)
 	return -ETIMEDOUT;
 }
 
+static int rcar_pcie_hw_init_gen2(struct rcar_pcie *pcie)
+{
+	/*
+	 * These settings come from the R-Car Series, 2nd Generation User's
+	 * Manual, section 50.3.1 (2) Initialization of the physical layer.
+	 */
+	rcar_pci_write_reg(pcie, 0x000f0030, GEN2_PCIEPHYADDR);
+	rcar_pci_write_reg(pcie, 0x00381203, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+
+	rcar_pci_write_reg(pcie, 0x000f0054, GEN2_PCIEPHYADDR);
+	/* The following value is for DC connection, no termination resistor */
+	rcar_pci_write_reg(pcie, 0x13802007, GEN2_PCIEPHYDATA);
+	rcar_pci_write_reg(pcie, 0x00000001, GEN2_PCIEPHYCTRL);
+	rcar_pci_write_reg(pcie, 0x00000006, GEN2_PCIEPHYCTRL);
+
+	return rcar_pcie_hw_init(pcie);
+}
+
 static int rcar_msi_alloc(struct rcar_msi *chip)
 {
 	int msi;
@@ -909,9 +934,9 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 
 static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
-	{ .compatible = "renesas,pcie-rcar-gen2", .data = rcar_pcie_hw_init },
-	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init },
-	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
+	{ .compatible = "renesas,pcie-rcar-gen2", .data = rcar_pcie_hw_init_gen2 },
+	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init_gen2 },
+	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init_gen2 },
 	{},
 };
 MODULE_DEVICE_TABLE(of, rcar_pcie_of_match);
-- 
2.7.4
