Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E83EDB7FE
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 10:58:35 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.78638.1775559492699210337
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Apr 2026 03:58:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: vbCy1yKOSqiPkvo7e4y6LA==
X-CSE-MsgGUID: edQNDu4RTPa4/R8qNtygnQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 07 Apr 2026 19:58:26 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.188])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 67E1A400754E;
	Tue,  7 Apr 2026 19:58:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/10] arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable CANFD
Date: Tue,  7 Apr 2026 11:58:07 +0100
Message-ID: <20260407105808.15196-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260407105808.15196-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Apr 2026 10:58:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22630

commit d3112a820ccfe9a39c171fe3bc313794f1325711 upstream.

Enable CANFD channel 0, which is available on the CN55 connector.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251224175204.3400062-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: fixed merge conflict]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
index b99bdf5bfdd69..ebb6ebb9cdcf9 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g077m44-rzt2h-evk.dts
@@ -165,6 +165,16 @@ channel@5 {
 	};
 };
 
+&canfd {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	channel0 {
+		status = "okay";
+	};
+};
+
 &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	pinctrl-names = "default";
@@ -193,6 +203,17 @@ &mdio2_phy {
 };
 
 &pinctrl {
+	/*
+	 * CAN0 Pin Configuration:
+	 *
+	 * SW7[1] OFF; SW7[2] ON - Use P24_4 as CANTX0.
+	 * SW7[3] OFF; SW7[4] ON - Use P24_3 as CANRX0.
+	 */
+	can0_pins: can0-pins {
+		pinmux = <RZT2H_PORT_PINMUX(24, 3, 0x19)>, /* CANRX0 */
+			 <RZT2H_PORT_PINMUX(24, 4, 0x19)>; /* CANTX0 */
+	};
+
 	/*
 	 * GMAC2 Pin Configuration:
 	 *
-- 
2.43.0


