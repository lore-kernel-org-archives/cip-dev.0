From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:19:27 +0000
Subject: [cip-dev] [PATCH 6/9] dt-bindings: gpio: rcar: Add r8a774a1
	(RZ/G2M) support
In-Reply-To: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
References: <1553246370-60751-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553246370-60751-7-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document Renesas' RZ/G2M (R8A774A1) GPIO blocks compatibility within the
relevant dt-bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
(cherry picked from commit 28123791ddbe493b957423625810e75a4ce3a9ef)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 4018ee5..e82144a 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -6,6 +6,7 @@ Required Properties:
     - "renesas,gpio-r8a7743": for R8A7743 (RZ/G1M) compatible GPIO controller.
     - "renesas,gpio-r8a7745": for R8A7745 (RZ/G1E) compatible GPIO controller.
     - "renesas,gpio-r8a77470": for R8A77470 (RZ/G1C) compatible GPIO controller.
+    - "renesas,gpio-r8a774a1": for R8A774A1 (RZ/G2M) compatible GPIO controller.
     - "renesas,gpio-r8a7778": for R8A7778 (R-Car M1) compatible GPIO controller.
     - "renesas,gpio-r8a7779": for R8A7779 (R-Car H1) compatible GPIO controller.
     - "renesas,gpio-r8a7790": for R8A7790 (R-Car H2) compatible GPIO controller.
@@ -22,7 +23,7 @@ Required Properties:
     - "renesas,gpio-r8a77995": for R8A77995 (R-Car D3) compatible GPIO controller.
     - "renesas,rcar-gen1-gpio": for a generic R-Car Gen1 GPIO controller.
     - "renesas,rcar-gen2-gpio": for a generic R-Car Gen2 or RZ/G1 GPIO controller.
-    - "renesas,rcar-gen3-gpio": for a generic R-Car Gen3 GPIO controller.
+    - "renesas,rcar-gen3-gpio": for a generic R-Car Gen3 or RZ/G2 GPIO controller.
     - "renesas,gpio-rcar": deprecated.
 
     When compatible with the generic version nodes must list the
-- 
2.7.4
