Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FECCCFA18
	for <webhook@archiver.kernel.org>; Sat,  8 Nov 2025 11:02:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3386.1762599718704965976
 for <cip-dev@lists.cip-project.org>;
 Sat, 08 Nov 2025 03:01:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5A8B1tD0210470; Sat, 8 Nov 2025 20:01:56 +0900
X-Iguazu-Qid: 2yAa7S8R2yip56R3Hk
X-Iguazu-QSIG: v=2; s=0; t=1762599715; q=2yAa7S8R2yip56R3Hk; m=yHzGkIRHWJL2B8Pf7O0paabPTsm1myGbxAnZO/8J6Ss=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d3Y0M4glvzyPQ; Sat,  8 Nov 2025 20:01:55 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1 0/3] Use S3 for RB test artifacts
Date: Sat,  8 Nov 2025 06:15:14 -0500
X-TSB-HOP2: ON
Message-Id: <20251108111517.752691-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Nov 2025 11:01:53.0938 (UTC) FILETIME=[178C8720:01DC509F]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 08 Nov 2025 11:02:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20478

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

So far we have been using the gitlab artifact storage for the build artifacts
from the RB tests. But this has the max artifact size per job set to 1 GB and
lately our builds seem to slightly go over this mark.

We have been using S3 for storing artifacts from the CI for quite sometime now.
Let's use S3 to store the RB build artifacts and later fetch from the same during
the test stage.

Adithya Balakumar (3):
  scripts/deploy-cip-core.sh: Support deploying artifacts for RB tests
  .reproducible-check-ci.yml: Use S3 instead of the gitlab artifact
    storage
  .gitlab-ci.yml: Update variables to stay consistent with changes in
    deploy-cip-core.sh

 .gitlab-ci.yml             |  6 ++--
 .reproducible-check-ci.yml | 67 ++++++++++++++++++++++++++------------
 scripts/deploy-cip-core.sh | 21 ++++++++++--
 3 files changed, 69 insertions(+), 25 deletions(-)

-- 
2.39.5



