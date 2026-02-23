Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFB0E98E1B
	for <webhook@archiver.kernel.org>; Mon, 23 Feb 2026 10:28:04 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32575.1771842481133845971
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Feb 2026 02:28:01 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: Nu+OgKgwQya7nK+1iur4Fw==
X-CSE-MsgGUID: 447O8QGuSo68FDNq42FFAw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 23 Feb 2026 19:28:00 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6078A401A659;
	Mon, 23 Feb 2026 19:27:59 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/4] Add RZ/V2N GPU support
Date: Mon, 23 Feb 2026 10:27:53 +0000
Message-ID: <20260223102758.119908-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Feb 2026 10:28:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21912

Hi,

This series adds GPU (Mali-G31) support for the Renesas RZ/V2N SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (4):
  dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2N SoC
  clk: renesas: r9a09g056: Add clocks and resets for Mali-G31 GPU
  arm64: dts: renesas: r9a09g056: Add Mali-G31 GPU node
  arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable Mali-G31 GPU

 .../bindings/gpu/arm,mali-bifrost.yaml        |  2 +
 arch/arm64/boot/dts/renesas/r9a09g056.dtsi    | 51 +++++++++++++++++++
 .../dts/renesas/r9a09g056n48-rzv2n-evk.dts    | 14 +++++
 drivers/clk/renesas/r9a09g056-cpg.c           | 16 ++++++
 4 files changed, 83 insertions(+)

-- 
2.34.1


