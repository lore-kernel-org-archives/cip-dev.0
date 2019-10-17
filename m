From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 17 Oct 2019 07:57:56 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 3/6] dt-bindings: can: rcar_canfd:
	document r8a774a1 support
In-Reply-To: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
References: <1571295479-39328-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1571295479-39328-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a7aa356e2c9ad1e874460ac5ee499ed1690e80cb upstream.

Document the support for rcar_canfd on R8A774A1 SoC devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index 804c68f..fecd6db 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -4,6 +4,7 @@ Renesas R-Car CAN FD controller Device Tree Bindings
 Required properties:
 - compatible: Must contain one or more of the following:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
+  - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
   - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
@@ -29,10 +30,10 @@ enable/disable the respective channel.
 
 Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd" and
 "renesas,r8a7796-canfd" compatible:
-In R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock and can be
-used by both CAN and CAN FD controller at the same time. It needs to be scaled
-to maximum frequency if any of these controllers use it. This is done using the
-below properties:
+In R8A774A1, R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock
+and can beused by both CAN and CAN FD controller at the same time. It needs
+to be scaled to maximum frequency if any of these controllers use it. This
+is done using the below properties:
 
 - assigned-clocks: phandle of canfd clock.
 - assigned-clock-rates: maximum frequency of this clock.
-- 
2.7.4
