Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7D4C7EE24
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 08:54:11 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.84062.1684140842138353029
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 01:54:06 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,276,1677510000"; 
   d="scan'208";a="159396969"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 May 2023 17:54:06 +0900
Received: from localhost.localdomain (unknown [10.226.93.20])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 339FD4009672;
	Mon, 15 May 2023 17:54:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 4/4] arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMAC nodes
Date: Mon, 15 May 2023 09:53:52 +0100
Message-Id: <20230515085352.25794-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
References: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 08:54:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11450

commit 05d11e2f4460752fa5f7ce7657e1b040056c1736 upstream.

Add clock-names and reset-names to RZ/G2{L,LC,UL}, RZ/V2L and
RZ/Five DMAC nodes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230315064726.22739-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 689aa4ba416b..48abd75dff9a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -602,9 +602,11 @@ dmac: dma-controller@11820000 {
 					  "ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD R9A07G043_DMAC_ACLK>,
 				 <&cpg CPG_MOD R9A07G043_DMAC_PCLK>;
+			clock-names = "main", "register";
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_DMAC_ARESETN>,
 				 <&cpg R9A07G043_DMAC_RST_ASYNC>;
+			reset-names = "arst", "rst_async";
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index e8ad84c55fca..28b8eae796fe 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -637,9 +637,11 @@ dmac: dma-controller@11820000 {
 					  "ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD R9A07G044_DMAC_ACLK>,
 				 <&cpg CPG_MOD R9A07G044_DMAC_PCLK>;
+			clock-names = "main", "register";
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G044_DMAC_ARESETN>,
 				 <&cpg R9A07G044_DMAC_RST_ASYNC>;
+			reset-names = "arst", "rst_async";
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 3d225ab6ad35..d3c0d137ccae 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -643,9 +643,11 @@ dmac: dma-controller@11820000 {
 					  "ch12", "ch13", "ch14", "ch15";
 			clocks = <&cpg CPG_MOD R9A07G054_DMAC_ACLK>,
 				 <&cpg CPG_MOD R9A07G054_DMAC_PCLK>;
+			clock-names = "main", "register";
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G054_DMAC_ARESETN>,
 				 <&cpg R9A07G054_DMAC_RST_ASYNC>;
+			reset-names = "arst", "rst_async";
 			#dma-cells = <1>;
 			dma-channels = <16>;
 		};
-- 
2.25.1


