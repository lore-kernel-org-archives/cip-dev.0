Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E679C7EE24
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 08:54:01 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.83642.1684140838403917181
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 01:53:58 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.99,276,1677510000"; 
   d="scan'208";a="162922189"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 15 May 2023 17:53:56 +0900
Received: from localhost.localdomain (unknown [10.226.93.20])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2E9F64009672;
	Mon, 15 May 2023 17:53:53 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/4] Add RZ/G2L DMA Reset support
Date: Mon, 15 May 2023 09:53:48 +0100
Message-Id: <20230515085352.25794-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 08:54:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11446

This patch series aims to add DMA reset support fot RZ/G2L alike SoCs

Also added a patch to remove unused variable.

All these patches are cherry-picked from the mainline.

Biju Das (3):
  dt-bindings: dma: rz-dmac: Document clock-names and reset-names
  dmaengine: sh: rz-dmac: Add reset support
  arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMAC
    nodes

Geert Uytterhoeven (1):
  dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size

 .../bindings/dma/renesas,rz-dmac.yaml          | 14 ++++++++++++++
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi     |  2 ++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi     |  2 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi     |  2 ++
 drivers/dma/sh/rz-dmac.c                       | 18 ++++++++++++++----
 5 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.25.1


