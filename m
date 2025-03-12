Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E42C28B30
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 13:22:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.37043.1741785753892860647
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 06:22:34 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52CDMVJf670299; Wed, 12 Mar 2025 22:22:32 +0900
X-Iguazu-Qid: 2rWh5b6vFSGobAkzrd
X-Iguazu-QSIG: v=2; s=0; t=1741785751; q=2rWh5b6vFSGobAkzrd; m=JeKVahsJoapxIkO5Wzu6gn4XOXdE9xgS4Pm1fZ+goPM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 52CDMUFv4099419
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 22:22:31 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 0/4] Add additional test cases
Date: Wed, 12 Mar 2025 18:43:59 +0530
X-TSB-HOP2: ON
Message-Id: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Mar 2025 13:22:28.0747 (UTC) FILETIME=[CD887DB0:01DB9351]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 13:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18086

Add the test cases to cover the different scenarios of SWUpdate and 
secure boot features to improve the test coverage. The below test
scenarios are implemented, 
* Unauthorized kernel image
* Unauthorized bootloader image
* Corrupt .swu file
* Apply the same image's .swu file(@config_check@)
* Corrupt the artifact of .swu file
* Reboot without confirming the successful update using "bg_setenv -c"

Shivanand Kunijadar (4):
  Add additional test cases for swupdate and secure boot in LAVA
  Update script to generate additional LAVA job defintion
  .gitlab-ci.yml: Update CI to add additional jobs
  .gitlab-ci.ymll: Enable security_test option for base images

 .gitlab-ci.yml                                | 147 ++++++++++++++++++
 scripts/submit_lava.sh                        |  64 ++++++++
 tests/templates/secureboot_negative_test.yml  |  81 ++++++++++
 .../secureboot_unsigned_bootloader_steps.yml  |   7 +
 .../secureboot_unsigned_kernel_steps.yml      |   7 +
 .../swupdate_corrupt_swu_artifact_steps.yml   |   9 ++
 .../templates/swupdate_corrupt_swu_steps.yml  |   6 +
 tests/templates/swupdate_negative_test.yml    |  89 +++++++++++
 .../swupdate_reboot_without_confirm.yml       |  43 +++++
 tests/templates/swupdate_same_uuid_steps.yml  |   9 ++
 tests/templates/swupdate_template.yml         |   2 +
 11 files changed, 464 insertions(+)
 create mode 100644 tests/templates/secureboot_negative_test.yml
 create mode 100644 tests/templates/secureboot_unsigned_bootloader_steps.yml
 create mode 100644 tests/templates/secureboot_unsigned_kernel_steps.yml
 create mode 100644 tests/templates/swupdate_corrupt_swu_artifact_steps.yml
 create mode 100644 tests/templates/swupdate_corrupt_swu_steps.yml
 create mode 100644 tests/templates/swupdate_negative_test.yml
 create mode 100644 tests/templates/swupdate_reboot_without_confirm.yml
 create mode 100644 tests/templates/swupdate_same_uuid_steps.yml

-- 
2.39.2



