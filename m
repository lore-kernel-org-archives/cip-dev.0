Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07084C54EE9
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4758.1662111901797907608
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="131460997"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:11 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 793AD400A11F;
	Fri,  2 Sep 2022 18:45:09 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 16/25] arm64: dts: renesas: rzg2ul-smarc: Enable
 Audio
Date: Fri,  2 Sep 2022 10:44:18 +0100
Message-Id: <20220902094427.116227-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9442

commit 1ed914e341392dbb7c29f0f62c105a81cce6b3e0 upstream.

Enable Audio on RZ/G2UL SMARC EVK by adding ssi1 pincontrol entries
to the soc-pinctrl dtsi and ssi1 and cpu sound_dai nodes to the board
dtsi.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220429072400.23729-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  7 ++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index 17527184ff2a..201b70150e01 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -98,4 +98,11 @@ sound_clk_pins: sound_clk {
 		pins = "AUDIO_CLK1", "AUDIO_CLK2";
 		input-enable;
 	};
+
+	ssi1_pins: ssi1 {
+		pinmux = <RZG2L_PORT_PINMUX(3, 0, 2)>, /* BCK */
+			 <RZG2L_PORT_PINMUX(3, 1, 2)>, /* RCK */
+			 <RZG2L_PORT_PINMUX(3, 2, 2)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(3, 3, 2)>; /* RXD */
+	};
 };
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index d75ad79ba804..0051634d7b1c 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -27,6 +27,10 @@ &canfd {
 };
 #endif
 
+&cpu_dai {
+	sound-dai = <&ssi1>;
+};
+
 &i2c1 {
 	wm8978: codec@1a {
 		compatible = "wlf,wm8978";
@@ -35,6 +39,25 @@ wm8978: codec@1a {
 	};
 };
 
+#if (SW_ET0_EN_N)
+&ssi1 {
+	pinctrl-0 = <&ssi1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+#else
+&snd_rzg2l {
+	status = "disabled";
+};
+
+&ssi1 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	status = "disabled";
+};
+#endif
+
 &vccq_sdhi1 {
 	gpios = <&pinctrl RZG2L_GPIO(6, 1) GPIO_ACTIVE_HIGH>;
 };
-- 
2.25.1


