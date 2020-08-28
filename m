Return-Path: <SRS0=vYpA=CG=lists.cip-project.org=bounce+64572+5318+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75167C2BC11
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0E9208C9
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="OCOJ08dB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0E9208C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5318+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UmvhYY4521723xALPlGeAjiN; Fri, 28 Aug 2020 09:07:53 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.45506.1598629371850471017
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:58 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587903"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:57 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 00510400C9FD;
	Sat, 29 Aug 2020 00:42:55 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 28/30] ARM: dts: r8a7742-iwg21m: Add iWave RZ/G1H Qseven SOM
Date: Fri, 28 Aug 2020 16:41:53 +0100
Message-Id: <20200828154155.5827-29-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8wJMqrluOz34v5h2TQGby3Bhx4520388AA=
Content-Type: multipart/mixed; boundary="qaoyOKMxWRCvtmdWQw91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630873;
 bh=uc350+E+O4AenTOBcX9OAzf0AikyPRmdfPEyVG0a1K8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=OCOJ08dB3yj6zsfyue6pVBa04GvRS20k8XbIKQj25gY2O7aXtU1CpMqSXOYklk3U2q1
 gI2x0dZ9bvqLJ2hk2XnMpfS7P7JTsR3a1D+mxcV8Ve4U+XETG41VOysWL67Mpnm8zTW/s
 saCjuarx/vWm0l5qt+k0UJbreMhWVTT7ZEg=

--qaoyOKMxWRCvtmdWQw91

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 269785eaba09172c5189e30d2202084586aeabdd upstream.

Add support for iWave RZ/G1H Qseven System On Module.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588542414-14826-10-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/r8a7742-iwg21m.dtsi | 53 +++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21m.dtsi

diff --git a/arch/arm/boot/dts/r8a7742-iwg21m.dtsi b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
new file mode 100644
index 000000000000..85aff429d408
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7742-iwg21m.dtsi
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave RZ/G1H Qseven SOM
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a7742.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	compatible = "iwave,g21m", "renesas,r8a7742";
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+
+	memory@200000000 {
+		device_type = "memory";
+		reg = <2 0x00000000 0 0x40000000>;
+	};
+
+	reg_3p3v: 3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "3P3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&pfc {
+	mmc1_pins: mmc1 {
+		groups = "mmc1_data4", "mmc1_ctrl";
+		function = "mmc1";
+	};
+};
+
+&mmcif1 {
+	pinctrl-0 = <&mmc1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+};
-- 
2.17.1


--qaoyOKMxWRCvtmdWQw91
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5318): https://lists.cip-project.org/g/cip-dev/message=
/5318
Mute This Topic: https://lists.cip-project.org/mt/76477107/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qaoyOKMxWRCvtmdWQw91--
