Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF8CF6D57
	for <webhook@archiver.kernel.org>; Wed,  2 Oct 2024 17:07:32 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.1130.1727888840918302443
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Oct 2024 10:07:24 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: biju.das.jz@bp.renesas.com)
X-IronPort-AV: E=Sophos;i="6.11,172,1725289200"; 
   d="scan'208";a="224579756"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Oct 2024 02:07:24 +0900
Received: from localhost.localdomain (unknown [10.226.92.106])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 608EC40065CF;
	Thu,  3 Oct 2024 02:07:14 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 00/15] Full duplex audio + RZ/G2UL DU support
Date: Wed,  2 Oct 2024 18:06:49 +0100
Message-ID: <20241002170712.655449-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Oct 2024 17:07:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16966

This patch series aim to add support for
1) RZ/G2UL display
2) Audio full duplex

All the patches are cherry-picked from the mainline

Biju Das (14):
  arm64: dts: renesas: r9a07g0{43,44,54}: Move regulator-vbus device
    node
  pinctrl: renesas: rzg2l: Use dev_err_probe()
  ASoC: sh: rz-ssi: Add full duplex support
  clk: renesas: r9a07g043: Add clock and reset entries for CRU
  clk: renesas: r9a07g043: Add LCDC clock and reset entries
  media: dt-bindings: media: renesas,vsp1: Document RZ/G2UL VSPD
    bindings
  media: dt-bindings: media: renesas,fcp: Document RZ/{G2L,V2L} FCPVD
    bindings
  media: dt-bindings: media: renesas,fcp: Document RZ/G2UL FCPVD
    bindings
  dt-bindings: display: renesas,rzg2l-du: Document RZ/G2UL DU bindings
  drm: renesas: rz-du: Add RZ/G2UL DU Support
  arm64: dts: renesas: r9a07g043u: Add FCPVD node
  arm64: dts: renesas: r9a07g043u: Add VSPD node
  arm64: dts: renesas: r9a07g043u: Add DU node
  arm64: dts: renesas: r9a07g043u11-smarc: Enable DU

Lad Prabhakar (1):
  drm: renesas: Move RZ/G2L MIPI DSI driver to rz-du

 .../bindings/display/renesas,rzg2l-du.yaml    |  32 ++-
 .../bindings/media/renesas,fcp.yaml           |  47 +++-
 .../bindings/media/renesas,vsp1.yaml          |   1 +
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   4 +
 arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |  49 ++++
 .../boot/dts/renesas/r9a07g043u11-smarc.dts   |  50 ++++
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |   4 +
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |   4 +
 .../boot/dts/renesas/rz-smarc-common.dtsi     |   3 -
 .../boot/dts/renesas/rz-smarc-du-adv7513.dtsi |  76 ++++++
 drivers/clk/renesas/r9a07g043-cpg.c           |  43 +++
 drivers/gpu/drm/renesas/rcar-du/Kconfig       |   8 -
 drivers/gpu/drm/renesas/rcar-du/Makefile      |   2 -
 drivers/gpu/drm/renesas/rz-du/Kconfig         |   8 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   2 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   8 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  11 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  |   3 +-
 .../{rcar-du => rz-du}/rzg2l_mipi_dsi.c       |   0
 .../{rcar-du => rz-du}/rzg2l_mipi_dsi_regs.h  |   0
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       |  37 +--
 sound/soc/sh/rz-ssi.c                         | 257 +++++++++++++-----
 22 files changed, 527 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/rz-smarc-du-adv7513.dtsi
 rename drivers/gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi.c (100%)
 rename drivers/gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi_regs.h (100%)

-- 
2.43.0


