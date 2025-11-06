Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32320CCFA1B
	for <webhook@archiver.kernel.org>; Thu,  6 Nov 2025 10:40:37 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11740.1762425629102090874
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Nov 2025 02:40:29 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: r0Dn/0SvQPStbd+hT0jgIQ==
X-CSE-MsgGUID: 9q9kXTVvS9u/LyFV+lhCqA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 06 Nov 2025 19:40:28 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.83])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 598C64003FD6;
	Thu,  6 Nov 2025 19:40:27 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.12.y-cip 1/9] dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP core clocks
Date: Thu,  6 Nov 2025 10:40:16 +0000
Message-ID: <20251106104024.28947-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Nov 2025 10:40:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20451

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit ad227dab306543208a0658357a82712e678a06f4 upstream.

Add definitions for USB2 PHY core clocks and Gigabit Ethernet PTP
reference core clocks in the R9A09G057 CPG DT bindings header file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407165202.197570-8-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g057-cpg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
index 541e6d719bd6..884dbeb1e139 100644
--- a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
@@ -17,5 +17,9 @@
 #define R9A09G057_CM33_CLK0			6
 #define R9A09G057_CST_0_SWCLKTCK		7
 #define R9A09G057_IOTOP_0_SHCLK			8
+#define R9A09G057_USB2_0_CLK_CORE0		9
+#define R9A09G057_USB2_0_CLK_CORE1		10
+#define R9A09G057_GBETH_0_CLK_PTP_REF_I		11
+#define R9A09G057_GBETH_1_CLK_PTP_REF_I		12
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__ */
-- 
2.51.0


