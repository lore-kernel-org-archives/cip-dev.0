Return-Path: <SRS0=jrSl=CG=lists.cip-project.org=bounce+64572+5320+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BA5C2D0E0
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951AA20872
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="irPydG3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951AA20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5320+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id qONVYY4521723xy3FTboAil4; Fri, 28 Aug 2020 09:07:54 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.45868.1598629382315801550
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:43:02 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55804764"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Aug 2020 00:43:01 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 27938400C4F0;
	Sat, 29 Aug 2020 00:42:59 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 30/30] ARM: dts: r8a7742-iwg21d-q7: Add iWave G21D-Q7 board based on RZ/G1H
Date: Fri, 28 Aug 2020 16:41:55 +0100
Message-Id: <20200828154155.5827-31-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: uAlQxTof0CgLPK33E3Bp3fZdx4520388AA=
Content-Type: multipart/mixed; boundary="lBOzN9LF4o7CTJRfjE6x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630874;
 bh=qBtoEgWwzPT3iMpdr69qSwdDc6MZ2rklN6K2K0z3Mss=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=irPydG3qtVjmx3yq7zeT+FVbnSglUhFaS2SJhLcUZj5uOsSJcQEQu7uJGaOHVFV6Me/
 O+7Jo8DKlNzNjf/frVUispj42P1s4WCnkL2LUkOkyFLUeOoPFWDjxQpHPhEuMUBK6jPaa
 BgF5a09O8C480row5HPFnMdT2gzwVkIjtP0=

--lBOzN9LF4o7CTJRfjE6x

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 48ad3c4a334ad1e583f5159f43c3623ecaffc9f9 upstream.

Add support for iWave RainboW-G21D-Qseven board based on RZ/G1H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1588542414-14826-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts | 37 +++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7742-iwg21d-q7.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f279346925a7..09d505aa0d3d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -546,6 +546,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r7s72100-genmai.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
+	r8a7742-iwg21d-q7.dtb \
 	r8a7743-iwg20d-q7.dtb \
 	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7744-iwg20d-q7.dtb \
diff --git a/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
new file mode 100644
index 000000000000..1f5c35c66d91
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7742-iwg21d-q7.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the iWave-RZ/G1H Qseven board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a7742-iwg21m.dtsi"
+
+/ {
+	model = "iWave Systems RainboW-G21D-Qseven board based on RZ/G1H";
+	compatible = "iwave,g21d", "iwave,g21m", "renesas,r8a7742";
+
+	aliases {
+		serial2 = &scifa2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel root=/dev/mmcblk0p1 rw rootwait";
+		stdout-path = "serial2:115200n8";
+	};
+};
+
+&pfc {
+	scifa2_pins: scifa2 {
+		groups = "scifa2_data_c";
+		function = "scifa2";
+	};
+};
+
+&scifa2 {
+	pinctrl-0 = <&scifa2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
2.17.1


--lBOzN9LF4o7CTJRfjE6x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5320): https://lists.cip-project.org/g/cip-dev/message=
/5320
Mute This Topic: https://lists.cip-project.org/mt/76477109/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--lBOzN9LF4o7CTJRfjE6x--
