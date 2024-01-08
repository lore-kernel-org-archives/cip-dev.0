Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675CCC47258
	for <webhook@archiver.kernel.org>; Mon,  8 Jan 2024 18:17:19 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.4583.1704737829194378591
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 10:17:10 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,180,1695654000"; 
   d="scan'208";a="189691447"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 09 Jan 2024 03:17:10 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.235])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1D0A34046F50;
	Tue,  9 Jan 2024 03:17:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 28/30] riscv: dts: renesas: r9a07g043f: Add L2 cache node
Date: Mon,  8 Jan 2024 18:16:10 +0000
Message-Id: <20240108181612.5651-29-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240108181612.5651-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jan 2024 18:17:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14316

commit a38b1061d327c120844e5dc0217191b06ce3b25f upstream.

Add L2 cache node for RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230929000704.53217-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
index 6ec1c6f9a403..c8d63a8f7d86 100644
--- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
+++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
@@ -29,6 +29,7 @@ cpu0: cpu@0 {
 			i-cache-line-size = <0x40>;
 			d-cache-size = <0x8000>;
 			d-cache-line-size = <0x40>;
+			next-level-cache = <&l2cache>;
 			clocks = <&cpg CPG_CORE R9A07G043_CLK_I>;
 			operating-points-v2 = <&cluster0_opp>;
 
@@ -56,4 +57,15 @@ plic: interrupt-controller@12c00000 {
 		resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
 		interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
 	};
+
+	l2cache: cache-controller@13400000 {
+		compatible = "andestech,ax45mp-cache", "cache";
+		reg = <0x0 0x13400000 0x0 0x100000>;
+		interrupts = <SOC_PERIPHERAL_IRQ(476) IRQ_TYPE_LEVEL_HIGH>;
+		cache-size = <0x40000>;
+		cache-line-size = <64>;
+		cache-sets = <1024>;
+		cache-unified;
+		cache-level = <2>;
+	};
 };
-- 
2.34.1


