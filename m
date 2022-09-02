Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103EECAAD5
	for <webhook@archiver.kernel.org>; Fri,  2 Sep 2022 09:45:39 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web08.4682.1662111927256305315
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Sep 2022 02:45:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,283,1654527600";
   d="scan'208";a="133482115"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 02 Sep 2022 18:45:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.155])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 52DBA400CF0E;
	Fri,  2 Sep 2022 18:45:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 25/25] arm64: dts: renesas: rzg2ul-smarc-som:
 Enable ADC on SMARC platform
Date: Fri,  2 Sep 2022 10:44:27 +0100
Message-Id: <20220902094427.116227-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
References: <20220902094427.116227-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Sep 2022 09:45:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9451

commit 52271d32348e22e5a7ce4fc80015ffb06a4ebf20 upstream.

Enable the ADC found on RZ/G2UL SMARC SoM.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220608173025.22792-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
index 19bdb52b8531..b291d26e6d2f 100644
--- a/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2ul-smarc-som.dtsi
@@ -57,6 +57,14 @@ vccq_sdhi0: regulator-vccq-sdhi0 {
 #endif
 };
 
+#if (SW_SW0_DEV_SEL)
+&adc {
+	pinctrl-0 = <&adc_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+#endif
+
 #if (!SW_ET0_EN_N)
 &eth0 {
 	pinctrl-0 = <&eth0_pins>;
@@ -124,6 +132,10 @@ &ostm2 {
 };
 
 &pinctrl {
+	adc_pins: adc {
+		pinmux = <RZG2L_PORT_PINMUX(6, 2, 1)>; /* ADC_TRG */
+	};
+
 	eth0_pins: eth0 {
 		pinmux = <RZG2L_PORT_PINMUX(4, 5, 1)>, /* ET0_LINKSTA */
 			 <RZG2L_PORT_PINMUX(4, 3, 1)>, /* ET0_MDC */
-- 
2.25.1


