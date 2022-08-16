Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F81C28B2B
	for <webhook@archiver.kernel.org>; Tue, 16 Aug 2022 12:34:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.15100.1660653294204212629
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Aug 2022 05:34:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,241,1654527600";
   d="scan'208";a="131578412"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2022 21:34:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 118BD402D0A4;
	Tue, 16 Aug 2022 21:34:51 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/31] arm64: dts: renesas: r9a07g054: Fillup the
 sbc stub node
Date: Tue, 16 Aug 2022 13:33:58 +0100
Message-Id: <20220816123406.27553-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220816123406.27553-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Aug 2022 12:34:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9242

commit 8d3da65c4c40d77977799f58fa6465bdc723536f upstream.

Fillup the sbc stub node in RZ/V2L (R9A07G054) SoC DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220227203744.18355-7-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index fafb986fe3bc..1207a99bf3fe 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -398,12 +398,20 @@
 		};
 
 		sbc: spi@10060000 {
+			compatible = "renesas,r9a07g054-rpc-if",
+				     "renesas,rzg2l-rpc-if";
 			reg = <0 0x10060000 0 0x10000>,
 			      <0 0x20000000 0 0x10000000>,
 			      <0 0x10070000 0 0x10000>;
+			reg-names = "regs", "dirmap", "wbuf";
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD R9A07G054_SPI_CLK2>,
+				 <&cpg CPG_MOD R9A07G054_SPI_CLK>;
+			resets = <&cpg R9A07G054_SPI_RST>;
+			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* place holder */
+			status = "disabled";
 		};
 
 		cpg: clock-controller@11010000 {
-- 
2.17.1


