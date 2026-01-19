Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC3D489BA
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 12:54:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34158.1768827247991069381
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 04:54:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: xHifUmuRTZuqENPsXCqoIA==
X-CSE-MsgGUID: 0X5FPCqZTOu03Rd3eSbwAg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 19 Jan 2026 21:54:07 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3E23541319E4;
	Mon, 19 Jan 2026 21:54:05 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 1/5] dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
Date: Mon, 19 Jan 2026 12:53:59 +0000
Message-ID: <20260119125403.32197-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
References: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 12:54:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21660

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5e4e8c1415c181ce311a0b5936ef301edd57c5d1 upstream.

Add XSPI core clock definitions to the clock bindings for the Renesas
R9A09G056 and R9A09G057 SoCs. These clocks IDs are used to support XSPI
interface.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627204237.214635-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: cherry-pick only the RZ/V2N part]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g056-cpg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g056-cpg.h b/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
index f4905b27f8d9..a9af5af9e3a1 100644
--- a/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g056-cpg.h
@@ -20,5 +20,6 @@
 #define R9A09G056_USB2_0_CLK_CORE0		9
 #define R9A09G056_GBETH_0_CLK_PTP_REF_I		10
 #define R9A09G056_GBETH_1_CLK_PTP_REF_I		11
+#define R9A09G056_SPI_CLK_SPI			12
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G056_CPG_H__ */
-- 
2.51.0


