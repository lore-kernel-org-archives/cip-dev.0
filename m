From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 29 Jan 2020 14:30:02 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 09/12] dt-bindings: mmc: renesas_sdhi:
	Add r8a774b1 support
In-Reply-To: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
References: <1580308205-20435-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1580308205-20435-10-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document RZ/G2N (R8A774B1) SoC bindings.

This patch is similar to commit 01a5674301fa790d05e1d2c888c9c98370082d45
("dt-bindings: mmc: renesas_sdhi: Add r8a774b1 support") in mainline
kernel, but since tmio_mmc.txt is renamed to renesas,sdhi.txt due to split
of core functionality, DMA and MFD glue in mainline kernel in commit
b6147490e6aa ("mmc: tmio: split core functionality, DMA and MFD glue")

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index ac5c93c..d50c6cb 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -18,6 +18,7 @@ Required properties:
 		"renesas,sdhi-r8a7743" - SDHI IP on R8A7743 SoC
 		"renesas,sdhi-r8a7745" - SDHI IP on R8A7745 SoC
 		"renesas,sdhi-r8a774a1" - SDHI IP on R8A774A1 SoC
+		"renesas,sdhi-r8a774b1" - SDHI IP on R8A774B1 SoC
 		"renesas,sdhi-r8a774c0" - SDHI IP on R8A774C0 SoC
 		"renesas,sdhi-r8a77470" - SDHI IP on R8A77470 SoC
 		"renesas,sdhi-mmc-r8a77470" - SDHI/MMC IP on R8A77470 SoC
-- 
2.7.4
