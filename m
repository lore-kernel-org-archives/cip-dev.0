Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F37C25B0F
	for <webhook@archiver.kernel.org>; Fri, 12 Aug 2022 10:13:45 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.8954.1660299214547583633
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Aug 2022 03:13:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,231,1654527600";
   d="scan'208";a="129340338"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 12 Aug 2022 19:13:37 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 253934243969;
	Fri, 12 Aug 2022 19:13:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 09/11] spi: rspi: drop unneeded MODULE_ALIAS
Date: Fri, 12 Aug 2022 11:13:15 +0100
Message-Id: <20220812101317.12380-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220812101317.12380-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Aug 2022 10:13:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9181

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

commit 98c29b35a7e3b1ef7e64a8dd05a4383ea2e2ac72 upstream.

The MODULE_DEVICE_TABLE already creates proper alias for platform
driver.  Having another MODULE_ALIAS causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Link: https://lore.kernel.org/r/20210916164423.134603-1-krzysztof.kozlowski@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 27b5a9cfc904..e5efa0aab5a7 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1449,4 +1449,3 @@ module_platform_driver(rspi_driver);
 MODULE_DESCRIPTION("Renesas RSPI bus driver");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Yoshihiro Shimoda");
-MODULE_ALIAS("platform:rspi");
-- 
2.17.1


