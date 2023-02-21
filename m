Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5249C6379F
	for <webhook@archiver.kernel.org>; Tue, 21 Feb 2023 08:02:45 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.37724.1676966558851809519
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Feb 2023 00:02:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.97,315,1669042800"; 
   d="scan'208";a="153582897"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 21 Feb 2023 17:02:42 +0900
Received: from localhost.localdomain (unknown [10.226.93.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 591F141CEE67;
	Tue, 21 Feb 2023 17:02:40 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 2/2] pinctrl: renesas: rzg2l: remove unnecessary check from rzg2l_dt_node_to_map()
Date: Tue, 21 Feb 2023 08:02:32 +0000
Message-Id: <20230221080232.24958-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
References: <20230221080232.24958-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Feb 2023 08:02:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10746

commit 41a87e789c7c2cdeb302331043f866c0138f0413 upstream.

This patch removes the unnecessary check from rzg2l_dt_node_to_map()
as the ret value is already negative.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20221108191309.3908415-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c3cdf52b7294..6593e2172d0a 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -425,8 +425,7 @@ static int rzg2l_dt_node_to_map(struct pinctrl_dev *pctldev,
 	ret = -EINVAL;
 
 done:
-	if (ret < 0)
-		rzg2l_dt_free_map(pctldev, *map, *num_maps);
+	rzg2l_dt_free_map(pctldev, *map, *num_maps);
 
 	return ret;
 }
-- 
2.25.1


