Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CEEEB57D
	for <webhook@archiver.kernel.org>; Mon, 11 Sep 2023 13:32:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.58498.1694439112349762767
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Sep 2023 06:31:53 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 38BDVn814008036; Mon, 11 Sep 2023 22:31:50 +0900
X-Iguazu-Qid: 2rWgyA9ooqJg4PHcae
X-Iguazu-QSIG: v=2; s=0; t=1694439109; q=2rWgyA9ooqJg4PHcae; m=tXyqDy4g8phqo2m0Oj/HGx/kqh9HaW6kxEj3dNoYdyo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 38BDVm6p3612965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Sep 2023 22:31:48 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/5] Add security and BBB targets in
Date: Mon, 11 Sep 2023 19:01:42 +0530
X-TSB-HOP2: ON
Message-Id: <20230911133147.3164-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Sep 2023 13:31:46.0754 (UTC) FILETIME=[4FC29A20:01D9E4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Sep 2023 13:32:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13018

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Hi,

This series patch enables the security extensions and BBB target to the
reproducible check CI.


venkata pyla (5):
  .reproducible-check-ci.yml: Set default values in base job
  .reproducible-check-ci.yml: Enable security target
  reproducible-check: Add option to pass extensions of the image
  .reproducible-check-ci.yml: Add BBB target
  scripts/repro-tests.sh: Add *wic.p0 image into reproducible tests

 .reproducible-check-ci.yml | 31 ++++++++++++++++++++++---------
 scripts/repro-tests.sh     | 14 ++++++++++++--
 2 files changed, 34 insertions(+), 11 deletions(-)

-- 
2.20.1



