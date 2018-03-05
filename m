From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:07 +0000
Subject: [cip-dev] [PATCH 03/10] PCI: rcar: Add device tree support for
	r8a7743/5
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add internal PCI bridge support for r8a7743/5 SoC.  The Renesas RZ/G1[ME]
(R8A7743/5) internal PCI bridge is identical to the R-Car Gen2 family.

This doesn't change the driver, so it does nothing by itself.  But it does
mean that checkpatch won't complain about a future patch that adds
"renesas,pci-r8a7743" to a DT, which helps ensure that shipped DTs use
documented compatibility strings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
[bhelgaas: add explanatory note]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit c31c83c970165b9f2cb4c0ad6ae89d0a8242cf7b)

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 3690f68..421ab0a 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -6,7 +6,9 @@ AHB. There is one bridge instance per USB port connected to the internal
 OHCI and EHCI controllers.
 
 Required properties:
-- compatible: "renesas,pci-r8a7790" for the R8A7790 SoC;
+- compatible: "renesas,pci-r8a7743" for the R8A7743 SoC;
+	      "renesas,pci-r8a7745" for the R8A7745 SoC;
+	      "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
 	      "renesas,pci-r8a7794" for the R8A7794 SoC;
 	      "renesas,pci-rcar-gen2" for a generic R-Car Gen2 compatible device
-- 
2.7.4
