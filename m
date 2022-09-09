Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A52DECAAA1
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 07:04:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.3749.1662707035197270998
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 00:03:56 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 28973qEY016764;
 Fri, 9 Sep 2022 16:03:53 +0900
X-Iguazu-Qid: 2wGrOipqTAHmOfGGsY
X-Iguazu-QSIG: v=2; s=0; t=1662707032; q=2wGrOipqTAHmOfGGsY;
 m=TRFatjYDLeZNYhQ/T/tO453IZTewDhLvdWrFez1z+ls=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 28973qJE025019
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Sep 2022 16:03:52 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] Patches to meet IEC CR 7.3
Date: Fri,  9 Sep 2022 12:33:47 +0530
X-TSB-HOP2: ON
Message-Id: <20220909070349.10519-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Sep 2022 07:03:50.0057 (UTC)
 FILETIME=[502A4190:01D8C41A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 07:04:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9474

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These patches contain the packages to add in the IEC security layer to meet CR 7.3
and the manual to use the package to fulfill the requirement.

Sai (2):
  cip-core-image-security.bb: Add duplicity package to enable IEC
    requirement
  README.control-system-backup.md : Add steps to explain control system
    backup

 doc/README.control-system-backup.md           | 214 ++++++++++++++++++
 .../images/cip-core-image-security.bb         |   1 +
 2 files changed, 215 insertions(+)
 create mode 100644 doc/README.control-system-backup.md

-- 
2.20.1



