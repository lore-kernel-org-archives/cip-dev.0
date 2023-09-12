Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D5EE3F1B
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.450.1694548765259810954
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="179568803"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:37 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9AA1640A488A;
	Wed, 13 Sep 2023 04:59:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 08/15] Documentation: ABI: sysfs-bus-counter: Fix indentation
Date: Tue, 12 Sep 2023 20:59:08 +0100
Message-Id: <20230912195915.607664-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
References: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13082

commit 3a91388002afb03521b03c0cc1b7f371e3b1151a upstream.

Fix the indentation of the KernelVersion, Contact, and Description in
external_input_phase_clock_select_available block by replacing
spaces with tabs similar to other blocks.

Reported-by: Pavel Machek <pavel@denx.de>
Closes: https://lore.kernel.org/r/ZH8D3lCobUJP2T4K@duo.ucw.cz/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230721151243.282435-1-biju.das.jz@bp.renesas.com/
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/ABI/testing/sysfs-bus-counter | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index 2f1e4d8e50f6..5f4d6dc539c6 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -22,11 +22,11 @@ Description:
 			phase clock.
 
 What:		/sys/bus/counter/devices/counterX/external_input_phase_clock_select_available
-KernelVersion:  6.1
-Contact:        linux-iio@vger.kernel.org
+KernelVersion:	6.4
+Contact:	linux-iio@vger.kernel.org
 Description:
-                Discrete set of available values for the respective device
-                configuration are listed in this file.
+		Discrete set of available values for the respective device
+		configuration are listed in this file.
 
 What:		/sys/bus/counter/devices/counterX/countY/count
 KernelVersion:	5.2
-- 
2.25.1


