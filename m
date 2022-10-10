Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55A2C4332F
	for <webhook@archiver.kernel.org>; Mon, 10 Oct 2022 07:02:42 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web09.3478.1665385360323408319
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Oct 2022 00:02:41 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 29A72bN1011193;
 Mon, 10 Oct 2022 16:02:38 +0900
X-Iguazu-Qid: 2wHHgak9u7khgt5T3B
X-Iguazu-QSIG: v=2; s=0; t=1665385357; q=2wHHgak9u7khgt5T3B;
 m=gODrLiWV6ZuMmqKuUAEAMaaicI4vZtJmFwP7eX16yv4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 29A72aeM038720
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 10 Oct 2022 16:02:37 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Update secure-boot documentation and scripts
Date: Mon, 10 Oct 2022 12:32:29 +0530
X-TSB-HOP2: ON
Message-Id: <20221010070232.10478-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Oct 2022 07:02:34.0216 (UTC)
 FILETIME=[45C41680:01D8DC76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Oct 2022 07:02:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9702

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Update scripts to set the default distro version as bullseye and change default ovmf files to use 4M size.
Update README.secureboot for user-generated keys and bullseye version.

Sai (3):
  start-qemu.sh : Set bullseye as default DISTRO RELEASE
  README.secureboot.md : Update steps for user-generated keys
  start-efishell.sh : Use default OVMF files with '4M' size

 doc/README.secureboot.md  | 55 +++++++++++++++++++++++++++------------
 scripts/start-efishell.sh |  4 +--
 start-qemu.sh             |  6 ++---
 3 files changed, 43 insertions(+), 22 deletions(-)

-- 
2.20.1



