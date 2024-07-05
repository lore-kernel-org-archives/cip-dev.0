Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8B3C41513
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 07:16:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.12067.1720163811255012877
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 00:16:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4657GnVA2158367; Fri, 5 Jul 2024 16:16:49 +0900
X-Iguazu-Qid: 2yAaI0wiG4mTlxQJ1y
X-Iguazu-QSIG: v=2; s=0; t=1720163808; q=2yAaI0wiG4mTlxQJ1y; m=ZywUAhSa7Iqv55nZWOWDHNhBvrfsT2sGk+pnNXWKito=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4657GmGj1003946
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 5 Jul 2024 16:16:48 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/2] Update README files
Date: Fri,  5 Jul 2024 12:41:27 +0530
X-TSB-HOP2: ON
Message-Id: <20240705071129.1374609-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jul 2024 07:16:46.0157 (UTC) FILETIME=[4B7577D0:01DACEAB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 07:16:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16382

Extend the current secure boot readme to add an additional key enrolment
method using KeyTool.efi binary.
Add separate README file with detailed instructions to build and verify 
base, SWUpdate and Secure Boot images on M-COM device.

Shivanand (2):
  doc/REAME.secureboot.md: Add steps to inject UEFI keys from
    KeyTool.efi
  README.m-com-x86.md: Add M-COM board specific details

 doc/README.secureboot.md       |  23 ++++++-
 doc/boards/README.m-com-x86.md | 112 +++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 doc/boards/README.m-com-x86.md

-- 
2.39.2



