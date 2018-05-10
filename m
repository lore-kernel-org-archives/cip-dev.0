From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 May 2018 16:08:14 +0100
Subject: [cip-dev] [PATCH 25/62] dmaengine: rcar-dmac: Document SoC specific
	bindings
In-Reply-To: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
References: <1525964931-14960-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1525964931-14960-26-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Simon Horman <horms+renesas@verge.net.au>

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
most drivers for Renesas hardware. The purpose of this patch is to
update the Renesas R-Car DMA Controller driver to follow this convention.

Cc: devicetree at vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
(cherry picked from commit 6bf641039f96e0c0cf3b10ae9ba12039d1a01122)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index 09daeef..5b902ac 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -14,7 +14,14 @@ not described in these device tree bindings.
 
 Required Properties:
 
-- compatible: must contain "renesas,rcar-dmac"
+- compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
+	      Examples with soctypes are:
+		- "renesas,dmac-r8a7790" (R-Car H2)
+		- "renesas,dmac-r8a7791" (R-Car M2-W)
+		- "renesas,dmac-r8a7792" (R-Car V2H)
+		- "renesas,dmac-r8a7793" (R-Car M2-N)
+		- "renesas,dmac-r8a7794" (R-Car E2)
+		- "renesas,dmac-r8a7795" (R-Car H3)
 
 - reg: base address and length of the registers block for the DMAC
 
@@ -35,7 +42,7 @@ Required Properties:
 Example: R8A7790 (R-Car H2) SYS-DMACs
 
 	dmac0: dma-controller at e6700000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
 		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
 			      0 200 IRQ_TYPE_LEVEL_HIGH
@@ -65,7 +72,7 @@ Example: R8A7790 (R-Car H2) SYS-DMACs
 	};
 
 	dmac1: dma-controller@e6720000 {
-		compatible = "renesas,rcar-dmac";
+		compatible = "renesas,dmac-r8a7790", "renesas,rcar-dmac";
 		reg = <0 0xe6720000 0 0x20000>;
 		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
 			      0 216 IRQ_TYPE_LEVEL_HIGH
-- 
2.7.4
