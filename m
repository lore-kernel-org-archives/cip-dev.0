Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CF4C7EE2A
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:52:49 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.3502.1686037961551066056
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:52:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.00,219,1681138800"; 
   d="scan'208";a="162379909"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Jun 2023 16:52:39 +0900
Received: from localhost.localdomain (unknown [10.226.92.247])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 68E474187F12;
	Tue,  6 Jun 2023 16:52:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/8] Add MTU3 core/counter driver support for RZ/G2L alike SoCs
Date: Tue,  6 Jun 2023 08:52:27 +0100
Message-Id: <20230606075235.183132-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:52:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11841

This patch series aims to add MTU3 core/counter driver support for RZ/G2L alike
SoCs.

All these patches are cherry-picked from the mainline.

It is tested with Rotary encoder[1]
[1] https://www.mouser.co.uk/ProductDetail/Alps-Alpine/EC11E15244B2?qs=m0BA540hBPfDpUEkDmFV5A%3D%3D


Biju Das (8):
  clk: renesas: r9a07g044: Add MTU3a clock and reset entry
  dt-bindings: timer: Document RZ/G2L MTU3a bindings
  mfd: Add Renesas RZ/G2L MTU3a core driver
  Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and
    external_input_phase_clock_select
  counter: Add Renesas RZ/G2L MTU3a counter driver
  MAINTAINERS: Add entries for Renesas RZ/G2L MTU3a counter driver
  arm64: dts: renesas: r9a07g044: Add MTU3a node
  arm64: dts: renesas: r9a07g054: Add MTU3a node

 Documentation/ABI/testing/sysfs-bus-counter   |  32 +
 .../bindings/timer/renesas,rz-mtu3.yaml       | 302 ++++++
 MAINTAINERS                                   |   8 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  70 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  70 ++
 drivers/clk/renesas/r9a07g044-cpg.c           |   5 +-
 drivers/counter/Kconfig                       |  11 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/rz-mtu3-cnt.c                 | 902 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/rz-mtu3.c                         | 391 ++++++++
 drivers/mfd/rz-mtu3.h                         | 147 +++
 include/linux/mfd/rz-mtu3.h                   | 257 +++++
 14 files changed, 2206 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
 create mode 100644 drivers/counter/rz-mtu3-cnt.c
 create mode 100644 drivers/mfd/rz-mtu3.c
 create mode 100644 drivers/mfd/rz-mtu3.h
 create mode 100644 include/linux/mfd/rz-mtu3.h

-- 
2.25.1


