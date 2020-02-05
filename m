From: prabhakar.mahadev-lad.rj@bp.renesas.com (Lad Prabhakar)
Date: Wed,  5 Feb 2020 20:38:58 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 32/35] dt-bindings: usb: renesas_usb3:
	Document r8a774b1 support
In-Reply-To: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Message-ID: <1580935141-1173-33-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 7236c197b4ed5de4771a92945888526b1316bd46 upstream.

Document RZ/G2N (R8A774B1) SoC bindings.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/1570531132-21856-7-git-send-email-fabrizio.castro at bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
index 9551e8c..51a7b37 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
+++ b/Documentation/devicetree/bindings/usb/renesas,usb3-peri.txt
@@ -3,6 +3,7 @@ Renesas Electronics USB3.0 Peripheral driver
 Required properties:
   - compatible: Must contain one of the following:
 	- "renesas,r8a774a1-usb3-peri"
+	- "renesas,r8a774b1-usb3-peri"
 	- "renesas,r8a774c0-usb3-peri"
 	- "renesas,r8a7795-usb3-peri"
 	- "renesas,r8a7796-usb3-peri"
-- 
2.7.4
