From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:04 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 05/32] dt-bindings: display: renesas:
	lvds: Document r8a774c0 bindings
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-6-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 1cac4f267b60ae9c8ce17a85c4bd9a8c6d760f83 upstream.

The RZ/G2E (r8a774c0) supports two LVDS channels. Extend the binding to
support them.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
[fab: backported to v4.19.y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
index 77912c6..d06c25e 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,lvds.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible : Shall contain one of
   - "renesas,r8a7743-lvds" for R8A7743 (RZ/G1M) compatible LVDS encoders
   - "renesas,r8a774a1-lvds" for R8A774A1 (RZ/G2M) compatible LVDS encoders
+  - "renesas,r8a774c0-lvds" for R8A774C0 (RZ/G2E) compatible LVDS encoders
   - "renesas,r8a7790-lvds" for R8A7790 (R-Car H2) compatible LVDS encoders
   - "renesas,r8a7791-lvds" for R8A7791 (R-Car M2-W) compatible LVDS encoders
   - "renesas,r8a7793-lvds" for R8A7793 (R-Car M2-N) compatible LVDS encoders
@@ -23,9 +24,9 @@ Required properties:
 - clock-names: Name of the clocks. This property is model-dependent.
   - The functional clock, which mandatory for all models, shall be listed
     first, and shall be named "fck".
-  - On R8A77995, the LVDS encoder can use the EXTAL or DU_DOTCLKINx clocks.
-    Those clocks are optional. When supplied they must be named "extal" and
-    "dclkin.x" respectively, with "x" being the DU_DOTCLKIN numerical index.
+  - On R8A77995 and R8A774C0, the LVDS encoder can use the EXTAL or DU_DOTCLKINx
+    clocks. Those clocks are optional. When supplied they must be named "extal"
+    and "dclkin.x" respectively, with "x" being the DU_DOTCLKIN numerical index.
   - When the clocks property only contains the functional clock, the
     clock-names property may be omitted.
 - resets: A phandle + reset specifier for the module reset
-- 
2.7.4
