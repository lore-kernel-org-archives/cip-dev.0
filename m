Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBBFC001B0
	for <webhook@archiver.kernel.org>; Fri, 23 Jun 2023 14:06:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.42920.1687529165898772745
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jun 2023 07:06:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 35NE62Iv018709; Fri, 23 Jun 2023 23:06:03 +0900
X-Iguazu-Qid: 34ts1GHAf1tFgUPrwB
X-Iguazu-QSIG: v=2; s=0; t=1687529162; q=34ts1GHAf1tFgUPrwB; m=1J9/JnnmHNbzVCqK9QAnB26LcjrIjJgFsT/KZ4ic/t8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1512) id 35NE61TF020657
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 23 Jun 2023 23:06:02 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Enable swupdate targets in reproducible check
Date: Fri, 23 Jun 2023 19:35:52 +0530
X-TSB-HOP2: ON
Message-Id: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jun 2023 14:05:59.0395 (UTC) FILETIME=[D62EC330:01D9A5DB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jun 2023 14:06:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12145

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This following patch series enables the swupdate targets in reproducible
check and enable html output in diffoscope to view the non-reproducible
contents in the browser.

venkata pyla (3):
  .reproducible-check-ci.yml: Add swupdate targets in reproducible check
  .reproducible-check-ci.yml: Include only files required for RB check
  repro-tests.sh: Enable html output in diffoscope

 .reproducible-check-ci.yml | 60 ++++++++++++++++++++++++++++++++++++--
 scripts/repro-tests.sh     |  2 ++
 2 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.20.1



