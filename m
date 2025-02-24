Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1FBC021B6
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 08:53:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.84758.1740387187002459564
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 00:53:07 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 51O8r5gX2495150; Mon, 24 Feb 2025 17:53:05 +0900
X-Iguazu-Qid: 2yAbpfLvFgGFP0l8Vu
X-Iguazu-QSIG: v=2; s=0; t=1740387184; q=2yAbpfLvFgGFP0l8Vu; m=vdrkoiPKoeGRIamamonJ8WL3VBzvjq4l92ZympfMRYM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 51O8r2uL4140717
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 17:53:04 +0900
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 0/2] Test reproducibility of wic images
Date: Mon, 24 Feb 2025 04:00:50 -0500
X-TSB-HOP2: ON
Message-Id: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Feb 2025 08:53:00.0401 (UTC) FILETIME=[81D6AE10:01DB8699]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 08:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17888

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Currently only the individual partition images are checked in the
reproducibility test. This patch set tests reproducibility of entire
disk image too.

Adithya Balakumar (2):
  .reproducible-check-ci.yml: Upload wic files for reproducibility test
  scripts/repro-tests.sh: Update script to check wic file
    reproducibility

 .reproducible-check-ci.yml | 10 ++++-
 scripts/repro-tests.sh     | 92 +++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 34 deletions(-)

-- 
2.39.5



