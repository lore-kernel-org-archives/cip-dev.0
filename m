Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821A1C52CDC
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59157.1722267092806798109
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908961"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 94B314006A90;
	Tue, 30 Jul 2024 00:31:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/13] arm64: dts: renesas: rz-smarc: Replace fixed regulator for USB VBUS
Date: Mon, 29 Jul 2024 16:30:48 +0100
Message-ID: <20240729153109.510325-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16663

commit c1267e1afae60e0b1d17d3a2e55515ecccb22a3e upstream.

Replace the fixed regulator for USB VBUS and use the proper one that
controls regulator based on VBUS detection.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240702180032.207275-5-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
index 48b839a6eae4..90b20324c5d1 100644
--- a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
@@ -54,14 +54,6 @@ codec_dai: simple-audio-card,codec {
 		};
 	};
 
-	usb0_vbus_otg: regulator-usb0-vbus-otg {
-		compatible = "regulator-fixed";
-
-		regulator-name = "USB0_VBUS_OTG";
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-	};
-
 	vccq_sdhi1: regulator-vccq-sdhi1 {
 		compatible = "regulator-gpio";
 		regulator-name = "SDHI1 VccQ";
@@ -139,6 +131,9 @@ &ohci1 {
 
 &phyrst {
 	status = "okay";
+	usb0_vbus_otg: regulator-vbus {
+		regulator-name = "vbus";
+	};
 };
 
 &scif0 {
-- 
2.43.0


