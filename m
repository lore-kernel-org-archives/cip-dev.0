Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55691C369C2
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 09:11:27 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.2723.1745572277578265580
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 02:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: SFXHjx9ISimz83XCiaLNkg==
X-CSE-MsgGUID: ReaVvCLkRbGs4d5OsfQ3vw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Apr 2025 18:11:17 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7408241FE019;
	Fri, 25 Apr 2025 18:11:15 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 08/15] i2c: riic: Simplify unsupported bus speed handling
Date: Fri, 25 Apr 2025 10:10:50 +0100
Message-ID: <20250425091057.33752-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 09:11:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18612

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 71dacb2565ed9d2839adb8e2a80ef30185c29035 upstream.

Simplify checking for unsupported bus speeds and reporting errors by
factoring out the calculation of the maximum bus speed, and by using the
dev_err_probe() helper.

While at it, use "%u" for u32, and improve the error message.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index b4e9a6aae7ca0..a6cfc195baf80 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -317,16 +317,13 @@ static int riic_init_hw(struct riic_dev *riic)
 	struct i2c_timings *t = &riic->i2c_t;
 	struct device *dev = riic->adapter.dev.parent;
 	bool fast_mode_plus = riic->info->fast_mode_plus;
+	u32 max_freq = fast_mode_plus ? I2C_MAX_FAST_MODE_PLUS_FREQ
+				      : I2C_MAX_FAST_MODE_FREQ;
 
-	if ((!fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_FREQ) ||
-	    (fast_mode_plus && t->bus_freq_hz > I2C_MAX_FAST_MODE_PLUS_FREQ)) {
-		dev_err(&riic->adapter.dev,
-			"unsupported bus speed (%dHz). %d max\n",
-			t->bus_freq_hz,
-			fast_mode_plus ? I2C_MAX_FAST_MODE_PLUS_FREQ :
-					 I2C_MAX_FAST_MODE_FREQ);
-		return -EINVAL;
-	}
+	if (t->bus_freq_hz > max_freq)
+		return dev_err_probe(&riic->adapter.dev, -EINVAL,
+				     "unsupported bus speed %uHz (%u max)\n",
+				     t->bus_freq_hz, max_freq);
 
 	rate = clk_get_rate(riic->clk);
 
-- 
2.43.0


