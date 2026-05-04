Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCE2CD342F
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 06:49:54 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9370.1777877388211967274
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 23:49:49 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: EaS1LzviQw+Jjgz80zpuIA==
X-CSE-MsgGUID: JPqpzSOJRzy4IpQLQEU/pQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 May 2026 15:49:49 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.25])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2DD05400754C;
	Mon,  4 May 2026 15:49:47 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 2/9] dt-bindings: clock: renesas,r9a09g057-cpg: Add USB3.0 core clocks
Date: Mon,  4 May 2026 06:49:36 +0000
Message-ID: <20260504064943.7237-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
References: <20260504064943.7237-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 06:49:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22849

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 280b7cdddc3d96c4887fdb31b6766e4db1b2f2a3 upstream.

Add definitions for USB3.0 core clocks in the R9A09G057 CPG DT bindings
header file.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251101050034.738807-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g057-cpg.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
index 5346a898ab60..f91d7f72922a 100644
--- a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
@@ -22,5 +22,9 @@
 #define R9A09G057_GBETH_0_CLK_PTP_REF_I		11
 #define R9A09G057_GBETH_1_CLK_PTP_REF_I		12
 #define R9A09G057_SPI_CLK_SPI			13
+#define R9A09G057_USB3_0_REF_ALT_CLK_P		14
+#define R9A09G057_USB3_0_CLKCORE		15
+#define R9A09G057_USB3_1_REF_ALT_CLK_P		16
+#define R9A09G057_USB3_1_CLKCORE		17
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__ */
-- 
2.34.1


