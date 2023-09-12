Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B78CA0ED4
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 13:51:58 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.25384.1694526707105340650
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 06:51:52 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,139,1688396400"; 
   d="scan'208";a="179548611"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 12 Sep 2023 22:51:52 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5EAE7400B9C7;
	Tue, 12 Sep 2023 22:51:50 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 06/12] mfd: rz-mtu3: Fix COMPILE_TEST build error
Date: Tue, 12 Sep 2023 14:51:28 +0100
Message-Id: <20230912135134.299576-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
References: <20230912135134.299576-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 13:51:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13067

commit 94f34d99401c23247f940e9d1b6408236a3a3769 upstream.

When (MFD) RZ_MTU3=m and PWM_RZ_MTU3=y, It hits the below error
aarch64-linux-gnu-ld: rz-mtu3.c:(.text+0x544): undefined reference to `mfd_remove_devices'

Fix this issue by selecting MFD_CORE.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Closes: https://lore.kernel.org/linux-pwm/20230718090023.wo6m6ffzaifgctkj@pengutronix.de/
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20230718134314.118333-1-biju.das.jz@bp.renesas.com
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index dacac8c076e6..49d57d5d625a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1249,6 +1249,7 @@ config MFD_SC27XX_PMIC
 config RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a core driver"
 	depends on (ARCH_RZG2L && OF) || COMPILE_TEST
+	select MFD_CORE
 	help
 	  Select this option to enable Renesas RZ/G2L MTU3a core driver for
 	  the Multi-Function Timer Pulse Unit 3 (MTU3a) hardware available
-- 
2.25.1


