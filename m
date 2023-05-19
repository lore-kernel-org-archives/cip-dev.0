Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C60C7EE2A
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:17 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20922.1684484462890095063
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:11 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963132"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:10 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 06FFB419E629;
	Fri, 19 May 2023 17:21:08 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 04/23] arm64: dts: renesas: r9a09g011: Add L2 Cache node
Date: Fri, 19 May 2023 09:20:39 +0100
Message-Id: <20230519082058.109760-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11536

commit c6b1737f45ca708fee76a30afb4a7b0247455749 upstream.

The Cortex-A53 processor on RZ/V2M has 512 KB L2 Cache.
Add L2 Cache node to SoC dtsi.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20221110160931.101539-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index dc7862549246..e2e776a71b4e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -37,8 +37,15 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			reg = <0>;
 			device_type = "cpu";
+			next-level-cache = <&L2_CA53>;
 			clocks = <&cpg CPG_MOD R9A09G011_CA53_CLK>;
 		};
+
+		L2_CA53: cache-controller-0 {
+			compatible = "cache";
+			cache-unified;
+			cache-level = <2>;
+		};
 	};
 
 	soc: soc {
-- 
2.25.1


