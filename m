Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AD5C4167B
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 13:47:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.84378.1701956855834620741
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Dec 2023 05:47:38 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,256,1695654000"; 
   d="scan'208";a="185671007"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 07 Dec 2023 22:47:37 +0900
Received: from localhost.localdomain (unknown [10.226.93.153])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C08B042B1D29;
	Thu,  7 Dec 2023 22:47:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 17/18] arm64: dts: renesas: r9a07g054: Add fcpvd node
Date: Thu,  7 Dec 2023 13:46:56 +0000
Message-Id: <20231207134657.371420-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
References: <20231207134657.371420-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Dec 2023 13:47:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13860

commit fad741768e7b9572fad05fe4523c76a236c4056a upstream.

Add fcpvd node to RZ/V2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230411100346.299768-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 2d3674bc8567..7776cf6f5063 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -653,6 +653,18 @@ sbc: spi@10060000 {
 			status = "disabled";
 		};
 
+		fcpvd: fcp@10880000 {
+			compatible = "renesas,r9a07g054-fcpvd",
+				     "renesas,fcpv";
+			reg = <0 0x10880000 0 0x10000>;
+			clocks = <&cpg CPG_MOD R9A07G054_LCDC_CLK_A>,
+				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_P>,
+				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_D>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G054_LCDC_RESET_N>;
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g054-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.25.1


