Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E4FFCEE95
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 12:10:22 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43850.1772021412384374918
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 04:10:17 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: yrKs6nj7QMKhsA1cFDfvvw==
X-CSE-MsgGUID: LQ9OYvcHReKKdFfWamYDrg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Feb 2026 21:10:17 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.192])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DB9A941A8077;
	Wed, 25 Feb 2026 21:10:15 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 06/25] clk: renesas: rzv2h: Add instance field to struct pll
Date: Wed, 25 Feb 2026 12:09:44 +0000
Message-ID: <20260225121003.129467-7-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
References: <20260225121003.129467-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 12:10:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21937

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 36a23904b4def05bfbb589af9fab5bc06144d241 upstream.

Add a two-bit "instance" member to struct pll and extend the PLL_PACK()
macro to accept an instance parameter.  Initialize all existing PLL
definitions with instance 0 to preserve legacy behavior. This change
enables support for SoCs with multiple PLL instances (for example,
RZ/G3E we have two PLL DSIs).

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251015192611.241920-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cpg.h
index 130e165a7214..496481a5493f 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -16,20 +16,23 @@
  *
  * @offset: STBY register offset
  * @has_clkn: Flag to indicate if CLK1/2 are accessible or not
+ * @instance: PLL instance number
  */
 struct pll {
 	unsigned int offset:9;
 	unsigned int has_clkn:1;
+	unsigned int instance:2;
 };
 
-#define PLL_PACK(_offset, _has_clkn) \
+#define PLL_PACK(_offset, _has_clkn, _instance) \
 	((struct pll){ \
 		.offset = _offset, \
-		.has_clkn = _has_clkn \
+		.has_clkn = _has_clkn, \
+		.instance = _instance \
 	})
 
-#define PLLCA55		PLL_PACK(0x60, 1)
-#define PLLGPU		PLL_PACK(0x120, 1)
+#define PLLCA55		PLL_PACK(0x60, 1, 0)
+#define PLLGPU		PLL_PACK(0x120, 1, 0)
 
 /**
  * struct ddiv - Structure for dynamic switching divider
-- 
2.34.1


