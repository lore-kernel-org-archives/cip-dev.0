Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B129EE49AA
	for <webhook@archiver.kernel.org>; Mon, 21 Aug 2023 14:38:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.1008.1692628695125774967
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Aug 2023 07:38:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,190,1684767600"; 
   d="scan'208";a="173473049"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2023 23:38:28 +0900
Received: from localhost.localdomain (unknown [10.226.92.38])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4C4CF400754E;
	Mon, 21 Aug 2023 23:38:26 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/15] arm64: dts: renesas: r9a07g043u: Update pinctrl node to handle GPIO interrupts
Date: Mon, 21 Aug 2023 15:37:55 +0100
Message-Id: <20230821143759.227105-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
References: <20230821143759.227105-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Aug 2023 14:38:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12805

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 85169df721078bf90fb0fc3bf15e4743fea45b2d upstream.

Add required properties in pinctrl node to handle GPIO interrupts.

Note as IRQC is not enabled in RZ/Five the phandle for interrupt-parent
is added in RZ/G2UL specific dtsi so that RZ/Five pinctrl driver
continues without waiting for IRQC to probe.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230102221815.273719-6-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi  | 2 ++
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index 5f534db54d1c..27c35a657b15 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -526,6 +526,8 @@ pinctrl: pinctrl@11030000 {
 			gpio-controller;
 			#gpio-cells = <2>;
 			gpio-ranges = <&pinctrl 0 0 152>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
 			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
 			power-domains = <&cpg>;
 			resets = <&cpg R9A07G043_GPIO_RSTN>,
diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
index a6e777aee02e..ebaaf82edeca 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u.dtsi
@@ -48,6 +48,10 @@ timer {
 	};
 };
 
+&pinctrl {
+	interrupt-parent = <&irqc>;
+};
+
 &soc {
 	interrupt-parent = <&gic>;
 
-- 
2.25.1


