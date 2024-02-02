Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F94C4828E
	for <webhook@archiver.kernel.org>; Fri,  2 Feb 2024 11:38:08 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.20721.1706873883860394125
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Feb 2024 03:38:05 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,237,1701097200"; 
   d="scan'208";a="192658057"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Feb 2024 20:38:05 +0900
Received: from localhost.localdomain (unknown [10.226.93.210])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6511D4000F90;
	Fri,  2 Feb 2024 20:38:03 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 3/6] clk: versaclock3: Avoid unnecessary padding
Date: Fri,  2 Feb 2024 11:37:51 +0000
Message-Id: <20240202113754.202827-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
References: <20240202113754.202827-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Feb 2024 11:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14618

commit 1e8ce92afdbf2dafa345a9b1d91fb14a1487dc7f upstream.

Move long/pointer variables at the beginning of struct to avoid
unnecessary padding.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20231122142310.203169-3-biju.das.jz@bp.renesas.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/clk-versaclock3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-versaclock3.c b/drivers/clk/clk-versaclock3.c
index 2aa5f5f34ddd..ac5f2c43b595 100644
--- a/drivers/clk/clk-versaclock3.c
+++ b/drivers/clk/clk-versaclock3.c
@@ -148,16 +148,16 @@ struct vc3_pfd_data {
 };
 
 struct vc3_pll_data {
+	unsigned long vco_min;
+	unsigned long vco_max;
 	u8 num;
 	u8 int_div_msb_offs;
 	u8 int_div_lsb_offs;
-	unsigned long vco_min;
-	unsigned long vco_max;
 };
 
 struct vc3_div_data {
-	u8 offs;
 	const struct clk_div_table *table;
+	u8 offs;
 	u8 shift;
 	u8 width;
 	u8 flags;
-- 
2.25.1


