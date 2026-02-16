Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82F8E81A3A
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 15:18:33 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.21693.1771255104154438987
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 07:18:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 6o5fXuQ7SP6qvOUE21v8lA==
X-CSE-MsgGUID: EmO+E918THqJPmk/T/fKRQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 17 Feb 2026 00:18:27 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 062FA4006C63;
	Tue, 17 Feb 2026 00:18:25 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 3/3] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Rename fixed regulator node names
Date: Mon, 16 Feb 2026 15:18:19 +0000
Message-ID: <20260216151819.92667-4-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
References: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 15:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21888

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c0cd5213d409994f65ebd900f7f54d6d7a6435a4 upstream.

Rename "regulator0" to "regulator-0p8v" and "regulator1" to
"regulator-3p3v" for consistency as done in the RZ/V2N EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250620121045.56114-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index 380e8c706a29..a2c8509648b6 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -69,7 +69,7 @@ memory@240000000 {
 		reg = <0x2 0x40000000 0x2 0x00000000>;
 	};
 
-	reg_0p8v: regulator0 {
+	reg_0p8v: regulator-0p8v {
 		compatible = "regulator-fixed";
 
 		regulator-name = "fixed-0.8V";
@@ -88,7 +88,7 @@ reg_1p8v: regulator-1p8v {
 		regulator-always-on;
 	};
 
-	reg_3p3v: regulator1 {
+	reg_3p3v: regulator-3p3v {
 		compatible = "regulator-fixed";
 
 		regulator-name = "fixed-3.3V";
-- 
2.51.0


