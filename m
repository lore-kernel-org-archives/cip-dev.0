From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 18 Dec 2019 11:33:43 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 33/39] dt-bindings: pinctrl: sh-pfc:
	Document r8a774b1 PFC support
In-Reply-To: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1576668829-59767-34-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 887047c317a48e49de7d0e0318ec0464666f6229 upstream.

Document PFC support for the R8A774B1 SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Link: https://lore.kernel.org/r/1568881036-4404-8-git-send-email-biju.das at bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
index 564759b..62ef37a 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
@@ -17,6 +17,7 @@ Required Properties:
     - "renesas,pfc-r8a7745": for R8A7745 (RZ/G1E) compatible pin-controller.
     - "renesas,pfc-r8a77470": for R8A77470 (RZ/G1C) compatible pin-controller.
     - "renesas,pfc-r8a774a1": for R8A774A1 (RZ/G2M) compatible pin-controller.
+    - "renesas,pfc-r8a774b1": for R8A774B1 (RZ/G2N) compatible pin-controller.
     - "renesas,pfc-r8a774c0": for R8A774C0 (RZ/G2E) compatible pin-controller.
     - "renesas,pfc-r8a7778": for R8A7778 (R-Car M1) compatible pin-controller.
     - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
-- 
2.7.4
