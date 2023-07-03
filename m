Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34853EB64DD
	for <webhook@archiver.kernel.org>; Mon,  3 Jul 2023 06:22:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.21549.1688365355671294255
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Jul 2023 23:22:36 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3636MXcB527874; Mon, 3 Jul 2023 15:22:34 +0900
X-Iguazu-Qid: 2yAbG2OhpNcXggQeAi
X-Iguazu-QSIG: v=2; s=0; t=1688365353; q=2yAbG2OhpNcXggQeAi; m=NA9FGQcjvN/MjsYw4tG5xlTlXKxHoh7dxRJJ3Re5+i8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 3636MWsg1122129
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jul 2023 15:22:33 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/6] Enable swupdate in reproducible check
Date: Mon,  3 Jul 2023 11:52:25 +0530
X-TSB-HOP2: ON
Message-Id: <20230703062231.18183-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <176C1D7D866704FB.6977@lists.cip-project.org>
References: <176C1D7D866704FB.6977@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jul 2023 06:22:31.0484 (UTC) FILETIME=[BF81C7C0:01D9AD76]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jul 2023 06:22:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12171

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

The following patch series enables swupdate in reproducible check CI,
and also it include fixes for the reproducible build failures with
swupdate feature.

venkata pyla (6):
  .reproducible-check-ci.yml: Include swupdate artifacts in reproducible
    check
  .reproducible-check-ci.yml: Drop 'base' in job names
  .reproducible-check-ci.yml: Include only files required for RB check
  repro-tests.sh: Enable html output in diffoscope
  squashfs.bbclass: Fix file timestamps are not reproducible in squashfs
    image
  swupdate.bbclass: Fix file timestamps are not reproducible in swu file

 .reproducible-check-ci.yml | 35 +++++++++++++++++++++++------------
 classes/squashfs.bbclass   |  6 ++++++
 classes/swupdate.bbclass   | 10 +++++++++-
 scripts/repro-tests.sh     |  2 ++
 4 files changed, 40 insertions(+), 13 deletions(-)

-- 
2.20.1



