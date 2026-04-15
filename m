Return-Path: <Chris.Brandt@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDFFF42119
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 18:18:19 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1944.1776277094099207805
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 11:18:14 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: chris.brandt@renesas.com)
X-CSE-ConnectionGUID: CnrWO+0gQKaTGWB3k7kpmQ==
X-CSE-MsgGUID: 99IO94beQDG1b1//yCNGqQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 16 Apr 2026 03:18:12 +0900
Received: from lenovo-p330 (unknown [132.158.152.97])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A81EA405BF70;
	Thu, 16 Apr 2026 03:18:11 +0900 (JST)
From: Chris Brandt <chris.brandt@renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Subject: [PATCH 5.10.y-cip 00/10] Add additional support for MIPI-DSI for RZ/G2L
Date: Wed, 15 Apr 2026 14:17:59 -0400
Message-ID: <20260415181810.4073807-1-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 18:18:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22720

There is important functionality missing from the MIPI-DSI display driver and also the clock
driver for generating the correct pixel clock frequencies.

Since everything is now accepted in mainline, this is the backport of those patches.

The patches were tested on a RZ/G2L board that has a connector for a MIPI-DSI panel.
Additionally, the RZ/G2L SMARC board with a MIPI-to-HDMI bridge chip was re-tested.


Chris



Chris Brandt (5):
  drm: renesas: rz-du: Add atomic_pre_enable
  drm: renesas: rz-du: mipi_dsi: Set DSI divider
  clk: renesas: rzg2l: Fix intin variable size
  clk: renesas: rzg2l: Select correct div round macro
  clk: renesas: rzg2l: Remove DSI clock rate restrictions

Geert Uytterhoeven (2):
  clk: renesas: Use IS_ERR() for pointers that cannot be NULL
  clk: renesas: Add missing log message terminators

Hugo Villeneuve (2):
  drm: renesas: rz-du: Implement MIPI DSI host transfers
  drm: renesas: rz-du: mipi_dsi: fix kernel panic when rebooting for
    some panels

Pali Rohár (1):
  math64: New DIV_U64_ROUND_CLOSEST helper

 drivers/clk/renesas/clk-vbattb.c              |   4 +-
 drivers/clk/renesas/renesas-cpg-mssr.c        |   4 +-
 drivers/clk/renesas/rzg2l-cpg.c               | 182 +++++++++++---
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 223 +++++++++++++++++-
 .../drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h   |  54 +++++
 include/linux/clk/renesas.h                   |  12 +
 include/linux/math64.h                        |  13 +
 7 files changed, 450 insertions(+), 42 deletions(-)

--
2.52.0


