Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4FC3DA7E
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 15:35:29 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.58893.1722267324064889186
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 08:35:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.09,246,1716217200"; 
   d="scan'208";a="217878944"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 30 Jul 2024 00:35:23 +0900
Received: from localhost.localdomain (unknown [10.226.92.63])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D9FC24017D6C;
	Tue, 30 Jul 2024 00:35:21 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 07/13] regulator: Further restrict RZG2L USB VBCTRL regulator dependencies
Date: Mon, 29 Jul 2024 16:34:52 +0100
Message-ID: <20240729153504.510443-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
References: <20240729153504.510443-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 15:35:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16675

From: Mark Brown <broonie@kernel.org>

commit e975d955c07cbc2cd6a83a5d8235d8373441fdb9 upstream.

Since the regulator can't be used without the USB controller also
tighten the dependency to match, as well as the default.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20240726-regulator-restrict-rzg2l-v1-1-640e508896e2@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 75ccde6e8e64..44821e2f70bd 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1234,7 +1234,7 @@ config REGULATOR_UNIPHIER
 
 config REGULATOR_RZG2L_VBCTRL
 	tristate "Renesas RZ/G2L USB VBUS regulator driver"
-	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on RESET_RZG2L_USBPHY_CTRL || COMPILE_TEST
 	depends on OF
 	select REGMAP_MMIO
 	default RESET_RZG2L_USBPHY_CTRL
-- 
2.43.0


