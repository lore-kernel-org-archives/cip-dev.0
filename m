From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 29 Jun 2018 15:38:19 +0100
Subject: [cip-dev] [PATCH 18/86] ARM: DTS: Fix register map for virt-capable
	GIC
In-Reply-To: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1530283167-14050-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1530283167-14050-19-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Marc Zyngier <marc.zyngier@arm.com>

Since everybody copied my own mistake from the DT binding example,
let's address all the offenders in one swift go.

Most of them got the CPU interface size wrong (4kB, while it should
be 8kB), except for both keystone platforms which got the control
interface wrong (4kB instead of 8kB).

In a few cases where I knew for sure what implementation was used,
I've added the "arm,gic-400" compatible string. I'm 99% sure that
this is what everyone is using, but short of having the TRM for
all the other SoCs, I've left them alone.

Acked-by: Shawn Guo <shawnguo@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
(cherry picked from commit 387720c93812f1e702c20c667cb003a356e24a6c)
(Backported only for r8a7745)
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7745.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 62dd97e..8cfc644 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -52,7 +52,7 @@
 			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0 0xf1001000 0 0x1000>,
-			      <0 0xf1002000 0 0x1000>,
+			      <0 0xf1002000 0 0x2000>,
 			      <0 0xf1004000 0 0x2000>,
 			      <0 0xf1006000 0 0x2000>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
-- 
2.7.4
