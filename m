From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 15:30:37 +0000
Subject: [cip-dev] [PATCH 1/7] dt-bindings: pinctrl: sh-pfc: Document
	r8a774a1 PFC support
In-Reply-To: <1553182243-50724-1-git-send-email-biju.das@bp.renesas.com>
References: <1553182243-50724-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553182243-50724-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Document PFC support for the R8A774A1 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
(cherry picked from commit 8f9a1acd8c8b8e6d980bca02fd55ee9867792609)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index abd8fbc..01c6f5f 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -16,6 +16,7 @@ Required Properties:
     - "renesas,pfc-r8a7743": for R8A7743 (RZ/G1M) compatible pin-controller.
     - "renesas,pfc-r8a7745": for R8A7745 (RZ/G1E) compatible pin-controller.
     - "renesas,pfc-r8a77470": for R8A77470 (RZ/G1C) compatible pin-controller.
+    - "renesas,pfc-r8a774a1": for R8A774A1 (RZ/G2M) compatible pin-controller.
     - "renesas,pfc-r8a7778": for R8A7778 (R-Car M1) compatible pin-controller.
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
     - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
-- 
2.7.4
