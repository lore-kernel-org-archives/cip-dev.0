From: biju.das@bp.renesas.com (Biju Das)
Date: Fri,  6 Dec 2019 12:12:24 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 08/12] media: dt-bindings: media:
	rcar_vin: add device tree support for r8a7744
In-Reply-To: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
References: <1575634348-10954-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1575634348-10954-9-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit d07d9195c950d1cd16ec32a0819b2b98084c0753 upstream.

Add compatible strings for r8a7744. No driver change is needed as
"renesas,rcar-gen2-vin" will activate the right code.However, it is good
practice to document compatible strings for the specific SoC as this
allows SoC specific changes to the driver if needed, in addition to
document SoC support and therefore allow checkpatch.pl to validate
compatible string values.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Acked-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/media/rcar_vin.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
index 08eca2e..6c7ba02 100644
--- a/Documentation/devicetree/bindings/media/rcar_vin.txt
+++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
@@ -7,6 +7,7 @@ channel which can be either RGB, YUYV or BT656.
 
  - compatible: Must be one or more of the following
    - "renesas,vin-r8a7743" for the R8A7743 device
+   - "renesas,vin-r8a7744" for the R8A7744 device
    - "renesas,vin-r8a7745" for the R8A7745 device
    - "renesas,vin-r8a7778" for the R8A7778 device
    - "renesas,vin-r8a7779" for the R8A7779 device
-- 
2.7.4
