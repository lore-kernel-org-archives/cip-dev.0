From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:02 +0100
Subject: [cip-dev] [PATCH 13/62] PCI: rcar: Use proper name for the R-Car SoC
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

It is 'R-Car', not 'RCar'. No code or binding changes, only descriptive
text.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit a8d992d8f8d4bf6051e7b9df86ffe21d8a78a472)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 6b4d2f7..a85353a 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -1,4 +1,4 @@
-* Renesas RCar PCIe interface
+* Renesas R-Car PCIe interface
 
 Required properties:
 compatible: "renesas,pcie-r8a7779" for the R8A7779 SoC;
-- 
2.7.4
