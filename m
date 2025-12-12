Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F65FD59F52
	for <webhook@archiver.kernel.org>; Fri, 12 Dec 2025 21:39:04 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4863.1765575534934041713
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Dec 2025 13:39:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: xhBDNJrhQoyzWVtXKxHz/Q==
X-CSE-MsgGUID: 6bwmzl0mS7mVLr7lNrut6g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 13 Dec 2025 06:39:01 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.53])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 05ED740071F7;
	Sat, 13 Dec 2025 06:38:59 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 4/4] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable WDT1
Date: Fri, 12 Dec 2025 21:38:43 +0000
Message-ID: <20251212213843.24018-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
References: <20251212213843.24018-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Dec 2025 21:39:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21003

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f3e57b92340400e99d0b6341c40692c5cb5ab774 upstream.

Enable WDT1 hardware block on the RZ/V2N EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514101528.41663-9-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index d33a28521c9f..3e0606a8c034 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -153,3 +153,7 @@ &sdhi1 {
 	sd-uhs-sdr104;
 	status = "okay";
 };
+
+&wdt1 {
+	status = "okay";
+};
-- 
2.51.0


