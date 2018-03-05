From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon,  5 Mar 2018 11:39:10 +0000
Subject: [cip-dev] [PATCH 06/10] phy: rcar-gen2: add fallback binding
In-Reply-To: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1520249954-29357-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1520249954-29357-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

In the case of Renesas R-Car hardware we know that there are generations of
SoCs, e.g. Gen 2 and Gen 3. But beyond that its not clear what the
relationship between IP blocks might be. For example, I believe that
r8a7790 is older than r8a7791 but that doesn't imply that the latter is a
descendant of the former or vice versa.

We can, however, by examining the documentation and behaviour of the
hardware at run-time observe that the current driver implementation appears
to be compatible with the IP blocks on SoCs within a given generation.

For the above reasons and convenience when enabling new SoCs a
per-generation fallback compatibility string scheme being adopted for
drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt | 8 +++++++-
 drivers/phy/phy-rcar-gen2.c                             | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
index 883b915..75abc6d 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
@@ -9,6 +9,12 @@ Required properties:
 	      "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
 	      "renesas,usb-phy-r8a7794" if the device is a part of R8A7794 SoC.
+	      "renesas,rcar-gen2-usb-phy" for a generic R-Car Gen2 compatible device.
+
+	      When compatible with the generic version, nodes must list the
+	      SoC-specific version corresponding to the platform first
+	      followed by the generic version.
+
 - reg: offset and length of the register block.
 - #address-cells: number of address cells for the USB channel subnodes, must
 		  be <1>.
@@ -36,7 +42,7 @@ the USB channel; see the selector meanings below:
 Example (Lager board):
 
 	usb-phy at e6590100 {
-		compatible = "renesas,usb-phy-r8a7790";
+		compatible = "renesas,usb-phy-r8a7790", "renesas,rcar-gen2-usb-phy";
 		reg = <0 0xe6590100 0 0x100>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/drivers/phy/phy-rcar-gen2.c b/drivers/phy/phy-rcar-gen2.c
index c7a0599..97d4dd6 100644
--- a/drivers/phy/phy-rcar-gen2.c
+++ b/drivers/phy/phy-rcar-gen2.c
@@ -195,6 +195,7 @@ static const struct of_device_id rcar_gen2_phy_match_table[] = {
 	{ .compatible = "renesas,usb-phy-r8a7790" },
 	{ .compatible = "renesas,usb-phy-r8a7791" },
 	{ .compatible = "renesas,usb-phy-r8a7794" },
+	{ .compatible = "renesas,rcar-gen2-usb-phy" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_gen2_phy_match_table);
-- 
2.7.4
