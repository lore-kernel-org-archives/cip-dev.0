Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9FDE92FE5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 22:39:25 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53259.1767047955770892045
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Dec 2025 14:39:16 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: bp.renesas.com, ip: 210.160.252.171, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
X-CSE-ConnectionGUID: O9ZSh7KZRhKQGF2H4JgGlw==
X-CSE-MsgGUID: 0Vytbt9kQhmfCDp/rtnbvQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Dec 2025 07:39:13 +0900
Received: from Ubuntu-22.. (unknown [10.24.0.160])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B0C2E400A0FF;
	Tue, 30 Dec 2025 07:39:12 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 00/17] Add I2C support to RZ/T2H and RZ/N2H SoCs
Date: Mon, 29 Dec 2025 22:38:54 +0000
Message-ID: <20251229223911.8663-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 22:39:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21258

Hi All,

This patch series aims to add I2C support to Renesas RZ/T2H and RZ/N2H
SoCs and enable the I2C support on the EVKs. Note, all the patches have
been cherry picked from upstream kernel.

Cheers,
Prabhakar

Lad Prabhakar (17):
  clk: renesas: r9a09g077: Propagate rate changes to parent clocks
  clk: renesas: r9a09g077: Remove stray blank line
  clk: renesas: r9a09g077: Use devm_ helpers for divider clock
    registration
  clk: renesas: cpg-mssr: Add module reset support for RZ/T2H
  clk: renesas: r9a09g077: Add RIIC module clocks
  dt-bindings: i2c: renesas,riic: Move ref for i2c-controller.yaml to
    the end
  dt-bindings: i2c: renesas,riic: Document RZ/T2H and RZ/N2H support
  i2c: riic: Make use of devres helper to request deasserted reset line
  i2c: riic: Implement bus recovery
  i2c: riic: Pass IRQ desc array as part of OF data
  i2c: riic: Move generic compatible string to end of array
  i2c: riic: Add support for RZ/T2H SoC
  arm64: dts: renesas: r9a09g077: Add I2C controller nodes
  arm64: dts: renesas: r9a09g087: Add I2C controller nodes
  arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Enable I2C0 and I2C1
    support
  arm64: dts: renesas: r9a09g087m44-rzt2h-evk: Enable I2C0 and I2C1
    support
  arm64: dts: renesas: rzt2h-n2h-evk-common: Enable EEPROM on I2C0

 .../devicetree/bindings/i2c/renesas,riic.yaml | 105 ++++++++++-----
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  45 +++++++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  36 ++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  45 +++++++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  56 ++++++++
 .../dts/renesas/rzt2h-n2h-evk-common.dtsi     |  10 ++
 drivers/clk/renesas/r9a09g077-cpg.c           |  34 ++---
 drivers/clk/renesas/renesas-cpg-mssr.c        | 110 +++++++++++++++-
 drivers/i2c/busses/i2c-riic.c                 | 120 ++++++++++++++----
 9 files changed, 485 insertions(+), 76 deletions(-)


base-commit: 204087e9ed3a3aada175fc26ef37c96445fbfbb3
-- 
2.43.0


