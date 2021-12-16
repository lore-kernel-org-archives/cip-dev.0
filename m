Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A3C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 12:55:16 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.10105.1639659291122281966
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Dec 2021 04:55:15 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,211,1635174000";
   d="scan'208";a="103722247"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Dec 2021 21:55:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 545924012258;
	Thu, 16 Dec 2021 21:55:14 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 20/24] clk: renesas: Rename renesas-rzg2l-cpg.[ch]
 to rzg2l-cpg.[ch]
Date: Thu, 16 Dec 2021 12:54:42 +0000
Message-Id: <20211216125446.15451-21-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211216125446.15451-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 12:55:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7143

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 0aae437ac5c264e8e2cb6c3fead20b44d2fa31d1 upstream.

Rename renesas-rzg2l-cpg.c and renesas-rzg2l-cpg.h to rzg2l-cpg.c resp.
rzg2l-cpg.h, for consistency with other (sub)drivers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/edc442daaedffcf10e835ff479d906fcae0e59db.1626268821.git.geert+renesas@glider.be
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/clk/renesas/Makefile                             | 2 +-
 drivers/clk/renesas/r9a07g044-cpg.c                      | 2 +-
 drivers/clk/renesas/{renesas-rzg2l-cpg.c => rzg2l-cpg.c} | 2 +-
 drivers/clk/renesas/{renesas-rzg2l-cpg.h => rzg2l-cpg.h} | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename drivers/clk/renesas/{renesas-rzg2l-cpg.c => rzg2l-cpg.c} (99%)
 rename drivers/clk/renesas/{renesas-rzg2l-cpg.h => rzg2l-cpg.h} (100%)

diff --git a/drivers/clk/renesas/Makefile b/drivers/clk/renesas/Makefile
index 077fae8b0846..cd104e75dab6 100644
--- a/drivers/clk/renesas/Makefile
+++ b/drivers/clk/renesas/Makefile
@@ -36,7 +36,7 @@ obj-$(CONFIG_CLK_SH73A0)		+= clk-sh73a0.o
 obj-$(CONFIG_CLK_RCAR_GEN2_CPG)		+= rcar-gen2-cpg.o
 obj-$(CONFIG_CLK_RCAR_GEN3_CPG)		+= rcar-gen3-cpg.o
 obj-$(CONFIG_CLK_RCAR_USB2_CLOCK_SEL)	+= rcar-usb2-clock-sel.o
-obj-$(CONFIG_CLK_RZG2L)			+= renesas-rzg2l-cpg.o
+obj-$(CONFIG_CLK_RZG2L)			+= rzg2l-cpg.o
 
 # Generic
 obj-$(CONFIG_CLK_RENESAS_CPG_MSSR)	+= renesas-cpg-mssr.o
diff --git a/drivers/clk/renesas/r9a07g044-cpg.c b/drivers/clk/renesas/r9a07g044-cpg.c
index ae24e0397d3c..fb8e199c7409 100644
--- a/drivers/clk/renesas/r9a07g044-cpg.c
+++ b/drivers/clk/renesas/r9a07g044-cpg.c
@@ -12,7 +12,7 @@
 
 #include <dt-bindings/clock/r9a07g044-cpg.h>
 
-#include "renesas-rzg2l-cpg.h"
+#include "rzg2l-cpg.h"
 
 enum clk_ids {
 	/* Core Clock Outputs exported to DT */
diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
similarity index 99%
rename from drivers/clk/renesas/renesas-rzg2l-cpg.c
rename to drivers/clk/renesas/rzg2l-cpg.c
index 9addc9dae31a..3b3b2c3347f3 100644
--- a/drivers/clk/renesas/renesas-rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -29,7 +29,7 @@
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
 
-#include "renesas-rzg2l-cpg.h"
+#include "rzg2l-cpg.h"
 
 #ifdef DEBUG
 #define WARN_DEBUG(x)	WARN_ON(x)
diff --git a/drivers/clk/renesas/renesas-rzg2l-cpg.h b/drivers/clk/renesas/rzg2l-cpg.h
similarity index 100%
rename from drivers/clk/renesas/renesas-rzg2l-cpg.h
rename to drivers/clk/renesas/rzg2l-cpg.h
-- 
2.17.1


