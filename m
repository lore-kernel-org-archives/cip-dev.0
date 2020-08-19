Return-Path: <SRS0=RLIh=B5=lists.cip-project.org=bounce+64572+5146+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2863C433EA
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:12 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6967208B3
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="r4fTu5KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6967208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5146+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RyeRYY4521723xfzIuDg7UUW; Wed, 19 Aug 2020 09:45:12 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.91601.1597855005191174500
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Aug 2020 09:36:48 -0700
X-IronPort-AV: E=Sophos;i="5.76,332,1592838000"; 
   d="scan'208";a="54769729"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2020 01:36:48 +0900
X-Received: from localhost.localdomain (unknown [172.29.53.200])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9432E400967A;
	Thu, 20 Aug 2020 01:36:46 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 06/12] arm64: dts: renesas: Add HiHope RZ/G2M Rev.3.0/4.0 sub board support
Date: Wed, 19 Aug 2020 17:36:28 +0100
Message-Id: <20200819163634.5430-7-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
References: <20200819163634.5430-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: kVSeNcBNTiWgTS4yUtiL1hKtx4520388AA=
Content-Type: multipart/mixed; boundary="DtA3Z0kOxF5LJ8NLohhi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597855512;
 bh=uPir4niat3sSrP9jqVTw9Ga59VROcvMrwpKjRa0OupA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=r4fTu5KXRCUBkVVEVdnhcfnSQhlftb1K3DHRxQ8JhDPvimZ4bCGEeTn+jZUUNM14McV
 9U649BPHGDbkNZGyr1pXTHDsYV3tpmfOtSj79Ecu0Po11KzTfGP7tegDflHLqwgtNfgfZ
 zpL44x+f3Z+zZYZrpxkO7+xaTfyHeLZIkRg=

--DtA3Z0kOxF5LJ8NLohhi

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 035329301e633c28601f333f16a73c29e3819fac upstream.

The HiHope RZ/G2M sub board sits below the HiHope RZ/G2M Rev.3.0/4.0
main board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Link: https://lore.kernel.org/r/1593004330-5039-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  3 ++-
 .../dts/renesas/r8a774a1-hihope-rzg2m-ex.dts  | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 103d525f1852..3420c56e70ac 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,7 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb \
 			       r8a774a1-hihope-rzg2m-rev2.dtb
-dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex.dtb
+dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb \
+			       r8a774a1-hihope-rzg2m-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-rev2-ex.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
new file mode 100644
index 000000000000..a5ca86196a7b
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex.dts
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M Rev.3.0/4.0 connected to
+ * sub board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+#include "r8a774a1-hihope-rzg2m.dts"
+#include "hihope-rzg2-ex.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2M with sub board";
+	compatible = "hoperun,hihope-rzg2-ex", "hoperun,hihope-rzg2m",
+		     "renesas,r8a774a1";
+};
+
+/* SW43 should be OFF, if in ON state SATA port will be activated */
+&pciec1 {
+	status = "okay";
+};
-- 
2.17.1


--DtA3Z0kOxF5LJ8NLohhi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5146): https://lists.cip-project.org/g/cip-dev/message=
/5146
Mute This Topic: https://lists.cip-project.org/mt/76290776/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DtA3Z0kOxF5LJ8NLohhi--
