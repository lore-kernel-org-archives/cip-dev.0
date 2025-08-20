Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 766A9CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:10 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.15332.1755679615607846173
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 01:47:10 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-CSE-ConnectionGUID: TpOCSLSAREalZ7MAVLS1bQ==
X-CSE-MsgGUID: 1VzaJhIsS86v9bDwcxT3OA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 20 Aug 2025 17:47:09 +0900
Received: from localhost.localdomain (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1AFAF40138ED;
	Wed, 20 Aug 2025 17:47:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/23] clk: renesas: rzv2h: Use devm_kmemdup_array()
Date: Wed, 20 Aug 2025 09:45:53 +0100
Message-ID: <20250820084645.6988-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
References: <20250820084645.6988-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 08:47:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19802

From: Raag Jadav <raag.jadav@intel.com>

commit 338b505d564c1ea04d5ad0495dd25098a475f168 upstream.

Convert to use devm_kmemdup_array() which is more robust.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250610072809.1808464-1-raag.jadav@intel.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/clk/renesas/rzv2h-cpg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/renesas/rzv2h-cpg.c b/drivers/clk/renesas/rzv2h-cpg.c
index d60907e209772..47b1f1e0cae86 100644
--- a/drivers/clk/renesas/rzv2h-cpg.c
+++ b/drivers/clk/renesas/rzv2h-cpg.c
@@ -1031,8 +1031,8 @@ static int __init rzv2h_cpg_probe(struct platform_device *pdev)
 	/* Adjust for CPG_BUS_m_MSTOP starting from m = 1 */
 	priv->mstop_count -= 16;
 
-	priv->resets = devm_kmemdup(dev, info->resets, sizeof(*info->resets) *
-				    info->num_resets, GFP_KERNEL);
+	priv->resets = devm_kmemdup_array(dev, info->resets, info->num_resets,
+					  sizeof(*info->resets), GFP_KERNEL);
 	if (!priv->resets)
 		return -ENOMEM;
 
-- 
2.43.0


