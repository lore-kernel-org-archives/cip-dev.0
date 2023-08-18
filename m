Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67612C71136
	for <webhook@archiver.kernel.org>; Fri, 18 Aug 2023 09:28:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7435.1692350893584802847
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Aug 2023 02:28:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,182,1684767600"; 
   d="scan'208";a="173270404"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 18 Aug 2023 18:28:27 +0900
Received: from localhost.localdomain (unknown [10.226.93.81])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id E333341DADA0;
	Fri, 18 Aug 2023 18:28:25 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/14] rtc: isl1208: Drop name variable
Date: Fri, 18 Aug 2023 10:28:00 +0100
Message-Id: <20230818092807.159112-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818092807.159112-1-biju.das.jz@bp.renesas.com>
References: <20230818092807.159112-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Aug 2023 09:28:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12779

commit 380960c40a1d106bba3476c9a010eaf28195115d upstream.

Drop unused name variable from struct isl1208_config.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230623140948.384762-7-biju.das.jz@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/rtc/rtc-isl1208.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index 2d0d76ad710b..503c1c1c519e 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -79,15 +79,14 @@ enum isl1208_id {
 
 /* Chip capabilities table */
 static const struct isl1208_config {
-	const char	name[8];
 	unsigned int	nvmem_length;
 	unsigned	has_tamper:1;
 	unsigned	has_timestamp:1;
 } isl1208_configs[] = {
-	[TYPE_ISL1208] = { "isl1208", 2, false, false },
-	[TYPE_ISL1209] = { "isl1209", 2, true,  false },
-	[TYPE_ISL1218] = { "isl1218", 8, false, false },
-	[TYPE_ISL1219] = { "isl1219", 2, true,  true },
+	[TYPE_ISL1208] = { 2, false, false },
+	[TYPE_ISL1209] = { 2, true,  false },
+	[TYPE_ISL1218] = { 8, false, false },
+	[TYPE_ISL1219] = { 2, true,  true },
 };
 
 static const struct i2c_device_id isl1208_id[] = {
-- 
2.25.1


