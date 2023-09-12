Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA47EE3F20
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.450.1694548765259810954
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="179568806"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:39 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CFE8540A488A;
	Wed, 13 Sep 2023 04:59:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/15] counter: rz-mtu3-cnt: Reorder locking sequence for consistency
Date: Tue, 12 Sep 2023 20:59:09 +0100
Message-Id: <20230912195915.607664-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13083

commit 39266b642ccdc154b48eae11263920956fa0e89e upstream.

All functions except rz_mtu3_count_enable_write(), call
pm_runtime_{get,put} inside the lock. For consistency do the same here.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/r/ZH8Fmom8vZ4DwxqA@duo.ucw.cz
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230725154611.227556-1-biju.das.jz@bp.renesas.com/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/counter/rz-mtu3-cnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/rz-mtu3-cnt.c b/drivers/counter/rz-mtu3-cnt.c
index a371bab68499..d761e74d6aa3 100644
--- a/drivers/counter/rz-mtu3-cnt.c
+++ b/drivers/counter/rz-mtu3-cnt.c
@@ -496,8 +496,8 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 	int ret = 0;
 
 	if (enable) {
-		pm_runtime_get_sync(ch->dev);
 		mutex_lock(&priv->lock);
+		pm_runtime_get_sync(ch->dev);
 		ret = rz_mtu3_initialize_counter(counter, count->id);
 		if (ret == 0)
 			priv->count_is_enabled[count->id] = true;
@@ -506,8 +506,8 @@ static int rz_mtu3_count_enable_write(struct counter_device *counter,
 		mutex_lock(&priv->lock);
 		rz_mtu3_terminate_counter(counter, count->id);
 		priv->count_is_enabled[count->id] = false;
-		mutex_unlock(&priv->lock);
 		pm_runtime_put(ch->dev);
+		mutex_unlock(&priv->lock);
 	}
 
 	return ret;
-- 
2.25.1


