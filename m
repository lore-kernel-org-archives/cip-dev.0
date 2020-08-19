Return-Path: <SRS0=zqk+=B5=lists.cip-project.org=bounce+64572+5143+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EA2C433DF
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C511B208A9
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kt8bcK/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C511B208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5143+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IfGmYY4521723xibj4JjEoZW; Wed, 19 Aug 2020 09:45:10 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.92110.1597854998224602430
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:46 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54984479"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:46 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C5790400B9C0;
	Thu, 20 Aug 2020 01:36:44 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 05/12] arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 main board support
Date: Wed, 19 Aug 2020 17:36:27 +0100
Message-Id: <20200819163634.5430-6-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: ioKejZqH0fidGEWuchCul6JWx4520388AA=
Content-Type: multipart/mixed; boundary="aN23bD12eBe78w5fCKUD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855510;
 bh=vBeY5b+DG+F8GoXw9RMzE+YgbaoqHmiNC4noMNhGgi8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kt8bcK/ctyoF98fQIumPKQwadDFfW6bZzb133zCU5G/5yoC0fUbxcuF7z9EieaFpczi
 tNHplqrMGB5xx/SnEH/3pfK5O9F8qmxdxjuBKaDE8YOQTh4hvZEQeTskOLWf0rsP1tuX3
 Py2osCESAzLEw1VOpsEtfkriMhCBsRCUIUI=

--aN23bD12eBe78w5fCKUD

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8c41b3d7a7abc4af05eda380ddb17b8457a3f3de upstream.

Add support for HiHope RZ/G2M Rev.3.0/4.0 main board support based on
r8a774a1 SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  3 +-
 .../dts/renesas/r8a774a1-hihope-rzg2m.dts     | 37 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi     |  2 +
 3 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index e77140d382ac..103d525f1852 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb \
+			       r8a774a1-hihope-rzg2m-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
new file mode 100644
index 000000000000..25ae255de0f2
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M Rev.3.0/4.0 main board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774a1.dtsi"
+#include "hihope-rev4.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2M main board based on r8a774a1";
+	compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+
+	memory@600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x0 0x80000000>;
+	};
+};
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 722>,
+		 <&versaclock5 1>,
+		 <&x302_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.2",
+		      "dclkin.0", "dclkin.1", "dclkin.2";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 86ad9b34810f..2aaeb8e7dc65 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -10,6 +10,8 @@
 #include <dt-bindings/clock/r8a774a1-cpg-mssr.h>
 #include <dt-bindings/power/r8a774a1-sysc.h>
 
+#define CPG_AUDIO_CLK_I		R8A774A1_CLK_S0D4
+
 / {
 	compatible = "renesas,r8a774a1";
 	#address-cells = <2>;
-- 
2.17.1


--aN23bD12eBe78w5fCKUD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5143): https://lists.cip-project.org/g/cip-dev/message=
/5143
Mute This Topic: https://lists.cip-project.org/mt/76290772/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--aN23bD12eBe78w5fCKUD--
