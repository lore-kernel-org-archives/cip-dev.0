Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF61E6748D
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 08:00:09 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.76219.1766390403354832391
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 00:00:03 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: /OBUfWa6SkmKLoifPKLEEw==
X-CSE-MsgGUID: qYwrLDefSeGoXH/7gNuk3Q==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Dec 2025 17:00:01 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.2])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 842EE40E20CB;
	Mon, 22 Dec 2025 17:00:00 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 0/1] Backport RZ DMAC fix to 6.1.y-cip
Date: Mon, 22 Dec 2025 07:59:48 +0000
Message-ID: <20251222075949.58472-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 08:00:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21184

Backport commit 6e9c5c8ef282 ("dmaengine: sh: rz-dmac: handle configs
where one address is zero") to 6.1-cip. The patch was cherry-picked
from mainline kernel and it applies cleanly.

Best regards,
Ovidiu

Wolfram Sang (1):
  dmaengine: sh: rz-dmac: handle configs where one address is zero

 drivers/dma/sh/rz-dmac.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

-- 
2.51.0


