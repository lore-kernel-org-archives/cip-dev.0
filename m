Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF21C77B73
	for <webhook@archiver.kernel.org>; Mon,  5 Jun 2023 11:05:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.4742.1685963126906425926
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 04:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,217,1681138800"; 
   d="scan'208";a="162244596"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jun 2023 20:05:33 +0900
Received: from localhost.localdomain (unknown [10.226.93.143])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id F208141CEB16;
	Mon,  5 Jun 2023 20:05:31 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 7/7] arm64: dts: renesas: rzg2ul-smarc: Enable SCI0
Date: Mon,  5 Jun 2023 12:05:12 +0100
Message-Id: <20230605110512.111017-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
References: <20230605110512.111017-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jun 2023 11:05:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11795

commit 52a3554bdf9dbaff42b42f0e0360f456890894d9 upstream.

DT overlay support is missing in 5.10.y-cip. So ported the changes.

Add support for enabling sci0 node and disabling can{0,1}-stb-hog nodes in
board dtsi file as its pins are shared with sci0 pins.

The sci0 node is disabled by default as PMOD_SCI0_EN is set to 0.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230321114753.75038-6-biju.das.jz@bp.renesas.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
index f9835c12023e..b672e3474705 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi
@@ -15,6 +15,9 @@
 #define SW_SW0_DEV_SEL	1
 #define SW_ET0_EN_N	1
 
+/* Please set this macro to 1 for enabling SCI0 on PMOD1 */
+#define PMOD_SCI0_EN	0
+
 #include "rzg2ul-smarc-som.dtsi"
 #include "rzg2ul-smarc-pinfunction.dtsi"
 #include "rz-smarc-common.dtsi"
@@ -39,6 +42,29 @@ wm8978: codec@1a {
 	};
 };
 
+#if (SW_ET0_EN_N && PMOD_SCI0_EN)
+&pinctrl {
+	can0-stb-hog {
+		status = "disabled";
+	};
+
+	can1-stb-hog {
+		status = "disabled";
+	};
+
+	sci0_pins: sci0-pins {
+		pinmux = <RZG2L_PORT_PINMUX(2, 2, 5)>, /* TxD */
+			 <RZG2L_PORT_PINMUX(2, 3, 5)>; /* RxD */
+	};
+};
+
+&sci0 {
+	pinctrl-0 = <&sci0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+#endif
+
 #if (SW_ET0_EN_N)
 &ssi1 {
 	pinctrl-0 = <&ssi1_pins>;
-- 
2.25.1


