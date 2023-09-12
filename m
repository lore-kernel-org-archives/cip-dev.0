Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604FEEE3F15
	for <webhook@archiver.kernel.org>; Tue, 12 Sep 2023 19:59:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.448.1694548760878224845
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Sep 2023 12:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.02,141,1688396400"; 
   d="scan'208";a="175845684"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Sep 2023 04:59:19 +0900
Received: from localhost.localdomain (unknown [10.226.93.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9EA7940A488A;
	Wed, 13 Sep 2023 04:59:17 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/15] Enable MTU3 PWM/Counter support on RZ/G2L SMARC
Date: Tue, 12 Sep 2023 20:59:00 +0100
Message-Id: <20230912195915.607664-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Sep 2023 19:59:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13074

This patch series aims to enable MTU3 PWM/Counter support on RZ/G2L SMARC EVK.

The first 2 patches are dma fixes.
 
All the patches are cherry-picked from the mainline.

This patch series depend upon [1]
[1]
https://lore.kernel.org/cip-dev/20230911162840.1115401-1-biju.das.jz@bp.renesas.com/T/#t

Arnd Bergmann (1):
  mfd: rz-mtu3: Link time dependencies

Biju Das (13):
  dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
  clk: renesas: r9a07g043: Add MTU3a clock and reset entry
  mfd: rz-mtu3: Fix COMPILE_TEST build error
  mfd: rz-mtu3: Reduce critical sections
  mfd: rz-mtu3: Replace raw_spin_lock->spin_lock()
  Documentation: ABI: sysfs-bus-counter: Fix indentation
  counter: rz-mtu3-cnt: Reorder locking sequence for consistency
  pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
  arm64: defconfig: Enable Renesas MTU3a PWM config
  arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
  arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
  arm64: dts: renesas: r9a07g043: Add MTU3a node
  arm64: dts: renesas: rzg2ul-smarc: Add support for enabling MTU3

Hien Huynh (1):
  dmaengine: sh: rz-dmac: Fix destination and source data size setting

 Documentation/ABI/testing/sysfs-bus-counter   |  8 +--
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 70 +++++++++++++++++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   | 11 +++
 .../boot/dts/renesas/r9a07g044c2-smarc.dts    | 12 ++++
 .../boot/dts/renesas/r9a07g044l2-smarc.dts    | 21 ++++++
 .../boot/dts/renesas/r9a07g054l2-smarc.dts    | 20 ++++++
 .../dts/renesas/rzg2l-smarc-pinfunction.dtsi  | 20 ++++++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  | 23 +++++-
 .../dts/renesas/rzg2lc-smarc-pinfunction.dtsi |  9 +++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi | 14 +++-
 .../dts/renesas/rzg2ul-smarc-pinfunction.dtsi |  6 ++
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi | 13 ++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/renesas/r9a07g043-cpg.c           |  3 +
 drivers/counter/rz-mtu3-cnt.c                 |  4 +-
 drivers/dma/sh/rz-dmac.c                      | 17 +++--
 drivers/mfd/Kconfig                           |  1 +
 drivers/mfd/rz-mtu3.c                         | 30 ++++----
 drivers/pwm/Kconfig                           |  2 +-
 drivers/pwm/pwm-rz-mtu3.c                     |  2 +-
 include/linux/mfd/rz-mtu3.h                   | 66 -----------------
 21 files changed, 252 insertions(+), 101 deletions(-)

-- 
2.25.1


