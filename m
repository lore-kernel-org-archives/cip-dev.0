Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB62ECAAD5
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.4682.1662111927256305315
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:27 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="133482104"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AABB4400A11F;
	Fri,  2 Sep 2022 18:45:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 22/25] arm64: dts: renesas: r9a07g043: Add SPI
 Multi I/O Bus controller node
Date: Fri,  2 Sep 2022 10:44:24 +0100
Message-Id: <20220902094427.116227-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9448

commit 470218e29daf7f1de9f4d1af16c7ecf54344f6a1 upstream.

Add SPI Multi I/O Bus controller node to R9A07G043 (RZ/G2UL) SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220502190155.84496-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 9048edb5e2b1..b31fb713ae4d 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -498,12 +498,19 @@ tsu: thermal@10059400 {
 		};
 
 		sbc: spi@10060000 {
+			compatible = "renesas,r9a07g043-rpc-if",
+				     "renesas,rzg2l-rpc-if";
 			reg = <0 0x10060000 0 0x10000>,
 			      <0 0x20000000 0 0x10000000>,
 			      <0 0x10070000 0 0x10000>;
+			reg-names = "regs", "dirmap", "wbuf";
+			clocks = <&cpg CPG_MOD R9A07G043_SPI_CLK2>,
+				 <&cpg CPG_MOD R9A07G043_SPI_CLK>;
+			resets = <&cpg R9A07G043_SPI_RST>;
+			power-domains = <&cpg>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			/* place holder */
+			status = "disabled";
 		};
 
 		cpg: clock-controller@11010000 {
-- 
2.25.1


