Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED3CC25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 07:09:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.77505.1717398567492372309
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 00:09:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 45379PNI2417617; Mon, 3 Jun 2024 16:09:25 +0900
X-Iguazu-Qid: 2rWhNMNed189TXSYi5
X-Iguazu-QSIG: v=2; s=0; t=1717398564; q=2rWhNMNed189TXSYi5; m=tHbpily27ooD3NuIazcve9SvAyEewf4dtj1fz6nY8gA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 45379NBh1243622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jun 2024 16:09:24 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 0/3] Trigger CIP Core testing LAVA jobs
Date: Mon,  3 Jun 2024 12:39:17 +0530
X-TSB-HOP2: ON
Message-Id: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jun 2024 07:09:19.0346 (UTC) FILETIME=[F3EB8520:01DAB584]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 07:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16084

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches will trigger LAVA jobs which test swupdate, secure boot
and IEC layer.

sai ashrith sathujoda (3):
  test/templates: Include functionality based templates
  submit_lava.sh: Add script to submit the jobs prepared from templates
  .gitlab-ci.yml: Add test targets specific for CIP core functionalities

 .gitlab-ci.yml                         |  33 ++
 scripts/submit_lava.sh                 | 458 +++++++++++++++++++++++++
 test/templates/IEC_template.yml        |  72 ++++
 test/templates/secureboot_template.yml |  63 ++++
 test/templates/swupdate_template.yml   | 123 +++++++
 5 files changed, 749 insertions(+)
 create mode 100755 scripts/submit_lava.sh
 create mode 100644 test/templates/IEC_template.yml
 create mode 100644 test/templates/secureboot_template.yml
 create mode 100644 test/templates/swupdate_template.yml

-- 
2.30.2



