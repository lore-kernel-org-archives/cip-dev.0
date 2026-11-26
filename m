Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16098.1795706757019134457
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:25:57 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FE3C4570C;
	Thu, 26 Nov 2026 15:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 666AD1F000C0;
	Thu, 26 Nov 2026 15:25:55 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/11] Renesas: Backport audio and serial support
Date: Thu, 26 Nov 2026 17:25:42 +0200
Message-ID: <20261126152553.1298561-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:26:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25138
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series switches the rz-ssi driver to use cyclic DMA. Along with
it a DMA fix was added. This fix needs to be applied after the rz-ssi is
switched to use cyclic DMA, to avoid any regression.

For bisectability reasons, this series needs to be applied on top of
series https://lore.kernel.org/cip-dev/20261126152204.1297798-1-claudiu.b=
eznea@tuxon.dev/T/#t.

I tried to limit the number of patches per series. Please let me know
if this needs to be further improved and will consider it for the
future sumissions.

Thank you,
Claudiu
=20

Claudiu Beznea (9):
  ASoC: renesas: rz-ssi: Simplify the logic in rz_ssi_stream_is_play()
  ASoC: renesas: rz-ssi: Drop unnecessary if condition
  ASoC: renesas: rz-ssi: Drop the & operator in front of function name
  ASoC: renesas: rz-ssi: Drop goto label
  ASoC: renesas: rz-ssi: Fix playback and capture
  ASoC: renesas: rz-ssi: Add pause support
  ASoC: renesas: rz-ssi: Use generic PCM dmaengine APIs
  dmaengine: sh: rz-dmac: Set the Link End (LE) bit on the last
    descriptor
  arm64: dts: renesas: r9a07g044: Add DMA properties to serial nodes

Dan Carpenter (1):
  ASoC: renesas: rz-ssi: Add a check for negative sample_space

Kuninori Morimoto (1):
  ASoC: renesas: rz-ssi: Use guard() for spin locks

 arch/arm64/boot/dts/renesas/r9a07g044.dtsi |  10 +
 drivers/dma/sh/rz-dmac.c                   |   5 +-
 sound/soc/sh/Kconfig                       |   1 +
 sound/soc/sh/rz-ssi.c                      | 446 +++++++--------------
 4 files changed, 169 insertions(+), 293 deletions(-)

--=20
2.43.0

