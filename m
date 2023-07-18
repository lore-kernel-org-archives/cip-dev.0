Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA5FEB64DC
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 15:26:30 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.10729.1689693987594879117
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 08:26:28 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173423007"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2023 00:26:25 +0900
Received: from mulinux.home (unknown [10.226.93.62])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7330B4007143;
	Wed, 19 Jul 2023 00:26:23 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 0/4] Add PWC support
Date: Tue, 18 Jul 2023 16:26:18 +0100
Message-Id: <20230718152622.327364-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 15:26:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12398

Dear All,

this series add PWC support to 6.1.y-cip.
All the patches are cherry-picked from mainline.

Cheers,
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
 drivers/soc/renesas/pwc-rzv2m.c               | 141 ++++++++++++++++++
 6 files changed, 215 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml
 create mode 100644 drivers/soc/renesas/pwc-rzv2m.c

-- 
2.34.1


