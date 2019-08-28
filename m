From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:31:55 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 08/57] dt-bindings: thermal:
	rcar-gen3-thermal: Add r8a774a1 support
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit be6af481f3b2d5084c4e70684eaa962602f94707 upstream.

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
index cfa154b..098bf95 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
@@ -7,6 +7,7 @@ inside the LSI.
 Required properties:
 - compatible		: "renesas,<soctype>-thermal",
 			  Examples with soctypes are:
+			    - "renesas,r8a774a1-thermal" (RZ/G2M)
 			    - "renesas,r8a7795-thermal" (R-Car H3)
 			    - "renesas,r8a7796-thermal" (R-Car M3-W)
 			    - "renesas,r8a77965-thermal" (R-Car M3-N)
-- 
2.7.4
