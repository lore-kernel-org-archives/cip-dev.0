Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC3FEB64DD
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 09:17:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.103545.1692004638285334983
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 02:17:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 37E9HGKF3641827; Mon, 14 Aug 2023 18:17:16 +0900
X-Iguazu-Qid: 2yAbeDFf8tedjI4Xp4
X-Iguazu-QSIG: v=2; s=0; t=1692004635; q=2yAbeDFf8tedjI4Xp4; m=kTqLvAyDawoBNYYhp7ZRS6V7PN5JmXRBM0iuwqffVhM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 37E9HFXW133548
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 14 Aug 2023 18:17:15 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/4] Enable File system images in reproducible
Date: Mon, 14 Aug 2023 14:47:10 +0530
X-TSB-HOP2: ON
Message-Id: <20230814091714.9400-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Aug 2023 09:17:13.0932 (UTC) FILETIME=[1CE1E8C0:01D9CE90]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 09:17:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12626

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

The following patch series enable file system images in reproducible
check CI, please review them and provide your feedback.

There were reproducible build failures with file system image creations,
will fix them in another patch series.

venkata pyla (4):
  kas/opt/reproducible.yml: Enable extracting individual partition files
  .reproducible-check-ci: Include individual file system images
  scripts/repro-tests.sh: Fix condition check for artifact folder
  scripts/repro-tests.sh: Print partition label and fstype in the output

 .reproducible-check-ci.yml |  7 +------
 kas/opt/reproducible.yml   |  1 +
 scripts/repro-tests.sh     | 22 ++++++++++++----------
 3 files changed, 14 insertions(+), 16 deletions(-)

-- 
2.20.1



