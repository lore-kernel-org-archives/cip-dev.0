Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F0DD32D7B
	for <webhook@archiver.kernel.org>; Fri,  5 Dec 2025 14:33:31 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6927.1764945202623019546
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Dec 2025 06:33:27 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: jB8b1Z90Rz20hANQ+CjErw==
X-CSE-MsgGUID: acxNh/rYSPmzDP+LV+R9mg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Dec 2025 23:33:27 +0900
Received: from Ubuntu-22.. (unknown [10.24.1.60])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 108B44179B99;
	Fri,  5 Dec 2025 23:33:25 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/38] soc: renesas: Add RZ/T2H (R9A09G077) config option
Date: Fri,  5 Dec 2025 14:32:35 +0000
Message-ID: <20251205143258.13748-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251205143258.13748-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Dec 2025 14:33:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20929

From: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>

commit b19376dee3da29fe4ea1027ed2061b67efa15112 upstream.

Add a configuration option for the RZ/T2H SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thierry Bultel <thierry.bultel.yh@bp.renesas.com>
Link: https://lore.kernel.org/20250515141828.43444-4-thierry.bultel.yh@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/soc/renesas/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index 791f8c0acdf59..24fab4c39ea70 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -366,6 +366,12 @@ config ARCH_R9A09G057
 	help
 	  This enables support for the Renesas RZ/V2H(P) SoC variants.
 
+config ARCH_R9A09G077
+	bool "ARM64 Platform support for RZ/T2H"
+	default y if ARCH_RENESAS
+	help
+	  This enables support for the Renesas RZ/T2H SoC variants.
+
 endif # ARM64
 
 if RISCV
-- 
2.43.0


