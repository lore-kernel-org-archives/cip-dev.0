From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:07:52 +0100
Subject: [cip-dev] [PATCH 03/62] dt-bindings: can: rcar_can: document
	r8a774[35] can support
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document "renesas,can-r8a7743" and "renesas,can-r8a7745" compatible
strings. Since the fallback compatible string ("renesas,rcar-gen2-can")
activates the right code in the driver, no driver change is needed.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
(cherry picked from commit 216bf2f490c214b8a0702b52cc957138ba24bc3f)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index f2172fb..6f81b1f 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -2,12 +2,15 @@ Renesas R-Car CAN controller Device Tree Bindings
 -------------------------------------------------
 
 Required properties:
-- compatible: "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
+- compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
+	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
+	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
 	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
 	      "renesas,can-r8a7791" if CAN controller is a part of R8A7791 SoC.
 	      "renesas,rcar-gen1-can" for a generic R-Car Gen1 compatible device.
-	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 compatible device.
+	      "renesas,rcar-gen2-can" for a generic R-Car Gen2 or RZ/G1
+	      compatible device.
 	      When compatible with the generic version, nodes must list the
 	      SoC-specific version corresponding to the platform first
 	      followed by the generic version.
-- 
2.7.4
