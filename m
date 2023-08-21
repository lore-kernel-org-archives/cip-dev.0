Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B26DEE49AA
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1004.1692628688570230402
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="173473027"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1AA62400754E;
	Mon, 21 Aug 2023 23:38:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/15] arm64: dts: renesas: rzg2ul-smarc: Move spi1 pinmux to carrier board DTSI
Date: Mon, 21 Aug 2023 15:37:46 +0100
Message-Id: <20230821143759.227105-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12796

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit affab0af979a331adae2d1f7f86afe8ecf81b5fc upstream.

spi1 is available on the RZ/G2UL SMARC EVK carrier board (PMOD0), hence
moving the spi1 pinmux from SoM to carrier board. This is to keep
consistency with the other SMARC EVKs.

Also while moving the pinmux rename rspi1 to spi1 to be consistent with
other SMARC EVK DTSIs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220921082221.10599-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi | 7 +++++++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi         | 7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
index bd8bc858c28c..58923dc83faa 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -99,6 +99,13 @@ sound_clk_pins: sound_clk {
 		input-enable;
 	};
 
+	spi1_pins: spi1 {
+		pinmux = <RZG2L_PORT_PINMUX(4, 0, 2)>, /* CK */
+			 <RZG2L_PORT_PINMUX(4, 1, 2)>, /* MOSI */
+			 <RZG2L_PORT_PINMUX(4, 2, 2)>, /* MISO */
+			 <RZG2L_PORT_PINMUX(4, 3, 2)>; /* SSL */
+	};
+
 	ssi1_pins: ssi1 {
 		pinmux = <RZG2L_PORT_PINMUX(3, 0, 2)>, /* BCK */
 			 <RZG2L_PORT_PINMUX(3, 1, 2)>, /* RCK */
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 2a0feb53f0dc..931efc07d6fb 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -221,13 +221,6 @@ sd0_mux_uhs {
 			pinmux = <RZG2L_PORT_PINMUX(0, 0, 1)>; /* SD0_CD */
 		};
 	};
-
-	spi1_pins: rspi1 {
-		pinmux = <RZG2L_PORT_PINMUX(4, 0, 2)>, /* CK */
-			 <RZG2L_PORT_PINMUX(4, 1, 2)>, /* MOSI */
-			 <RZG2L_PORT_PINMUX(4, 2, 2)>, /* MISO */
-			 <RZG2L_PORT_PINMUX(4, 3, 2)>; /* SSL */
-	};
 };
 
 #if (SW_SW0_DEV_SEL)
-- 
2.25.1


