Return-Path: <fabrizio.castro.jz@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5D9C30654
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 17:17:03 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.38998.1688404613916851886
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jul 2023 10:16:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: fabrizio.castro.jz@renesas.com)
X-IronPort-AV: E=Sophos;i="6.01,178,1684767600"; 
   d="scan'208";a="170260234"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Jul 2023 02:16:52 +0900
Received: from dev.ree.adwin.renesas.com (unknown [10.226.38.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 563F04003863;
	Tue,  4 Jul 2023 02:16:50 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 5.10.y-cip 0/5] Add SDHI support to the Renesas RZ/V2M
Date: Mon,  3 Jul 2023 18:16:44 +0100
Message-Id: <20230703171649.15862-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 17:17:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12190

Dear All,

this series adds eMMC/SDHI support to the Renesas RZ/V2M SoC.

I would like to highlight that the driver patch looks fairly
different from upstream, and the reason for it is that the
SDHI IP found inside the RZ/V2M requires a couple of quirks.
The SDHI quirks have been reworked quite a bit over time, and
the implementation the upstream driver patch relies on depends
on changes spanning the renesas sdhi core, the renesas internal
DMAC implementation, and the CPG implemenation.
Considering the amount of patches that would need backporting
in order to get a similar solution to the one found upstream,
and considering that the changes would affect several platforms,
I thought that adapting the solution for the quirks found
upstream to the solution currently available in v5.10.y-cip is the
best way to go, as it adds the required support without introducing
unnecessary risks.

Cheers,
Fab

Fabrizio Castro (4):
  dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support
  mmc: renesas_sdhi: Add RZ/V2M compatible string
  arm64: dts: renesas: r9a09g011: Add eMMC and SDHI support
  arm64: dts: renesas: rzv2mevk2: Add uSD card and eMMC support

Phil Edworthy (1):
  clk: renesas: r9a09g011: Add SDHI/eMMC clock and reset entries

 .../devicetree/bindings/mmc/renesas,sdhi.yaml |   1 +
 .../boot/dts/renesas/r9a09g011-v2mevk2.dts    | 123 ++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g011.dtsi    |  48 +++++++
 drivers/clk/renesas/r9a09g011-cpg.c           |  20 +++
 drivers/mmc/host/renesas_sdhi_core.c          |   1 +
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |   3 +
 6 files changed, 196 insertions(+)

-- 
2.25.1


