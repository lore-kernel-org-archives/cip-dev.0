From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:47 +0100
Subject: [cip-dev] [PATCH 46/86] dt-bindings: net: ravb : Add support for
	r8a7745 SoC
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-47-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

Add a new compatible string for the RZ/G1E (R8A7745) SoC.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 22cb7a3ac380ecaab6837670963813599b123a53)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 715b8ce..9a22b1e 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -6,6 +6,7 @@ interface contains.
 Required properties:
 - compatible: Must contain one or more of the following:
       - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
+      - "renesas,etheravb-r8a7745" for the R8A7745 SoC.
       - "renesas,etheravb-r8a7790" for the R8A7790 SoC.
       - "renesas,etheravb-r8a7794" for the R8A7794 SoC.
       - "renesas,etheravb-rcar-gen2" as a fallback for the above
-- 
2.7.4
