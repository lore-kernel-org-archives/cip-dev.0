From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 19 Nov 2019 14:53:30 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/17] dt-bindings: net: ravb: Add
	support for r8a7744 SoC
In-Reply-To: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
References: <1574175222-52858-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574175222-52858-6-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit b1589924c046a5e774c6c74b195213555617bb78 upstream.

Document RZ/G1N (R8A7744) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index b289f61..0a8e8df 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -6,6 +6,7 @@ interface contains.
 Required properties:
 - compatible: Must contain one or more of the following:
       - "renesas,etheravb-r8a7743" for the R8A7743 SoC.
+      - "renesas,etheravb-r8a7744" for the R8A7744 SoC.
       - "renesas,etheravb-r8a7745" for the R8A7745 SoC.
       - "renesas,etheravb-r8a77470" for the R8A77470 SoC.
       - "renesas,etheravb-r8a7790" for the R8A7790 SoC.
-- 
2.7.4
