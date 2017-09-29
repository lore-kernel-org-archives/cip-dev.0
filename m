From: chris.paterson2@renesas.com (Chris Paterson)
Date: Fri, 29 Sep 2017 18:28:13 +0100
Subject: [cip-dev] [PATCH 11/15] dt-bindings: mmc: sh_mmcif: Document
	r8a7743 DT bindings
In-Reply-To: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
References: <1506706097-29770-1-git-send-email-chris.paterson2@renesas.com>
Message-ID: <1506706097-29770-12-git-send-email-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 62b1ab2a71c4d3acb59e109fadb5fec3430642ed)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Conflicts:
	Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index cae29eb..0c9ac54 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -9,6 +9,7 @@ Required properties:
 - compatible: should be "renesas,mmcif-<soctype>", "renesas,sh-mmcif" as a
   fallback. Examples with <soctype> are:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
+	- "renesas,mmcif-r8a7743" for the MMCIF found in r8a7743 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
 	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
-- 
1.9.1
