From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 26 Nov 2019 16:20:25 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 04/10] dt-bindings: mmc: sh_mmcif:
	Document r8a7744 DT bindings
In-Reply-To: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
References: <1574785231-56219-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574785231-56219-5-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 2ffca7a34df5ce95efff4a481cd79ec47abf3d6d upstream.

Add support for r8a7744 SoC. Renesas RZ/G1N (R8A7744) MMCIF is identical
to the R-Car Gen2 family.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[biju: backported to 4.4 kernel]
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index aa33691..ccbcd76 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -10,6 +10,7 @@ Required properties:
   fallback. Examples with <soctype> are:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
+	- "renesas,mmcif-r8a7744" for the MMCIF found in r8a7744 SoCs
 	- "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
-- 
2.7.4
