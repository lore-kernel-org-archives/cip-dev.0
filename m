Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59897C369D8
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 11:32:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.37478.1745321522309336498
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 04:32:02 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 53MBVxd73038991; Tue, 22 Apr 2025 20:31:59 +0900
X-Iguazu-Qid: 2yAbaKzOhmph5ShmTs
X-Iguazu-QSIG: v=2; s=0; t=1745321518; q=2yAbaKzOhmph5ShmTs; m=5SZPwTnAyslfWahs4nxsmZT1pmukfUt1FaAtzciVhHg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 53MBVvUB080844
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 20:31:58 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v5 0/2] Update IEC job timeouts based on targets
Date: Tue, 22 Apr 2025 16:57:49 +0530
X-TSB-HOP2: ON
Message-Id: <20250422112751.3620163-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Apr 2025 11:31:56.0077 (UTC) FILETIME=[27171DD0:01DBB37A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 11:32:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18550

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series sets IEC test jobs timeouts based on the targets as well as updates
IEC layer tests revision

Changes apart from v4

1. Modified usage of envsusbst to substitute only "IEC_TEST_TIMEOUT_MINUTES".
sai ashrith sathujoda (2):
  .gitlab-ci.yml: Set timeout value to run IEC layer tests for different
    targets.
  IEC_template.yml: Update IEC layer tests revision

 .gitlab-ci.yml                   | 6 +++++-
 scripts/submit_lava.sh           | 7 +++++++
 tests/templates/IEC_template.yml | 4 ++--
 3 files changed, 14 insertions(+), 3 deletions(-)

-- 
2.30.2



