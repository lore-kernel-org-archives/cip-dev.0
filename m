Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7101EC41513
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 14:20:39 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.161739.1692195631560341227
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Aug 2023 07:20:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,177,1684767600"; 
   d="scan'208";a="173100187"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2023 23:20:30 +0900
Received: from localhost.localdomain (unknown [10.226.92.162])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id AF23F4210C25;
	Wed, 16 Aug 2023 23:20:28 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 04/31] Documentation: list RTC devres helpers in devres.rst
Date: Wed, 16 Aug 2023 15:19:50 +0100
Message-Id: <20230816142017.147173-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
References: <20230816142017.147173-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Aug 2023 14:20:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12686

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit 4d49ffc7a20dd0b05efb82fbf5b52d7aa57e9f4b upstream.

It's customary to list all devres helpers in devres.rst. Add missing RTC
routines.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201109163409.24301-4-brgl@bgdev.pl
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index bb676570acc3..6ffc0f07404f 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -411,6 +411,10 @@ RESET
   devm_reset_control_get()
   devm_reset_controller_register()
 
+RTC
+  devm_rtc_device_register()
+  devm_rtc_allocate_device()
+
 SERDEV
   devm_serdev_device_open()
 
-- 
2.25.1


