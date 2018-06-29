From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 29 Jun 2018 14:59:01 +0100
Subject: [cip-dev] [PATCH 2/3] media: dt-bindings: media: rcar_vin: Reverse
	SoC part number list
In-Reply-To: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
References: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1530280742-6540-3-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Change the sorting of the part numbers from descending to ascending to
match with other documentation.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
(cherry picked from commit aac7a6ccf2d44f8c19273dd5efd3c465a1ab5867)
(removed r8a7792 and r8a7795 devices)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 1abe1ef..18287b0 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -6,12 +6,12 @@ family of devices. The current blocks are always slaves and suppot one input
 channel which can be either RGB, YUYV or BT656.
 
  - compatible: Must be one or more of the following
-   - "renesas,vin-r8a7794" for the R8A7794 device
-   - "renesas,vin-r8a7793" for the R8A7793 device
-   - "renesas,vin-r8a7791" for the R8A7791 device
-   - "renesas,vin-r8a7790" for the R8A7790 device
-   - "renesas,vin-r8a7779" for the R8A7779 device
    - "renesas,vin-r8a7778" for the R8A7778 device
+   - "renesas,vin-r8a7779" for the R8A7779 device
+   - "renesas,vin-r8a7790" for the R8A7790 device
+   - "renesas,vin-r8a7791" for the R8A7791 device
+   - "renesas,vin-r8a7793" for the R8A7793 device
+   - "renesas,vin-r8a7794" for the R8A7794 device
    - "renesas,rcar-gen2-vin" for a generic R-Car Gen2 compatible device.
 
    When compatible with the generic version nodes must list the
-- 
2.7.4
