From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:39 +0100
Subject: [cip-dev] [PATCH 4.19.y 16/17] usb: gadget: udc: renesas_usb3: Add
	bindings for r8a774c0
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-17-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 35ed6229c0f0d079f28b22b60b0af3114f9226fb upstream.

Document RZ/G2E (R8A774C0) SoC bindings.

Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
---
 Documentation/devicetree/bindings/usb/renesas_usb3.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usb3.txt b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
index b22f0a5..9551e8c 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usb3.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usb3.txt
@@ -3,6 +3,7 @@ Renesas Electronics USB3.0 Peripheral driver
 Required properties:
   - compatible: Must contain one of the following:
 	- "renesas,r8a774a1-usb3-peri"
+	- "renesas,r8a774c0-usb3-peri"
 	- "renesas,r8a7795-usb3-peri"
 	- "renesas,r8a7796-usb3-peri"
 	- "renesas,r8a77965-usb3-peri"
-- 
2.7.4
