Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3E1F419A9
	for <webhook@archiver.kernel.org>; Wed, 15 Apr 2026 13:21:05 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18779.1776259260228068217
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Apr 2026 06:21:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: ZK9UokC8R4aV0YSfqAuFmQ==
X-CSE-MsgGUID: 8JpJrUggS+63KeB2pHP50Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Apr 2026 22:20:59 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.18])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1FF85400A113;
	Wed, 15 Apr 2026 22:20:57 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/5] Add RSPI support for RZ/V2H and RZ/V2N
Date: Wed, 15 Apr 2026 13:20:51 +0000
Message-ID: <20260415132056.95570-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Apr 2026 13:21:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22714

Hi,

This series adds RSPI support for the Renesas RZ/V2H and RZ/V2N SoCs.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Fabrizio Castro (2):
  clk: renesas: r9a09g057: Add entries for the RSPIs
  arm64: dts: renesas: r9a09g057: Add RSPI nodes

Lad Prabhakar (3):
  spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/V2N SoC support
  clk: renesas: r9a09g056: Add entries for the RSPIs
  arm64: dts: renesas: r9a09g056: Add RSPI nodes

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  3 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 63 +++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 63 +++++++++++++++++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 24 +++++++
 drivers/clk/renesas/r9a09g057-cpg.c           | 24 +++++++
 5 files changed, 177 insertions(+)

-- 
2.34.1


