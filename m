Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F805C433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 10:15:48 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.49376.1640772940300083487
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 02:15:47 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,244,1635174000";
   d="scan'208";a="105094683"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Dec 2021 19:15:47 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4A21C423CEBB;
	Wed, 29 Dec 2021 19:15:46 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 11/31] iio: adc: rzg2l_adc: Fix -EBUSY timeout
 error return
Date: Wed, 29 Dec 2021 10:15:10 +0000
Message-Id: <20211229101530.22783-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 10:15:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7288

From: Colin Ian King <colin.king@canonical.com>

commit 9909a395e9807aa79145c9289d0c13d0133359a2 upstream.

Currently when a timeout occurs in rzg2l_adc_hw_init the error -EBUSY is
assigned to ret but the error code is used as the function is hard-coded
to return 0.  The variable ret is 0 before entering the while-loop hence
the fix is just to return ret at the end of the function to return the
success 0 or -EBUSY return code.

Addresses-Coverity: ("Unused value")
Fixes: d484c21bacfa ("iio: adc: Add driver for Renesas RZ/G2L A/D converter")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/20210817172111.495897-1-colin.king@canonical.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/iio/adc/rzg2l_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rzg2l_adc.c b/drivers/iio/adc/rzg2l_adc.c
index 919108d798ba..6472170be9d1 100644
--- a/drivers/iio/adc/rzg2l_adc.c
+++ b/drivers/iio/adc/rzg2l_adc.c
@@ -390,7 +390,7 @@ static int rzg2l_adc_hw_init(struct rzg2l_adc *adc)
 exit_hw_init:
 	clk_disable_unprepare(adc->pclk);
 
-	return 0;
+	return ret;
 }
 
 static void rzg2l_adc_pm_runtime_disable(void *data)
-- 
2.17.1


