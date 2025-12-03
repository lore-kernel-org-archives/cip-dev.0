Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E231AD15D9E
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:41:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18296.1764776461970046583
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:41:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: hvojsThcScuFWf4qTETgjw==
X-CSE-MsgGUID: p89etTZCRsWB462DhExETQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Dec 2025 00:41:04 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id C1C27400CD06;
	Thu,  4 Dec 2025 00:41:03 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 02/11] soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC
Date: Wed,  3 Dec 2025 15:40:49 +0000
Message-ID: <20251203154058.33022-3-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
References: <20251203154058.33022-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20828

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 31d358e611b7cc21349da58dd2c9118c84b0859f upstream.

Add a new Kconfig option, ARCH_R9A09G056, to enable ARM64 platform support
for the Renesas RZ/V2N SoC. Default this option to "y" when ARCH_RENESAS is
enabled, ensuring that support for the RZ/V2N SoC is automatically included.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/soc/renesas/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 49648cf28bd2..c679a6e089b1 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -352,6 +352,12 @@ config ARCH_R9A09G047
 	help
 	  This enables support for the Renesas RZ/G3E SoC variants.
 
+config ARCH_R9A09G056
+	bool "ARM64 Platform support for RZ/V2N"
+	default y if ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/V2N SoC variants.
+
 config ARCH_R9A09G057
 	bool "ARM64 Platform support for RZ/V2H(P)"
 	select RENESAS_RZV2H_ICU
-- 
2.51.0


