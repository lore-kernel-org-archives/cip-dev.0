Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AFEC88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 14:02:00 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.40048.1789135314861274946
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 07:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=xuxu=hd=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C779442E97;
	Fri, 11 Sep 2026 14:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD54F1F000FF;
	Fri, 11 Sep 2026 14:01:52 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH linux-5.10.y-cip 00/14] mmc: renesas_sdhi: Backport old info1 register layout
Date: Fri, 11 Sep 2026 17:01:37 +0300
Message-ID: <20260911140151.2119555-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 14:02:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24132

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Some early Gen3 SoCs have the DTRANEND1 bit at a different location than
all later SoCs. Series backports necessary patches to differentiate b/w
old and new register layout. While at it, and since the code is aligned
for doing it now, backport the patches to enable RZ/G2N and RZ/G2E
though their own compatible.

All the patches backported here (except RZ/G2N and RZ/G2E ones) are
already present in v6.1 and v6.12 CIP kernels.

Thank you,
Claudiu

Geert Uytterhoeven (1):
  mmc: renesas_sdhi: Add missing checks for the presence of quirks

Lad Prabhakar (2):
  mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
  mmc: renesas_sdhi: Add OF entry for RZ/G2E SoC

Wolfram Sang (10):
  mmc: renesas_sdhi: remove accessor function for internal_dmac
  mmc: tmio: add callback for dma irq
  mmc: renesas_sdhi: remove outdated headers
  mmc: renesas_sdhi: remove a stale comment
  mmc: renesas_sdhi: make 'fixed_addr_mode' a quirk
  mmc: renesas_sdhi: make 'dmac_only_one_rx' a quirk
  mmc: renesas_sdhi: style fix for proper function bodies
  mmc: renesas_sdhi: add quirk for broken register layout
  mmc: renesas_sdhi: improve naming of DMA struct
  mmc: renesas_sdhi: take DMA end interrupts into account

Yoshihiro Shimoda (1):
  mmc: renesas_sdhi: Refactor renesas_sdhi_probe()

 drivers/mmc/host/renesas_sdhi.h               |  25 +-
 drivers/mmc/host/renesas_sdhi_core.c          |  96 +------
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 269 ++++++++++++++----
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   3 +-
 drivers/mmc/host/tmio_mmc.h                   |   1 +
 drivers/mmc/host/tmio_mmc_core.c              |   3 +
 6 files changed, 236 insertions(+), 161 deletions(-)

--=20
2.43.0


