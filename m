Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E073C54E69
	for <webhook@archiver.kernel.org>; Thu, 14 Mar 2024 19:30:12 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1814.1710444609052472480
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Mar 2024 12:30:09 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.07,126,1708354800"; 
   d="scan'208";a="197762420"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Mar 2024 04:30:08 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.128])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1BB5F4005445;
	Fri, 15 Mar 2024 04:30:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4.19.y-cip 8/9] spi: spi-rpc-if: Check return value of rpcif_sw_init()
Date: Thu, 14 Mar 2024 19:29:49 +0000
Message-Id: <20240314192950.27343-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20240314192950.27343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Mar 2024 19:30:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15316

commit 0b0a281ed7001d4c4f4c47bdc84680c4997761ca upstream.

rpcif_sw_init() can fail so make sure we check the return value
of it and on error exit rpcif_spi_probe() callback with error code.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211025205631.21151-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index 3579675485a5..727d7cf0a6ad 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -139,7 +139,9 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rpc = spi_controller_get_devdata(ctlr);
-	rpcif_sw_init(rpc, parent);
+	error = rpcif_sw_init(rpc, parent);
+	if (error)
+		return error;
 
 	platform_set_drvdata(pdev, ctlr);
 
-- 
2.34.1


