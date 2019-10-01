From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:02 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 03/32] dt-bindings: display: renesas:
	du: Document r8a774c0 bindings
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-4-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 8c9fde42c5d386165d96593d8cc16fca48813589 upstream.

Document the RZ/G2E (a.k.a. r8a774c0) SoC in the R-Car DU bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
[fab: backported to v4.19,y-cip]
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index e01acc6..8f9d65c 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -6,6 +6,7 @@ Required Properties:
     - "renesas,du-r8a7743" for R8A7743 (RZ/G1M) compatible DU
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
     - "renesas,du-r8a774a1" for R8A774A1 (RZ/G2M) compatible DU
+    - "renesas,du-r8a774c0" for R8A774C0 (RZ/G2E) compatible DU
     - "renesas,du-r8a7779" for R8A7779 (R-Car H1) compatible DU
     - "renesas,du-r8a7790" for R8A7790 (R-Car H2) compatible DU
     - "renesas,du-r8a7791" for R8A7791 (R-Car M2-W) compatible DU
@@ -53,6 +54,7 @@ corresponding to each DU output.
  R8A7743 (RZ/G1M)       DPAD 0         LVDS 0         -              -
  R8A7745 (RZ/G1E)       DPAD 0         DPAD 1         -              -
  R8A774A1 (RZ/G2M)      DPAD 0         HDMI 0         LVDS 0         -
+ R8A774C0 (RZ/G2E)      DPAD 0         LVDS 0         LVDS 1         -
  R8A7779 (R-Car H1)     DPAD 0         DPAD 1         -              -
  R8A7790 (R-Car H2)     DPAD 0         LVDS 0         LVDS 1         -
  R8A7791 (R-Car M2-W)   DPAD 0         LVDS 0         -              -
-- 
2.7.4
