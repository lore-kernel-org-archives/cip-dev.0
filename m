Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A6C77B7F
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:21:57 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20948.1684484510605996546
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963240"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:53 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 990BD419EC47;
	Fri, 19 May 2023 17:21:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 20/23] arm64: dts: renesas: r9a09g011: Add i2c nodes
Date: Fri, 19 May 2023 09:20:55 +0100
Message-Id: <20230519082058.109760-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11552

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 54ac6794df9db684d367662a7ea84b7f41cf9312 upstream.

Add device nodes for the I2C controllers that are not assigned to the
ISP.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220819193944.337599-3-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
index e037e08026b6..e32e9881164e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g011.dtsi
@@ -135,6 +135,34 @@ sys: system-controller@a3f03000 {
 			reg = <0 0xa3f03000 0 0x400>;
 		};
 
+		i2c0: i2c@a4030000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+			reg = <0 0xa4030000 0 0x80>;
+			interrupts = <GIC_SPI 232 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 236 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "tia", "tis";
+			clocks = <&cpg CPG_MOD R9A09G011_IIC_PCLK0>;
+			resets = <&cpg R9A09G011_IIC_GPA_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@a4030100 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "renesas,i2c-r9a09g011", "renesas,rzv2m-i2c";
+			reg = <0 0xa4030100 0 0x80>;
+			interrupts = <GIC_SPI 234 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 238 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "tia", "tis";
+			clocks = <&cpg CPG_MOD R9A09G011_IIC_PCLK1>;
+			resets = <&cpg R9A09G011_IIC_GPB_PRESETN>;
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
 		uart0: serial@a4040000 {
 			compatible = "renesas,r9a09g011-uart", "renesas,em-uart";
 			reg = <0 0xa4040000 0 0x80>;
-- 
2.25.1


