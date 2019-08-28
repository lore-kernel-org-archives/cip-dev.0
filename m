From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Wed, 28 Aug 2019 14:32:42 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip v2 55/57] arm64: dts: renesas:
	r8a774a1: Fix hsusb reg size
In-Reply-To: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566999164-27898-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1566999164-27898-56-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 173c3b3ca2130af4d69b1b25d95c52709fbd4a2f upstream.

HS-USB has registers outside the currently specified memory area,
therefore change the definition accordingly.

Fixes: ed898d4fc19d ("arm64: dts: renesas: r8a774a1: Add USB-DMAC and HSUSB device nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 61258ab..1969649 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -599,7 +599,7 @@
 		hsusb: usb at e6590000 {
 			compatible = "renesas,usbhs-r8a774a1",
 				     "renesas,rcar-gen3-usbhs";
-			reg = <0 0xe6590000 0 0x100>;
+			reg = <0 0xe6590000 0 0x200>;
 			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 704>;
 			dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
-- 
2.7.4
