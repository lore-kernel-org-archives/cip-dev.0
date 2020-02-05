From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:28 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 02/35] dt-bindings: can: rcar_canfd:
	document r8a774b1 support
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 837b7deb364c3cf927f922d88b6131c8a4f81d0e upstream.

Document the support for rcar_canfd on R8A774B1 SoC devices.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1570717560-7431-3-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
index fecd6db..769f01b 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: Must contain one or more of the following:
   - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible controllers.
   - "renesas,r8a774a1-canfd" for R8A774A1 (RZ/G2M) compatible controller.
+  - "renesas,r8a774b1-canfd" for R8A774B1 (RZ/G2N) compatible controller.
   - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller.
   - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller.
   - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controller.
@@ -30,9 +31,9 @@ enable/disable the respective channel.
 
 Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd" and
 "renesas,r8a7796-canfd" compatible:
-In R8A774A1, R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6 clock
-and can beused by both CAN and CAN FD controller at the same time. It needs
-to be scaled to maximum frequency if any of these controllers use it. This
+In R8A774A1, R8A774B1, R8A774C0, R8A7795 and R8A7796 SoCs, canfd clock is a div6
+clock and can beused by both CAN and CAN FD controller at the same time. It
+needs to be scaled to maximum frequency if any of these controllers use it. This
 is done using the below properties:
 
 - assigned-clocks: phandle of canfd clock.
-- 
2.7.4
