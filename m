Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D5C001B0
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:02:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.38620.1688403736033447206
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:02:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="170259398"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jul 2023 02:02:13 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 7AA58400EF84;
	Tue,  4 Jul 2023 02:02:12 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCH 5.10.y-cip 0/4] Add Renesas RZ/V2M PWC support
Date: Mon,  3 Jul 2023 18:02:07 +0100
Message-Id: <20230703170211.15484-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:02:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12185

Dear All,

this series adds support for the PWC IP found inside the Renesas
RZ/V2M SoC.

Thanks,
Fab

Fabrizio Castro (4):
  dt-bindings: soc: renesas: Add RZ/V2M PWC
  soc: renesas: Add PWC support for RZ/V2M
  arm64: dts: renesas: r9a09g011: Add PWC support
  arm64: dts: renesas: v2mevk2: Add PWC support

 .../soc/renesas/renesas,rzv2m-pwc.yaml        |  56 +++++++
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    |   5 +
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |   8 +
 drivers/soc/renesas/Kconfig                   |   4 +
 drivers/soc/renesas/Makefile                  |   1 +
 drivers/soc/renesas/pwc-rzv2m.c               | 150 ++++++++++++++++++
 6 files changed, 224 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c

-- 
2.25.1


