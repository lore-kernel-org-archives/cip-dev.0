Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2635E81A37
	for <webhook@archiver.kernel.org>; Mon, 16 Feb 2026 15:18:23 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21901.1771255102641506078
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Feb 2026 07:18:22 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: oOdbTxmGTkqKx4IqIK/wqA==
X-CSE-MsgGUID: YoUrokzcTwKCyW6COdaA0g==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 17 Feb 2026 00:18:21 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.12])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A601C4006A89;
	Tue, 17 Feb 2026 00:18:20 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/3] Add RZ/V2H GPU support
Date: Mon, 16 Feb 2026 15:18:16 +0000
Message-ID: <20260216151819.92667-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Feb 2026 15:18:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21885

Hi,

This series adds GPU (Mali-G31) support for the Renesas RZ/V2H SoC.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (3):
  arm64: dts: renesas: r9a09g057: Add Mali-G31 GPU node
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable Mali-G31
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Rename fixed regulator
    node names

 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 51 +++++++++++++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 17 ++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.51.0


