Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BDBC10DC1
	for <webhook@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.35277.1702041653355936297
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Dec 2023 05:20:53 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,260,1695654000"; 
   d="scan'208";a="189673983"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Dec 2023 22:20:52 +0900
Received: from localhost.localdomain (unknown [10.226.92.254])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2A56940065A7;
	Fri,  8 Dec 2023 22:20:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 19/25] arm64: dts: renesas: r9a07g054: [HACK DO NOT APPLY] Add DU node
Date: Fri,  8 Dec 2023 13:20:01 +0000
Message-Id: <20231208132007.108762-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
References: <20231208132007.108762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Dec 2023 13:20:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13962

Add DU node to RZ/V2L SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index c4b6d051692c..bc86b751f5d2 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -707,6 +707,21 @@ fcpvd: fcp@10880000 {
 			resets = <&cpg R9A07G054_LCDC_RESET_N>;
 		};
 
+		du: display@10890000 {
+			compatible = "renesas,r9a07g054-du",
+				     "renesas,r9a07g044-du";
+			reg = <0 0x10890000 0 0x10000>;
+			interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_LCDC_CLK_A>,
+				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_P>,
+				 <&cpg CPG_MOD R9A07G054_LCDC_CLK_D>;
+			clock-names = "aclk", "pclk", "vclk";
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G054_LCDC_RESET_N>;
+			renesas,vsps = <&vspd 0>;
+			status = "disabled";
+		};
+
 		cpg: clock-controller@11010000 {
 			compatible = "renesas,r9a07g054-cpg";
 			reg = <0 0x11010000 0 0x10000>;
-- 
2.25.1


