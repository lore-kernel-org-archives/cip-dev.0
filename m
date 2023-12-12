Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DDEC4167D
	for <webhook@archiver.kernel.org>; Tue, 12 Dec 2023 12:41:00 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.689.1702384849048197610
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Dec 2023 04:40:52 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.04,270,1695654000"; 
   d="scan'208";a="186194500"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 12 Dec 2023 21:40:52 +0900
Received: from localhost.localdomain (unknown [10.226.93.124])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 71BA840001D0;
	Tue, 12 Dec 2023 21:40:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 06/14] arm64: dts: renesas: rzg2lc-smarc-som: Add vdd core regulator
Date: Tue, 12 Dec 2023 12:40:27 +0000
Message-Id: <20231212124035.151367-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
References: <20231212124035.151367-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Dec 2023 12:41:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14049

commit 6f57895c49bc36a6ba125b9926d4b9699376e656 upstream.

Add vdd core regulator (1.1 V) for GPU.

This patch add regulator support for GPU.

The H/W manual mentions nothing about a GPU regulator. So using vdd
core regulator for GPU.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220307192436.13237-4-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
index 2ad49a6fb9dc..370e9420d380 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc-som.dtsi
@@ -41,6 +41,15 @@ reg_3p3v: regulator1 {
 		regulator-always-on;
 	};
 
+	reg_1p1v: regulator-vdd-core {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.1V";
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1100000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	vccq_sdhi0: regulator-vccq-sdhi0 {
 		compatible = "regulator-gpio";
 
@@ -91,6 +100,10 @@ &extal_clk {
 	clock-frequency = <24000000>;
 };
 
+&gpu {
+	mali-supply = <&reg_1p1v>;
+};
+
 &i2c2 {
 	raa215300: pmic@12 {
 		compatible = "renesas,raa215300";
-- 
2.25.1


