Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8B9C47DA9
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 16:16:06 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.21.1706631360236302709
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jan 2024 08:16:00 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.05,230,1701097200"; 
   d="scan'208";a="196170636"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 31 Jan 2024 01:15:58 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.7])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1AD534003EC2;
	Wed, 31 Jan 2024 01:15:56 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 0/9] Update SSI interrupts for RZ/G2L family and Split out RZ/G2UL DTS/I
Date: Tue, 30 Jan 2024 16:15:46 +0000
Message-Id: <20240130161555.85042-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jan 2024 16:16:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14501

Hi All,

This patch series does the below,
- Updates SSI interrupts for RZ/G2L family
- Splits up RZ/G2UL DTS/I for re-using for RZ/Five SoC

Note, patch #5 has been newly added and rest of the patches have been
cherry-picked from upstream kernel.

Cheers,
Prabhakar

Lad Prabhakar (9):
  ASoC: dt-bindings: renesas,rz-ssi: Update interrupts and
    interrupt-names properties
  ASoC: sh: rz-ssi: Update interrupt handling for half duplex channels
  arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels
  arm64: dts: renesas: r9a07g044: Update IRQ numbers for SSI channels
  arm64: dts: renesas: rzg2ul-smarc: Move selecting PMOD_SCI0_EN to
    board DTS
  arm64: dts: renesas: rzg2ul-smarc: Include SoM DTSI into board DTS
  arm64: dts: renesas: r9a07g043: Introduce SOC_PERIPHERAL_IRQ() macro
    to specify interrupt property
  arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
  arm64: dts: renesas: r9a07g043: Split out RZ/G2UL SoC specific parts

 .../bindings/sound/renesas,rz-ssi.yaml        |  21 +-
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    | 350 ++++++++----------
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  72 ++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  17 +-
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  19 +-
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  19 +-
 arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  14 -
 sound/soc/sh/rz-ssi.c                         |  63 +++-
 8 files changed, 304 insertions(+), 271 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi

-- 
2.34.1


