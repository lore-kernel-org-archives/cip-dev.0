Return-Path: <SRS0=oXU2=B7=lists.cip-project.org=bounce+64572+5194+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E494FC433FE
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7224207BB
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EphqSX/E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7224207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5194+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PahrYY4521723x4575YGHbfL; Fri, 21 Aug 2020 03:58:36 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.130424.1598002997752220163
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 02:43:22 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="54954529"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Aug 2020 18:43:21 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 72B574231AD9;
	Fri, 21 Aug 2020 18:43:20 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 03/36] soc: renesas: rcar-sysc: Add r8a774e1 support
Date: Fri, 21 Aug 2020 10:42:39 +0100
Message-Id: <20200821094312.3249-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
References: <20200821094312.3249-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TYO4KlwAJXXmI4zlkaFmRD8Ux4520388AA=
Content-Type: multipart/mixed; boundary="Gl0MSnpUAfryDTEJAHad"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598007516;
 bh=Fl0q0YgixAffizuWiy8XLlNwrOpRC+ttzGQFPlfJG7I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EphqSX/EcefZPW+d28vHTcdlSzUrTFA0Q5j7HL4gmASdkd5pigYOVkKywUqrn+oA8lS
 fX1bfI3sYeFpZGn7s4KO79Obl4g8w8Vv1rTw2rwarL0ndrmGqfOJ3FJ/6AxszVuLkZ5UC
 n2DZtgKqVsi04GN7mwVc6b6eiasG/QsYRfk=

--Gl0MSnpUAfryDTEJAHad

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit f446ade0952aed929186139f3643d714d9d2a855 upstream

Add support for RZ/G2H (R8A774E1) SoC power areas to the R-Car SYSC
driver.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594138692-16816-6-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[Biju: Added SYSC_R8A774E1 in Kconfig to enable the
sysc driver in 4.19.y-cip kernel]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig         |  5 ++++
 drivers/soc/renesas/Makefile        |  1 +
 drivers/soc/renesas/r8a774e1-sysc.c | 43 +++++++++++++++++++++++++++++
 drivers/soc/renesas/rcar-sysc.c     |  3 ++
 drivers/soc/renesas/rcar-sysc.h     |  1 +
 5 files changed, 53 insertions(+)
 create mode 100644 drivers/soc/renesas/r8a774e1-sysc.c

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index f3727aa60aac..3b33e091ccff 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -13,6 +13,7 @@ config SOC_RENESAS
 	select SYSC_R8A774A1 if ARCH_R8A774A1
 	select SYSC_R8A774B1 if ARCH_R8A774B1
 	select SYSC_R8A774C0 if ARCH_R8A774C0
+	select SYSC_R8A774E1 if ARCH_R8A774E1
 	select SYSC_R8A7779 if ARCH_R8A7779
 	select SYSC_R8A7790 if ARCH_R8A7790
 	select SYSC_R8A7791 if ARCH_R8A7791 || ARCH_R8A7793
@@ -53,6 +54,10 @@ config SYSC_R8A774C0
 	bool "RZ/G2E System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
 
+config SYSC_R8A774E1
+	bool "RZ/G2H System Controller support" if COMPILE_TEST
+	select SYSC_RCAR
+
 config SYSC_R8A7779
 	bool "R-Car H1 System Controller support" if COMPILE_TEST
 	select SYSC_RCAR
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index c2263f446921..2e43e2b5dc0e 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_SYSC_R8A77470)	+= r8a77470-sysc.o
 obj-$(CONFIG_SYSC_R8A774A1)	+= r8a774a1-sysc.o
 obj-$(CONFIG_SYSC_R8A774B1)	+= r8a774b1-sysc.o
 obj-$(CONFIG_SYSC_R8A774C0)	+= r8a774c0-sysc.o
+obj-$(CONFIG_SYSC_R8A774E1)	+= r8a774e1-sysc.o
 obj-$(CONFIG_SYSC_R8A7779)	+= r8a7779-sysc.o
 obj-$(CONFIG_SYSC_R8A7790)	+= r8a7790-sysc.o
 obj-$(CONFIG_SYSC_R8A7791)	+= r8a7791-sysc.o
diff --git a/drivers/soc/renesas/r8a774e1-sysc.c b/drivers/soc/renesas/r8a774e1-sysc.c
new file mode 100644
index 000000000000..18449f746455
--- /dev/null
+++ b/drivers/soc/renesas/r8a774e1-sysc.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2H System Controller
+ * Copyright (C) 2020 Renesas Electronics Corp.
+ *
+ * Based on Renesas R-Car H3 System Controller
+ * Copyright (C) 2016-2017 Glider bvba
+ */
+
+#include <linux/kernel.h>
+
+#include <dt-bindings/power/r8a774e1-sysc.h>
+
+#include "rcar-sysc.h"
+
+static const struct rcar_sysc_area r8a774e1_areas[] __initconst = {
+	{ "always-on",	    0, 0, R8A774E1_PD_ALWAYS_ON, -1, PD_ALWAYS_ON },
+	{ "ca57-scu",	0x1c0, 0, R8A774E1_PD_CA57_SCU, R8A774E1_PD_ALWAYS_ON, PD_SCU },
+	{ "ca57-cpu0",	 0x80, 0, R8A774E1_PD_CA57_CPU0, R8A774E1_PD_CA57_SCU, PD_CPU_NOCR },
+	{ "ca57-cpu1",	 0x80, 1, R8A774E1_PD_CA57_CPU1, R8A774E1_PD_CA57_SCU, PD_CPU_NOCR },
+	{ "ca57-cpu2",	 0x80, 2, R8A774E1_PD_CA57_CPU2, R8A774E1_PD_CA57_SCU, PD_CPU_NOCR },
+	{ "ca57-cpu3",	 0x80, 3, R8A774E1_PD_CA57_CPU3, R8A774E1_PD_CA57_SCU, PD_CPU_NOCR },
+	{ "ca53-scu",	0x140, 0, R8A774E1_PD_CA53_SCU, R8A774E1_PD_ALWAYS_ON, PD_SCU },
+	{ "ca53-cpu0",	0x200, 0, R8A774E1_PD_CA53_CPU0, R8A774E1_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu1",	0x200, 1, R8A774E1_PD_CA53_CPU1, R8A774E1_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu2",	0x200, 2, R8A774E1_PD_CA53_CPU2, R8A774E1_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "ca53-cpu3",	0x200, 3, R8A774E1_PD_CA53_CPU3, R8A774E1_PD_CA53_SCU, PD_CPU_NOCR },
+	{ "a3vp",	0x340, 0, R8A774E1_PD_A3VP, R8A774E1_PD_ALWAYS_ON },
+	{ "a3vc",	0x380, 0, R8A774E1_PD_A3VC, R8A774E1_PD_ALWAYS_ON },
+	{ "a2vc1",	0x3c0, 1, R8A774E1_PD_A2VC1, R8A774E1_PD_A3VC },
+	{ "3dg-a",	0x100, 0, R8A774E1_PD_3DG_A, R8A774E1_PD_ALWAYS_ON },
+	{ "3dg-b",	0x100, 1, R8A774E1_PD_3DG_B, R8A774E1_PD_3DG_A },
+	{ "3dg-c",	0x100, 2, R8A774E1_PD_3DG_C, R8A774E1_PD_3DG_B },
+	{ "3dg-d",	0x100, 3, R8A774E1_PD_3DG_D, R8A774E1_PD_3DG_C },
+	{ "3dg-e",	0x100, 4, R8A774E1_PD_3DG_E, R8A774E1_PD_3DG_D },
+};
+
+const struct rcar_sysc_info r8a774e1_sysc_info __initconst = {
+	.areas = r8a774e1_areas,
+	.num_areas = ARRAY_SIZE(r8a774e1_areas),
+	.extmask_offs = 0x2f8,
+	.extmask_val = BIT(0),
+};
diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
index 061ea1be940e..54ea9bb8fca2 100644
--- a/drivers/soc/renesas/rcar-sysc.c
+++ b/drivers/soc/renesas/rcar-sysc.c
@@ -295,6 +295,9 @@ static const struct of_device_id rcar_sysc_matches[] __initconst = {
 #ifdef CONFIG_SYSC_R8A774C0
 	{ .compatible = "renesas,r8a774c0-sysc", .data = &r8a774c0_sysc_info },
 #endif
+#ifdef CONFIG_SYSC_R8A774E1
+	{ .compatible = "renesas,r8a774e1-sysc", .data = &r8a774e1_sysc_info },
+#endif
 #ifdef CONFIG_SYSC_R8A7779
 	{ .compatible = "renesas,r8a7779-sysc", .data = &r8a7779_sysc_info },
 #endif
diff --git a/drivers/soc/renesas/rcar-sysc.h b/drivers/soc/renesas/rcar-sysc.h
index f32b501c93d5..0864ff0a53d8 100644
--- a/drivers/soc/renesas/rcar-sysc.h
+++ b/drivers/soc/renesas/rcar-sysc.h
@@ -58,6 +58,7 @@ extern const struct rcar_sysc_info r8a77470_sysc_info;
 extern const struct rcar_sysc_info r8a774a1_sysc_info;
 extern const struct rcar_sysc_info r8a774b1_sysc_info;
 extern const struct rcar_sysc_info r8a774c0_sysc_info;
+extern const struct rcar_sysc_info r8a774e1_sysc_info;
 extern const struct rcar_sysc_info r8a7779_sysc_info;
 extern const struct rcar_sysc_info r8a7790_sysc_info;
 extern const struct rcar_sysc_info r8a7791_sysc_info;
-- 
2.17.1


--Gl0MSnpUAfryDTEJAHad
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5194): https://lists.cip-project.org/g/cip-dev/message=
/5194
Mute This Topic: https://lists.cip-project.org/mt/76326733/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Gl0MSnpUAfryDTEJAHad--
