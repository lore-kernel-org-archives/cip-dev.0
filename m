Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94557CA0ED9
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 13:51:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.25384.1694526707105340650
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 06:51:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,139,1688396400"; 
   d="scan'208";a="179548607"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Sep 2023 22:51:49 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0F9CC4006DFE;
	Tue, 12 Sep 2023 22:51:47 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 05/12] pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
Date: Tue, 12 Sep 2023 14:51:27 +0100
Message-Id: <20230912135134.299576-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
References: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 13:51:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13066

commit bdebe27e3dc22c11c72b0d1ef4ed30355f154e58 upstream.

Fix the below build warning:
warning: Function parameter or member 'num_channel_ios' not described
in 'rz_mtu3_channel_io_map'

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/pwm-rz-mtu3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index 5c6a65e87dbf..2a90176bf794 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -40,7 +40,7 @@
  * struct rz_mtu3_channel_io_map - MTU3 pwm channel map
  *
  * @base_pwm_number: First PWM of a channel
- * @num: number of IOs on the HW channel.
+ * @num_channel_ios: number of IOs on the HW channel.
  */
 struct rz_mtu3_channel_io_map {
 	u8 base_pwm_number;
-- 
2.25.1


