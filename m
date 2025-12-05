Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A54D32D8F
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:34:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6944.1764945237663626403
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: +3LGbEJ3RYqjIiXpG8fPVw==
X-CSE-MsgGUID: ndb4cVZESl+2WjhjzTntvA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:34:07 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4C417417C326;
	Fri,  5 Dec 2025 23:34:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 38/38] arm64: dts: renesas: rzt2h-n2h-evk-common: Add pinctrl for SCI0 node
Date: Fri,  5 Dec 2025 14:32:58 +0000
Message-ID: <20251205143258.13748-39-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:34:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20952

commit 1366c160df036d5596240ea4b36b88afe2cd0d2a upstream.

Add pinctrl for SCI0 node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250820200659.2048755-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/rzt2h-n2h-evk-common.dtsi  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 66d97059c47c9..245b70f1557fe 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -23,6 +23,23 @@ &extal_clk {
 	clock-frequency = <25000000>;
 };
 
+&pinctrl {
+	/*
+	 * SCI0 Pin Configuration:
+	 * ------------------------
+	 * Signal     | Pin     | RZ/T2H (SW4) | RZ/N2H (DSW9)
+	 * -----------|---------|--------------|---------------
+	 * SCI0_RXD   | P27_4   | 5: ON, 6: OFF| 1: ON, 2: OFF
+	 * SCI0_TXD   | P27_5   | 7: ON, 8: OFF| 3: ON, 4: OFF
+	 */
+	sci0_pins: sci0-pins {
+		pinmux = <RZT2H_PORT_PINMUX(27, 4, 0x14)>,
+			 <RZT2H_PORT_PINMUX(27, 5, 0x14)>;
+	};
+};
+
 &sci0 {
+	pinctrl-0 = <&sci0_pins>;
+	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.43.0


