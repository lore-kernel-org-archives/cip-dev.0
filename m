Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFE0EB64DD
	for <webhook@archiver.kernel.org>; Tue, 18 Jul 2023 15:32:20 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.10790.1689694336488386504
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jul 2023 08:32:16 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,214,1684767600"; 
   d="scan'208";a="173423800"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 19 Jul 2023 00:32:15 +0900
Received: from mulinux.home (unknown [10.226.93.62])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8DB6B400563A;
	Wed, 19 Jul 2023 00:32:13 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 0/6] Add eMMC/SDHI support
Date: Tue, 18 Jul 2023 16:32:06 +0100
Message-Id: <20230718153212.327448-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jul 2023 15:32:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12403

Dear All,

this series adds eMMC/SDHI support to the Renesas RZ/V2M EVK v2
platform.
All the patches are cherry-picked from mainline.

Cheers,
Fab

Fabrizio Castro (4):
  dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
  mmc: renesas_sdhi: Add RZ/V2M compatible string
  arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
  arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support

Geert Uytterhoeven (1):
  pinctrl: renesas: rzv2m: Handle non-unique subnode names

Phil Edworthy (1):
  clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries

 .../devicetree/bindings/mmc/renesas,sdhi.yaml |   1 +
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 123 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  48 +++++++
 drivers/clk/renesas/r9a09g011-cpg.c           |  20 +++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  11 ++
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |  28 ++--
 6 files changed, 223 insertions(+), 8 deletions(-)

-- 
2.34.1


