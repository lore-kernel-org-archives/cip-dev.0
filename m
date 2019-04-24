From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:33 +0100
Subject: [cip-dev] [PATCH 4.19.y 10/17] dt-bindings: dmaengine: usb-dmac:
	Add binding for r8a774c0
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-11-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 3eaba568b54e572187a3f4a08d5582d4d623e7e3 upstream.

This patch adds bindings for the r8a774c0 (RZ/G2E).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
index 482e543..4354ed6 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
@@ -5,6 +5,7 @@ Required Properties:
 	Examples with soctypes are:
 	  - "renesas,r8a7743-usb-dmac" (RZ/G1M)
 	  - "renesas,r8a7745-usb-dmac" (RZ/G1E)
+	  - "renesas,r8a774c0-usb-dmac" (RZ/G2E)
 	  - "renesas,r8a7790-usb-dmac" (R-Car H2)
 	  - "renesas,r8a7791-usb-dmac" (R-Car M2-W)
 	  - "renesas,r8a7793-usb-dmac" (R-Car M2-N)
-- 
2.7.4
