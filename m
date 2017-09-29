From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:07 +0100
Subject: [cip-dev] [PATCH 05/15] ravb: add fallback compatibility strings
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-6-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

Add fallback compatibility strings for R-Car Gen 2 & 3 SoC Families.
This is in keeping with the fallback scheme being adopted wherever appropriate
for drivers for Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 0e8743611a76ced8b0971b6894f982ce89624cc4)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 9 ++++++++-
 drivers/net/ethernet/renesas/ravb_main.c               | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index b486f3f..7555116 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -7,6 +7,13 @@ Required properties:
 - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
 	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
+	      "renesas,etheravb-rcar-gen2" for generic R-Car Gen 2 compatible interface.
+	      "renesas,etheravb-rcar-gen3" for generic R-Car Gen 3 compatible interface.
+
+	      When compatible with the generic version, nodes must list the
+	      SoC-specific version corresponding to the platform first
+	      followed by the generic version.
+
 - reg: offset and length of (1) the register block and (2) the stream buffer.
 - interrupts: A list of interrupt-specifiers, one for each entry in
 	      interrupt-names.
@@ -37,7 +44,7 @@ Optional properties:
 Example:
 
 	ethernet at e6800000 {
-		compatible = "renesas,etheravb-r8a7795";
+		compatible = "renesas,etheravb-r8a7795", "renesas,etheravb-rcar-gen3";
 		reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0 0x10000>;
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>,
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 585e90f..c7b3c25 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1688,7 +1688,9 @@ static int ravb_mdio_release(struct ravb_private *priv)
 static const struct of_device_id ravb_match_table[] = {
 	{ .compatible = "renesas,etheravb-r8a7790", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,etheravb-r8a7794", .data = (void *)RCAR_GEN2 },
+	{ .compatible = "renesas,etheravb-rcar-gen2", .data = (void *)RCAR_GEN2 },
 	{ .compatible = "renesas,etheravb-r8a7795", .data = (void *)RCAR_GEN3 },
+	{ .compatible = "renesas,etheravb-rcar-gen3", .data = (void *)RCAR_GEN3 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
-- 
1.9.1
