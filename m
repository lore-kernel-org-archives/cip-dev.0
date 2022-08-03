Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B806C3F6B0
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 16:54:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.134.1659545655590408986
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 09:54:20 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,214,1654527600";
   d="scan'208";a="128394730"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Aug 2022 01:54:19 +0900
Received: from localhost.localdomain (unknown [10.226.93.45])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id B8B0F40B100C;
	Thu,  4 Aug 2022 01:54:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/13] arm64: dts: renesas: rzg2l-smarc: Move out
 i2c3 and Audio codec from common dtsi
Date: Wed,  3 Aug 2022 17:53:52 +0100
Message-Id: <20220803165358.2156150-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
References: <20220803165358.2156150-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 16:54:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9077

commit 0a7c1c888a0c0276837f2cd7190683474a136506 upstream.

On RZ/G2L SoM module, the Audio codec is connected to i2c3 bus whereas on
RZ/G2LC, it is connected to i2c2 bus. So move out i2c3 and wm8978 nodes
from common dtsi to soc specific dtsi.

While at it add wm8978 node to RZ/G2LC SoC specific dtsi to fix the
build error.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20220303164155.7706-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts |  6 ------
 arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi  | 15 ---------------
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi      | 15 +++++++++++++++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi     | 11 +++++++++++
 4 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
index d5254b16b0b3..dc39b05e9256 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dts
@@ -26,12 +26,6 @@ &i2c1 {
 	status = "disabled";
 };
 
-&i2c3 {
-	/delete-property/ pinctrl-0;
-	/delete-property/ pinctrl-names;
-	status = "disabled";
-};
-
 &spi1 {
 	/delete-property/ pinctrl-0;
 	/delete-property/ pinctrl-names;
diff --git a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
index 588117aafaca..8dd1c69a6749 100644
--- a/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rz-smarc-common.dtsi
@@ -26,7 +26,6 @@ aliases {
 		serial0 = &scif0;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
-		i2c3 = &i2c3;
 	};
 
 	chosen {
@@ -131,20 +130,6 @@ &i2c1 {
 	status = "okay";
 };
 
-&i2c3 {
-	pinctrl-0 = <&i2c3_pins>;
-	pinctrl-names = "default";
-	clock-frequency = <400000>;
-
-	status = "okay";
-
-	wm8978: codec@1a {
-		compatible = "wlf,wm8978";
-		#sound-dai-cells = <0>;
-		reg = <0x1a>;
-	};
-};
-
 &ohci0 {
 	dr_mode = "otg";
 	status = "okay";
diff --git a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
index 33ddfd18bd56..c934cd3633a4 100644
--- a/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi
@@ -14,6 +14,21 @@
 / {
 	aliases {
 		serial1 = &scif2;
+		i2c3 = &i2c3;
+	};
+};
+
+&i2c3 {
+	pinctrl-0 = <&i2c3_pins>;
+	pinctrl-names = "default";
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	wm8978: codec@1a {
+		compatible = "wlf,wm8978";
+		#sound-dai-cells = <0>;
+		reg = <0x1a>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
index df7631fe5fac..55d3b73f84e7 100644
--- a/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi
@@ -43,6 +43,7 @@
 / {
 	aliases {
 		serial1 = &scif1;
+		i2c2 = &i2c2;
 	};
 };
 
@@ -59,6 +60,16 @@ &canfd {
 };
 #endif
 
+&i2c2 {
+	status = "disabled";
+
+	wm8978: codec@1a {
+		compatible = "wlf,wm8978";
+		#sound-dai-cells = <0>;
+		reg = <0x1a>;
+	};
+};
+
 /*
  * To enable SCIF1 (SER0) on PMOD1 (CN7), On connector board
  * SW1 should be at position 2->3 so that SER0_CTS# line is activated
-- 
2.25.1


