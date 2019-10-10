From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Oct 2019 07:45:13 +0100
Subject: [cip-dev] [PATCH 4.19.y-cip 1/3] arm64: dts: renesas:
	hihope-common: Add PCA9654 I/O expander
In-Reply-To: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
References: <1570689915-14149-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1570689915-14149-2-git-send-email-biju.das@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

commit cd3e43be14189542d8934faa94eff0392da32536 upstream.

Enable PCA9654 GPIO expander, so that we can configure its GPIOs later.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 23fd022..a13cb88 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -162,6 +162,13 @@
 	clock-frequency = <400000>;
 	status = "okay";
 
+	gpio_expander: gpio at 20 {
+		compatible = "onnn,pca9654";
+		reg = <0x20>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	versaclock5: clock-generator at 6a {
 		compatible = "idt,5p49v5923";
 		reg = <0x6a>;
-- 
2.7.4
