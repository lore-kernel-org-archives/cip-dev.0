Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06684C4332F
	for <webhook@archiver.kernel.org>; Tue,  8 Nov 2022 12:56:50 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.7381.1667912195619553618
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Nov 2022 04:56:36 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.96,147,1665414000"; 
   d="scan'208";a="139360133"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 08 Nov 2022 21:56:34 +0900
Received: from localhost.localdomain (unknown [10.226.92.61])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5B5C54048F0D;
	Tue,  8 Nov 2022 21:56:32 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/3] SDHI Fixes/enhancements
Date: Tue,  8 Nov 2022 12:56:27 +0000
Message-Id: <20221108125630.3853219-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Nov 2022 12:56:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9944

This patch series aims to add rounding error fixes for selecting
533MHz SDHI source clk and avoid glitches when resetting.

Biju Das (2):
  mmc: renesas_sdhi: Fix rounding errors
  clk: renesas: rzg2l: Support sd clk mux round operation

Wolfram Sang (1):
  mmc: tmio: avoid glitches when resetting

 drivers/clk/renesas/rzg2l-cpg.c      |  2 +-
 drivers/mmc/host/renesas_sdhi_core.c | 48 ++++++++++++++++++----------
 drivers/mmc/host/tmio_mmc.c          |  2 +-
 drivers/mmc/host/tmio_mmc.h          |  6 +++-
 drivers/mmc/host/tmio_mmc_core.c     | 28 ++++++++++++----
 5 files changed, 61 insertions(+), 25 deletions(-)

-- 
2.25.1


