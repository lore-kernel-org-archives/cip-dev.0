Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BDDCCFA05
	for <webhook@archiver.kernel.org>; Mon,  3 Nov 2025 11:38:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18662.1762169901935752604
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Nov 2025 03:38:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: uIKLW3VgR8KoVlA5W5fcRQ==
X-CSE-MsgGUID: 7duYyNITTZePZ2I189jW3w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Nov 2025 20:38:21 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.166])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4085F41A027C;
	Mon,  3 Nov 2025 20:38:19 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 6.12.y-cip 01/22] soc: renesas: Add config option for RZ/V2N (R9A09G056) SoC
Date: Mon,  3 Nov 2025 12:37:45 +0100
Message-ID: <20251103113817.36331-2-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
References: <20251103113817.36331-1-john.madieu.xa@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Nov 2025 11:38:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20319

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 31d358e611b7cc21349da58dd2c9118c84b0859f ]

Add a new Kconfig option, ARCH_R9A09G056, to enable ARM64 platform support
for the Renesas RZ/V2N SoC. Default this option to "y" when ARCH_RENESAS is
enabled, ensuring that support for the RZ/V2N SoC is automatically included.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250407191628.323613-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
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
2.25.1


