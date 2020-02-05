From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:27 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 01/35] dt-bindings: can: rcar_can:
	document r8a774b1 support
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit b32bfbc98a747e82d30cc8fd6e4b173a48c01530 upstream.

Document RZ/G2N (r8a774b1) SoC specific bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/1570717560-7431-2-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index aede950..b22bec8 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible: "renesas,can-r8a7743" if CAN controller is a part of R8A7743 SoC.
 	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
 	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 SoC.
+	      "renesas,can-r8a774b1" if CAN controller is a part of R8A774B1 SoC.
 	      "renesas,can-r8a774c0" if CAN controller is a part of R8A774C0 SoC.
 	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
 	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
@@ -31,7 +32,7 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-Required properties for R8A774A1, R8A774C0, R8A7795, and R8A7796:
+Required properties for R8A774A1, R8A774B1, R8A774C0, R8A7795, and R8A7796:
 For the denoted SoCs, "clkp2" can be CANFD clock. This is a div6 clock and can
 be used by both CAN and CAN FD controller at the same time. It needs to be
 scaled to maximum frequency if any of these controllers use it. This is done
-- 
2.7.4
