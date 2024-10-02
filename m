Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AA5CF6D53
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:32 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1137.1727888849299391325
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:29 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="220602759"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8D6164006191;
	Thu,  3 Oct 2024 02:07:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 01/15] arm64: dts: renesas: r9a07g0{43,44,54}: Move regulator-vbus device node
Date: Wed,  2 Oct 2024 18:06:50 +0100
Message-ID: <20241002170712.655449-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16969

commit bdfa062d14b22e36207c219206b2bf770d5363b3 upstream.

Move regulator-vbus device node from common to the usbphy-ctrl device node
of the individual SoC dtsi's as it embeds the vbus regulator.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240715140705.334183-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi       | 4 ++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi       | 4 ++++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi       | 4 ++++
 arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi | 3 ---
 4 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 6212ee550f33..7b07bcb3be88 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -725,6 +725,10 @@ phyrst: usbphy-ctrl@11c40000 {
 			power-domains = <&cpg>;
 			#reset-cells = <1>;
 			status = "disabled";
+
+			usb0_vbus_otg: regulator-vbus {
+				regulator-name = "vbus";
+			};
 		};
 
 		ohci0: usb@11c50000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index f05e27a90979..267fbfcccc2b 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -1050,6 +1050,10 @@ phyrst: usbphy-ctrl@11c40000 {
 			power-domains = <&cpg>;
 			#reset-cells = <1>;
 			status = "disabled";
+
+			usb0_vbus_otg: regulator-vbus {
+				regulator-name = "vbus";
+			};
 		};
 
 		ohci0: usb@11c50000 {
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 994cc88e6e3e..a5c3a68c1e01 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -1058,6 +1058,10 @@ phyrst: usbphy-ctrl@11c40000 {
 			power-domains = <&cpg>;
 			#reset-cells = <1>;
 			status = "disabled";
+
+			usb0_vbus_otg: regulator-vbus {
+				regulator-name = "vbus";
+			};
 		};
 
 		ohci0: usb@11c50000 {
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
index 90b20324c5d1..111c5f0ecec0 100644
--- a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
@@ -131,9 +131,6 @@ &ohci1 {
 
 &phyrst {
 	status = "okay";
-	usb0_vbus_otg: regulator-vbus {
-		regulator-name = "vbus";
-	};
 };
 
 &scif0 {
-- 
2.43.0


