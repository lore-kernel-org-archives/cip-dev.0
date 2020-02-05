From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:52 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 26/35] dt-bindings: dmaengine:
	usb-dmac: Add binding for r8a774b1
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-27-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 07562314c2d3563daafb6f5fde8ca22e11308e0d upstream.

This patch adds the binding for r8a774b1 SoC (RZ/G2N).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1570531132-21856-3-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
index 5e82a93..f365523 100644
--- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
@@ -6,6 +6,7 @@ Required Properties:
 	  - "renesas,r8a7743-usb-dmac" (RZ/G1M)
 	  - "renesas,r8a7745-usb-dmac" (RZ/G1E)
 	  - "renesas,r8a774a1-usb-dmac" (RZ/G2M)
+	  - "renesas,r8a774b1-usb-dmac" (RZ/G2N)
 	  - "renesas,r8a774c0-usb-dmac" (RZ/G2E)
 	  - "renesas,r8a7790-usb-dmac" (R-Car H2)
 	  - "renesas,r8a7791-usb-dmac" (R-Car M2-W)
-- 
2.7.4
