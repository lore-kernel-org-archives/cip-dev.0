Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A15E8306B
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 09:13:53 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12665.1770110023945291093
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Feb 2026 01:13:44 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: john.madieu.xa@bp.renesas.com)
X-CSE-ConnectionGUID: Lda67xaxTGKfzxEhJ7h79Q==
X-CSE-MsgGUID: n1UwzdkURUOgBSyAnWCdeA==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Feb 2026 18:13:43 +0900
Received: from ubuntu.adwin.renesas.com (unknown [10.226.93.13])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1E85B416D941;
	Tue,  3 Feb 2026 18:13:40 +0900 (JST)
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 0/2] ADD RZ/G3E TSU support
Date: Tue,  3 Feb 2026 10:13:29 +0100
Message-ID: <20260203091332.98580-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Feb 2026 09:13:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21819

Hi,

This series adds the TSU (thermal sensor) support for Renesas RZ/G3E and
addresses an unbind issue seen with the TSU device.

Patch 1 extends the PM domain detach allowlist to include the RZ/G3E SoC
compatible, avoiding asynchronous aborts when the TSU is unbound.

Patch 2 backports the upstream RZ/G3E TSU DTSI support (TSU node, thermal zone,
and CPU cooling maps). It also adds a "syscon" fallback compatible to the
system-controller node so the TSU driver can access calibration data via
syscon_regmap_lookup_by_phandle_args().

This has been tested on an RZ/G3E SMARC platform.

Thanks,
John Madieu

John Madieu (2):
  PM: domains: Add RZ/G3E compatible to PM domain detach list
  arm64: dts: renesas: r9a09g047: Add TSU node

 arch/arm64/boot/dts/renesas/r9a09g047.dtsi | 50 +++++++++++++++++++++-
 drivers/base/power/common.c                |  1 +
 2 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.25.1


