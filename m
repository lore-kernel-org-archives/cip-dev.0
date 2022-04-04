Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BB1C63708
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:46 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.34415.1649075760888079755
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Apr 2022 05:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,234,1643641200";
   d="scan'208";a="116695165"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 04 Apr 2022 21:36:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1C2F44226B03;
	Mon,  4 Apr 2022 21:36:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 14/29] reset: Add
 of_reset_control_get_optional_exclusive()
Date: Mon,  4 Apr 2022 13:35:38 +0100
Message-Id: <20220404123553.25851-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220404123553.25851-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 Apr 2022 18:46:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7977

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c4f5b30dda01f2f6979a9681142de454991182ee upstream.

Add optional variant of of_reset_control_get_exclusive(). If the
requested reset is not specified in the device tree, this function
returns NULL instead of an error.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20211112184413.4391-2-biju.das.jz@bp.renesas.com
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 include/linux/reset.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 05aa9f440f48..13aa754d2269 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -253,6 +253,26 @@ static inline struct reset_control *of_reset_control_get_exclusive(
 	return __of_reset_control_get(node, id, 0, false, false, true);
 }
 
+/**
+ * of_reset_control_get_optional_exclusive - Lookup and obtain an optional exclusive
+ *                                           reference to a reset controller.
+ * @node: device to be reset by the controller
+ * @id: reset line name
+ *
+ * Optional variant of of_reset_control_get_exclusive(). If the requested reset
+ * is not specified in the device tree, this function returns NULL instead of
+ * an error.
+ *
+ * Returns a struct reset_control or IS_ERR() condition containing errno.
+ *
+ * Use of id names is optional.
+ */
+static inline struct reset_control *of_reset_control_get_optional_exclusive(
+				struct device_node *node, const char *id)
+{
+	return __of_reset_control_get(node, id, 0, false, true, true);
+}
+
 /**
  * of_reset_control_get_shared - Lookup and obtain a shared reference
  *                               to a reset controller.
-- 
2.17.1


