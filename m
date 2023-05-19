Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D0EC7EE26
	for <webhook@archiver.kernel.org>; Fri, 19 May 2023 08:22:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20948.1684484510605996546
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 May 2023 01:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,176,1681138800"; 
   d="scan'208";a="159963250"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 May 2023 17:21:58 +0900
Received: from localhost.localdomain (unknown [10.226.93.34])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 98793419EC5D;
	Fri, 19 May 2023 17:21:56 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 22/23] arm64: dts: renesas: rzv2m evk: Enable i2c
Date: Fri, 19 May 2023 09:20:57 +0100
Message-Id: <20230519082058.109760-23-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
References: <20230519082058.109760-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 May 2023 08:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11554

From: Phil Edworthy <phil.edworthy@renesas.com>

commit 39ffd3307fb85ec8a73a8b9d13b0ea923c48b72a upstream.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Link: https://lore.kernel.org/r/20220819193944.337599-4-phil.edworthy@renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
index 6d0b1f69ddc4..11e1d51c7c0e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dts
@@ -7,6 +7,7 @@
 
 /dts-v1/;
 #include "r9a09g011.dtsi"
+#include <dt-bindings/pinctrl/rzv2m-pinctrl.h>
 
 / {
 	model = "RZ/V2M Evaluation Kit 2.0";
@@ -53,6 +54,32 @@ &extal_clk {
 	clock-frequency = <48000000>;
 };
 
+&i2c0 {
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <100000>;
+	status = "okay";
+};
+
+&pinctrl {
+	i2c0_pins: i2c0 {
+		pinmux = <RZV2M_PORT_PINMUX(5, 0, 2)>, /* SDA */
+			 <RZV2M_PORT_PINMUX(5, 1, 2)>; /* SCL */
+	};
+
+	i2c2_pins: i2c2 {
+		pinmux = <RZV2M_PORT_PINMUX(3, 8, 2)>, /* SDA */
+			 <RZV2M_PORT_PINMUX(3, 9, 2)>; /* SCL */
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.25.1


