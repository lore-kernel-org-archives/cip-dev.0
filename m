Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B743EC3F6B0
	for <webhook@archiver.kernel.org>; Mon, 15 Aug 2022 16:37:31 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.4469.1660581443659508777
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Aug 2022 09:37:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,238,1654527600";
   d="scan'208";a="129583868"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 16 Aug 2022 01:37:21 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id C711C40171F2;
	Tue, 16 Aug 2022 01:37:19 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/4] Renesas SDHI/DMA/thermal driver fixes and
 improvements
Date: Mon, 15 Aug 2022 17:37:14 +0100
Message-Id: <20220815163718.24056-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Aug 2022 16:37:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9212

Hi All,

This patch series backports SDHI/DMA/thermal driver fixes and
improvements.

Note: All the patches have been cherry picked from 6.0-rc1 kernel.

Cheers,
Prabhakar

Biju Das (2):
  thermal/drivers/rzg2l: Fix comments
  dmaengine: sh: rz-dmac: Add device_synchronize callback

Lad Prabhakar (2):
  mmc: renesas_sdhi: Get the reset handle early in the probe
  mmc: renesas_sdhi: Fix typo's

 drivers/dma/sh/rz-dmac.c                      | 17 +++++++++++++++++
 drivers/mmc/host/renesas_sdhi_core.c          |  8 ++++----
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  4 ++--
 drivers/thermal/rzg2l_thermal.c               | 18 +++++++++++-------
 4 files changed, 34 insertions(+), 13 deletions(-)

-- 
2.17.1


