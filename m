Return-Path: <tho1.nguyendat@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90722C83F13
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 10:43:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.10395.1693219420249024174
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Aug 2023 03:43:40 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: tho1.nguyendat@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 37SAhbOK1952147; Mon, 28 Aug 2023 19:43:37 +0900
X-Iguazu-Qid: 2rWgJRkMVkFDHvZagi
X-Iguazu-QSIG: v=2; s=0; t=1693219416; q=2rWgJRkMVkFDHvZagi; m=RO6uKKcfoSpc3zaBu31RuzB2BhZZEJ3UCEQlpnsgZBk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 37SAhZje2001922
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Aug 2023 19:43:36 +0900
From: tho1.nguyendat@toshiba.co.jp
To: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: tho1.nguyendat@toshiba.co.jp, kazuhiro3.hayashi@toshiba.co.jp
Subject: [PATCH 0/3] Enable secured boot for BBB
Date: Mon, 28 Aug 2023 17:43:12 +0700
X-TSB-HOP2: ON
Message-Id: <20230828104315.466393-1-tho1.nguyendat@toshiba.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Aug 2023 10:43:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12883

From: Tho Nguyen <tho1.nguyendat@toshiba.co.jp>

Hi,

The following patch series enables secured boot for Beaglebone Black, please help me review them and give your feedback.

Nguyen Dat Tho (3):
  linux/cip-kernel-config: Use latest commit
  bbb: Enable secured boot
  u-boot: Add EFI secure boot dependency

 Kconfig                                       |  2 +-
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl |  1 +
 recipes-kernel/linux/cip-kernel-config.inc    |  2 +-
 wic/bbb-efibootguard-secureboot.wks.in        | 13 +++++++++++++
 4 files changed, 16 insertions(+), 2 deletions(-)
 create mode 100644 wic/bbb-efibootguard-secureboot.wks.in

-- 
2.39.2



