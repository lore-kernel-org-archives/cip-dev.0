Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0BECAAD3
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 08:07:41 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.4172.1662710857259544687
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 01:07:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 28987Zt7004762;
 Fri, 9 Sep 2022 17:07:35 +0900
X-Iguazu-Qid: 34tMLsHDlBtYsU0trl
X-Iguazu-QSIG: v=2; s=0; t=1662710855; q=34tMLsHDlBtYsU0trl;
 m=e+YSHh0U4nMgUDwVcN/xfgd9aKHus/MUkAafnHE+Cj8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 28987Yuf019012
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Sep 2022 17:07:34 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] Patches to meet IEC CR 7.3
Date: Fri,  9 Sep 2022 13:37:29 +0530
X-TSB-HOP2: ON
Message-Id: <20220909080731.10848-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Sep 2022 08:07:31.0869 (UTC)
 FILETIME=[36247CD0:01D8C423]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 08:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9478

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

These patches contain the packages to add in the IEC security layer to
meet CR 7.3 and the manual to use the package to fulfill the requirement.

Sai (2):
  README.control-system-backup.md: Add steps to explain control system
    backup
  cip-core-image-security.bb: Add duplicity package to enable IEC
    requirement

 doc/README.control-system-backup.md           | 194 ++++++++++++++++++
 .../images/cip-core-image-security.bb         |   1 +
 2 files changed, 195 insertions(+)
 create mode 100644 doc/README.control-system-backup.md

-- 
2.20.1



