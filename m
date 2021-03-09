Return-Path: <SRS0=DKPO=IH=lists.cip-project.org=bounce+64572+6256+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172EEC43331
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCC1664F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCC1664F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6256+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fPGwYY4521723xlrkveq03Mk; Tue, 09 Mar 2021 08:37:53 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:53 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342285"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:52 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A32F040A3D20;
	Wed, 10 Mar 2021 01:37:51 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 40/40] arm64: dts: renesas: Add support for MIPI Adapter V2.1 connected to HiHope RZ/G2N
Date: Tue,  9 Mar 2021 16:36:56 +0000
Message-Id: <20210309163656.20944-41-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: SfnuLL9yd5ypxe1qnGiXDgO7x4520388AA=
Content-Type: multipart/mixed; boundary="pl9aaOj0HR7i8wLKPtpu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307873;
 bh=Pwrzva88gNXe/tc4iO8pFhLlf+vu61p6joJZakHHnjo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=WgV7Godnpwr4Ysjac2vQZ737G2W1/8VjqCrzn3GAUl180OXvv88sP+KaA3kHKZ5eBdn
 h8X2rYxFhEI+sdoQ8uUDgvCMcEH5r99fLZs5+DnaxTlYEdvpBfBL5hm7LHZ8IbHg4Cc3o
 4dt5ahvbiNv9X4AfW/AKhXaXYWWGX6UFQxc=

--pl9aaOj0HR7i8wLKPtpu

commit bdf0c8ea8c63d9e288ff06fc300e2eb8bd332d1c upstream.

Add support for AISTARVISION MIPI Adapter V2.1 board connected to HiHope
RZ/G2N board.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20201020125134.22625-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[PL: manually applied changes to Makefile]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile             |  3 ++-
 .../r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 5a70517385d9..3a1673fdd6cb 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -9,7 +9,8 @@ dtb-$(CONFIG_ARCH_R8A774A1) += r8a774a1-hihope-rzg2m-ex-idk-1110wr.dtb \
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n.dtb \
 			       r8a774b1-hihope-rzg2n-rev2.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex.dtb \
-			       r8a774b1-hihope-rzg2n-rev2-ex.dtb
+			       r8a774b1-hihope-rzg2n-rev2-ex.dtb \
+			       r8a774b1-hihope-rzg2n-ex-mipi-2.1.dtb
 dtb-$(CONFIG_ARCH_R8A774B1) += r8a774b1-hihope-rzg2n-ex-idk-1110wr.dtb \
 			       r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb
 dtb-$(CONFIG_ARCH_R8A774C0) += r8a774c0-cat874.dtb r8a774c0-ek874.dtb \
diff --git a/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts
new file mode 100644
index 000000000000..ce8e3bcc7dc9
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-ex-mipi-2.1.dts
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the HiHope RZ/G2N board
+ * connected with aistarvision-mipi-v2-adapter board
+ *
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a774b1-hihope-rzg2n-ex.dts"
+#include "hihope-rzg2-ex-aistarvision-mipi-adapter-2.1.dtsi"
+
+/ {
+	model = "HopeRun HiHope RZ/G2N with sub board connected with aistarvision-mipi-v2-adapter board";
+	compatible = "hoperun,hihope-rzg2n", "renesas,r8a774b1";
+};
-- 
2.17.1


--pl9aaOj0HR7i8wLKPtpu
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6256): https://lists.cip-project.org/g/cip-dev/message=
/6256
Mute This Topic: https://lists.cip-project.org/mt/81205399/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pl9aaOj0HR7i8wLKPtpu--
