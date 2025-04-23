Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC5C369CB
	for <webhook@archiver.kernel.org>; Wed, 23 Apr 2025 21:05:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.489.1745442302682817640
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Apr 2025 14:05:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.172, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: wtbyBl6KTcKxo7T86U2d+Q==
X-CSE-MsgGUID: 2G9I+gDQRROjYmpKy08Oxg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 24 Apr 2025 06:05:01 +0900
Received: from Ubuntu-22.. (unknown [10.226.92.43])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 77245401C94A;
	Thu, 24 Apr 2025 06:04:59 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: [PATCH 6.12.y-cip 0/8] i2c: riic: miscellaneous code cleanup and improvements
Date: Wed, 23 Apr 2025 22:04:50 +0100
Message-ID: <20250423210458.14698-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Apr 2025 21:05:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18583

Hi All,

This patch series includes miscellaneous code cleanup and
improvements to RIIC driver used by Renesas RZ SoCs.

Note, all the patches have been cherry-picked from v6.15-rc3.

Cheers,
Prabhakar

Lad Prabhakar (8):
  i2c: riic: Introduce a separate variable for IRQ
  i2c: riic: Use dev_err_probe in probe and riic_init_hw functions
  i2c: riic: Use local `dev` pointer in `dev_err_probe()`
  i2c: riic: Use BIT macro consistently
  i2c: riic: Use GENMASK() macro for bitmask definitions
  i2c: riic: Mark riic_irqs array as const
  i2c: riic: Use predefined macro and simplify clock tick calculation
  i2c: riic: Add `riic_bus_barrier()` to check bus availability

 drivers/i2c/busses/i2c-riic.c | 117 ++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 47 deletions(-)

-- 
2.43.0


