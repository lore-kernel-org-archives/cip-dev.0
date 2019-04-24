From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 24 Apr 2019 18:20:31 +0100
Subject: [cip-dev] [PATCH 4.19.y 08/17] dt-bindings: usb: renesas_usbhs: add
	clock-names property
In-Reply-To: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1556126440-27978-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1556126440-27978-9-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

commit 8e0d368a59bf87efa5ee4daea142527d01447864 upstream.

R-Car Gen3 needs to enable clocks of both host and peripheral.
Otherwise, other side device cannot work correctly. So, this patch
adds a property of clock-names for R-Car Gen3 as an optional.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas_usbhs.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
index 43960fa..f19ec72 100644
--- a/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
+++ b/Documentation/devicetree/bindings/usb/renesas_usbhs.txt
@@ -25,7 +25,11 @@ Required properties:
 
   - reg: Base address and length of the register for the USBHS
   - interrupts: Interrupt specifier for the USBHS
-  - clocks: A list of phandle + clock specifier pairs
+  - clocks: A list of phandle + clock specifier pairs.
+	    - In case of "renesas,rcar-gen3-usbhs", two clocks are required.
+	      First clock should be peripheral and second one should be host.
+	    - In case of except above, one clock is required. First clock
+	      should be peripheral.
 
 Optional properties:
   - renesas,buswait: Integer to use BUSWAIT register
-- 
2.7.4
