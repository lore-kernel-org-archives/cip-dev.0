Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B6105D9B5
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 09:42:02 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.102575.1775641313321168496
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 02:41:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: QL+sLiOjTmCaVYu+SueUjw==
X-CSE-MsgGUID: CB5U1NhNSXmd0r8tSygkgQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 08 Apr 2026 18:41:52 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.8])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8BB6D40116C8;
	Wed,  8 Apr 2026 18:41:51 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/7] Add RZ/V2N TSU support
Date: Wed,  8 Apr 2026 09:41:43 +0000
Message-ID: <20260408094150.66941-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 09:42:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22644

Hi,

This series adds TSU support for the Renesas RZ/V2N SoC.

All patches, except for patches 4/7 and 6/7, were cherry-picked
from mainline kernel.

The RZ/V2H binding patch (1/7) was missed during RZ/V2H TSU backporting,
so it was added in this series.

Patch 4/7 is needed to fix asynchronous aborts during unbind. See the MSTOP
series for more details:
https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com/

Patch 6/7 is a backport specific change that is needed to allow the
thermal driver to read calibration data from the system controller.

Best regards,
Ovidiu

Kuninori Morimoto (1):
  arm64: dts: renesas: r9a09g056: Move interrupt-parent to root node

Ovidiu Panait (6):
  dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2H TSU
  dt-bindings: thermal: r9a09g047-tsu: Document RZ/V2N TSU
  clk: renesas: r9a09g056: Add clock and reset entries for TSU
  PM: domains: Add RZ/V2N compatible to PM domain detach list
  arm64: dts: renesas: r9a09g056: Use syscon compatible for the system
    controller
  arm64: dts: renesas: r9a09g056: Add TSU nodes

 .../thermal/renesas,r9a09g047-tsu.yaml        |  8 +-
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 89 +++++++++++++++++--
 drivers/base/power/common.c                   |  1 +
 drivers/clk/renesas/r9a09g056-cpg.c           |  6 ++
 4 files changed, 96 insertions(+), 8 deletions(-)

-- 
2.51.0


