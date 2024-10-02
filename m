Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB5CF6D50
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:04:52 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1054.1727888691447172225
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:04:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579658"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:04:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4AE79402586C;
	Thu,  3 Oct 2024 02:04:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 14/16] arm64: dts: renesas: r9a07g043u: Add VSPD node
Date: Wed,  2 Oct 2024 18:04:07 +0100
Message-ID: <20241002170417.655339-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
References: <20241002170417.655339-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:04:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16962

commit 6bfd974d03a433e7fa9d5444f89851e4e4eb9779 upstream.

Add VSPD node to RZ/G2UL SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240805131709.101679-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index 2af4583fcd07..b24ca968afcc 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -128,6 +128,19 @@ csi2cru: endpoint@0 {
 		};
 	};
 
+	vspd: vsp@10870000 {
+		compatible = "renesas,r9a07g043u-vsp2", "renesas,r9a07g044-vsp2";
+		reg = <0 0x10870000 0 0x10000>;
+		interrupts = <SOC_PERIPHERAL_IRQ(149) IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD R9A07G043_LCDC_CLK_A>,
+			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_P>,
+			 <&cpg CPG_MOD R9A07G043_LCDC_CLK_D>;
+		clock-names = "aclk", "pclk", "vclk";
+		power-domains = <&cpg>;
+		resets = <&cpg R9A07G043_LCDC_RESET_N>;
+		renesas,fcp = <&fcpvd>;
+	};
+
 	fcpvd: fcp@10880000 {
 		compatible = "renesas,r9a07g043u-fcpvd", "renesas,fcpv";
 		reg = <0 0x10880000 0 0x10000>;
-- 
2.43.0


