Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416DDC7EE26
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 13:56:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.23572.1684850178533838967
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 May 2023 06:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 34NDuFVP015363; Tue, 23 May 2023 22:56:15 +0900
X-Iguazu-Qid: 34trbMFXoXdMFvbn72
X-Iguazu-QSIG: v=2; s=0; t=1684850175; q=34trbMFXoXdMFvbn72; m=wCfFJayrGmpflHaReYcn98B7cEMuKOXfJirR5PU4Llk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 34NDuEin038639
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 23 May 2023 22:56:14 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/2] Test different artifacts are bit identical
Date: Tue, 23 May 2023 19:26:09 +0530
X-TSB-HOP2: ON
Message-Id: <20230523135611.31234-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 May 2023 13:56:12.0763 (UTC) FILETIME=[55B792B0:01D98D7E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 13:56:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11615

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This patch series enhances the reproducible check CI that include
different artifacts in the build image are verified against bit identical
artifacts.

venkata pyla (2):
  scripts: Add script to test different artifacts in the image are bit
    identical
  .reproducible-check-ci.yml: use repro-tests.sh in the CI check

 .reproducible-check-ci.yml | 15 +++++--
 scripts/repro-tests.sh     | 91 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+), 4 deletions(-)
 create mode 100755 scripts/repro-tests.sh

-- 
2.20.1



