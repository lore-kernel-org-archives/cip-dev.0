Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE6DC021B8
	for <webhook@archiver.kernel.org>; Wed, 26 Feb 2025 08:24:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.1613.1740558294964020577
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 00:24:55 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 51Q8Oq3Y1546897; Wed, 26 Feb 2025 17:24:52 +0900
X-Iguazu-Qid: 2rWh5b6vF47nphQRgo
X-Iguazu-QSIG: v=2; s=0; t=1740558291; q=2rWh5b6vF47nphQRgo; m=RGfBUz2AJxZezDt9x9NVldKG5Vizzf1L6AjfwFaK0YE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 51Q8OomH2496992
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 17:24:51 +0900
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v2 0/2] Test reproducibility of wic images
Date: Wed, 26 Feb 2025 03:32:37 -0500
X-TSB-HOP2: ON
Message-Id: <20250226083239.601295-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Feb 2025 08:24:48.0950 (UTC) FILETIME=[E67B3D60:01DB8827]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 08:24:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17914

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Currently only the individual partition images are checked in the
reproducibility test. This patch set tests reproducibility of entire
disk image too.

Changes since v1:
- Addressed shellcheck warnings apart from the one mentioned below

In scripts/repro-tests.sh line 63:
set -- $remaining_vars
       ^-------------^ SC2086 (info): Double quote to prevent globbing and word splitting.

Since word splitting is what I want in the scenario, I suppressed the
warning in the script

Adithya Balakumar (2):
  .reproducible-check-ci.yml: Upload wic files for reproducibility test
  scripts/repro-tests.sh: Update script to check wic file
    reproducibility

 .reproducible-check-ci.yml | 10 ++++-
 scripts/repro-tests.sh     | 92 +++++++++++++++++++++++++-------------
 2 files changed, 69 insertions(+), 33 deletions(-)

-- 
2.39.5



