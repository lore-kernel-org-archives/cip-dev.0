From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:58 +0100
Subject: [cip-dev] [PATCH 09/62] PCI: rcar: Add gen2 fallback compatibility
	string for pcie-rcar
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility string for R-Car Gen 2 family.  This is in
keeping with the fallback scheme being adopted wherever appropriate for
drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
(cherry picked from commit a37b3eafe8e9cbe7c7754bc6003c125b23749554)
(removed r8a7795 soc from DT binding documentation)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 13 ++++++++++---
 drivers/pci/host/pcie-rcar.c                       |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 29d3b98..6b4d2f7 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -1,8 +1,15 @@
 * Renesas RCar PCIe interface
 
 Required properties:
-- compatible: should contain one of the following
-	"renesas,pcie-r8a7779", "renesas,pcie-r8a7790", "renesas,pcie-r8a7791"
+compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
+	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
+	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
+	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
+
+	    When compatible with the generic version, nodes must list the
+	    SoC-specific version corresponding to the platform first
+	    followed by the generic version.
+
 - reg: base address and length of the pcie controller registers.
 - #address-cells: set to <3>
 - #size-cells: set to <2>
@@ -25,7 +32,7 @@ Example:
 SoC specific DT Entry:
 
 	pcie: pcie at fe000000 {
-		compatible = "renesas,pcie-r8a7791";
+		compatible = "renesas,pcie-r8a7791", "renesas,pcie-rcar-gen2";
 		reg = <0 0xfe000000 0 0x80000>;
 		#address-cells = <3>;
 		#size-cells = <2>;
diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 5e4f02d..ae095fc 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -917,6 +917,7 @@ static int rcar_pcie_parse_map_dma_ranges(struct rcar_pcie *pcie,
 
 static const struct of_device_id rcar_pcie_of_match[] = {
 	{ .compatible = "renesas,pcie-r8a7779", .data = rcar_pcie_hw_init_h1 },
+	{ .compatible = "renesas,pcie-rcar-gen2", .data = rcar_pcie_hw_init },
 	{ .compatible = "renesas,pcie-r8a7790", .data = rcar_pcie_hw_init },
 	{ .compatible = "renesas,pcie-r8a7791", .data = rcar_pcie_hw_init },
 	{},
-- 
2.7.4
