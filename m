From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed,  1 May 2019 11:22:09 +0100
Subject: [cip-dev] [PATCH 4.19.y 15/29] media: dt-bindings: rcar-csi2: Add
	r8a774c0
In-Reply-To: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556706143-11898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556706143-11898-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 9640ee1c308c1bb21c224a0cf41d9ed1b7e3a427 upstream.

Add the compatible string for RZ/G2E (a.k.a. R8A774C0) to the
list of supported SoCs.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt b/Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
index 2d385b6..4e9a4f7 100644
--- a/Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
+++ b/Documentation/devicetree/bindings/media/renesas,rcar-csi2.txt
@@ -2,12 +2,13 @@ Renesas R-Car MIPI CSI-2
 ------------------------
 
 The R-Car CSI-2 receiver device provides MIPI CSI-2 capabilities for the
-Renesas R-Car family of devices. It is used in conjunction with the
+Renesas R-Car and RZ/G2 family of devices. It is used in conjunction with the
 R-Car VIN module, which provides the video capture capabilities.
 
 Mandatory properties
 --------------------
  - compatible: Must be one or more of the following
+   - "renesas,r8a774c0-csi2" for the R8A774C0 device.
    - "renesas,r8a7795-csi2" for the R8A7795 device.
    - "renesas,r8a7796-csi2" for the R8A7796 device.
    - "renesas,r8a77965-csi2" for the R8A77965 device.
-- 
2.7.4
