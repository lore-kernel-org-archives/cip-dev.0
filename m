Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1526EB64DD
	for <webhook@archiver.kernel.org>; Fri, 30 Jun 2023 15:51:28 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.16054.1688140282961533098
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Jun 2023 08:51:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,171,1684767600"; 
   d="scan'208";a="169865866"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 01 Jul 2023 00:51:23 +0900
Received: from localhost.localdomain (unknown [10.226.93.15])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 12E6A400CE6D;
	Sat,  1 Jul 2023 00:51:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 1/3] i2c: rzv2m: Drop extra space
Date: Fri, 30 Jun 2023 16:51:16 +0100
Message-Id: <20230630155118.584293-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
References: <20230630155118.584293-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 30 Jun 2023 15:51:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12164

commit 3c4b88de7e2f61a8c742c7cf0ae59e83cf1e6b35 upstream.

Drop extra space from the I2C_RZV2M config help description.

Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/i2c/busses/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index b81f92cd5ccc..f9c0275a446b 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -966,7 +966,7 @@ config I2C_RZV2M
 	depends on ARCH_RENESAS || COMPILE_TEST
 	help
 	  If you say yes to this option, support will be included for the
-	  Renesas RZ/V2M  I2C interface.
+	  Renesas RZ/V2M I2C interface.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-rzv2m.
-- 
2.25.1


