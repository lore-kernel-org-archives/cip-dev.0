Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735CDD35E5D
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 09:39:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.68510.1730972383781196925
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 01:39:47 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,265,1725289200"; 
   d="scan'208";a="228129493"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 07 Nov 2024 18:39:46 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.71])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7619441D430C;
	Thu,  7 Nov 2024 18:39:35 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip v2 0/5] Enable CRU, CSI support on RZ/{G2LC, G2UL}
Date: Thu,  7 Nov 2024 09:39:29 +0000
Message-ID: <20241107093934.14574-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 09:39:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17200

Hi All,

This patch series aims to add (and enable) CRU, CSI support on the
Renesas RZ/{G2LC, G2UL} SoCs.

All the patches have been cherry-picked from upstream.

v1->v2
- Fixed build on RISC-V by moving the enabling of CRU and CSI from
  rzg2ul-smarc.dtsi to r9a07g043u11-smarc.dts.

Cheers,
Prabhakar

Biju Das (4):
  media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G2UL CRU
    block
  media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G2UL CSI-2
    block
  arm64: dts: renesas: r9a07g043u: Add CSI and CRU nodes
  arm64: dts: renesas: rzg2ul-smarc: Enable CRU, CSI support

Lad Prabhakar (1):
  arm64: dts: renesas: rzg2lc-smarc: Enable CRU, CSI support

 .../bindings/media/renesas,rzg2l-cru.yaml     | 35 ++++++++--
 .../bindings/media/renesas,rzg2l-csi2.yaml    |  1 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 69 +++++++++++++++++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  8 +++
 arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  8 +++
 5 files changed, 117 insertions(+), 4 deletions(-)


base-commit: 0351950bb8213297af5df9c503242886119127a0
-- 
2.43.0


