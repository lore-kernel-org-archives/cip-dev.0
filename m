From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu,  5 Sep 2019 09:37:17 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip repost 6/6] arm64: dts: renesas:
	hihope-common: Remove "label" from LEDs
In-Reply-To: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1567672637-29449-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1567672637-29449-7-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit f6130381e2a20b0503838477462a3f55f7672434 upstream.

Remove "label" properties from the LEDs device tree nodes, since
we don't have nice labels on the PCB.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index cc5dde5..77d183a 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -22,22 +22,18 @@
 
 		led0 {
 			gpios = <&gpio6 11 GPIO_ACTIVE_HIGH>;
-			label = "LED0";
 		};
 
 		led1 {
 			gpios = <&gpio6 12 GPIO_ACTIVE_HIGH>;
-			label = "LED1";
 		};
 
 		led2 {
 			gpios = <&gpio6 13 GPIO_ACTIVE_HIGH>;
-			label = "LED2";
 		};
 
 		led3 {
 			gpios = <&gpio0  0 GPIO_ACTIVE_HIGH>;
-			label = "LED3";
 		};
 	};
 
-- 
2.7.4
