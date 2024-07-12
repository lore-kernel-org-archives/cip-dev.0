Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D7EC41513
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:51:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.3506.1720774286426872976
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:51:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 46C8pOMI3948811; Fri, 12 Jul 2024 17:51:24 +0900
X-Iguazu-Qid: 2yAaI0wiGGn11lirjS
X-Iguazu-QSIG: v=2; s=0; t=1720774283; q=2yAaI0wiGGn11lirjS; m=snDqjCpDVLeu28pYNeinFthmfRpIWPLUdZAt3t570rs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 46C8pMRE1073389
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 17:51:23 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] Update docs
Date: Fri, 12 Jul 2024 14:15:55 +0530
X-TSB-HOP2: ON
Message-Id: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jul 2024 08:51:21.0038 (UTC) FILETIME=[AAD7D6E0:01DAD438]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:51:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16462

doc/README.secureboot.md: The information about DB and KEK keys in case
of Debian snakeoil key method is missing here, I just added a line so
that user will get know PK.esl can be used as DB and KEK for secure
boot.

README.m-com-x86.md: Add information about how to generate Debian
snakeoil based UEFI keys and also how to generate user generated keys
for secure boot.

Shivanand Kunijadar (2):
  doc/README.secureboot.md: Add information of DB and KEK in case of
    snakeoil keys
  doc: Add information about Debian snakeoil and user generated keys
    method for secure boot

 doc/README.secureboot.md       |  2 ++
 doc/boards/README.m-com-x86.md | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.39.2



