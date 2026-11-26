Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15963.1795706527630766796
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:22:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: srs0=ebed=jp=tuxon.dev=claudiu.beznea@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 9B7ED456EE;
	Thu, 26 Nov 2026 15:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D81B1F000C0;
	Thu, 26 Nov 2026 15:22:05 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 00/27] Renesas: Backport DMA fixes and improvements
Date: Thu, 26 Nov 2026 17:21:36 +0200
Message-ID: <20261126152204.1297798-1-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:22:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25110

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

This series backports cyclic DMA, runtime PM and suspend to RAM
along with preparatory and cleanup patches.

I tried to limit the number of patches per series. Please let me know
if this needs to be further improved and will consider it for the
future sumissions.

Thank you,
Claudiu

Biju Das (1):
  dmaengine: sh: rz-dmac: Add device_tx_status() callback

Claudiu Beznea (21):
  dmaengine: sh: rz-dmac: Protect the driver specific lists
  dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
  dmaengine: sh: rz-dmac: Drop read of CHCTRL register
  dmaengine: sh: rz-dmac: Drop goto instruction and label
  dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
  dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
  dmaengine: sh: rz-dmac: Move interrupt request after everything is set
    up
  dmaengine: sh: rz-dmac: Fix incorrect NULL check for
    list_first_entry()
  dmaengine: sh: rz-dmac: Use list_first_entry_or_null()
  dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
  dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
  dmaengine: sh: rz-dmac: Save the start LM descriptor
  dmaengine: sh: rz-dmac: Add helper to check if the channel is enabled
  dmaengine: sh: rz-dmac: Add helper to check if the channel is paused
  dmaengine: sh: rz-dmac: Use virt-dma APIs for channel descriptor
    processing
  dmaengine: sh: rz-dmac: Refactor pause/resume code
  dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with
    CHCTRL_SETEN
  dmaengine: sh: rz-dmac: Add cyclic DMA support
  dmaengine: sh: rz-dmac: Adjust rz_dmac_chan_get_residue() to return
    error codes
  dmaengine: sh: rz-dmac: Add runtime PM support
  dmaengine: sh: rz-dmac: Add suspend to RAM support

Geert Uytterhoeven (1):
  dmaengine: sh: rz-dmac: Make channel irq local

John Madieu (1):
  dmaengine: sh: rz-dmac: Use rz_lmdesc_setup() to invalidate
    descriptors

Lad Prabhakar (1):
  dmaengine: sh: rz-dmac: Avoid format-overflow warning

Tommaso Merciai (1):
  dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup

Wolfram Sang (1):
  dmaengine: sh: rz-dmac: handle configs where one address is zero

 drivers/dma/sh/rz-dmac.c | 927 +++++++++++++++++++++++++++++++--------
 1 file changed, 747 insertions(+), 180 deletions(-)

--=20
2.43.0

