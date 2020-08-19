Return-Path: <SRS0=pcxy=B5=lists.cip-project.org=bounce+64572+5144+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AADC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647F720888
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EFtsIaqb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647F720888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5144+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rPpSYY4521723x6buEX0m90X; Wed, 19 Aug 2020 09:45:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.91601.1597855005191174500
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:52 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54769736"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:51 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 46385400B9C0;
	Thu, 20 Aug 2020 01:36:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 08/12] arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 board with idk-1110wr display
Date: Wed, 19 Aug 2020 17:36:30 +0100
Message-Id: <20200819163634.5430-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: cCb9VQi9zWGWw2Xdjg8gwVM1x4520388AA=
Content-Type: multipart/mixed; boundary="2OyAX0IuVWFSPPBk3UgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855512;
 bh=OuL6AIIxEfeWSnbCZm8m4193I9J3l5gVj2Xa2phRAfQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EFtsIaqbEs8rVSbS485gnd8pfQ3HPC0KyaUSmCGkEMee4PacHHcZSD+lmE+FZ5hZLMO
 qhHIisA4sjU5AA636NF7ZJ3+Kdaq700ewHEgJndJQSe3YkUHrZ0BUEdRgZ9HPRWtADyVt
 CnU/Yo8DtFwsIg3T6aq8yh6C5/QoZCGcYaE=

--2OyAX0IuVWFSPPBk3UgE

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 51fb6306d0587ab24187f429a703272aab466b1e upstream.

Add support for idk-1110wr display as similarly done for Rev.2.0

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile              |  3 ++-
 .../r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts       | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 3420c56e70ac..de0d211034c6 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -3,7 +3,8 @@ dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb \
 			       r8a774a1-hihope-rzg2m-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb \
 			       r8a774a1-hihope-rzg2m-rev2-ex.dtb
-dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb \
+			       r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
new file mode 100644
index 000000000000..06c04c59cc78
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-idk-1110wr.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M Rev.3.0/4.0 sub board connected
+ * to an Advantech IDK-1110WR 10.1" LVDS panel
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a774a1-hihope-rzg2m-ex.dts"
+#include "hihope-rzg2-ex-lvds.dtsi"
+#include "rzg2-advantech-idk-1110wr-panel.dtsi"
+
+&lvds0 {
+	status = "okay";
+};
-- 
2.17.1


--2OyAX0IuVWFSPPBk3UgE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5144): https://lists.cip-project.org/g/cip-dev/message=
/5144
Mute This Topic: https://lists.cip-project.org/mt/76290774/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--2OyAX0IuVWFSPPBk3UgE--
