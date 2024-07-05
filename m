Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7FBC3DA42
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 13:04:38 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.16345.1720184677011733360
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 06:04:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="210416827"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jul 2024 22:04:36 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0AA114532922;
	Fri,  5 Jul 2024 22:04:34 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 8/9] riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt properties from ETH0/1 nodes
Date: Fri,  5 Jul 2024 14:04:16 +0100
Message-Id: <20240705130417.125593-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 13:04:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16414

commit fc5d2b222ab18612bc7bdfef7f672afd2cd7275b upstream.

Now that we have enabled IRQC support for RZ/Five SoC switch to interrupt
mode for ethernet0/1 PHYs instead of polling mode.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240403203503.634465-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../riscv/boot/dts/renesas/rzfive-smarc-som.dtsi | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
index 433ab5c6a626c..5e808242649ec 100644
--- a/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
+++ b/arch/riscv/boot/dts/renesas/rzfive-smarc-som.dtsi
@@ -6,19 +6,3 @@
  */
 
 #include <arm64/renesas/rzg2ul-smarc-som.dtsi>
-
-#if (!SW_ET0_EN_N)
-&eth0 {
-	phy0: ethernet-phy@7 {
-		/delete-property/ interrupt-parent;
-		/delete-property/ interrupts;
-	};
-};
-#endif
-
-&eth1 {
-	phy1: ethernet-phy@7 {
-		/delete-property/ interrupt-parent;
-		/delete-property/ interrupts;
-	};
-};
-- 
2.34.1


