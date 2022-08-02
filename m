Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA51C00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 11:09:41 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4777.1659438571969390531
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 04:09:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,210,1654527600";
   d="scan'208";a="128236792"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 02 Aug 2022 20:09:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.246])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AF15F400D4CE;
	Tue,  2 Aug 2022 20:09:29 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Pavel Machek <pavel@denx.de>
Cc: nobuhiro1.iwamatsu@toshiba.co.jp,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 17/24] pinctrl: renesas: rzg2l: Improve
 rzg2l_gpio_register()
Date: Tue,  2 Aug 2022 12:08:43 +0100
Message-Id: <20220802110850.1496057-18-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 11:09:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9014

commit 2e08ab0427fe3e33a92a37cfe3b6db340ab7397f upstream.

Update rzg2l_gpio_register() to use driver data for chip->names
and check for gpio-range. This allows reusing the driver for
SoC's with different port pin definitions(eg:- RZ/G2UL SoC has
fewer ports compared to RZ/G2L and port pin definitions are
different).

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20220206194614.13209-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index ccee9c9e2e22..cb805502fb0f 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1090,12 +1090,12 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
 	}
 
 	if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
-	    of_args.args[2] != ARRAY_SIZE(rzg2l_gpio_names)) {
+	    of_args.args[2] != pctrl->data->n_port_pins) {
 		dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n");
 		return -EINVAL;
 	}
 
-	chip->names = rzg2l_gpio_names;
+	chip->names = pctrl->data->port_pins;
 	chip->request = rzg2l_gpio_request;
 	chip->free = rzg2l_gpio_free;
 	chip->get_direction = rzg2l_gpio_get_direction;
-- 
2.25.1


