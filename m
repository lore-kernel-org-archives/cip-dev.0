Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4D0C7EE29
	for <webhook@archiver.kernel.org>; Tue, 13 Jun 2023 13:24:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.13027.1686662641799362894
 for <cip-dev@lists.cip-project.org>;
 Tue, 13 Jun 2023 06:24:02 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,239,1681138800"; 
   d="scan'208";a="163405959"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jun 2023 22:24:01 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E6C2426DCD0;
	Tue, 13 Jun 2023 22:23:58 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 7/7] arm64: dts: renesas: rzv2mevk2: Add uart0 pins
Date: Tue, 13 Jun 2023 14:23:39 +0100
Message-Id: <20230613132339.150671-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
References: <20230613132339.150671-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 13 Jun 2023 13:24:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11987

commit 6ec5791375954411640871fec6a7df2cb5365a86 upstream.

Add uart0 pins in pinctrl node and update the uart0 node
to include pinctrl and uart-has-rtscts properties.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230209131422.192941-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index 78f5af4646ce..0f170fd4227b 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -127,9 +127,20 @@ i2c2_pins: i2c2 {
 		pinmux = <RZV2M_PORT_PINMUX(3, 8, 2)>, /* SDA */
 			 <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
 	};
+
+	uart0_pins: uart0 {
+		pinmux = <RZV2M_PORT_PINMUX(3, 0, 2)>, /* UATX0 */
+			 <RZV2M_PORT_PINMUX(3, 1, 2)>, /* UARX0 */
+			 <RZV2M_PORT_PINMUX(3, 2, 2)>, /* UACTS0N */
+			 <RZV2M_PORT_PINMUX(3, 3, 2)>; /* UARTS0N */
+	};
 };
 
 &uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
 	status = "okay";
 };
 
-- 
2.25.1


