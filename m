Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7191DC41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:59 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161754.1692195654103012015
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787685"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:55 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 25B954210C25;
	Wed, 16 Aug 2023 23:20:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/31] rtc: class: check return value when calling dev_set_name()
Date: Wed, 16 Aug 2023 15:20:00 +0100
Message-Id: <20230816142017.147173-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12696

From: Yang Yingliang <yangyingliang@huawei.com>

commit 24d23181e43d72ca692a479e70dfe5b0b5dd33f1 upstream.

I got a null-ptr-deref report when doing fault injection test:

BUG: kernel NULL pointer dereference, address: 0000000000000000
RIP: 0010:strcmp+0xc/0x20
Call Trace:
 __devm_rtc_register_device.cold.7+0x16a/0x2df
 rv3029_probe+0x4b1/0x770 [rtc_rv3029c2]
 rv3029_i2c_probe+0x141/0x180 [rtc_rv3029c2]
 i2c_device_probe+0xa07/0xbb0
 really_probe+0x285/0xc30

If dev_set_name() fails, dev_name() is null, it causes null-ptr-deref,
we need check the return value of dev_set_name().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20211012041629.2504158-1-yangyingliang@huawei.com
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 99ee40642cb6..edd84ee38005 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -373,7 +373,9 @@ struct rtc_device *devm_rtc_allocate_device(struct device *dev)
 
 	rtc->id = id;
 	rtc->dev.parent = dev;
-	dev_set_name(&rtc->dev, "rtc%d", id);
+	err = dev_set_name(&rtc->dev, "rtc%d", id);
+	if (err)
+		return ERR_PTR(err);
 
 	err = devm_add_action_or_reset(dev, devm_rtc_release_device, rtc);
 	if (err)
-- 
2.25.1


