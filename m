Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D600CC41513
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 16:10:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.90418.1718727041510055579
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 09:10:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 45IGAd1c3077045; Wed, 19 Jun 2024 01:10:39 +0900
X-Iguazu-Qid: 2yAbrn6vGecTR7S3xz
X-Iguazu-QSIG: v=2; s=0; t=1718727038; q=2yAbrn6vGecTR7S3xz; m=WY1b/SEFIsTa6KJQ7RW0SB1bpNrPrmUTE38VtjU0Z3M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1802) id 45IGAcgd855037
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 01:10:38 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 0/3] Minor corrections to CIP Core testing
Date: Tue, 18 Jun 2024 21:40:32 +0530
X-TSB-HOP2: ON
Message-Id: <20240618161035.1810237-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jun 2024 16:10:34.0100 (UTC) FILETIME=[0C93FB40:01DAC19A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 16:10:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16284

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches rectify minor issues found while checking the
test job results.

sai ashrith sathujoda (3):
  templates/swupdate_template.yml: Fail the job immediately after
    unexpected outcome
  submit_lava.sh: Rectify the ustate value in case of a rollback
    scenario
  .gitlab-ci.yml: Add relevant qemu target in 'needs' for test targets

 .gitlab-ci.yml                        | 12 +++++++++++-
 scripts/submit_lava.sh                |  3 ++-
 tests/templates/swupdate_template.yml |  8 ++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.30.2



