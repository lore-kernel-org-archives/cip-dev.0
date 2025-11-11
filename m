Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E707CCFA18
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 04:34:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10142.1762835646467749601
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Nov 2025 20:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5AB4Y3Vk3490831; Tue, 11 Nov 2025 13:34:03 +0900
X-Iguazu-Qid: 2rWgZy3EWpCMXiyQ9h
X-Iguazu-QSIG: v=2; s=0; t=1762835643; q=2rWgZy3EWpCMXiyQ9h; m=mCqdz3biaoIrsIQalKQY5WPCgebTZlQTABCch5xa1z4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d5DFR0NxNz1xnc; Tue, 11 Nov 2025 13:34:02 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v2 0/2] Use S3 for RB test artifacts
Date: Mon, 10 Nov 2025 23:47:18 -0500
X-TSB-HOP2: ON
Message-Id: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 11 Nov 2025 04:33:59.0335 (UTC) FILETIME=[660B3370:01DC52C4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 04:34:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20489

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

So far we have been using the gitlab artifact storage for the build artifacts
from the RB tests. But this has the max artifact size per job set to 1 GB and
lately our builds seem to slightly go over this mark.

We have been using S3 for storing artifacts from the CI for quite sometime now.
Let's use S3 to store the RB build artifacts and later fetch from the same during
the test stage.

Changes since v1:
- Control RB artifacts deployment with an optional 8th argument to
  deploy-cip-core.sh
- Drop patch 3 as its no longer required

Adithya Balakumar (2):
  scripts/deploy-cip-core.sh: Support deploying artifacts for RB tests
  .reproducible-check-ci.yml: Use S3 instead of the gitlab artifact
    storage

 .reproducible-check-ci.yml | 66 ++++++++++++++++++++++++++------------
 scripts/deploy-cip-core.sh | 21 +++++++++++-
 2 files changed, 65 insertions(+), 22 deletions(-)

-- 
2.39.5



