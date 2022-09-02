Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0107FC6FA83
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.4682.1662111927256305315
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="133482110"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B44CD400CF08;
	Fri,  2 Sep 2022 18:45:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 24/25] arm64: dts: renesas: rzg2ul-smarc: Enable
 RSPI1 on carrier board
Date: Fri,  2 Sep 2022 10:44:26 +0100
Message-Id: <20220902094427.116227-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9450

commit ea25b1836f57e91e2432b315727fc3f3b8c92872 upstream.

RSPI1 (SPI1) interface is available on PMOD0 connector (J1) on the
carrier board.  This patch adds pinmux and spi1 nodes to the carrier
board dtsi file and drops deleting pinctl* properties from board
DTS file.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220608173025.22792-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts | 6 ------
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi  | 7 +++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi      | 6 ++++++
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index 2d740bd420ca..121e55282d18 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -13,9 +13,3 @@ / {
 	model = "Renesas SMARC EVK based on r9a07g043u11";
 	compatible = "renesas,smarc-evk", "renesas,r9a07g043u11", "renesas,r9a07g043";
 };
-
-&spi1 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index a663115f5aae..19bdb52b8531 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -209,6 +209,13 @@ sd0_mux_uhs {
 			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
 		};
 	};
+
+	spi1_pins: rspi1 {
+		pinmux = <RZG2L_PORT_PINMUX(4, 0, 2)>, /* CK */
+			 <RZG2L_PORT_PINMUX(4, 1, 2)>, /* MOSI */
+			 <RZG2L_PORT_PINMUX(4, 2, 2)>, /* MISO */
+			 <RZG2L_PORT_PINMUX(4, 3, 2)>; /* SSL */
+	};
 };
 
 #if (SW_SW0_DEV_SEL)
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index 0051634d7b1c..f9835c12023e 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -51,6 +51,12 @@ &snd_rzg2l {
 	status = "disabled";
 };
 
+&spi1 {
+	/delete-property/ pinctrl-0;
+	/delete-property/ pinctrl-names;
+	status = "disabled";
+};
+
 &ssi1 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-names;
-- 
2.25.1


