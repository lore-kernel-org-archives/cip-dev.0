Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58766CA0EFD
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:39:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.15351.1755679146753582501
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:39:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: 8tNpnu8tSkufbjGKZ3B5aw==
X-CSE-MsgGUID: r/KR7m86TCmmfU4TWEAu4Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:39:26 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0F8DF415F3C9;
	Wed, 20 Aug 2025 17:39:24 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/22] memory: renesas-rpc-if: Fix RPCIF_DRENR_CDB macro error
Date: Wed, 20 Aug 2025 09:38:18 +0100
Message-ID: <20250820083855.6337-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
References: <20250820083855.6337-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:39:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19779

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
index 23f7f3a08886..200b8a5c2bef 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -57,7 +57,7 @@
 #define RPCIF_DROPR		0x0018	/* R/W */
 
 #define RPCIF_DRENR		0x001C	/* R/W */
-#define RPCIF_DRENR_CDB(o)	(u32)((((o) & 0x3) << 30))
+#define RPCIF_DRENR_CDB(o)	(((u32)((o) & 0x3)) << 30)
 #define RPCIF_DRENR_OCDB(o)	(((o) & 0x3) << 28)
 #define RPCIF_DRENR_ADB(o)	(((o) & 0x3) << 24)
 #define RPCIF_DRENR_OPDB(o)	(((o) & 0x3) << 20)
-- 
2.43.0


