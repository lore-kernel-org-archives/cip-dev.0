From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:25 +0100
Subject: [cip-dev] [PATCH 4.19.y 02/17] dt-bindings: rcar-gen3-phy-usb2: Add
	r8a774c0 support
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 4f0960ba7a6aedee18d5749e13ac74afe939bf2e upstream.

Document RZ/G2E (R8A774C0) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
index 6a4b5b6..6f73293 100644
--- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
+++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
@@ -6,6 +6,8 @@ This file provides information on what the device node for the R-Car generation
 Required properties:
 - compatible: "renesas,usb2-phy-r8a774a1" if the device is a part of an R8A774A1
 	      SoC.
+	      "renesas,usb2-phy-r8a774c0" if the device is a part of an R8A774C0
+	      SoC.
 	      "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
 	      SoC.
 	      "renesas,usb2-phy-r8a7796" if the device is a part of an R8A7796
-- 
2.7.4
