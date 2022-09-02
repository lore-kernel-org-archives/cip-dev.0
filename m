Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE68C38145
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.4622.1662111914600497437
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="133482082"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:14 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0816C400CF0E;
	Fri,  2 Sep 2022 18:45:11 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/25] arm64: dts: renesas: rzg2ul-smarc: Enable
 USB2.0 support
Date: Fri,  2 Sep 2022 10:44:19 +0100
Message-Id: <20220902094427.116227-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9443

commit 094ff3485a05cd29db083a6e2905e87b68f13538 upstream.

Enable USB2.0 Host/Device support on RZ/G2UL SMARC EVK by
adding usb{0,1} pincontrol entries to the soc-pinctrl dtsi
and deleting the nodes which disabled it.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220429072400.23729-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 46 -------------------
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi | 11 +++++
 2 files changed, 11 insertions(+), 46 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 52ee1640c3c1..2d740bd420ca 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -14,54 +14,8 @@ / {
 	compatible = "renesas,smarc-evk", "renesas,r9a07g043u11", "renesas,r9a07g043";
 };
 
-&ehci0 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
-&ehci1 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
-&hsusb {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
-&ohci0 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
-&ohci1 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
-&phyrst {
-	status = "disabled";
-};
-
 &spi1 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-names;
 	status = "disabled";
 };
-
-&usb2_phy0 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
-&usb2_phy1 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index 201b70150e01..bd8bc858c28c 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -105,4 +105,15 @@ ssi1_pins: ssi1 {
 			 <RZG2L_PORT_PINMUX(3, 2, 2)>, /* TXD */
 			 <RZG2L_PORT_PINMUX(3, 3, 2)>; /* RXD */
 	};
+
+	usb0_pins: usb0 {
+		pinmux = <RZG2L_PORT_PINMUX(5, 0, 1)>, /* VBUS */
+			 <RZG2L_PORT_PINMUX(5, 2, 1)>, /* OVC */
+			 <RZG2L_PORT_PINMUX(5, 3, 1)>; /* OTG_ID */
+	};
+
+	usb1_pins: usb1 {
+		pinmux = <RZG2L_PORT_PINMUX(5, 4, 5)>, /* OVC */
+			 <RZG2L_PORT_PINMUX(6, 0, 1)>; /* VBUS */
+	};
 };
-- 
2.25.1


