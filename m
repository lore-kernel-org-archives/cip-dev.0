Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939ECD98D2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 05:00:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.147125.1781586058783335773
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Jun 2026 22:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 65G50uBW2550074; Tue, 16 Jun 2026 14:00:56 +0900
X-Iguazu-Qid: 2yAbEgvmdDuEyBQtcJ
X-Iguazu-QSIG: v=2; s=0; t=1781586056; q=2yAbEgvmdDuEyBQtcJ; m=EdvcSwbKFFnL7sKpTn0wnleYMS/XpPNv+NiwmmTF11Y=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4gfZZJ0NvXz1xnl; Tue, 16 Jun 2026 14:00:55 +0900 (JST)
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, Adithya.Balakumar@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 0/2] Enable Debian sid support
Date: Tue, 16 Jun 2026 10:17:55 +0530
X-TSB-HOP2: ON
Message-Id: <20260616044758.3560272-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jun 2026 05:00:53.0503 (UTC) FILETIME=[1BCD70F0:01DCFD4D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 05:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23144

This enables the support to build Sid based images in the repository, 
which helps to detect the issues in advance.

I've confirmed the Sid image boot works for SWUpdate & Data encryption enabled images.

Shivanand Kunijadar (2):
  Enable Debian Sid support
  Add packages for Debian sid version

 Kconfig                                                       | 4 ++++
 .../initramfs-crypt-hook/initramfs-crypt-hook_0.11.bb         | 2 ++
 start-qemu.sh                                                 | 2 ++
 3 files changed, 8 insertions(+)

-- 
2.39.5



