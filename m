Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F560C0015E
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 14:11:40 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.8578.1689689493732484416
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 07:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173413946"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2023 23:11:32 +0900
Received: from localhost.localdomain (unknown [10.226.92.137])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3E0B84007F26;
	Tue, 18 Jul 2023 23:11:30 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 0/6]  Add RZ/{G2L,G2LC,V2L} MTU3 PWM support.
Date: Tue, 18 Jul 2023 15:11:23 +0100
Message-Id: <20230718141129.119809-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 14:11:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12391

This patch series aims to add support for RZ/{G2L,G2LC,V2L}
MTU3 PWM driver.

All the patches are cherry-picked from the mainline
except patch#4-patch#6. The trivial patches#4-#6 are
cherry-picked from next.

Biju Das (5):
  arm64: defconfig: Enable Renesas MTU3a counter config
  pwm: Add Renesas RZ/G2L MTU3a PWM driver
  arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
  arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
  arm64: defconfig: Enable Renesas MTU3a PWM config

Lad Prabhakar (1):
  arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS

 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  42 ++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  21 +
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    |  20 +
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  20 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  23 +-
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi |   9 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  42 +-
 arch/arm64/configs/defconfig                  |   4 +
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-rz-mtu3.c                     | 551 ++++++++++++++++++
 11 files changed, 712 insertions(+), 32 deletions(-)
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c

-- 
2.25.1


