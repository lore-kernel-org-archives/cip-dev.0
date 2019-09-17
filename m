From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue, 17 Sep 2019 14:07:30 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 02/32] dt-bindings: display:
	renesas: du: Document the r8a774a1 bindings
In-Reply-To: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568725680-32730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568725680-32730-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 2acd1d1f219946e292aa85a9e3dff35e4bb78237 upstream.

Document the RZ/G2M (R8A774A1) SoC in the R-Car DU bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index ec9d34be..e01acc6 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -5,6 +5,7 @@ Required Properties:
   - compatible: must be one of the following.
     - "renesas,du-r8a7743" for R8A7743 (RZ/G1M) compatible DU
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
+    - "renesas,du-r8a774a1" for R8A774A1 (RZ/G2M) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
     - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
@@ -51,6 +52,7 @@ corresponding to each DU output.
 -----------------------------------------------------------------------------
  R8A7743 (RZ/G1M)       DPAD 0         LVDS 0         -              -
  R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              -
+ R8A774A1 (RZ/G2M)      DPAD 0         HDMI 0         LVDS 0         -
  R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
  R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         -
  R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              -
-- 
2.7.4
