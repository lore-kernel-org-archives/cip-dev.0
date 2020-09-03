Return-Path: <SRS0=IB7d=CM=lists.cip-project.org=bounce+64572+5401+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA7C43461
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:14 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C6D0206EF
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="MxReWvib"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6D0206EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5401+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MPzAYY4521723xtMnqgH5zKd; Thu, 03 Sep 2020 07:43:14 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.15617.1599144186096464858
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:13 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56297562"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 67DF040C46C1;
	Thu,  3 Sep 2020 23:43:12 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 6/6] ARM: dts: r8a7742-iwg21d-q7-dbcm-ca: Add device tree for camera DB
Date: Thu,  3 Sep 2020 15:43:03 +0100
Message-Id: <20200903144303.13275-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RWvadi5hSDbvS64CMhBB2gswx4520388AA=
Content-Type: multipart/mixed; boundary="nrelH2cR2PTsAZkl82cX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144194;
 bh=/WsnNt4jaGJ3TjVr7nQBJa59v9jHwAwPa9aNorD1V2Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=MxReWvibxB21lKhJp0QHnqa2BNJtDueD9ygdJJoGLajv+//YPq51clCLr9JhPGFRc+x
 FZunRZHHIad7y14jzMXMXcIs5914RvbQKdhx+MxBlFTIF31fwa5+Vxu7bcO0meU1tmj0a
 h2RSj3JYmXGnniWP1XqeaQbfF5LHyiRXYMg=

--nrelH2cR2PTsAZkl82cX

commit 91cebe35d1f5a335ef3de80027a34d9fd04a7ae9 upstream.

Add support for the camera daughter board which is connected to
iWave's RZ/G1H Qseven carrier board. Also enable ttySC[0135] and
ethernet1 interfaces.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1591552659-21314-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile                    |  1 +
 .../boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts    | 96 +++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 09d505aa0d3d..0bc7ae92cdf7 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -547,6 +547,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7742-iwg21d-q7.dtb \
+	r8a7742-iwg21d-q7-dbcm-ca.dtb \
 	r8a7743-iwg20d-q7.dtb \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7744-iwg20d-q7.dtb \
diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
new file mode 100644
index 000000000000..951820dfdf1c
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7-dbcm-ca.dts
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave-RZ/G1H Qseven board development
+ * platform with camera daughter board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a7742-iwg21d-q7.dts"
+
+/ {
+	model = "iWave Systems RZ/G1H Qseven development platform with camera add-on";
+	compatible = "iwave,g21d", "iwave,g21m", "renesas,r8a7742";
+
+	aliases {
+		serial0 = &scif0;
+		serial1 = &scif1;
+		serial3 = &scifb1;
+		serial5 = &hscif0;
+		ethernet1 = &ether;
+	};
+};
+
+&avb {
+	/* Pins shared with VIN0, keep status disabled */
+	status = "disabled";
+};
+
+&ether {
+	pinctrl-0 = <&ether_pins>;
+	pinctrl-names = "default";
+
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		micrel,led-mode = <1>;
+	};
+};
+
+&hscif0 {
+	pinctrl-0 = <&hscif0_pins>;
+	pinctrl-names = "default";
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&pfc {
+	ether_pins: ether {
+		groups = "eth_mdio", "eth_rmii";
+		function = "eth";
+	};
+
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
+	scif0_pins: scif0 {
+		groups = "scif0_data";
+		function = "scif0";
+	};
+
+	scif1_pins: scif1 {
+		groups = "scif1_data";
+		function = "scif1";
+	};
+
+	scifb1_pins: scifb1 {
+		groups = "scifb1_data";
+		function = "scifb1";
+	};
+};
+
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&scifb1 {
+	pinctrl-0 = <&scifb1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	rts-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+	cts-gpios = <&gpio4 17 GPIO_ACTIVE_LOW>;
+};
-- 
2.17.1


--nrelH2cR2PTsAZkl82cX
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5401): https://lists.cip-project.org/g/cip-dev/message=
/5401
Mute This Topic: https://lists.cip-project.org/mt/76608373/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--nrelH2cR2PTsAZkl82cX--
