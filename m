From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 28 Aug 2019 09:48:35 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 17/17] ARM: dts: iwg23s-sbc: Enable
	HS-USB
In-Reply-To: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
References: <1566982115-11148-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1566982115-11148-18-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit 0725a5478e3b7080666512e6889c94bc361e7b88 upstream.

Enable HS-USB device for the iWave SBC based on RZ/G1C.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
index 5c20c4c..273acc8 100644
--- a/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
+++ b/arch/arm/boot/dts/r8a77470-iwg23s-sbc.dts
@@ -52,6 +52,10 @@
 	clock-frequency = <20000000>;
 };
 
+&hsusb0 {
+	status = "okay";
+};
+
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
-- 
2.7.4
