From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 16 Sep 2019 16:50:18 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 04/32] dt-bindings: display: renesas:
	Add r8a774a1 support
In-Reply-To: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1568649046-17420-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1568649046-17420-5-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 74a22e8f4350a9e096c84fc9e88cf72abf71887c upstream.

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
index a41d280..db68041 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.txt
@@ -12,10 +12,12 @@ following device-specific properties.
 Required properties:
 
 - compatible : Shall contain one or more of
+  - "renesas,r8a774a1-hdmi" for R8A774A1 (RZ/G2M) compatible HDMI TX
   - "renesas,r8a7795-hdmi" for R8A7795 (R-Car H3) compatible HDMI TX
   - "renesas,r8a7796-hdmi" for R8A7796 (R-Car M3-W) compatible HDMI TX
   - "renesas,r8a77965-hdmi" for R8A77965 (R-Car M3-N) compatible HDMI TX
-  - "renesas,rcar-gen3-hdmi" for the generic R-Car Gen3 compatible HDMI TX
+  - "renesas,rcar-gen3-hdmi" for the generic R-Car Gen3 and RZ/G2 compatible
+			     HDMI TX
 
     When compatible with generic versions, nodes must list the SoC-specific
     version corresponding to the platform first, followed by the
-- 
2.7.4
