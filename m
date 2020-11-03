Return-Path: <SRS0=Y/IU=EJ=lists.cip-project.org=bounce+64572+5728+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C467C2D0A3
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:59 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39C1022226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="S9KmrrV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39C1022226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5728+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 3IPmYY4521723xIJEFjmfT2R; Tue, 03 Nov 2020 09:33:58 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.794.1604424834598542940
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:58 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61344839"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:57 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0F2614009BE5;
	Wed,  4 Nov 2020 02:33:56 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 15/17] arm64: dts: renesas: Add HiHope RZ/G2H board with idk-1110wr display
Date: Tue,  3 Nov 2020 17:33:34 +0000
Message-Id: <20201103173336.2829-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: jttQx3EnaZxSwpw003UDiNU7x4520388AA=
Content-Type: multipart/mixed; boundary="JzwPrMgCfhrcEO5AQMHW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424838;
 bh=xG96c55+sIFer2w36mAr32TRQwS0PXTIEPOgskyf2q8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=S9KmrrV0sxyR2fN6pBKY5yA5ta6RDt72H6UqXR+4UqAxJ1yFcZEFjwi888YCXItoMUP
 /AqWJs3kQqzl1gM/MhZCvrk56FqP3PpL5rzeWebrQsoPNDCeT47mDvMpRnLa4rger4jnN
 d+GYBhMGygKGqU5lUyDOyqj6zIKDhjsEcNk=

--JzwPrMgCfhrcEO5AQMHW

commit e9f0fb53ac88c1ccf3728b47c687838b6054f481 upstream.

The HiHope RZ/G2H is advertised as compatible with panel idk-1110wr from
Advantech, however the panel isn't sold alongside the board. New dts,
enabling the lvds node to get the panel to work with HiHope RZ/G2H.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20200827181918.30130-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: Manually applied changes to Makefile]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile              |  1 +
 .../r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts       | 15 +++++++++++++++
 2 files changed, 16 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 73cf57a3919b..16d63679f358 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
 			       r8a774c0-ek874-idk-2121wr.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex.dtb
+dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts
new file mode 100644
index 000000000000..3b7339127bc0
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex-idk-1110wr.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2H sub board connected
+ * to an Advantech IDK-1110WR 10.1" LVDS panel
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a774e1-hihope-rzg2h-ex.dts"
+#include "hihope-rzg2-ex-lvds.dtsi"
+#include "rzg2-advantech-idk-1110wr-panel.dtsi"
+
+&lvds0 {
+	status = "okay";
+};
-- 
2.17.1


--JzwPrMgCfhrcEO5AQMHW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5728): https://lists.cip-project.org/g/cip-dev/message=
/5728
Mute This Topic: https://lists.cip-project.org/mt/78011708/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--JzwPrMgCfhrcEO5AQMHW--
