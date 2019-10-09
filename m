From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  9 Oct 2019 17:19:43 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] dt-bindings: can: rcar_canfd:
	document r8a774c0 support
In-Reply-To: <1570637984-22632-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1570637984-22632-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1570637984-22632-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit c908fd08692b8b4d87524762218652df6922386d upstream.

Document the support for rcar_canfd on R8A774C0 SoC devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
[fab: backported to 4.19.y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index ac71daa..804c68f 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -3,7 +3,8 @@ Renesas R-Car CAN FD controller Device Tree Bindings
 
 Required properties:
 - compatible: Must contain one or more of the following:
-  - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
+  - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
+  - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
   - "renesas,r8a77970-canfd" for R8A77970 (R-Car V3M) compatible controller.
@@ -26,12 +27,12 @@ The name of the child nodes are "channel0" and "channel1" respectively. Each
 child node supports the "status" property only, which is used to
 enable/disable the respective channel.
 
-Required properties for "renesas,r8a7795-canfd" and "renesas,r8a7796-canfd"
-compatible:
-In R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be used by both
-CAN and CAN FD controller at the same time. It needs to be scaled to maximum
-frequency if any of these controllers use it. This is done using the below
-properties:
+Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd" and
+"renesas,r8a7796-canfd" compatible:
+In R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be
+used by both CAN and CAN FD controller at the same time. It needs to be scaled
+to maximum frequency if any of these controllers use it. This is done using the
+below properties:
 
 - assigned-clocks: phandle of canfd clock.
 - assigned-clock-rates: maximum frequency of this clock.
-- 
2.7.4
