Return-Path: <SRS0=Mnyx=B7=lists.cip-project.org=bounce+64572+5211+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDBDC433F4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:47 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24BE2072D
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="N3McSBZ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24BE2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5211+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id j7hyYY4521723xy2WMunqtau; Fri, 21 Aug 2020 03:58:46 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130439.1598003056666915018
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:44:23 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55170393"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 18:44:23 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1B7E44232061;
	Fri, 21 Aug 2020 18:44:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 36/36] arm64: dts: renesas: Add HiHope RZ/G2H sub board support
Date: Fri, 21 Aug 2020 10:43:12 +0100
Message-Id: <20200821094312.3249-37-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: B2THWJchCkjN6v8wIjFMZpQLx4520388AA=
Content-Type: multipart/mixed; boundary="UE6F6z9ErUa6mISxYppK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007526;
 bh=ex9eGBHUWMSUl8inv3ZL6UlOUuLaKEp3CtFi3xnz3GA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=N3McSBZ7GonGsMriuNSQMmvJXW/z/DbCF1nj4UjvGVj9e5OIdgY7jAGLWgHNrY29s1L
 QDbAJ3MbckuISlcEw/0MFoSlA8DjwLQQbGjI71rFv920Ri4VCi2DJf6GjARcsWGJLJZon
 6tb0TgC0RplATrVGVL8cmTkLw3eAkMCNmXQ=

--UE6F6z9ErUa6mISxYppK

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit adbe62e93c1e793ad08d5e913151137b6c24daa4 upstream.

The HiHope RZ/G2H sub board sits below the HiHope RZ/G2H main board.
These boards are identical with the ones for RZ/G2M[N].

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594230511-24790-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile              |  1 +
 arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi   |  2 +-
 .../boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts | 15 +++++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 9c2942510ab5..73cf57a3919b 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -14,6 +14,7 @@ dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb \
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
 			       r8a774c0-ek874-idk-2121wr.dtb
 dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h.dtb
+dtb-$(CONFIG_ARCH_R8A774E1) += r8a774e1-hihope-rzg2h-ex.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-h3ulcb-kf.dtb
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-xs.dtb
diff --git a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
index acfcfd050a6c..178401a34cbf 100644
--- a/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
+++ b/arch/arm64/boot/dts/renesas/hihope-rzg2-ex.dtsi
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree Source for the RZ/G2[MN] HiHope sub board common parts
+ * Device Tree Source for the RZ/G2[HMN] HiHope sub board common parts
  *
  * Copyright (C) 2019 Renesas Electronics Corp.
  */
diff --git a/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
new file mode 100644
index 000000000000..265355e0de5f
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774e1-hihope-rzg2h-ex.dts
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2H sub board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a774e1-hihope-rzg2h.dts"
+#include "hihope-rzg2-ex.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2H with sub board";
+	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2h",
+		     "renesas,r8a774e1";
+};
-- 
2.17.1


--UE6F6z9ErUa6mISxYppK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5211): https://lists.cip-project.org/g/cip-dev/message=
/5211
Mute This Topic: https://lists.cip-project.org/mt/76326751/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--UE6F6z9ErUa6mISxYppK--
