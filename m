Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCF0ECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 16:37:47 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com
 [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.1129.1661963862287461618
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 09:37:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bp.renesas.com, ip: 210.160.252.171,
 mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="5.93,278,1654527600";
   d="scan'208";a="131239743"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Sep 2022 01:37:40 +0900
Received: from localhost.localdomain (unknown [10.226.92.133])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 07717402172B;
	Thu,  1 Sep 2022 01:37:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/10] Document RZ/G2UL SOC bindings
Date: Wed, 31 Aug 2022 17:37:25 +0100
Message-Id: <20220831163735.2112470-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 16:37:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9349

This patch series aims to document various IP's present in
RZ/G2UL SoC.

Biju Das (10):
  dt-bindings: arm: renesas: Document Renesas RZ/V2L SoC on SMARC EVK
  dt-bindings: arm: renesas: Document Renesas RZ/G2UL SMARC EVK
  dt-bindings: power: renesas,rzg2l-sysc: Document RZ/G2UL SoC
  dt-bindings: clock: renesas: Document RZ/G2UL SoC
  dt-bindings: pinctrl: renesas: Document RZ/G2UL pinctrl
  dt-bindings: serial: renesas,scif: Document RZ/G2UL SoC
  dt-bindings: serial: renesas,sci: Document RZ/G2UL SoC
  dt-bindings: dma: rz-dmac: Document RZ/G2UL SoC
  dt-bindings: mmc: renesas,sdhi: Document RZ/G2UL SoC
  dt-bindings: net: renesas,etheravb: Document RZ/G2UL SoC

 Documentation/devicetree/bindings/arm/renesas.yaml    | 11 +++++++++++
 .../devicetree/bindings/clock/renesas,rzg2l-cpg.yaml  |  7 ++++---
 .../devicetree/bindings/dma/renesas,rz-dmac.yaml      |  3 ++-
 .../devicetree/bindings/mmc/renesas,sdhi.yaml         |  2 ++
 .../devicetree/bindings/net/renesas,etheravb.yaml     |  3 ++-
 .../bindings/pinctrl/renesas,rzg2l-pinctrl.yaml       |  5 +++--
 .../devicetree/bindings/serial/renesas,sci.yaml       |  2 ++
 .../devicetree/bindings/serial/renesas,scif.yaml      |  3 ++-
 .../bindings/soc/renesas/renesas,rzg2l-sysc.yaml      |  5 +++--
 9 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.25.1


