Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B8AC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.134.1659545655590408986
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:25 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="128394733"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:24 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E3B6A40B10E9;
	Thu,  4 Aug 2022 01:54:22 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/13] arm64: dts: renesas: rzg2lc-smarc: Enable
 Audio
Date: Wed,  3 Aug 2022 17:53:54 +0100
Message-Id: <20220803165358.2156150-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9079

commit 4eb6a6bb8ef31491c217167ecce2c0a26fd4f34e upstream.

Enable Audio on RZ/G2LC SMARC EVK by deleting ssi0 entries from
board DT and adding pincontrol entries to the soc-pinctrl dtsi,
so that entries from common dtsi kick in and make audio functionality
operational.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220303164155.7706-5-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts         | 6 ------
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi | 7 +++++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index 52b834205126..74a2f2bade10 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -19,9 +19,3 @@ &spi1 {
 	/delete-property/ pinctrl-names;
 	status = "disabled";
 };
-
-&ssi0 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
index 1322e5bcd456..d275a55333e3 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-pinfunction.dtsi
@@ -106,6 +106,13 @@ sound_clk_pins: sound_clk {
 		input-enable;
 	};
 
+	ssi0_pins: ssi0 {
+		pinmux = <RZG2L_PORT_PINMUX(45, 0, 1)>, /* BCK */
+			 <RZG2L_PORT_PINMUX(45, 1, 1)>, /* RCK */
+			 <RZG2L_PORT_PINMUX(45, 2, 1)>, /* TXD */
+			 <RZG2L_PORT_PINMUX(45, 3, 1)>; /* RXD */
+	};
+
 	usb0_pins: usb0 {
 		pinmux = <RZG2L_PORT_PINMUX(4, 0, 1)>, /* VBUS */
 			 <RZG2L_PORT_PINMUX(5, 0, 1)>, /* OVC */
-- 
2.25.1


