From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Mar 2019 14:24:15 +0000
Subject: [cip-dev] [PATCH 17/18] dt-bindings: reset: rcar-rst: Document
	r8a774c0 rst
In-Reply-To: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
References: <1553178256-6293-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553178256-6293-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document bindings for the RZ/G2E (a.k.a. R8A774C0) reset
module.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit fe46b8229f287e912b8c8d28bf8dde4cd704c17e)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/reset/renesas,rst.txt b/Documentation/devicetree/bindings/reset/renesas,rst.txt
index e4fe0ab..25e6db5 100644
--- a/Documentation/devicetree/bindings/reset/renesas,rst.txt
+++ b/Documentation/devicetree/bindings/reset/renesas,rst.txt
@@ -19,6 +19,7 @@ Required properties:
 		  - "renesas,r8a7745-rst" (RZ/G1E)
 		  - "renesas,r8a77470-rst" (RZ/G1C)
 		  - "renesas,r8a774a1-rst" (RZ/G2M)
+		  - "renesas,r8a774c0-rst" (RZ/G2E)
 		  - "renesas,r8a7778-reset-wdt" (R-Car M1A)
 		  - "renesas,r8a7779-reset-wdt" (R-Car H1)
 		  - "renesas,r8a7790-rst" (R-Car H2)
-- 
2.7.4
