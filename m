Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6CAC3DA49
	for <webhook@archiver.kernel.org>; Tue, 16 Jul 2024 08:23:18 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.5927.1721118184270232470
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jul 2024 01:23:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; 
   d="scan'208";a="215425987"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 16 Jul 2024 17:23:12 +0900
Received: from localhost.localdomain (unknown [10.226.92.125])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D687E4016D5E;
	Tue, 16 Jul 2024 17:23:10 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/31] mfd: da9061: Fix Failed to set Two-Wire Bus Mode.
Date: Tue, 16 Jul 2024 09:22:17 +0100
Message-ID: <20240716082255.56551-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
References: <20240716082255.56551-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jul 2024 08:23:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16532

From: Jens Hillenstedt <jens.hillenstedt@ise.de>

commit 834382ea32865a4bdeae83ec2dcb9321dc9489f2 upstream.

In da9062_i2c_probe() regmap_clear_bits() tries to access CONFIG_J
register. As CONFIG_J is not present in da9061_aa_writeable_ranges[] probe
of da9061 fails:

  da9062 2-0058: Entering I2C mode!
  da9062 2-0058: Failed to set Two-Wire Bus Mode.
  da9062: probe of 2-0058 failed with error -5

Add CONFIG_J register to da9061_aa_writeable_ranges[].

Fixes: 5c6f0f456351 ("mfd: da9062: Support SMBus and I2C mode")
Signed-off-by: Jens Hillenstedt <jens.hillenstedt@ise.de>
Reviewed-by: Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20220915092004.168744-1-jens.hillenstedt@ise.de
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/da9062-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index 2774b2cbaea6..c2acdbcd5d6b 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -453,6 +453,7 @@ static const struct regmap_range da9061_aa_writeable_ranges[] = {
 	regmap_reg_range(DA9062AA_VBUCK1_B, DA9062AA_VBUCK4_B),
 	regmap_reg_range(DA9062AA_VBUCK3_B, DA9062AA_VBUCK3_B),
 	regmap_reg_range(DA9062AA_VLDO1_B, DA9062AA_VLDO4_B),
+	regmap_reg_range(DA9062AA_CONFIG_J, DA9062AA_CONFIG_J),
 	regmap_reg_range(DA9062AA_GP_ID_0, DA9062AA_GP_ID_19),
 };
 
-- 
2.43.0


