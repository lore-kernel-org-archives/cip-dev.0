Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82426ECAAD4
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:48:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.1265.1661964487009489496
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:48:13 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240584"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:48:13 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B3C6740457DA;
	Thu,  1 Sep 2022 01:48:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 26/26] arm64: dts: renesas: rzg2ul-smarc-som:
 Enable Ethernet on SMARC platform
Date: Wed, 31 Aug 2022 17:46:45 +0100
Message-Id: <20220831164645.2134258-27-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:48:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9386

commit 6494e4f90503cb4027632dfcedcb7a683d829db0 upstream.

Enable Ethernet{0,1} interfaces on RZ/G2UL SMARC EVK.

Ethernet0 pins are muxed with CAN0, CAN1, SSI1 and RSPI1 pins and Ethernet0
device selection is based on the SW1[3] switch position.

Set SW1[3] to position OFF for selecting CAN0, CAN1, SSI1 and RSPI1.
Set SW1[3] to position ON for selecting Ethernet0.

This patch disables Ethernet0 on RZ/G2UL SMARC platform by default.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402081328.26292-8-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg2ul-smarc-som.dtsi    | 97 ++++++++++++++++++-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  2 +
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 0d6fc0d84783..b0822679a55b 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -9,8 +9,13 @@
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
+	aliases {
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+	};
+
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=on";
 	};
 
 	memory@48000000 {
@@ -52,11 +57,101 @@ vccq_sdhi0: regulator-vccq-sdhi0 {
 #endif
 };
 
+#if (!SW_ET0_EN_N)
+&eth0 {
+	pinctrl-0 = <&eth0_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy0>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	phy0: ethernet-phy@7 {
+		compatible = "ethernet-phy-id0022.1640",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		rxc-skew-psec = <2400>;
+		txc-skew-psec = <2400>;
+		rxdv-skew-psec = <0>;
+		txdv-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+#endif
+
+&eth1 {
+	pinctrl-0 = <&eth1_pins>;
+	pinctrl-names = "default";
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	phy1: ethernet-phy@7 {
+		compatible = "ethernet-phy-id0022.1640",
+			     "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+		rxc-skew-psec = <2400>;
+		txc-skew-psec = <2400>;
+		rxdv-skew-psec = <0>;
+		txdv-skew-psec = <0>;
+		rxd0-skew-psec = <0>;
+		rxd1-skew-psec = <0>;
+		rxd2-skew-psec = <0>;
+		rxd3-skew-psec = <0>;
+		txd0-skew-psec = <0>;
+		txd1-skew-psec = <0>;
+		txd2-skew-psec = <0>;
+		txd3-skew-psec = <0>;
+	};
+};
+
 &extal_clk {
 	clock-frequency = <24000000>;
 };
 
 &pinctrl {
+	eth0_pins: eth0 {
+		pinmux = <RZG2L_PORT_PINMUX(4, 5, 1)>, /* ET0_LINKSTA */
+			 <RZG2L_PORT_PINMUX(4, 3, 1)>, /* ET0_MDC */
+			 <RZG2L_PORT_PINMUX(4, 4, 1)>, /* ET0_MDIO */
+			 <RZG2L_PORT_PINMUX(1, 0, 1)>, /* ET0_TXC */
+			 <RZG2L_PORT_PINMUX(1, 1, 1)>, /* ET0_TX_CTL */
+			 <RZG2L_PORT_PINMUX(1, 2, 1)>, /* ET0_TXD0 */
+			 <RZG2L_PORT_PINMUX(1, 3, 1)>, /* ET0_TXD1 */
+			 <RZG2L_PORT_PINMUX(1, 4, 1)>, /* ET0_TXD2 */
+			 <RZG2L_PORT_PINMUX(2, 0, 1)>, /* ET0_TXD3 */
+			 <RZG2L_PORT_PINMUX(3, 0, 1)>, /* ET0_RXC */
+			 <RZG2L_PORT_PINMUX(3, 1, 1)>, /* ET0_RX_CTL */
+			 <RZG2L_PORT_PINMUX(3, 2, 1)>, /* ET0_RXD0 */
+			 <RZG2L_PORT_PINMUX(3, 3, 1)>, /* ET0_RXD1 */
+			 <RZG2L_PORT_PINMUX(4, 0, 1)>, /* ET0_RXD2 */
+			 <RZG2L_PORT_PINMUX(4, 1, 1)>; /* ET0_RXD3 */
+	};
+
+	eth1_pins: eth1 {
+		pinmux = <RZG2L_PORT_PINMUX(10, 4, 1)>, /* ET1_LINKSTA */
+			 <RZG2L_PORT_PINMUX(10, 2, 1)>, /* ET1_MDC */
+			 <RZG2L_PORT_PINMUX(10, 3, 1)>, /* ET1_MDIO */
+			 <RZG2L_PORT_PINMUX(7, 0, 1)>, /* ET1_TXC */
+			 <RZG2L_PORT_PINMUX(7, 1, 1)>, /* ET1_TX_CTL */
+			 <RZG2L_PORT_PINMUX(7, 2, 1)>, /* ET1_TXD0 */
+			 <RZG2L_PORT_PINMUX(7, 3, 1)>, /* ET1_TXD1 */
+			 <RZG2L_PORT_PINMUX(7, 4, 1)>, /* ET1_TXD2 */
+			 <RZG2L_PORT_PINMUX(8, 0, 1)>, /* ET1_TXD3 */
+			 <RZG2L_PORT_PINMUX(8, 4, 1)>, /* ET1_RXC */
+			 <RZG2L_PORT_PINMUX(9, 0, 1)>, /* ET1_RX_CTL */
+			 <RZG2L_PORT_PINMUX(9, 1, 1)>, /* ET1_RXD0 */
+			 <RZG2L_PORT_PINMUX(9, 2, 1)>, /* ET1_RXD1 */
+			 <RZG2L_PORT_PINMUX(9, 3, 1)>, /* ET1_RXD2 */
+			 <RZG2L_PORT_PINMUX(10, 0, 1)>; /* ET1_RXD3 */
+	};
+
 	sdhi0_emmc_pins: sd0emmc {
 		sd0_emmc_data {
 			pins = "SD0_DATA0", "SD0_DATA1", "SD0_DATA2", "SD0_DATA3",
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index f8c90ff676fe..056a77369c8d 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -9,9 +9,11 @@
  * DIP-Switch SW1 setting
  * 1 : High; 0: Low
  * SW1-2 : SW_SD0_DEV_SEL	(0: uSD; 1: eMMC)
+ * SW1-3 : SW_ET0_EN_N		(0: ETHER0; 1: CAN0, CAN1, SSI1, RSPI1)
  * Please change below macros according to SW1 setting
  */
 #define SW_SW0_DEV_SEL	1
+#define SW_ET0_EN_N	1
 
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
-- 
2.25.1


