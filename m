Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B58C433EF
	for <webhook@archiver.kernel.org>; Mon, 10 Jan 2022 11:54:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.30350.1641815634920037812
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jan 2022 03:54:06 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,276,1635174000";
   d="scan'208";a="106552717"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Jan 2022 20:54:06 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0DC6B429BEB3;
	Mon, 10 Jan 2022 20:54:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 5.10.y-cip 12/15] arm64: dts: renesas: rzg2l-smarc-som:
 Move extal and memory nodes to SOM DTSI
Date: Mon, 10 Jan 2022 11:53:45 +0000
Message-Id: <20220110115348.14297-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220110115348.14297-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jan 2022 11:54:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7361

commit 55c6826119f64be75c4b423a0092a8c1353a7a81 upstream.

Move extal and memory nodes to SOM DTSI.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20210922212049.19851-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../boot/dts/renesas/r9a07g044l2-smarc.dts     |  7 +------
 .../boot/dts/renesas/rzg2l-smarc-som.dtsi      | 18 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi   |  4 ----
 3 files changed, 19 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
index d3f72ec62f03..247b0b3f1b58 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dts
@@ -7,15 +7,10 @@
 
 /dts-v1/;
 #include "r9a07g044l2.dtsi"
+#include "rzg2l-smarc-som.dtsi"
 #include "rzg2l-smarc.dtsi"
 
 / {
 	model = "Renesas SMARC EVK based on r9a07g044l2";
 	compatible = "renesas,smarc-evk", "renesas,r9a07g044l2", "renesas,r9a07g044";
-
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x78000000>;
-	};
 };
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
new file mode 100644
index 000000000000..0748f2e7396a
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G2L SMARC SOM common parts
+ *
+ * Copyright (C) 2021 Renesas Electronics Corp.
+ */
+
+/ {
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 8ecc5b45fc99..8e02311ff0a6 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -39,10 +39,6 @@
 	status = "okay";
 };
 
-&extal_clk {
-	clock-frequency = <24000000>;
-};
-
 &hsusb {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.17.1


