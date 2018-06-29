From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:51 +0100
Subject: [cip-dev] [PATCH 50/86] dt-bindings: mmc: sh_mmcif: Document
	r8a7745 DT bindings
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-51-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit b773b3bf1916a368c29a19916abf0f5eca8b3c33)
(dropped interrupt information)
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index 0c9ac54..aa33691 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -10,6 +10,7 @@ Required properties:
   fallback. Examples with <soctype> are:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
+	- "renesas,mmcif-r8a7745" for the MMCIF found in r8a7745 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
 	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
-- 
2.7.4
