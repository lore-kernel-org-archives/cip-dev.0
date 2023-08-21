Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87599EE4996
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.1018.1692628710778054720
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="177171134"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 85A42400754E;
	Mon, 21 Aug 2023 23:38:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 12/15] arm64: dts: renesas: rzg2ul-smarc-som: Add PHY interrupt support for ETH{0/1}
Date: Mon, 21 Aug 2023 15:37:56 +0100
Message-Id: <20230821143759.227105-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12806

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f4673e52dbab9d890d236ed75264653bcd43bac1 upstream.

The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ7 for ETH0 and
ETH1 respectively.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102221815.273719-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 931efc07d6fb..49ecd33aeeb8 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -6,6 +6,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irqc-rzg2l.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
 
 / {
@@ -77,6 +78,8 @@ phy0: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ2 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -104,6 +107,8 @@ phy1: ethernet-phy@7 {
 		compatible = "ethernet-phy-id0022.1640",
 			     "ethernet-phy-ieee802.3-c22";
 		reg = <7>;
+		interrupt-parent = <&irqc>;
+		interrupts = <RZG2L_IRQ7 IRQ_TYPE_LEVEL_LOW>;
 		rxc-skew-psec = <2400>;
 		txc-skew-psec = <2400>;
 		rxdv-skew-psec = <0>;
@@ -151,7 +156,8 @@ eth0_pins: eth0 {
 			 <RZG2L_PORT_PINMUX(3, 2, 1)>, /* ET0_RXD0 */
 			 <RZG2L_PORT_PINMUX(3, 3, 1)>, /* ET0_RXD1 */
 			 <RZG2L_PORT_PINMUX(4, 0, 1)>, /* ET0_RXD2 */
-			 <RZG2L_PORT_PINMUX(4, 1, 1)>; /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(4, 1, 1)>, /* ET0_RXD3 */
+			 <RZG2L_PORT_PINMUX(5, 1, 7)>; /* IRQ2 */
 	};
 
 	eth1_pins: eth1 {
@@ -169,7 +175,8 @@ eth1_pins: eth1 {
 			 <RZG2L_PORT_PINMUX(9, 1, 1)>, /* ET1_RXD0 */
 			 <RZG2L_PORT_PINMUX(9, 2, 1)>, /* ET1_RXD1 */
 			 <RZG2L_PORT_PINMUX(9, 3, 1)>, /* ET1_RXD2 */
-			 <RZG2L_PORT_PINMUX(10, 0, 1)>; /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(10, 0, 1)>, /* ET1_RXD3 */
+			 <RZG2L_PORT_PINMUX(18, 5, 1)>; /* IRQ7 */
 	};
 
 	sdhi0_emmc_pins: sd0emmc {
-- 
2.25.1


