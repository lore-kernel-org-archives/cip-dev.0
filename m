Return-Path: <SRS0=7ICV=B7=lists.cip-project.org=bounce+64572+5202+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39279C433EB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01989207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hnXAM90+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01989207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5202+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id s7xbYY4521723x3vXRROzKCS; Fri, 21 Aug 2020 03:58:45 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.131167.1598003052343639956
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:22 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954645"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:21 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4D9AC4232078;
	Fri, 21 Aug 2020 18:44:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 35/36] arm64: dts: renesas: Add HiHope RZ/G2H main board support
Date: Fri, 21 Aug 2020 10:43:11 +0100
Message-Id: <20200821094312.3249-36-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 61QphgvlNrKt2d9bAmyKfcFtx4520388AA=
Content-Type: multipart/mixed; boundary="SkL5HsTMSk55WkAQMo90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007525;
 bh=9fDLsrmXpALiOqShKCerWlLEtZY2zRTLkXkZnuQHm/s=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hnXAM90+V8Lyw0LeYxumcThnQ3VM50eBFsxlzFchtpRLkHy02+RRX49/AlJ8FRf30tS
 Q2qDJ2/QgrR5JjtWTRiQygcnm10KeAPeMLerVNNKeq2J5pwVQbfIdhg8RpErgSfZ1TT/l
 rt91c1gbLezx4ZezoQx5Hc1j91qUFB+MU9A=

--SkL5HsTMSk55WkAQMo90

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit deadcd50771bc06ad03a3d09c568a0f66694e053 upstream.

Basic support for the HiHope RZ/G2H main board:
  - Memory,
  - Main crystal,
  - Serial console
  - eMMC

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594230511-24790-8-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  1 +
 .../arm64/boot/dts/renesas/hihope-common.dtsi |  4 +--
 arch/arm64/boot/dts/renesas/hihope-rev4.dtsi  |  4 +--
 .../dts/renesas/r8a774e1-hihope-rzg2h.dts     | 26 +++++++++++++++++++
 4 files changed, 31 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index d43027ca5c03..9c2942510ab5 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb \
 			       r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
 			       r8a774c0-ek874-idk-2121wr.dtb
+dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
diff --git a/arch/arm64/boot/dts/renesas/hihope-common.dtsi b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
index 3132c2cc99c4..5091c27a378e 100644
--- a/arch/arm64/boot/dts/renesas/hihope-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-common.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2[MN] main board
- * Rev.[2.0/3.0/4.0] common parts
+ * Device Tree Source for the HiHope RZ/G2H Rev.4.0 and
+ * HiHope RZ/G2[MN] Rev.[2.0/3.0/4.0] main board common parts
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi b/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi
index 9f869187aea6..3046c07a288b 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rev4.dtsi
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the HiHope RZ/G2[MN] Rev.3.0/4.0 main board
- * common parts
+ * Device Tree Source for the HiHope RZ/G2H Rev.4.0 and
+ * HiHope RZ/G2[MN] Rev.3.0/4.0 main board common parts
  *
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
new file mode 100644
index 000000000000..cdbe527e9340
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2H main board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774e1.dtsi"
+#include "hihope-rev4.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2H main board based on r8a774e1";
+	compatible = "hoperun,hihope-rzg2h", "renesas,r8a774e1";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory@500000000 {
+		device_type = "memory";
+		reg = <0x5 0x00000000 0x0 0x80000000>;
+	};
+};
-- 
2.17.1


--SkL5HsTMSk55WkAQMo90
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5202): https://lists.cip-project.org/g/cip-dev/message=
/5202
Mute This Topic: https://lists.cip-project.org/mt/76326742/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--SkL5HsTMSk55WkAQMo90--
