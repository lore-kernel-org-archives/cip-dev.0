From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:03 +0100
Subject: [cip-dev] [PATCH 14/62] dt-bindings: PCI: rcar: Add device tree
	support for r8a7743
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add support for r8a7743. The Renesas RZ/G1M(R8A7743)PCIe controller
is identical to the R-Car Gen2 family.

No driver change is needed due to the fallback compatible value
"renesas,pcie-rcar-gen2".
Adding the SoC-specific compatible values here has three purposes:
1. Document which SoCs have this hardware module,
2. Allow checkpatch to validate compatible values.
3. Allow the driver to support SoC specific implementations in future
   as necessary.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 2380ca5f1f46412d08c96ebea996e049548829bd)
(removed gen3 devices from DT binding documentation)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index a85353a..bedfdc1 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -1,10 +1,12 @@
 * Renesas R-Car PCIe interface
 
 Required properties:
-compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
+compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
+	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
-	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 compatible device.
+	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
+				     RZ/G1 compatible device.
 
 	    When compatible with the generic version, nodes must list the
 	    SoC-specific version corresponding to the platform first
-- 
2.7.4
