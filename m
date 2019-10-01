From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:03 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 04/32] dt-bindings: display: renesas:
	lvds: Add EXTAL and DU_DOTCLKIN clocks
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

commit 9734a7009de62c05e9b08fa65efb7c5214ab3f30 upstream.

On the D3 and E3 SoCs, the LVDS encoder can derive its internal pixel
clock from an externally supplied clock, either through the EXTAL pin or
through one of the DU_DOTCLKINx pins. Add corresponding clocks to the DT
bindings.

To retain backward compatibility with DT that don't specify the
clock-names property, the functional clock must always be specified
first, and the clock-names property is optional when only the functional
clock is specified.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
[fab: removed reference to r8a77990]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 .../devicetree/bindings/display/bridge/renesas,lvds.txt       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
index 3ede032..77912c6 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
@@ -18,7 +18,16 @@ Required properties:
   - "renesas,r8a77995-lvds" for R8A77995 (R-Car D3) compatible LVDS encoders
 
 - reg: Base address and length for the memory-mapped registers
-- clocks: A phandle + clock-specifier pair for the functional clock
+- clocks: A list of phandles + clock-specifier pairs, one for each entry in
+  the clock-names property.
+- clock-names: Name of the clocks. This property is model-dependent.
+  - The functional clock, which mandatory for all models, shall be listed
+    first, and shall be named "fck".
+  - On R8A77995, the LVDS encoder can use the EXTAL or DU_DOTCLKINx clocks.
+    Those clocks are optional. When supplied they must be named "extal" and
+    "dclkin.x" respectively, with "x" being the DU_DOTCLKIN numerical index.
+  - When the clocks property only contains the functional clock, the
+    clock-names property may be omitted.
 - resets: A phandle + reset specifier for the module reset
 
 Required nodes:
-- 
2.7.4
