From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 22 Mar 2019 09:40:07 +0000
Subject: [cip-dev] [PATCH 08/11] dt-bindings: mmc: renesas_sdhi: Add
	r8a774c0 support
In-Reply-To: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
References: <1553247610-33056-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1553247610-33056-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit ab409be2be555e61516214885537dcb619f12e9e)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index f1bffc7..ac5c93c 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -18,6 +18,7 @@ Required properties:
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
 		"renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
+		"renesas,sdhi-r8a774c0" - SDHI IP on R8A774C0 SoC
 		"renesas,sdhi-r8a77470" - SDHI IP on R8A77470 SoC
 		"renesas,sdhi-mmc-r8a77470" - SDHI/MMC IP on R8A77470 SoC
 		"renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
-- 
2.7.4
