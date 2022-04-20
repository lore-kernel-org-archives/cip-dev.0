Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E79C64EBC
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.13676.1650490481389619530
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Apr 2022 14:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.90,276,1643641200";
   d="scan'208";a="117482578"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 21 Apr 2022 06:34:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3450A4108B69;
	Thu, 21 Apr 2022 06:34:37 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/24] ASoC: sh: rz-ssi: Fix dereference of noderef
 expression warning
Date: Wed, 20 Apr 2022 22:34:06 +0100
Message-Id: <20220420213424.27837-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220420213424.27837-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8128

From: Biju Das <biju.das.jz@bp.renesas.com>

commit d40dfb860ad72a32b9c2aeae739a2725f8ce011a upstream.

Fix following sparse warning:
sound/soc/sh/rz-ssi.c:156:15: sparse: warning: dereference of
noderef expression

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/r/20210816132049.28128-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 4e702b7d5b49..d96c1bea047c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -148,7 +148,7 @@ static u32 rz_ssi_reg_readl(struct rz_ssi_priv *priv, uint reg)
 	return readl(priv->base + reg);
 }
 
-static void rz_ssi_reg_mask_setl(struct rz_ssi_priv __iomem *priv, uint reg,
+static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
 				 u32 bclr, u32 bset)
 {
 	u32 val;
-- 
2.17.1


