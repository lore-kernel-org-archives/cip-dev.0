Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121DBC6FA85
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4758.1662111901797907608
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460967"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 44949400A11F;
	Fri,  2 Sep 2022 18:44:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 12/25] arm64: dts: renesas: rzg2ul-smarc: Enable
 CANFD
Date: Fri,  2 Sep 2022 10:44:14 +0100
Message-Id: <20220902094427.116227-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9438

commit 820e976909c2b286d1ef259ea524979540475ba6 upstream.

Enable CANFD on RZ/G2UL SMARC platform.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220425170530.200921-12-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  6 ----
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi | 28 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  8 ++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 2bf4a3b62438..df27b63f0465 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -14,12 +14,6 @@ / {
 	compatible = "renesas,smarc-evk", "renesas,r9a07g043u11", "renesas,r9a07g043";
 };
 
-&canfd {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
 &ehci0 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-names;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index 94106095c66a..17527184ff2a 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -12,6 +12,34 @@ &pinctrl {
 	pinctrl-0 = <&sound_clk_pins>;
 	pinctrl-names = "default";
 
+	can0_pins: can0 {
+		pinmux = <RZG2L_PORT_PINMUX(1, 1, 3)>, /* TX */
+			 <RZG2L_PORT_PINMUX(1, 2, 3)>; /* RX */
+	};
+
+#if (SW_ET0_EN_N)
+	can0-stb-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(2, 2) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "can0_stb";
+	};
+#endif
+
+	can1_pins: can1 {
+		pinmux = <RZG2L_PORT_PINMUX(2, 0, 3)>, /* TX */
+			 <RZG2L_PORT_PINMUX(2, 1, 3)>; /* RX */
+	};
+
+#if (SW_ET0_EN_N)
+	can1-stb-hog {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(2, 3) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "can1_stb";
+	};
+#endif
+
 	i2c0_pins: i2c0 {
 		pins = "RIIC0_SDA", "RIIC0_SCL";
 		input-enable;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index a580b04987ec..d75ad79ba804 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -19,6 +19,14 @@
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
+#if (!SW_ET0_EN_N)
+&canfd {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	status = "disabled";
+};
+#endif
+
 &i2c1 {
 	wm8978: codec@1a {
 		compatible = "wlf,wm8978";
-- 
2.25.1


