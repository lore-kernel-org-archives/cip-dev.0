Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E798FCCFA05
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:38:06 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11655.1762425463946013726
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:37:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: ZqTChWYmTpuYfVgsrno9Bw==
X-CSE-MsgGUID: xaRf1ZOyQgexe288ROhmmg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2025 19:37:57 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 589F84003FD6;
	Thu,  6 Nov 2025 19:37:56 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 9/9] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name for GBETH1
Date: Thu,  6 Nov 2025 10:37:38 +0000
Message-ID: <20251106103738.28911-10-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
References: <20251106103738.28911-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:38:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20449

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ffcc8c2e97ca29494687201557fd984d16d5cc4c upstream.

Rename the GBETH1 pinctrl node from "eth0" to "eth1" to avoid duplicate
node names in the DT and correctly reflect the label "eth1_pins".

Fixes: 802292ee27a7 ("arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250703235544.715433-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 6ddc1746aa5a..a53ef16c2b1e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -218,7 +218,7 @@ eth0_pins: eth0 {
 		output-enable;
 	};
 
-	eth1_pins: eth0 {
+	eth1_pins: eth1 {
 		pins = "ET1_TXC_TXCLK";
 		output-enable;
 	};
-- 
2.51.0


