Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D77C433EF
	for <webhook@archiver.kernel.org>; Fri, 15 Jul 2022 07:23:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.3871.1657869794050960984
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Jul 2022 00:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.92,273,1650898800";
   d="scan'208";a="127955904"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 Jul 2022 16:23:46 +0900
Received: from localhost.localdomain (unknown [10.226.92.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 505D940083E1;
	Fri, 15 Jul 2022 16:23:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 23/24] arm64: dts: renesas: Fix pin controller node
 names
Date: Fri, 15 Jul 2022 08:22:43 +0100
Message-Id: <20220715072244.2298757-24-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
References: <20220715072244.2298757-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Jul 2022 07:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8809

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit c9b7011768b5dbb68792b4bacad5ae913059ed74 upstream.

Align all pin controller node names with the expectations of the DT
bindings in Documentation/devicetree/bindings/pinctrl/pinctrl.yaml.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/09a09c8ac9cb1a11b859c1ab9d9eae84cfefb1bb.1639666967.git.geert+renesas@glider.be
[Biju: Manually applied the changes]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index 3859337989b7..63bf5bb62554 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -589,7 +589,7 @@ sysc: system-controller@11020000 {
 			status = "disabled";
 		};
 
-		pinctrl: pin-controller@11030000 {
+		pinctrl: pinctrl@11030000 {
 			compatible = "renesas,r9a07g044-pinctrl";
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
-- 
2.25.1


