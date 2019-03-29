From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Mar 2019 08:32:34 +0000
Subject: [cip-dev] [PATCH 4.19.y 1/4] dt-bindings: PCI: rcar: Add device
	tree support for r8a774c0
In-Reply-To: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1553848357-30592-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1553848357-30592-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add PCIe support for the RZ/G2E (a.k.a. R8A774C0).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 2e2b7615e310994b4d59c98b7d114449a9f019e5)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index a5f7fc6..fac07a4 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
+	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
 	    "renesas,pcie-r8a7791" for the R8A7791 SoC;
@@ -11,7 +12,8 @@ compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a77980" for the R8A77980 SoC;
 	    "renesas,pcie-rcar-gen2" for a generic R-Car Gen2 or
 				     RZ/G1 compatible device.
-	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 compatible device.
+	    "renesas,pcie-rcar-gen3" for a generic R-Car Gen3 or
+				     RZ/G2 compatible device.
 
 	    When compatible with the generic version, nodes must list the
 	    SoC-specific version corresponding to the platform first
-- 
2.7.4
