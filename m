Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8661E9271B
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 08:42:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.40132.1766997764468157589
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 00:42:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: X5gGYc6uQH2l0gMfR/wbAg==
X-CSE-MsgGUID: rClaFxsXTuSt+TYMmcJB7g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2025 17:42:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.6])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 066AA400494A;
	Mon, 29 Dec 2025 17:42:47 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12-y.cip 5/5] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Fix pinctrl node name for GBETH1
Date: Mon, 29 Dec 2025 08:42:37 +0000
Message-ID: <20251229084237.3634-6-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
References: <20251229084237.3634-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 08:42:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21247

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ed62c3807d3310f555ff02c1cd9b071d69faa38e upstream.

Rename the GBETH1 pinctrl node from "eth0" to "eth1" to avoid duplicate
node names in the DT and correctly reflect the label "eth1_pins".

Fixes: f111192baa80 ("arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable GBETH")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250703235544.715433-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index d6c392f79f33..b3e68e1a9f03 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -157,7 +157,7 @@ eth0_pins: eth0 {
 		output-enable;
 	};
 
-	eth1_pins: eth0 {
+	eth1_pins: eth1 {
 		pins = "ET1_TXC_TXCLK";
 		output-enable;
 	};
-- 
2.51.0


