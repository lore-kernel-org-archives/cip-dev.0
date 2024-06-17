Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A43C2BB85
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 18:21:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.64709.1718648514461534820
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 11:21:55 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45HILqCA4029221; Tue, 18 Jun 2024 03:21:52 +0900
X-Iguazu-Qid: 2rWhYYPQFlUl5sHIiO
X-Iguazu-QSIG: v=2; s=0; t=1718648511; q=2rWhYYPQFlUl5sHIiO; m=k/vlBg7xiDCmN13CN63tRocqb6TCVbB4YWV8u8il3nM=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 45HILox32549535
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:21:51 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 0/3] Split Gitlab test jobs
Date: Mon, 17 Jun 2024 23:51:44 +0530
X-TSB-HOP2: ON
Message-Id: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Jun 2024 18:21:45.0769 (UTC) FILETIME=[360B9990:01DAC0E3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 18:21:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16265

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches will run one LAVA job per Gitlab test job.
Accordingly the submit_lava.sh and template files are modified to
sync with the changes.

sai ashrith sathujoda (3):
  .gitlab-ci.yml: Break current test jobs to run one LAVA job per Gitlab
    job
  submit_lava.sh: Modify the script to handle only one job at a time
  tests: Modify the replacable strings and increase timeouts in the
    templates

 .gitlab-ci.yml                          |  80 +++++-
 scripts/submit_lava.sh                  | 336 ++++++++++--------------
 tests/templates/IEC_template.yml        |  16 +-
 tests/templates/secureboot_template.yml |  14 +-
 tests/templates/swupdate_template.yml   |  18 +-
 5 files changed, 227 insertions(+), 237 deletions(-)

-- 
2.30.2



