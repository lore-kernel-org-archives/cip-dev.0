Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03D4FA3740
	for <webhook@archiver.kernel.org>; Tue, 25 Oct 2022 14:41:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.7910.1666708896535930741
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Oct 2022 07:41:44 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.95,212,1661785200"; 
   d="scan'208";a="137874095"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Oct 2022 23:41:43 +0900
Received: from localhost.localdomain (unknown [10.226.92.152])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1D8DB43684FB;
	Tue, 25 Oct 2022 23:41:41 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/12] arm64: dts: renesas: r9a07g043: Add DMA support to RSPI
Date: Tue, 25 Oct 2022 15:41:23 +0100
Message-Id: <20221025144131.1309463-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
References: <20221025144131.1309463-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Oct 2022 14:41:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9825

commit 200d8e0119fd8fef78fa1c6441ef9eb2c1570984 upstream.

Add DMA properties to RSPI nodes to support DMA operation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220728122312.189766-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 313424b00f4b..2467e00e49c8 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -196,6 +196,8 @@ spi0: spi@1004ac00 {
 			interrupt-names = "error", "rx", "tx";
 			clocks = <&cpg CPG_MOD R9A07G043_RSPI0_CLKB>;
 			resets = <&cpg R9A07G043_RSPI0_RST>;
+			dmas = <&dmac 0x2e95>, <&dmac 0x2e96>;
+			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
 			num-cs = <1>;
 			#address-cells = <1>;
@@ -212,6 +214,8 @@ spi1: spi@1004b000 {
 			interrupt-names = "error", "rx", "tx";
 			clocks = <&cpg CPG_MOD R9A07G043_RSPI1_CLKB>;
 			resets = <&cpg R9A07G043_RSPI1_RST>;
+			dmas = <&dmac 0x2e99>, <&dmac 0x2e9a>;
+			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
 			num-cs = <1>;
 			#address-cells = <1>;
@@ -228,6 +232,8 @@ spi2: spi@1004b400 {
 			interrupt-names = "error", "rx", "tx";
 			clocks = <&cpg CPG_MOD R9A07G043_RSPI2_CLKB>;
 			resets = <&cpg R9A07G043_RSPI2_RST>;
+			dmas = <&dmac 0x2e9d>, <&dmac 0x2e9e>;
+			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
 			num-cs = <1>;
 			#address-cells = <1>;
-- 
2.25.1


