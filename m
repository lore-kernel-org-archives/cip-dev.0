Return-Path: <SRS0=J1nh=6E=lists.cip-project.org=bounce+64572+4589+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C05EC54FCF
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:57 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F45920857
	for <cip-dev@archiver.kernel.org>; Mon, 20 Apr 2020 19:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="vFiSzIPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F45920857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4589+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uIGYYY4521723xgMhgFr4zaR; Mon, 20 Apr 2020 12:50:57 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1917.1587412256015691888
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Apr 2020 12:50:56 -0700
X-IronPort-AV: E=Sophos;i="5.72,407,1580742000"; 
   d="scan'208";a="45226966"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2020 04:50:55 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 31C9540CC760;
	Tue, 21 Apr 2020 04:50:54 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Subject: [cip-dev] [PATCH 2/2] arm64: dts: renesas: Add HiHope RZ/G2M board with idk-1110wr display
Date: Mon, 20 Apr 2020 20:50:50 +0100
Message-Id: <1587412250-16752-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1587412250-16752-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jaQWzZUmJNiBgLpLglVkWJVbx4520388AA=
Content-Type: multipart/mixed; boundary="EBD2fLI1qYhhSCFHKmW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1587412257;
 bh=2O4VGmTDGldtm/Gvo7dVxuFhzz390YrS49s9M7EDilQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vFiSzIPFyuVECIQQAHiHkv7eWe6EK0cOoIBvnJjlxvMF30V8FBnxOeU0vwl/Q46URlc
 w+yqu3IJGJYKO2ePTmRDHAoCcxVg1p6C+8LtVjqxJYdknJII9X2Tn2iDl4b0mD7BF06Fo
 DxdYJt2O32jdSEtKzxmpTec4qJ4o9hYRdjU=

--EBD2fLI1qYhhSCFHKmW4

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit e30f56800e69db6d2763a1f7f64dfcc79f9b5ea7 upstream.

The HiHope RZ/G2M is advertised as compatible with panel idk-1110wr
from Advantech, however the panel isn't sold alongside the board.
A new dts, adding everything that's required to get the panel to
work the HiHope RZ/G2M, is the most convenient way to support the
HiHope RZ/G2M when it's connected to the idk-1110wr.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1583957020-16359-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/Makefile               |  1 +
 .../r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts        | 52 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 17785e1..c05feec 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
new file mode 100644
index 0000000..2ab5edd
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M sub board connected to an
+ * Advantech IDK-1110WR 10.1" LVDS panel
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a774a1-hihope-rzg2m-ex.dts"
+#include "rzg2-advantech-idk-1110wr-panel.dtsi"
+
+/ {
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 50000>;
+
+		brightness-levels = <0 2 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+	};
+
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
+	status = "okay";
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
-- 
2.7.4


--EBD2fLI1qYhhSCFHKmW4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4589): https://lists.cip-project.org/g/cip-dev/message=
/4589
Mute This Topic: https://lists.cip-project.org/mt/73158053/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--EBD2fLI1qYhhSCFHKmW4--
