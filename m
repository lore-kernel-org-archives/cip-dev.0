Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27366C3DA40
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 15:40:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.18954.1717602015995381594
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 08:40:16 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 455FeDb62240006; Thu, 6 Jun 2024 00:40:13 +0900
X-Iguazu-Qid: 2rWhGbqYjCI7H5oI1Q
X-Iguazu-QSIG: v=2; s=0; t=1717602013; q=2rWhGbqYjCI7H5oI1Q; m=bpg1jtAlihz1zYEOB4xRcv/i/V4Ypyy7IuyMUGXWHvo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 455FeBTJ2945115
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 6 Jun 2024 00:40:12 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 0/4] Trigger CIP Core testing LAVA jobs
Date: Wed,  5 Jun 2024 21:10:06 +0530
X-TSB-HOP2: ON
Message-Id: <20240605154010.3446832-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Jun 2024 15:40:09.0567 (UTC) FILETIME=[A5B396F0:01DAB75E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 15:40:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16115

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches will trigger LAVA jobs which test swupdate,
secure boot and IEC layer.

Changes in v2:
- Wrapped boot arguments in template files
- Variabilized artifact URL, branch, architecture
- Added README to briefly explain testing process
- Changed test targets to use small Gitlab runners

sai ashrith sathujoda (4):
  tests/templates: Include functionality based templates
  submit_lava.sh: Add script to submit the jobs prepared from templates
  .gitlab-ci.yml: Add test targets specific for CIP core functionalities
  doc/README.lava-testing.md: Add README to explain CIP Core testing

 .gitlab-ci.yml                          |  33 ++
 doc/README.lava-testing.md              |  30 ++
 scripts/submit_lava.sh                  | 464 ++++++++++++++++++++++++
 tests/templates/IEC_template.yml        |  74 ++++
 tests/templates/secureboot_template.yml |  65 ++++
 tests/templates/swupdate_template.yml   | 125 +++++++
 6 files changed, 791 insertions(+)
 create mode 100644 doc/README.lava-testing.md
 create mode 100755 scripts/submit_lava.sh
 create mode 100644 tests/templates/IEC_template.yml
 create mode 100644 tests/templates/secureboot_template.yml
 create mode 100644 tests/templates/swupdate_template.yml

-- 
2.30.2



