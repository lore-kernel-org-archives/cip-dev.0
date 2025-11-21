Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B64CFA746
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 08:07:44 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7335.1763712462366911862
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 00:07:42 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: ilRHud+uSG6McUTvHK2cVQ==
X-CSE-MsgGUID: q9kOEWamQ4mprEuBA8fQKQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Nov 2025 17:07:41 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.111])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5521B41B5579;
	Fri, 21 Nov 2025 17:07:40 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 1/6] dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
Date: Fri, 21 Nov 2025 08:07:32 +0000
Message-ID: <20251121080737.20611-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
References: <20251121080737.20611-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 08:07:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20669

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 5e4e8c1415c181ce311a0b5936ef301edd57c5d1 upstream.

Add XSPI core clock definitions to the clock bindings for the Renesas
R9A09G056 and R9A09G057 SoCs. These clocks IDs are used to support XSPI
interface.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250627204237.214635-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[OP: cherry-picked only the RZ/V2H part]
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 include/dt-bindings/clock/renesas,r9a09g057-cpg.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
index 884dbeb1e139..5346a898ab60 100644
--- a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
+++ b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
@@ -21,5 +21,6 @@
 #define R9A09G057_USB2_0_CLK_CORE1		10
 #define R9A09G057_GBETH_0_CLK_PTP_REF_I		11
 #define R9A09G057_GBETH_1_CLK_PTP_REF_I		12
+#define R9A09G057_SPI_CLK_SPI			13
 
 #endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__ */
-- 
2.51.0


