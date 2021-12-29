Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716B0C433F5
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 10:15:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.49376.1640772940300083487
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 02:15:56 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,244,1635174000";
   d="scan'208";a="105094699"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2021 19:15:56 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 536A0423D00D;
	Wed, 29 Dec 2021 19:15:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 18/31] arm64: dts: renesas: r9a07g044: Add DMA
 support to SSI
Date: Wed, 29 Dec 2021 10:15:17 +0000
Message-Id: <20211229101530.22783-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 10:15:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7295

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 89fe8d246a26a1a60e658a58e5099a90e4d56f6f upstream.

Add dmac phandles to SSI nodes to support DMA operation.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210921084605.16250-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 49f579856f14..4d4a23367529 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -106,6 +106,8 @@
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
 			resets = <&cpg R9A07G044_SSI0_RST_M2_REG>;
+			dmas = <&dmac 0x2655>, <&dmac 0x2656>;
+			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
@@ -125,6 +127,8 @@
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
 			resets = <&cpg R9A07G044_SSI1_RST_M2_REG>;
+			dmas = <&dmac 0x2659>, <&dmac 0x265a>;
+			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
@@ -144,6 +148,8 @@
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
 			resets = <&cpg R9A07G044_SSI2_RST_M2_REG>;
+			dmas = <&dmac 0x265f>;
+			dma-names = "rt";
 			power-domains = <&cpg>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
@@ -163,6 +169,8 @@
 				 <&audio_clk1>, <&audio_clk2>;
 			clock-names = "ssi", "ssi_sfr", "audio_clk1", "audio_clk2";
 			resets = <&cpg R9A07G044_SSI3_RST_M2_REG>;
+			dmas = <&dmac 0x2661>, <&dmac 0x2662>;
+			dma-names = "tx", "rx";
 			power-domains = <&cpg>;
 			#sound-dai-cells = <0>;
 			status = "disabled";
-- 
2.17.1


