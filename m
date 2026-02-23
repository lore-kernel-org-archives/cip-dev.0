Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64582E98E1F
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 10:28:14 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32575.1771842481133845971
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 02:28:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: KLfOEvFlThuXjXzu0XDa1A==
X-CSE-MsgGUID: z8L69NBcRMO3VMszwv0E0w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Feb 2026 19:28:07 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7C088401A659;
	Mon, 23 Feb 2026 19:28:06 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4/4] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable Mali-G31 GPU
Date: Mon, 23 Feb 2026 10:27:57 +0000
Message-ID: <20260223102758.119908-5-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
References: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 10:28:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21916

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit e3b7980d39116082106a8b3cd067dd8258c94e74 upstream.

Enable the Mali-G31 GPU on the RZ/V2N EVK.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514101528.41663-11-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index b7abc0fc5701..a636ca77bdfc 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -39,6 +39,15 @@ memory@48000000 {
 		reg = <0x0 0x48000000 0x1 0xf8000000>;
 	};
 
+	reg_0p8v: regulator-0p8v {
+		compatible = "regulator-fixed";
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
@@ -93,6 +102,11 @@ &eth1 {
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
2.34.1


