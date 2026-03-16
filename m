Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4787F506E6
	for <webhook@archiver.kernel.org>; Mon, 16 Mar 2026 14:59:34 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.52441.1773673162325782965
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Mar 2026 07:59:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: BprACyZhR7CqrBcwVRPoNQ==
X-CSE-MsgGUID: ms7r5dtPTDqpqSD0MNQRUQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Mar 2026 23:59:24 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.53])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AD97741B7814;
	Mon, 16 Mar 2026 23:59:23 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/35] dt-bindings: clock: renesas,r9a09g077/87: Add Ethernet clock IDs
Date: Mon, 16 Mar 2026 14:58:41 +0000
Message-ID: <20260316145915.8580-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260316145915.8580-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Mar 2026 14:59:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22396

commit 0dcfb6fcdd085bbfcdfdcf64a7d4a75c63c108af upstream.

Add clock definitions for Ethernet (ETCLK A-E) to both R9A09G077 and
R9A09G087 SoCs. These definitions are required for describing Ethernet
devices in DT.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250904071954.3176806-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h | 5 +++++
 include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
index 0c2ce81a8744..2a805e06487b 100644
--- a/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g077-cpg-mssr.h
@@ -26,5 +26,10 @@
 #define R9A09G077_CLK_PCLKL		14
 #define R9A09G077_SDHI_CLKHS		15
 #define R9A09G077_USB_CLK		16
+#define R9A09G077_ETCLKA		17
+#define R9A09G077_ETCLKB		18
+#define R9A09G077_ETCLKC		19
+#define R9A09G077_ETCLKD		20
+#define R9A09G077_ETCLKE		21
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G077_CPG_H__ */
diff --git a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
index 70ee883f2386..09da0ad33be6 100644
--- a/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
+++ b/include/dt-bindings/clock/renesas,r9a09g087-cpg-mssr.h
@@ -26,5 +26,10 @@
 #define R9A09G087_CLK_PCLKL		14
 #define R9A09G087_SDHI_CLKHS		15
 #define R9A09G087_USB_CLK		16
+#define R9A09G087_ETCLKA		17
+#define R9A09G087_ETCLKB		18
+#define R9A09G087_ETCLKC		19
+#define R9A09G087_ETCLKD		20
+#define R9A09G087_ETCLKE		21
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G087_CPG_H__ */
-- 
2.43.0


