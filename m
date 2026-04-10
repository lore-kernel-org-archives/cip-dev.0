Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E715BF459FA
	for <webhook@archiver.kernel.org>; Fri, 10 Apr 2026 17:03:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.161289.1775840584159043333
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Apr 2026 10:03:04 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
X-CSE-ConnectionGUID: WDlk/1onS2q3pnKQxL1wGA==
X-CSE-MsgGUID: pkMa/DEgRBeZEw1EWfiw3w==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 11 Apr 2026 02:03:02 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7C794402F526;
	Sat, 11 Apr 2026 02:03:01 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/11] Add TSU support for RZ/T2H and RZ/N2H
Date: Fri, 10 Apr 2026 20:02:04 +0300
Message-ID: <20260410170215.393698-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Apr 2026 17:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22663

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs expose the
temperature calibration via SMC SIP and do not have a reset for the
TSU peripheral, and use different minimum and maximum temperature values
compared to RZ/G3E.

Patches were cherry-picked from upstream kernel, except for patch
7/11 which is needed to fix asynchronous aborts during unbind.

See the MSTOP series for more details:
https://lore.kernel.org/cip-dev/20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com/

Cosmin Tanislav (11):
  clk: renesas: r9a09g077: Add TSU module clock
  thermal: renesas: rzg3e: make reset optional
  thermal: renesas: rzg3e: make min and max temperature per-chip
  thermal: renesas: rzg3e: make calibration value retrieval per-chip
  dt-bindings: thermal: r9a09g047-tsu: document RZ/T2H and RZ/N2H
  thermal: renesas: rzg3e: add support for RZ/T2H and RZ/N2H
  PM: domains: Add RZ/T2H and RZ/N2H compatibles to PM domain detach
    list
  arm64: dts: renesas: r9a09g077: Add OPP table
  arm64: dts: renesas: r9a09g077: Add TSU and thermal zones support
  arm64: dts: renesas: r9a09g087: Add OPP table
  arm64: dts: renesas: r9a09g087: Add TSU and thermal zones support

 .../thermal/renesas,r9a09g047-tsu.yaml        |  30 ++++-
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  65 +++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  65 +++++++++
 drivers/base/power/common.c                   |   2 +
 drivers/clk/renesas/r9a09g077-cpg.c           |   1 +
 drivers/thermal/renesas/rzg3e_thermal.c       | 123 +++++++++++-------
 6 files changed, 234 insertions(+), 52 deletions(-)

-- 
2.53.0


