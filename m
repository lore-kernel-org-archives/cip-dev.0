From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:56 +0100
Subject: [cip-dev] [PATCH v2 44/52] dt-bindings: rcar-dmac: Document missing
	error interrupt
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-45-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 5466c34f8425ccd24124ebdae6e3b6552195956d upstream.

The documentation for the "interrupt-names" property only mentions the
per-channel interrupts, while the error interrupt has always been
mandatory, too.

Fixes: 10f5c8438475909a ("dmaengine: rcar-dmac: Add device tree bindings
documentation")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 5f2ce66..471fcc2 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -29,8 +29,9 @@ Required Properties:
 
 - interrupts: interrupt specifiers for the DMAC, one for each entry in
   interrupt-names.
-- interrupt-names: one entry per channel, named "ch%u", where %u is the
-  channel number ranging from zero to the number of channels minus one.
+- interrupt-names: one entry for the error interrupt, named "error", plus one
+  entry per channel, named "ch%u", where %u is the channel number ranging from
+  zero to the number of channels minus one.
 
 - clock-names: "fck" for the functional clock
 - clocks: a list of phandle + clock-specifier pairs, one for each entry
-- 
2.7.4
