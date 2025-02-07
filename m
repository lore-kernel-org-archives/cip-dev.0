Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B51FC3DA4A
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.71585.1738940877924271111
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 07:07:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 517F7tbK676062; Sat, 8 Feb 2025 00:07:56 +0900
X-Iguazu-Qid: 2yAbuzQy0fvU20X4Pg
X-Iguazu-QSIG: v=2; s=0; t=1738940875; q=2yAbuzQy0fvU20X4Pg; m=OudcpM/aQ6jptA5R9jGpyUQiSKFp3BfYMJBaA5Nc4bY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 517F7sHi1285124
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:07:54 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 0/5] Automate CIP Core testing on M-COM x86 in LAVA
Date: Fri,  7 Feb 2025 20:34:34 +0530
X-TSB-HOP2: ON
Message-Id: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2025 15:07:52.0719 (UTC) FILETIME=[0F4849F0:01DB7972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 15:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17771

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches add template files and functionalities required to generate
jobs to test IEC layer, swupdate and secure boot features on M-COM x86 in LAVA
environment.

sai ashrith sathujoda (5):
  swupdate_template.yml: Give different names to test actions
  tests/templates: Add template files required to generate M-COM job
    defintions
  submit_lava.sh: Include functionality to prepare M-COM job defintions
  .gitlab-ci.yml: Enable building v2 x86-uefi target to deploy its
    swupdate artifact
  .gitlab-ci.yml: Add test targets for M-COM x86

 .gitlab-ci.yml                                | 25 +++++++++
 scripts/submit_lava.sh                        | 38 +++++++++++++-
 tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++++
 .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
 tests/templates/swupdate_template.yml         |  3 +-
 5 files changed, 133 insertions(+), 3 deletions(-)
 create mode 100644 tests/templates/M-COM-x86.yml
 create mode 100644 tests/templates/swupdate-test-action-M-COM.yml

-- 
2.30.2



