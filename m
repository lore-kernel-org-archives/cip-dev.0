Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0C6CF6D52
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1130.1727888840918302443
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579753"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:20 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BBB5140071FC;
	Thu,  3 Oct 2024 02:07:18 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 02/15] pinctrl: renesas: rzg2l: Use dev_err_probe()
Date: Wed,  2 Oct 2024 18:06:51 +0100
Message-ID: <20241002170712.655449-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
References: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16965

commit f73f63b24491fa43641daf3b6162d2a451bd8481 upstream.

Replace dev_err()->dev_err_probe() to simpilfy probe
helper functions.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240728090421.7136-1-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 37 +++++++++----------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index c4d9bcb6f80f..7306a100153f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2200,16 +2200,13 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 		return -EPROBE_DEFER;
 
 	ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
-	if (ret) {
-		dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "Unable to parse gpio-ranges\n");
 
 	if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
-	    of_args.args[2] != pctrl->data->n_port_pins) {
-		dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n");
-		return -EINVAL;
-	}
+	    of_args.args[2] != pctrl->data->n_port_pins)
+		return dev_err_probe(pctrl->dev, -EINVAL,
+				     "gpio-ranges does not match selected SOC\n");
 
 	chip->names = pctrl->data->port_pins;
 	chip->request = rzg2l_gpio_request;
@@ -2241,10 +2238,8 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 	pctrl->gpio_range.name = chip->label;
 	pctrl->gpio_range.gc = chip;
 	ret = devm_gpiochip_add_data(pctrl->dev, chip, pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to add GPIO controller\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO controller\n");
 
 	dev_dbg(pctrl->dev, "Registered gpio controller\n");
 
@@ -2325,22 +2320,16 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctrl *pctrl)
 
 	ret = devm_pinctrl_register_and_init(pctrl->dev, &pctrl->desc, pctrl,
 					     &pctrl->pctl);
-	if (ret) {
-		dev_err(pctrl->dev, "pinctrl registration failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "pinctrl registration failed\n");
 
 	ret = pinctrl_enable(pctrl->pctl);
-	if (ret) {
-		dev_err(pctrl->dev, "pinctrl enable failed\n");
-		return ret;
-	}
+	if (ret)
+		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
 
 	ret = rzg2l_gpio_register(pctrl);
-	if (ret) {
-		dev_err(pctrl->dev, "failed to add GPIO chip: %i\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(pctrl->dev, ret, "failed to add GPIO chip\n");
 
 	return 0;
 }
-- 
2.43.0


