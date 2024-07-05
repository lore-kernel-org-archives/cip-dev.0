Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B244C3271E
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 13:04:38 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.16672.1720184668856225869
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 06:04:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,184,1716217200"; 
   d="scan'208";a="214374057"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2024 22:04:34 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.112])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 03B61453293E;
	Fri,  5 Jul 2024 22:04:32 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 7/9] arm64: dts: renesas: r9a07g043: Move interrupt-parent property to common DTSI
Date: Fri,  5 Jul 2024 14:04:15 +0100
Message-Id: <20240705130417.125593-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240705130417.125593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 13:04:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16413

commit 1731ab2f8b62f0be2073de581ffef6db1196ad4f upstream.

Now that we have added support for IRQC to both RZ/Five and RZ/G2UL SoCs
we can move the interrupt-parent for pinctrl node back to the common
shared r9a07g043.dtsi file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240403203503.634465-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 766c54b91acce..6212ee550f330 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -598,6 +598,7 @@ pinctrl: pinctrl@11030000 {
 			gpio-ranges = <&pinctrl 0 0 152>;
 			#interrupt-cells = <2>;
 			interrupt-controller;
+			interrupt-parent = <&irqc>;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index b3f83d0ebcbb5..f0c1757a794ad 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -54,10 +54,6 @@ timer {
 	};
 };
 
-&pinctrl {
-	interrupt-parent = <&irqc>;
-};
-
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.34.1


