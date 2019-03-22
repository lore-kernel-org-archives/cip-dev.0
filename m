From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:56:17 +0000
Subject: [cip-dev] [PATCH 1/5] dt-bindings: net: ravb: Add support for
	r8a774c0 SoC
In-Reply-To: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
References: <1553248581-64466-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553248581-64466-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 1811caa0cf91320baff40c82cbb157c772cfd365)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index da249b7..9e3d768 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -17,6 +17,7 @@ Required properties:
 		R-Car Gen2 and RZ/G1 devices.
 
       - "renesas,etheravb-r8a774a1" for the R8A774A1 SoC.
+      - "renesas,etheravb-r8a774c0" for the R8A774C0 SoC.
       - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
       - "renesas,etheravb-r8a7796" for the R8A7796 SoC.
       - "renesas,etheravb-r8a77965" for the R8A77965 SoC.
-- 
2.7.4
