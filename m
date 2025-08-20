Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C168CA0EFD
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.15474.1755679628275340829
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: L8umezg3TVWqKhkHTVp6SA==
X-CSE-MsgGUID: AaFVomo6R46SRglcyknITA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:18 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 99874401A64C;
	Wed, 20 Aug 2025 17:47:16 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/23] memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
Date: Wed, 20 Aug 2025 09:45:57 +0100
Message-ID: <20250820084645.6988-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19806

commit bf657e234ac12923b579b13d8b9f1b5ca0519697 upstream.

Fix the below macro error found while moving the reg definitions
to renesas-rpc-if-regs.h in the later patch.

ERROR: Macros with complex values should be enclosed in parentheses

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250401143537.224047-3-biju.das.jz@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 7fbd36fa1a1b4..11461f6ceb71a 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -56,7 +56,7 @@
 #define RPCIF_DROPR		0x0018	/* R/W */
 
 #define RPCIF_DRENR		0x001C	/* R/W */
-#define RPCIF_DRENR_CDB(o)	(u32)((((o) & 0x3) << 30))
+#define RPCIF_DRENR_CDB(o)	(((u32)((o) & 0x3)) << 30)
 #define RPCIF_DRENR_OCDB(o)	(((o) & 0x3) << 28)
 #define RPCIF_DRENR_ADB(o)	(((o) & 0x3) << 24)
 #define RPCIF_DRENR_OPDB(o)	(((o) & 0x3) << 20)
-- 
2.43.0


