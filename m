Return-Path: <SRS0=kL6W=B5=lists.cip-project.org=bounce+64572+5147+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4ABC433E3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C540D208B3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="W+bpp+GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C540D208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5147+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id siEFYY4521723xBztglVtCyN; Wed, 19 Aug 2020 09:45:10 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.91601.1597855005191174500
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:50 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54769732"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:49 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6543A400B9C0;
	Thu, 20 Aug 2020 01:36:48 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/12] arm64: dts: renesas: hihope-rzg2-ex: Separate out lvds specific nodes into common file
Date: Wed, 19 Aug 2020 17:36:29 +0100
Message-Id: <20200819163634.5430-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ih3aZSDheEWhIR9W9lSxdWhex4520388AA=
Content-Type: multipart/mixed; boundary="qZInn3cMmLAY7pdqQMhE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855510;
 bh=GeSIqy/5W3zPudhN1+HUfohVlDoJVjl4NSHWPnkiiVA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=W+bpp+GV4jhHmr4Ij17j2VdQK/eb9pNA0BOofR8z42+GGdppjXIhxiSBtDaDcp5cTNS
 1+CclgiHkwlfNf7GKLuSBoVBSSdQNnSBK0HN+ckQKiyXrPjhCNsv51cheHQrZjAwmpZja
 DAlD/UCKcYrj1Nrueniaho6W3SPWLJVX0b4=

--qZInn3cMmLAY7pdqQMhE

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b0990638b625f4066396051c60b2f5480823f085 upstream.

Separate out LVDS specific nodes into common file
hihope-rzg2-ex-lvds.dtsi so that this can be re-used by RZ/G2M[N]
variants.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi | 52 +++++++++++++++++++
 .../boot/dts/renesas/hihope-rzg2-ex.dtsi      | 37 -------------
 ...a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts | 39 +-------------
 3 files changed, 53 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi

diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi
new file mode 100644
index 000000000000..40c5e8d6d841
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex-lvds.dtsi
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the RZ/G2[MN] HiHope sub board LVDS common parts
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/ {
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 50000>;
+
+		brightness-levels = <0 2 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+};
+
+&gpio1 {
+	/*
+	 * When GP1_20 is LOW LVDS0 is connected to the LVDS connector
+	 * When GP1_20 is HIGH LVDS0 is connected to the LT8918L
+	 */
+	lvds-connector-en-gpio {
+		gpio-hog;
+		gpios = <20 GPIO_ACTIVE_HIGH>;
+		output-low;
+		line-name = "lvds-connector-en-gpio";
+	};
+};
+
+&lvds0 {
+	ports {
+		port@1 {
+			lvds_connector: endpoint {
+			};
+		};
+	};
+};
+
+&pfc {
+	pwm0_pins: pwm0 {
+		groups = "pwm0";
+		function = "pwm0";
+	};
+};
+
+&pwm0 {
+	pinctrl-0 = <&pwm0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index 28fe17e3bc4e..acfcfd050a6c 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -13,14 +13,6 @@
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=on";
 	};
-
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 50000>;
-
-		brightness-levels = <0 2 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-	};
 };
 
 &avb {
@@ -51,35 +43,6 @@
 	status = "okay";
 };
 
-&gpio1 {
-	/*
-	 * When GP1_20 is LOW LVDS0 is connected to the LVDS connector
-	 * When GP1_20 is HIGH LVDS0 is connected to the LT8918L
-	 */
-	lvds-connector-en-gpio {
-		gpio-hog;
-		gpios = <20 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "lvds-connector-en-gpio";
-	};
-};
-
-&lvds0 {
-	/*
-	 * Please include the LVDS panel .dtsi file and uncomment the below line
-	 * to enable LVDS panel connected to RZ/G2[MN] boards.
-	 */
-
-	/* status = "okay"; */
-
-	ports {
-		port@1 {
-			lvds_connector: endpoint {
-			};
-		};
-	};
-};
-
 &pciec0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
index 3a1dcc914985..c0e9d8ca4a8c 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dts
@@ -7,46 +7,9 @@
  */
 
 #include "r8a774a1-hihope-rzg2m-rev2-ex.dts"
+#include "hihope-rzg2-ex-lvds.dtsi"
 #include "rzg2-advantech-idk-1110wr-panel.dtsi"
 
-/ {
-	backlight {
-		compatible = "pwm-backlight";
-		pwms = <&pwm0 0 50000>;
-
-		brightness-levels = <0 2 8 16 32 64 128 255>;
-		default-brightness-level = <6>;
-	};
-
-};
-
-&gpio1 {
-	/*
-	 * When GP1_20 is LOW LVDS0 is connected to the LVDS connector
-	 * When GP1_20 is HIGH LVDS0 is connected to the LT8918L
-	 */
-	lvds-connector-en-gpio {
-		gpio-hog;
-		gpios = <20 GPIO_ACTIVE_HIGH>;
-		output-low;
-		line-name = "lvds-connector-en-gpio";
-	};
-};
-
 &lvds0 {
 	status = "okay";
 };
-
-&pfc {
-	pwm0_pins: pwm0 {
-		groups = "pwm0";
-		function = "pwm0";
-	};
-};
-
-&pwm0 {
-	pinctrl-0 = <&pwm0_pins>;
-	pinctrl-names = "default";
-
-	status = "okay";
-};
-- 
2.17.1


--qZInn3cMmLAY7pdqQMhE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5147): https://lists.cip-project.org/g/cip-dev/message=
/5147
Mute This Topic: https://lists.cip-project.org/mt/76290777/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qZInn3cMmLAY7pdqQMhE--
