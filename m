Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AFBC433EF
	for <webhook@archiver.kernel.org>; Wed, 29 Dec 2021 10:15:44 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com
 [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web09.49296.1640772936778058884
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Dec 2021 02:15:42 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.172,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.88,244,1635174000";
   d="scan'208";a="105602446"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 29 Dec 2021 19:15:41 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 16440423D00D;
	Wed, 29 Dec 2021 19:15:40 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/31] ASoC: sh: rz-ssi: Fix wrong operator used
 issue
Date: Wed, 29 Dec 2021 10:15:06 +0000
Message-Id: <20211229101530.22783-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211229101530.22783-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Dec 2021 10:15:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7284

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1b5d1d3a2f77250707225509cadc17997bab4353 upstream.

Fix wrong operator used issue reported by Coverity by replacing |
operator with & operator.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20210816182336.29959-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index d96c1bea047c..341815476244 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -368,7 +368,7 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	/* Wait for idle */
 	timeout = 100;
 	while (--timeout) {
-		if (rz_ssi_reg_readl(ssi, SSISR) | SSISR_IIRQ)
+		if (rz_ssi_reg_readl(ssi, SSISR) & SSISR_IIRQ)
 			break;
 		udelay(1);
 	}
-- 
2.17.1


