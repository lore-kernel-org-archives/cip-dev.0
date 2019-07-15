From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:28:45 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/6] arm64: dts: renesas:
	r8a774c0-cat874: Add LEDs support
In-Reply-To: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563200930-39297-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit dc0b439471323521a20314934080f51e8589fd19 upstream.

This patch adds LEDs support to the CAT874 board specific
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index f08778e..af396bb 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -22,6 +22,30 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		led0 {
+			gpios = <&gpio5 19 GPIO_ACTIVE_HIGH>;
+			label = "LED0";
+		};
+
+		led1 {
+			gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
+			label = "LED1";
+		};
+
+		led2 {
+			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>;
+			label = "LED2";
+		};
+
+		led3 {
+			gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;
+			label = "LED3";
+		};
+	};
+
 	memory at 48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
-- 
2.7.4
