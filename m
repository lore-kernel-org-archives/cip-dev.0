Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81087ECAAD1
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:47:57 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1262.1661964474480012889
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:47:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="133251696"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Sep 2022 01:47:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6E70040457CD;
	Thu,  1 Sep 2022 01:47:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/26] arm64: dts: renesas: rzg2ul-smarc: Add scif0
 and audio clk pins
Date: Wed, 31 Aug 2022 17:46:39 +0100
Message-Id: <20220831164645.2134258-21-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
References: <20220831164645.2134258-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9380

commit 4e44055440e1fef93e830bd06111bbbb0a89fa44 upstream.

Add scif0 and audio clk pins to soc pinctrl dtsi and drop deleting
the pinctrl-0 and pinctrl-names properties for scif0 node so that
we now actually make use of these properties for scif0.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220402081328.26292-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  6 +----
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi | 24 +++++++++++++++++++
 2 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
index aaa29f83e84c..64370faf8f6d 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g043u11-smarc.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 #include "r9a07g043.dtsi"
 #include "rzg2ul-smarc-som.dtsi"
+#include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
 
 / {
@@ -73,11 +74,6 @@ &phyrst {
 	status = "disabled";
 };
 
-&scif0 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-};
-
 &sdhi1 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-1;
diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
new file mode 100644
index 000000000000..2db9c92cf01f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-pinfunction.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2UL SMARC pincontrol parts
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+&pinctrl {
+	pinctrl-0 = <&sound_clk_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: scif0 {
+		pinmux = <RZG2L_PORT_PINMUX(6, 4, 6)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(6, 3, 6)>; /* RxD */
+	};
+
+	sound_clk_pins: sound_clk {
+		pins = "AUDIO_CLK1", "AUDIO_CLK2";
+		input-enable;
+	};
+};
-- 
2.25.1


