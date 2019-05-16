From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 16 May 2019 10:39:49 +0100
Subject: [cip-dev] [PATCH v2 37/52] ARM: dts: r8a77470: Add PFC support
In-Reply-To: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1557999604-1117-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1557999604-1117-38-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

From: Biju Das <biju.das@bp.renesas.com>

commit 0ea1a4d2c92a65aea6acc2397938cd01b053bc38 upstream.

Define the generic R8A77470 part of the PFC device node.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

---
v1->v2:
* No change
---
 arch/arm/boot/dts/r8a77470.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470.dtsi b/arch/arm/boot/dts/r8a77470.dtsi
index 09c4d66..e971b5e 100644
--- a/arch/arm/boot/dts/r8a77470.dtsi
+++ b/arch/arm/boot/dts/r8a77470.dtsi
@@ -59,6 +59,11 @@
 		#size-cells = <2>;
 		ranges;
 
+		pfc: pin-controller at e6060000 {
+			compatible = "renesas,pfc-r8a77470";
+			reg = <0 0xe6060000 0 0x118>;
+		};
+
 		rst: reset-controller at e6160000 {
 			compatible = "renesas,r8a77470-rst";
 			reg = <0 0xe6160000 0 0x100>;
-- 
2.7.4
