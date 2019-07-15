From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 15 Jul 2019 15:01:52 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 12/12] arm64: dts: renesas: cat874: Add
	USB-HOST support
In-Reply-To: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
References: <1563199312-18842-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1563199312-18842-13-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit ad68fa5fe8c12262cf4156b8e0726117aa3be8c8 upstream.

This patch adds USB 2.0 HOST support to the CAT874 board.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Biju Das <biju.das@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
index 96ee0d2c..4333af8 100644
--- a/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
@@ -52,10 +52,20 @@
 	};
 };
 
+&ehci0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &extal_clk {
 	clock-frequency = <48000000>;
 };
 
+&ohci0 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &pcie_bus_clk {
 	clock-frequency = <100000000>;
 };
@@ -104,3 +114,8 @@
 	sd-uhs-sdr104;
 	status = "okay";
 };
+
+&usb2_phy0 {
+	renesas,no-otg-pins;
+	status = "okay";
+};
-- 
2.7.4
