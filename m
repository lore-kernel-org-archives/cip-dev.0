Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8CBC3DA41
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:04:05 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.9353.1689847435190774745
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:03:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,218,1684767600"; 
   d="scan'208";a="173888271"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 20 Jul 2023 19:03:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.157])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 10A074005B3B;
	Thu, 20 Jul 2023 19:03:51 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip v2 00/13] Add RZ/{G2L,G2LC,V2L} MTU3 support.
Date: Thu, 20 Jul 2023 11:03:37 +0100
Message-Id: <20230720100350.247386-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:04:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12445

This patch series aims to add support for RZ/{G2L,G2LC,V2L}
MTU3 core and PWM driver.

All the patches are cherry-picked from the mainline
except patch#11-patch#13. The trivial patches#11-#13 are
cherry-picked from next.

v1->v2:
 * Add WARN_ON for rz_mtu3_pwm_get_state() in patch#8 as suggested by pavel.

Biju Das (10):
  clk: renesas: r9a07g044: Add MTU3a clock and reset entry
  dt-bindings: timer: Document RZ/G2L MTU3a bindings
  mfd: Add Renesas RZ/G2L MTU3a core driver
  arm64: defconfig: Enable Renesas MTU3a counter config
  pwm: Add Renesas RZ/G2L MTU3a PWM driver
  arm64: dts: renesas: r9a07g044: Add MTU3a node
  arm64: dts: renesas: r9a07g054: Add MTU3a node
  arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
  arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
  arm64: defconfig: Enable Renesas MTU3a PWM config

Lad Prabhakar (1):
  arm64: dts: renesas: rzg2lc-smarc: Include SoM DTSI into board DTS

Uwe Kleine-König (1):
  pwm: Add a device-managed function to add PWM chips

Wolfram Sang (1):
  arm64: dts: renesas: rzg2l-smarc: Use proper bool operator

 .../bindings/timer/renesas,rz-mtu3.yaml       | 302 ++++++++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  70 +++
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    |  42 ++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    |  21 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  70 +++
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    |  20 +
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  |  20 +
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |  23 +-
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi |   9 +
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  42 +-
 arch/arm64/configs/defconfig                  |   2 +
 drivers/clk/renesas/r9a07g044-cpg.c           |   5 +-
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rz-mtu3.c                         | 392 +++++++++++++
 drivers/mfd/rz-mtu3.h                         | 147 +++++
 drivers/pwm/Kconfig                           |  11 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/core.c                            |  19 +
 drivers/pwm/pwm-rz-mtu3.c                     | 554 ++++++++++++++++++
 include/linux/mfd/rz-mtu3.h                   | 257 ++++++++
 include/linux/pwm.h                           |   3 +
 22 files changed, 1988 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
 create mode 100644 drivers/mfd/rz-mtu3.c
 create mode 100644 drivers/mfd/rz-mtu3.h
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c
 create mode 100644 include/linux/mfd/rz-mtu3.h

-- 
2.25.1


