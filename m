Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302A5C3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:31:29 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.59142.1722267074879486248
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:31:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="213908950"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Jul 2024 00:31:25 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0F4B14006A90;
	Tue, 30 Jul 2024 00:31:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 06/13] regulator: renesas-usb-vbus-regulator: Update the default
Date: Mon, 29 Jul 2024 16:30:45 +0100
Message-ID: <20240729153109.510325-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
References: <20240729153109.510325-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:31:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16660

commit 7164122e25b18806f5dce68c8a0bdaa9e4f902a5 upstream.

As the "rzg2l-usb-vbus-regulator" platform device is only created by
drivers/reset/reset-rzg2l-usbphy-ctrl.c, update the default stricter by
replacing ARCH_RZG2L->RESET_RZG2L_USBPHY_CTRL.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Closes: https://lore.kernel.org/all/CAMuHMdX5ayWbLEEa6nAipECVB6H9eCpRg21pu3zYrTdiER0F+Q@mail.gmail.com/
Link: https://patch.msgid.link/20240715134120.312610-1-biju.das.jz@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 5e1303eaf68e..beb53dd91a60 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1482,7 +1482,7 @@ config REGULATOR_RZG2L_VBCTRL
 	depends on ARCH_RZG2L || COMPILE_TEST
 	depends on OF
 	select REGMAP_MMIO
-	default ARCH_RZG2L
+	default RESET_RZG2L_USBPHY_CTRL
 	help
 	  Support for VBUS regulators implemented on Renesas RZ/G2L SoCs.
 
-- 
2.43.0


