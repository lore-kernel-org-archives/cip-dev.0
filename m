From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 29 Jun 2018 14:59:02 +0100
Subject: [cip-dev] [PATCH 3/3] media: dt-bindings: media: rcar_vin: add
	device tree support for r8a774[35]
In-Reply-To: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
References: <1530280742-6540-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1530280742-6540-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add compatible strings for r8a7743 and r8a7745. No driver change
is needed as "renesas,rcar-gen2-vin" will activate the right code.
However, it is good practice to document compatible strings for the
specific SoC as this allows SoC specific changes to the driver if
needed, in addition to document SoC support and therefore allow
checkpatch.pl to validate compatible string values.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
(cherry picked from commit 1d14a5eaa156b0b3898c749fb3f9da1ebbc3f4aa)
(removed "renesas,rcar-gen3-vin" fallback)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 18287b0..08eca2e 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -6,6 +6,8 @@ family of devices. The current blocks are always slaves and suppot one input
 channel which can be either RGB, YUYV or BT656.
 
  - compatible: Must be one or more of the following
+   - "renesas,vin-r8a7743" for the R8A7743 device
+   - "renesas,vin-r8a7745" for the R8A7745 device
    - "renesas,vin-r8a7778" for the R8A7778 device
    - "renesas,vin-r8a7779" for the R8A7779 device
    - "renesas,vin-r8a7790" for the R8A7790 device
-- 
2.7.4
