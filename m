Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75B6C19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:09 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.152.1659545646492541407
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="128394715"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:04 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 955D540B10E9;
	Thu,  4 Aug 2022 01:54:02 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/13] arm64: dts: renesas: rzg2lc-smarc: Enable
 CANFD channel 1
Date: Wed,  3 Aug 2022 17:53:46 +0100
Message-Id: <20220803165358.2156150-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9071

commit 46da632734a5979090ef588d9da40367581fd400 upstream.

On RZ/G2LC SMARC EVK, CAN0 is not populated.

CAN1 is multiplexed with SCIF1 using SW1[3] or RSPI using SW1[4].

This patch adds support for the CAN1 interface on RZ/G2LC SMARC EVK.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220203170636.7747-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  6 -----
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi | 23 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 13 +++++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index 50abdabc374a..5a5cea82a5d9 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -14,12 +14,6 @@ / {
 	compatible = "renesas,smarc-evk", "renesas,r9a07g044c2", "renesas,r9a07g044";
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
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
index ec9e08ec0822..bff56d696936 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
@@ -17,6 +17,14 @@ scif0_pins: scif0 {
 			 <RZG2L_PORT_PINMUX(38, 1, 1)>;	/* RxD */
 	};
 
+#if SW_SCIF_CAN
+	/* SW8 should be at position 2->1 */
+	can1_pins: can1 {
+		pinmux = <RZG2L_PORT_PINMUX(40, 0, 3)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(40, 1, 3)>; /* RxD */
+	};
+#endif
+
 	scif1_pins: scif1 {
 		pinmux = <RZG2L_PORT_PINMUX(40, 0, 1)>, /* TxD */
 			 <RZG2L_PORT_PINMUX(40, 1, 1)>, /* RxD */
@@ -24,6 +32,21 @@ scif1_pins: scif1 {
 			 <RZG2L_PORT_PINMUX(41, 1, 1)>; /* RTS# */
 	};
 
+#if SW_RSPI_CAN
+	/* SW8 should be at position 2->3 so that GPIO9_CAN1_STB line is activated */
+	can1-stb {
+		gpio-hog;
+		gpios = <RZG2L_GPIO(44, 3) GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "can1_stb";
+	};
+
+	can1_pins: can1 {
+		pinmux = <RZG2L_PORT_PINMUX(44, 0, 3)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(44, 1, 3)>; /* RxD */
+	};
+#endif
+
 	sd1-pwr-en-hog {
 		gpio-hog;
 		gpios = <RZG2L_GPIO(39, 2) GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index 1b59ef376296..28f21c287ba3 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -44,6 +44,19 @@ aliases {
 	};
 };
 
+#if (SW_SCIF_CAN || SW_RSPI_CAN)
+&canfd {
+	pinctrl-0 = <&can1_pins>;
+	/delete-node/ channel@0;
+};
+#else
+&canfd {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	status = "disabled";
+};
+#endif
+
 /*
  * To enable SCIF1 (SER0) on PMOD1 (CN7), On connector board
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.25.1


