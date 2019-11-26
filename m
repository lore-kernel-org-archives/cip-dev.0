From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:29 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/10] dt-bindings: PCI: rcar: Add
	device tree support for r8a7744
In-Reply-To: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
References: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574785231-56219-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 6adb734bb9c72c0fdcb1868edcc5fde3b6333d11 upstream.

Add internal PCI bridge support for r8a7744 SoC. The Renesas RZ/G1N
(R8A7744) internal PCI bridge is identical to the R-Car Gen2 family.

This doesn't change the driver, so it does nothing by itself.  But it does
mean that checkpatch won't complain about a future patch that adds
"renesas,pci-r8a7744" to a DT, which helps ensure that shipped DTs use
documented compatibility strings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
index 421ab0a..8ea3ec0 100644
--- a/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
+++ b/Documentation/devicetree/bindings/pci/pci-rcar-gen2.txt
@@ -7,6 +7,7 @@ OHCI and EHCI controllers.
 
 Required properties:
 - compatible: "renesas,pci-r8a7743" for the R8A7743 SoC;
+	      "renesas,pci-r8a7744" for the R8A7744 SoC;
 	      "renesas,pci-r8a7745" for the R8A7745 SoC;
 	      "renesas,pci-r8a7790" for the R8A7790 SoC;
 	      "renesas,pci-r8a7791" for the R8A7791 SoC;
-- 
2.7.4
