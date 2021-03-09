Return-Path: <SRS0=rLHD=IH=lists.cip-project.org=bounce+64572+6255+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BEEC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:52 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6816564F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6816564F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6255+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id OrV4YY4521723xk0Eoy7YGjS; Tue, 09 Mar 2021 08:37:52 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:51 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591060"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:51 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 54A0D40A2DC7;
	Wed, 10 Mar 2021 01:37:50 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 39/40] arm64: dts: renesas: Add support for MIPI Adapter V2.1 connected to HiHope RZ/G2M
Date: Tue,  9 Mar 2021 16:36:55 +0000
Message-Id: <20210309163656.20944-40-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: M3Hxs8zYny1av4goPAQ67Wthx4520388AA=
Content-Type: multipart/mixed; boundary="n0hY4tpCwluuokqhT84X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307872;
 bh=6GCrBKA+X2L38MLrKksP1eQvvqqijLZwcT/li3NbJvk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=jYG9PcoFxv7u1rYd/kMnGsdOcMI7myvdB/1a5u821uIOrLdRsnNrbF2X3NvGDzjS0qx
 +E8S4kKRwKiuIbLo6k+PucZsY5OYsAImF6LjmcAMEvlbpMdy/YuMSCUlOEZ4JXpUdq7CQ
 aqCcFGsKoA541MoplfhVP3kKFNmt22iavoY=

--n0hY4tpCwluuokqhT84X

commit 661495164934e15bc8a192f8eafa1ec9655e74f0 upstream.

Add support for AISTARVISION MIPI Adapter V2.1 board connected to HiHope
RZ/G2M board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201020125134.22625-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied changes to Makefile]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  3 +-
 .../r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts     | 29 +++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 6c569ebe4f9f..5a70517385d9 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -4,7 +4,8 @@ dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m.dtb \
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex.dtb \
 			       r8a774a1-hihope-rzg2m-rev2-ex.dtb
 dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb \
-			       r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb
+			       r8a774a1-hihope-rzg2m-rev2-ex-idk-1110wr.dtb \
+			       r8a774a1-hihope-rzg2m-ex-mipi-2.1.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb \
 			       r8a774b1-hihope-rzg2n-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb \
diff --git a/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts
new file mode 100644
index 000000000000..5c91e0d7e67b
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774a1-hihope-rzg2m-ex-mipi-2.1.dts
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2M board
+ * connected with aistarvision-mipi-v2-adapter board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774a1-hihope-rzg2m-ex.dts"
+#include "hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2M with sub board connected with aistarvision-mipi-v2-adapter board";
+	compatible = "hoperun,hihope-rzg2m", "renesas,r8a774a1";
+};
+
+/*
+ * On RZ/G2M SoC LSI V1.3 CSI40 supports only 4 lane mode.
+ * HiHope RZ/G2M Rev.4.0 board is based on LSI V1.3 so disable csi40 and
+ * imx219 as the imx219 endpoint driver supports only 2 lane mode.
+ */
+&csi40 {
+	status = "disabled";
+};
+
+&imx219 {
+	status = "disabled";
+};
-- 
2.17.1


--n0hY4tpCwluuokqhT84X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6255): https://lists.cip-project.org/g/cip-dev/message=
/6255
Mute This Topic: https://lists.cip-project.org/mt/81205398/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--n0hY4tpCwluuokqhT84X--
