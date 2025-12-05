Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026DCD32D7D
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:42 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7063.1764945182570660387
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:41 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: 3tUC3WU4RVSLq6zALTIJIA==
X-CSE-MsgGUID: wUDcwq1VR5qd9rq/6xh/yw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:41 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 064B24179CE0;
	Fri,  5 Dec 2025 23:33:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 23/38] clk: renesas: Add CPG/MSSR support to RZ/N2H SoC
Date: Fri,  5 Dec 2025 14:32:43 +0000
Message-ID: <20251205143258.13748-24-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20937

commit 8b8ca279752e0c9ae242a110ecb513dd85e5844f upstream.

Add clock driver support for the Renesas RZ/N2H (R9A09G087) SoC by reusing
the existing RZ/T2H (R9A09G077) CPG/MSSR implementation, as both SoCs
share the same clock and reset architecture.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250617155757.149597-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/Kconfig            | 5 +++++
 drivers/clk/renesas/Makefile           | 1 +
 drivers/clk/renesas/r9a09g077-cpg.c    | 1 +
 drivers/clk/renesas/renesas-cpg-mssr.c | 6 ++++++
 4 files changed, 13 insertions(+)

diff --git a/drivers/clk/renesas/Kconfig b/drivers/clk/renesas/Kconfig
index 45f9ae5b6ef1a..6a5a046649906 100644
--- a/drivers/clk/renesas/Kconfig
+++ b/drivers/clk/renesas/Kconfig
@@ -44,6 +44,7 @@ config CLK_RENESAS
 	select CLK_R9A09G056 if ARCH_R9A09G056
 	select CLK_R9A09G057 if ARCH_R9A09G057
 	select CLK_R9A09G077 if ARCH_R9A09G077
+	select CLK_R9A09G087 if ARCH_R9A09G087
 	select CLK_SH73A0 if ARCH_SH73A0
 
 if CLK_RENESAS
@@ -213,6 +214,10 @@ config CLK_R9A09G077
 	bool "RZ/T2H clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSSR
 
+config CLK_R9A09G087
+	bool "RZ/N2H clock support" if COMPILE_TEST
+	select CLK_RENESAS_CPG_MSSR
+
 config CLK_SH73A0
 	bool "SH-Mobile AG5 clock support" if COMPILE_TEST
 	select CLK_RENESAS_CPG_MSTP
diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index d8d894a15d24b..d28eb276a1534 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -41,6 +41,7 @@ obj-$(CONFIG_CLK_R9A09G047)		+= r9a09g047-cpg.o
 obj-$(CONFIG_CLK_R9A09G056)		+= r9a09g056-cpg.o
 obj-$(CONFIG_CLK_R9A09G057)		+= r9a09g057-cpg.o
 obj-$(CONFIG_CLK_R9A09G077)		+= r9a09g077-cpg.o
+obj-$(CONFIG_CLK_R9A09G087)		+= r9a09g077-cpg.o
 obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 
 # Family
diff --git a/drivers/clk/renesas/r9a09g077-cpg.c b/drivers/clk/renesas/r9a09g077-cpg.c
index b83ef933ae0fb..baf917ff4bebb 100644
--- a/drivers/clk/renesas/r9a09g077-cpg.c
+++ b/drivers/clk/renesas/r9a09g077-cpg.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 
 #include <dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h>
+#include <dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h>
 #include "renesas-cpg-mssr.h"
 
 #define RZT2H_REG_BLOCK_SHIFT	11
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 2ae0b513b9734..9ea544d00634b 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -948,6 +948,12 @@ static const struct of_device_id cpg_mssr_match[] = {
 		.compatible = "renesas,r9a09g077-cpg-mssr",
 		.data = &r9a09g077_cpg_mssr_info,
 	},
+#endif
+#ifdef CONFIG_CLK_R9A09G087
+	{
+		.compatible = "renesas,r9a09g087-cpg-mssr",
+		.data = &r9a09g077_cpg_mssr_info,
+	},
 #endif
 	{ /* sentinel */ }
 };
-- 
2.43.0


