From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 31 Aug 2017 15:34:19 +0100
Subject: [cip-dev] [PATCH v2 14/18] ARM: dts: r8a7743: Remove unit-address
	and reg from integrated cache
In-Reply-To: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
References: <1504190063-61519-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1504190063-61519-15-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: 34e8d993a68ae459 ("ARM: dts: r8a7743: initial SoC device tree")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
(cherry picked from commit 37f0c804e57ac93ca37a98aa5a210c6b73e6572a)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7743.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7743.dtsi b/arch/arm/boot/dts/r8a7743.dtsi
index 9227ab4..fde6327 100644
--- a/arch/arm/boot/dts/r8a7743.dtsi
+++ b/arch/arm/boot/dts/r8a7743.dtsi
@@ -31,9 +31,8 @@
 			next-level-cache = <&L2_CA15>;
 		};
 
-		L2_CA15: cache-controller at 0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			cache-unified;
 			cache-level = <2>;
 		};
-- 
1.9.1
