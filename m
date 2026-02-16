Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA13E81A36
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 15:18:33 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21901.1771255102641506078
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 07:18:25 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Z47VpNmJSpSU+yqoEInlWA==
X-CSE-MsgGUID: mDUvfEYESFCpU2R6pqQVFA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Feb 2026 00:18:25 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E6AE4006A89;
	Tue, 17 Feb 2026 00:18:23 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 2/3] arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable Mali-G31
Date: Mon, 16 Feb 2026 15:18:18 +0000
Message-ID: <20260216151819.92667-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
References: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 15:18:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21887

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8bf8ad268e46403c7140ea5aaa85e9c659117dbc upstream.

Enable Mali-G31 (GPU) node on EVK board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250218115922.407816-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts   | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
index a75101fe848a..380e8c706a29 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g057h44-rzv2h-evk.dts
@@ -69,6 +69,16 @@ memory@240000000 {
 		reg = <0x2 0x40000000 0x2 0x00000000>;
 	};
 
+	reg_0p8v: regulator0 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "fixed-0.8V";
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	reg_1p8v: regulator-1p8v {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -152,6 +162,11 @@ &eth1 {
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+	mali-supply = <&reg_0p8v>;
+};
+
 &hsusb {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.51.0


