Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2308C27C53
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 09:52:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.37944.1717753952694772542
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 02:52:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4579qVIt2331442; Fri, 7 Jun 2024 18:52:31 +0900
X-Iguazu-Qid: 2yAbxjwjwLaP0mQ3dK
X-Iguazu-QSIG: v=2; s=0; t=1717753950; q=2yAbxjwjwLaP0mQ3dK; m=xWJxOfKhuupn6WsCzHX0ZykjXaeKbg9tIMALDHcf5KU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 4579qUxw2317114
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 18:52:30 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 0/4] Trigger CIP Core testing LAVA jobs
Date: Fri,  7 Jun 2024 15:22:25 +0530
X-TSB-HOP2: ON
Message-Id: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jun 2024 09:52:28.0899 (UTC) FILETIME=[6899C330:01DAB8C0]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 09:52:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16135

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches will trigger LAVA jobs which test swupdate, secure boot and IEC layer.

Changes in v3:

Corrected line difference in [v2 2/4] patch

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



