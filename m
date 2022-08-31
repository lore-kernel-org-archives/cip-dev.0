Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82530C3DA6B
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.1337.1661964468278866315
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:51 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131240531"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:50 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5500240457D2;
	Thu,  1 Sep 2022 01:47:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/26] arm64: dts: renesas: r9a07g043: Fillup the
 pinctrl stub node
Date: Wed, 31 Aug 2022 17:46:38 +0100
Message-Id: <20220831164645.2134258-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9379

commit 2d10555298576a95b637a5087751d0aad570964d upstream.

Fillup the pinctrl(GPIO) stub node in RZ/G2UL SoC DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402081328.26292-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index aed9ab4f9ba4..f24756d89bc2 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -275,10 +275,16 @@ sysc: system-controller@11020000 {
 		};
 
 		pinctrl: pinctrl@11030000 {
+			compatible = "renesas,r9a07g043-pinctrl";
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			/* place holder */
+			gpio-ranges = <&pinctrl 0 0 152>;
+			clocks = <&cpg CPG_MOD R9A07G043_GPIO_HCLK>;
+			power-domains = <&cpg>;
+			resets = <&cpg R9A07G043_GPIO_RSTN>,
+				 <&cpg R9A07G043_GPIO_PORT_RESETN>,
+				 <&cpg R9A07G043_GPIO_SPARE_RESETN>;
 		};
 
 		dmac: dma-controller@11820000 {
-- 
2.25.1


