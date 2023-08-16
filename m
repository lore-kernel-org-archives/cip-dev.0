Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF06C41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:21:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.161762.1692195667914663381
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:21:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="176787701"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Aug 2023 23:21:07 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 750514210C2B;
	Wed, 16 Aug 2023 23:21:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 19/31] rtc: class: Fix potential memleak in devm_rtc_allocate_device()
Date: Wed, 16 Aug 2023 15:20:05 +0100
Message-Id: <20230816142017.147173-20-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:21:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12701

From: Shang XiaoJing <shangxiaojing@huawei.com>

commit 60da73808298ff2cfa9f165d55eb3d7aa7078601 upstream.

devm_rtc_allocate_device() will alloc a rtc_device first, and then run
dev_set_name(). If dev_set_name() failed, the rtc_device will memleak.
Move devm_add_action_or_reset() in front of dev_set_name() to prevent
memleak.

unreferenced object 0xffff888110a53000 (size 2048):
  comm "python3", pid 470, jiffies 4296078308 (age 58.882s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 08 30 a5 10 81 88 ff ff  .........0......
    08 30 a5 10 81 88 ff ff 00 00 00 00 00 00 00 00  .0..............
  backtrace:
    [<000000004aac0364>] kmalloc_trace+0x21/0x110
    [<000000000ff02202>] devm_rtc_allocate_device+0xd4/0x400
    [<000000001bdf5639>] devm_rtc_device_register+0x1a/0x80
    [<00000000351bf81c>] rx4581_probe+0xdd/0x110 [rtc_rx4581]
    [<00000000f0eba0ae>] spi_probe+0xde/0x130
    [<00000000bff89ee8>] really_probe+0x175/0x3f0
    [<00000000128e8d84>] __driver_probe_device+0xe6/0x170
    [<00000000ee5bf913>] device_driver_attach+0x32/0x80
    [<00000000f3f28f92>] bind_store+0x10b/0x1a0
    [<000000009ff812d8>] drv_attr_store+0x49/0x70
    [<000000008139c323>] sysfs_kf_write+0x8d/0xb0
    [<00000000b6146e01>] kernfs_fop_write_iter+0x214/0x2d0
    [<00000000ecbe3895>] vfs_write+0x61a/0x7d0
    [<00000000aa2196ea>] ksys_write+0xc8/0x190
    [<0000000046a600f5>] do_syscall_64+0x37/0x90
    [<00000000541a336f>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

Fixes: 24d23181e43d ("rtc: class: check return value when calling dev_set_name()")
Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
Reviewed-by: Yang Yingliang <yangyingliang@huawei.com>
Link: https://lore.kernel.org/r/20221110090810.11225-1-shangxiaojing@huawei.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/class.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 431f16efed2d..c516c215c431 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -374,11 +374,11 @@ struct rtc_device *devm_rtc_allocate_device(struct device *dev)
 
 	rtc->id = id;
 	rtc->dev.parent = dev;
-	err = dev_set_name(&rtc->dev, "rtc%d", id);
+	err = devm_add_action_or_reset(dev, devm_rtc_release_device, rtc);
 	if (err)
 		return ERR_PTR(err);
 
-	err = devm_add_action_or_reset(dev, devm_rtc_release_device, rtc);
+	err = dev_set_name(&rtc->dev, "rtc%d", id);
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.25.1


