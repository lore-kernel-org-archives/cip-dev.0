Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D542EEB56D
	for <webhook@archiver.kernel.org>; Wed, 31 Dec 2025 17:01:03 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.88804.1767200431635644184
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Dec 2025 09:00:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: j/j75ONySGWkRPw+FbBc/g==
X-CSE-MsgGUID: 2S0i70+nSmS6jedTSTkGiA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jan 2026 02:00:55 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.9])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id BD7FB402412E;
	Thu,  1 Jan 2026 02:00:53 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/17] arm64: dts: renesas: r9a09g077: Add WDT nodes
Date: Wed, 31 Dec 2025 17:00:24 +0000
Message-ID: <20251231170026.17006-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251231170026.17006-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Dec 2025 17:01:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21294

commit 19adb35f9dccd16df111f2d0ec265d572f8bb3f5 upstream.

Add WDT0-5 nodes to RZ/T2H (R9A09G077) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250821161946.1096033-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index da7aa2e3b043e..74ab90b92c96d 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -90,6 +90,66 @@ sci0: serial@80005000 {
 			status = "disabled";
 		};
 
+		wdt0: watchdog@80082000 {
+			compatible = "renesas,r9a09g077-wdt";
+			reg = <0 0x80082000 0 0x400>,
+			      <0 0x81295100 0 0x04>;
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
+			clock-names = "pclk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt1: watchdog@80082400 {
+			compatible = "renesas,r9a09g077-wdt";
+			reg = <0 0x80082400 0 0x400>,
+			      <0 0x81295104 0 0x04>;
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
+			clock-names = "pclk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt2: watchdog@80082800 {
+			compatible = "renesas,r9a09g077-wdt";
+			reg = <0 0x80082800 0 0x400>,
+			      <0 0x81295108 0 0x04>;
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
+			clock-names = "pclk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt3: watchdog@80082c00 {
+			compatible = "renesas,r9a09g077-wdt";
+			reg = <0 0x80082c00 0 0x400>,
+			      <0 0x8129510c 0 0x04>;
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
+			clock-names = "pclk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt4: watchdog@80083000 {
+			compatible = "renesas,r9a09g077-wdt";
+			reg = <0 0x80083000 0 0x400>,
+			      <0 0x81295110 0 0x04>;
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
+			clock-names = "pclk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		wdt5: watchdog@80083400 {
+			compatible = "renesas,r9a09g077-wdt";
+			reg = <0 0x80083400 0 0x400>,
+			      <0 0x81295114 0 0x04>;
+			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
+			clock-names = "pclk";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@80088000 {
 			compatible = "renesas,riic-r9a09g077";
 			reg = <0 0x80088000 0 0x400>;
-- 
2.43.0


