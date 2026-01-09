Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9865BD1A605
	for <webhook@archiver.kernel.org>; Fri,  9 Jan 2026 12:16:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8763.1767960987957835683
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Jan 2026 04:16:36 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: UECK8iEiREiu6QX2CBHCfg==
X-CSE-MsgGUID: B0h5pMqoTFCiutcZzlG7qQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 09 Jan 2026 21:16:35 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.57])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76A00401DE03;
	Fri,  9 Jan 2026 21:16:34 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 6/8] arm64: dts: renesas: r9a09g057: Add RTC node
Date: Fri,  9 Jan 2026 12:16:20 +0000
Message-ID: <20260109121622.46030-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
References: <20260109121622.46030-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Jan 2026 12:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21513

commit cfc733da4e79018f88d8ac5f3a5306abbba8ef89 upstream.

Add RTC node to Renesas RZ/V2H ("R9A09G057") SoC DTSI.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251107210706.45044-4-ovidiu.panait.rb@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 7cfdf9db851d..3eaa9b2698af 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -557,6 +557,21 @@ wdt3: watchdog@13000400 {
 			status = "disabled";
 		};
 
+		rtc: rtc@11c00800 {
+			compatible = "renesas,r9a09g057-rtca3", "renesas,rz-rtca3";
+			reg = <0 0x11c00800 0 0x400>;
+			interrupts = <GIC_SPI 524 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 525 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 526 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "alarm", "period", "carry";
+			clocks = <&cpg CPG_MOD 0x53>, <&rtxin_clk>;
+			clock-names = "bus", "counter";
+			power-domains = <&cpg>;
+			resets = <&cpg 0x79>, <&cpg 0x7a>;
+			reset-names = "rtc", "rtest";
+			status = "disabled";
+		};
+
 		scif: serial@11c01400 {
 			compatible = "renesas,scif-r9a09g057";
 			reg = <0 0x11c01400 0 0x400>;
-- 
2.51.0


