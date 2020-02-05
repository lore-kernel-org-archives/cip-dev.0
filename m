From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:30 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 04/35] dt-bindings: iommu: ipmmu-vmsa:
	Add r8a774b1 support
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-5-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit d0635ebf85aa2cbc17a5b83eaa65f20fa71bf388 upstream.

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
index 7b2cf8d..56faf8d 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -14,6 +14,7 @@ Required Properties:
     - "renesas,ipmmu-r8a7743" for the R8A7743 (RZ/G1M) IPMMU.
     - "renesas,ipmmu-r8a7745" for the R8A7745 (RZ/G1E) IPMMU.
     - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
+    - "renesas,ipmmu-r8a774b1" for the R8A774B1 (RZ/G2N) IPMMU.
     - "renesas,ipmmu-r8a774c0" for the R8A774C0 (RZ/G2E) IPMMU.
     - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
     - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
-- 
2.7.4
