From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:08 +0100
Subject: [cip-dev] [PATCH 06/15] dt-bindings: net: ravb : Add support for
	r8a7743 SoC
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-7-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add a new compatible string for the RZ/G1M (R8A7743) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit b3a703c7a698bcc0938fe22ba74d32593ad6e662)
(Documented r8a7743 SoC)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Conflicts:
	Documentation/devicetree/bindings/net/renesas,ravb.txt

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .../devicetree/bindings/net/renesas,ravb.txt        | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 7555116..715b8ce 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -4,15 +4,20 @@ This file provides information on what the device node for the Ethernet AVB
 interface contains.
 
 Required properties:
-- compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
-	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
-	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
-	      "renesas,etheravb-rcar-gen2" for generic R-Car Gen 2 compatible interface.
-	      "renesas,etheravb-rcar-gen3" for generic R-Car Gen 3 compatible interface.
+- compatible: Must contain one or more of the following:
+      - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
+      - "renesas,etheravb-r8a7790" for the R8A7790 SoC.
+      - "renesas,etheravb-r8a7794" for the R8A7794 SoC.
+      - "renesas,etheravb-rcar-gen2" as a fallback for the above
+		R-Car Gen2 and RZ/G1 devices.
 
-	      When compatible with the generic version, nodes must list the
-	      SoC-specific version corresponding to the platform first
-	      followed by the generic version.
+      - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
+      - "renesas,etheravb-rcar-gen3" as a fallback for the above
+		R-Car Gen3 devices.
+
+	When compatible with the generic version, nodes must list the
+	SoC-specific version corresponding to the platform first followed by
+	the generic version.
 
 - reg: offset and length of (1) the register block and (2) the stream buffer.
 - interrupts: A list of interrupt-specifiers, one for each entry in
-- 
1.9.1
