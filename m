Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2680DC7EE2C
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 12:50:05 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.7861.1684932583108467280
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 May 2023 05:50:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,189,1681138800"; 
   d="scan'208";a="164171395"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 May 2023 21:50:01 +0900
Received: from localhost.localdomain (unknown [10.226.93.65])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7C1AC40104E3;
	Wed, 24 May 2023 21:49:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 08/10] arm64: dts: renesas: r9a09g011: Fix I2C SoC specific strings
Date: Wed, 24 May 2023 13:49:35 +0100
Message-Id: <20230524124937.160355-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
References: <20230524124937.160355-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 May 2023 12:50:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11642

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 2ac909916b520df09a23f152bb9016d7b892b496 upstream.

The preferred form for Renesas' compatible strings is:
"<vendor>,<family>-<module>"

Somehow the compatible string for the r9a09g011 I2C IP was upstreamed
as renesas,i2c-r9a09g011 instead of renesas,r9a09g011-i2c, which
is really confusing, especially considering the generic fallback
is renesas,rzv2m-i2c.

The first user of renesas,i2c-r9a09g011 in the kernel is not yet in
a kernel release, it will be in v6.1, therefore it can still be
fixed in v6.1.
Even if we don't fix it before v6.2, I don't think there is any
harm in making such a change.

s/renesas,i2c-r9a09g011/renesas,r9a09g011-i2c/g for consistency.

Fixes: 54ac6794df9d ("arm64: dts: renesas: r9a09g011: Add i2c nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Link: https://lore.kernel.org/r/20221107165027.54150-3-fabrizio.castro.jz@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index e32e9881164e..4ac8ce594da7 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -138,7 +138,7 @@ sys: system-controller@a3f03000 {
 		i2c0: i2c@a4030000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+			compatible = "renesas,r9a09g011-i2c", "renesas,rzv2m-i2c";
 			reg = <0 0xa4030000 0 0x80>;
 			interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
@@ -152,7 +152,7 @@ i2c0: i2c@a4030000 {
 		i2c2: i2c@a4030100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+			compatible = "renesas,r9a09g011-i2c", "renesas,rzv2m-i2c";
 			reg = <0 0xa4030100 0 0x80>;
 			interrupts = <GIC_SPI 234 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 238 IRQ_TYPE_EDGE_RISING>;
-- 
2.25.1


