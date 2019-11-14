From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 14 Nov 2019 13:24:29 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 13/21] dt-bindings: pinctrl: sh-pfc:
	Document r8a7744 PFC support
In-Reply-To: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
References: <1573737877-11733-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1573737877-11733-14-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a6a7d2c2dc668fb19bc16b4cda397cb1831df54d upstream.

Document PFC support for the RZ/G1N (R8A7744) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index b2264d9..f2008d0 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -14,6 +14,7 @@ Required Properties:
     - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
     - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
     - "renesas,pfc-r8a7743": for R8A7743 (RZ/G1M) compatible pin-controller.
+    - "renesas,pfc-r8a7744": for R8A7744 (RZ/G1N) compatible pin-controller.
     - "renesas,pfc-r8a7745": for R8A7745 (RZ/G1E) compatible pin-controller.
     - "renesas,pfc-r8a77470": for R8A77470 (RZ/G1C) compatible pin-controller.
     - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
-- 
2.7.4
