From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:38 +0100
Subject: [cip-dev] [PATCH 4.19.y 15/17] usb: gadget: udc: renesas_usb3: Add
	r8a774a1 support
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-16-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit a1acad03aa77bde2d7fda7b1391ee72a55a705da upstream.

Document RZ/G2M (R8A774A1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 Documentation/devicetree/bindings/usb/renesas_usb3.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usb3.txt b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
index 2c071bb5..b22f0a5 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usb3.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
@@ -2,11 +2,12 @@ Renesas Electronics USB3.0 Peripheral driver
 
 Required properties:
   - compatible: Must contain one of the following:
+	- "renesas,r8a774a1-usb3-peri"
 	- "renesas,r8a7795-usb3-peri"
 	- "renesas,r8a7796-usb3-peri"
 	- "renesas,r8a77965-usb3-peri"
-	- "renesas,rcar-gen3-usb3-peri" for a generic R-Car Gen3 compatible
-	  device
+	- "renesas,rcar-gen3-usb3-peri" for a generic R-Car Gen3 or RZ/G2
+	  compatible device
 
     When compatible with the generic version, nodes must list the
     SoC-specific version corresponding to the platform first
-- 
2.7.4
