From: marian-cristian.rotariu.rb@bp.renesas.com (Marian-Cristian Rotariu)
Date: Thu, 19 Dec 2019 15:05:50 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 1/3] dt-bindings: display: renesas: du:
	Document the r8a7744 bindings
In-Reply-To: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
References: <1576767952-15873-1-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
Message-ID: <1576767952-15873-2-git-send-email-marian-cristian.rotariu.rb@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 5eb08d995564c9f9d4818a84050f7716b73c86cc upstream.

Document the RZ/G1N (R8A7744) SoC in the R-Car DU bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index 2cc5fdd..96cc080 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -4,6 +4,7 @@ Required Properties:
 
   - compatible: must be one of the following.
     - "renesas,du-r8a7743" for R8A7743 (RZ/G1M) compatible DU
+    - "renesas,du-r8a7744" for R8A7744 (RZ/G1N) compatible DU
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
@@ -46,6 +47,7 @@ corresponding to each DU output.
                       Port 0         Port1          Port2
 -----------------------------------------------------------------------------
  R8A7743 (RZ/G1M)     DPAD 0         LVDS 0         -
+ R8A7744 (RZ/G1N)     DPAD 0         LVDS 0         -
  R8A7745 (RZ/G1E)     DPAD 0         DPAD 1         -
  R8A7779 (R-Car H1)   DPAD 0         DPAD 1         -
  R8A7790 (R-Car H2)   DPAD 0         LVDS 0         LVDS 1
-- 
2.7.4
