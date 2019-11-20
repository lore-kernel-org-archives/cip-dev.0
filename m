From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 20 Nov 2019 16:47:17 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 3/6] ARM: dts: iwg23s-sbc: Enable
	watchdog support
In-Reply-To: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1574268440-33507-4-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit e1d31e7ebaa4087ecc7a5e16197f7fa6857aaa75 upstream.

This patch enables watchdog support on the iWave iwg23s sbc.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 273acc8..6cae910 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -126,6 +126,11 @@
 	};
 };
 
+&rwdt {
+	timeout-sec = <60>;
+	status = "okay";
+};
+
 &scif1 {
 	pinctrl-0 = <&scif1_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
