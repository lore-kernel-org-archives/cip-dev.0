Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F1FC369D1
	for <webhook@archiver.kernel.org>; Fri, 25 Apr 2025 09:11:07 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web11.2661.1745572261709979808
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Apr 2025 02:11:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: BKeA6bq0SIuMHDbvNviUKQ==
X-CSE-MsgGUID: iAwAnzhmQNqIZckAiuXZPg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 25 Apr 2025 18:10:59 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.1])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4E7E6402FDFC;
	Fri, 25 Apr 2025 18:10:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.1.y-cip 00/15] i2c: riic: miscellaneous code cleanup and improvements
Date: Fri, 25 Apr 2025 10:10:42 +0100
Message-ID: <20250425091057.33752-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Apr 2025 09:11:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18604

Hi all,

This patch series includes miscellaneous code cleanup and improvements
to RIIC driver used by Renesas RZ SoCs. Below are the features which
are backported:
- Runtime PM support
- Suspend/Resume support
- Fast Mode Plus

Note,
- Patches 9-15 have been recently posted to 6.12-cip
- All the patches have been cherry-picked from v6.15-rc3.

Cheers,
Prabhakar

Claudiu Beznea (7):
  i2c: riic: Use temporary variable for struct device
  i2c: riic: Call pm_runtime_get_sync() when need to access registers
  i2c: riic: Use pm_runtime_resume_and_get()
  i2c: riic: Enable runtime PM autosuspend support
  i2c: riic: Add suspend/resume support
  i2c: riic: Define individual arrays to describe the register offsets
  i2c: riic: Add support for fast mode plus

Geert Uytterhoeven (1):
  i2c: riic: Simplify unsupported bus speed handling

Lad Prabhakar (7):
  i2c: riic: Introduce a separate variable for IRQ
  i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
  i2c: riic: Use BIT macro consistently
  i2c: riic: Use GENMASK() macro for bitmask definitions
  i2c: riic: Mark riic_irqs array as const
  i2c: riic: Use predefined macro and simplify clock tick calculation
  i2c: riic: Add `riic_bus_barrier()` to check bus availability

 drivers/i2c/busses/i2c-riic.c | 333 ++++++++++++++++++++++------------
 1 file changed, 221 insertions(+), 112 deletions(-)

-- 
2.43.0


