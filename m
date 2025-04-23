Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD70C369D7
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 21:05:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.493.1745442307910644722
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 14:05:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: QYk7Uf9HTtmBVQUU8uXJAA==
X-CSE-MsgGUID: BmVNrXrHSVuG/G6PUj5sBA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 06:05:07 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C99D4401C946;
	Thu, 24 Apr 2025 06:05:05 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 3/8] i2c: riic: Use local `dev` pointer in `dev_err_probe()`
Date: Wed, 23 Apr 2025 22:04:53 +0100
Message-ID: <20250423210458.14698-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 21:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18586

commit 279c83db24552e83caa09347358473e633e56617 upstream.

Update the `riic_init_hw()` function to use the local `dev` pointer in
calls to `dev_err_probe()`. Previously, `riic_init_hw()` used
`riic->adapter.dev` in error reporting. Since this function is invoked
during the probe phase, the I2C adapter is not yet initialized, leading to
`(null) ...` being printed in error messages. This patch fixes the issue
by consistently using the local `dev` pointer, which points to
`riic->adapter.dev.parent`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 552ad6bb151b..0fcb0814846b 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -320,7 +320,7 @@ static int riic_init_hw(struct riic_dev *riic)
 				      : I2C_MAX_FAST_MODE_FREQ;
 
 	if (t->bus_freq_hz > max_freq)
-		return dev_err_probe(&riic->adapter.dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "unsupported bus speed %uHz (%u max)\n",
 				     t->bus_freq_hz, max_freq);
 
-- 
2.43.0


