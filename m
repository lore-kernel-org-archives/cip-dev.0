From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Thu, 16 Jan 2020 15:11:11 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 01/12] dt-bindings: can: rcar_can:
	document r8a77965 support
In-Reply-To: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1579187482-4626-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Eugeniu Rosca <rosca.eugeniu@gmail.com>

commit 4f145f14f6b98b5aa0dd91bdae518b3f24f74b37 upstream.

Document the support for rcar_can on R8A77965 SoC devices.
Add R8A77965 to the list of SoCs which require the "assigned-clocks" and
"assigned-clock-rates" properties (thanks, Sergei).

Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
[fab: discarded r8a77965 specfic support]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/can/rcar_can.txt | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Documentation/devicetree/bindings/net/can/rcar_can.txt
index e1d428a..2301331 100644
--- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
+++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
@@ -31,11 +31,10 @@ Required properties:
 - pinctrl-0: pin control group to be used for this controller.
 - pinctrl-names: must be "default".
 
-Required properties for "renesas,can-r8a7795" and "renesas,can-r8a7796"
-compatible:
-In R8A7795 and R8A7796 SoCs, "clkp2" can be CANFD clock. This is a div6 clock
-and can be used by both CAN and CAN FD controller at the same time. It needs to
-be scaled to maximum frequency if any of these controllers use it. This is done
+Required properties for R8A7795 and R8A7796:
+For the denoted SoCs, "clkp2" can be CANFD clock. This is a div6 clock and can
+be used by both CAN and CAN FD controller at the same time. It needs to be
+scaled to maximum frequency if any of these controllers use it. This is done
 using the below properties:
 
 - assigned-clocks: phandle of clkp2(CANFD) clock.
-- 
2.7.4
