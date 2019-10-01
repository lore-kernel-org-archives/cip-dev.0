From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Tue,  1 Oct 2019 09:25:00 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 01/32] media: vsp1: Add RZ/G support
In-Reply-To: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1569918331-6990-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1569918331-6990-2-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e260d78736db0c74240df2243c299be7b0d0b182 upstream.

Document RZ/G1 and RZ/G2 support.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/media/renesas,vsp1.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,vsp1.txt b/Documentation/devicetree/bindings/media/renesas,vsp1.txt
index 1642701..cd5a955 100644
--- a/Documentation/devicetree/bindings/media/renesas,vsp1.txt
+++ b/Documentation/devicetree/bindings/media/renesas,vsp1.txt
@@ -2,13 +2,13 @@
 
 The VSP is a video processing engine that supports up-/down-scaling, alpha
 blending, color space conversion and various other image processing features.
-It can be found in the Renesas R-Car second generation SoCs.
+It can be found in the Renesas R-Car Gen2, R-Car Gen3, RZ/G1, and RZ/G2 SoCs.
 
 Required properties:
 
   - compatible: Must contain one of the following values
-    - "renesas,vsp1" for the R-Car Gen2 VSP1
-    - "renesas,vsp2" for the R-Car Gen3 VSP2
+    - "renesas,vsp1" for the R-Car Gen2 and RZ/G1 VSP1
+    - "renesas,vsp2" for the R-Car Gen3 and RZ/G2 VSP2
 
   - reg: Base address and length of the registers block for the VSP.
   - interrupts: VSP interrupt specifier.
-- 
2.7.4
