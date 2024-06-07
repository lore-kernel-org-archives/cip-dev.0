Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110C9C27C6F
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 09:52:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.37872.1717753955574565641
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4579qYMW3866611; Fri, 7 Jun 2024 18:52:34 +0900
X-Iguazu-Qid: 2rWhclmqS6iRSpgGqA
X-Iguazu-QSIG: v=2; s=0; t=1717753953; q=2rWhclmqS6iRSpgGqA; m=qZODcuaieDjxwRXjs7B6FZQs/ZPpS1QxsPk0xIuwf3I=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 4579qWtj2263925
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 18:52:33 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 4/4] doc/README.lava-testing.md: Add README to explain CIP Core testing
Date: Fri,  7 Jun 2024 15:22:29 +0530
X-TSB-HOP2: ON
Message-Id: <20240607095229.490871-5-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jun 2024 09:52:29.0117 (UTC) FILETIME=[68BB06D0:01DAB8C0]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16138

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This README explains the kind of testing done by the LAVA job definitions
created from the template files.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 doc/README.lava-testing.md | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 doc/README.lava-testing.md

diff --git a/doc/README.lava-testing.md b/doc/README.lava-testing.md
new file mode 100644
index 0000000..85beaa7
--- /dev/null
+++ b/doc/README.lava-testing.md
@@ -0,0 +1,30 @@
+# CIP Core functionality testing with LAVA
+
+
+This document explains how SWUpdate, Secure boot and IEC layer are being tested using LAVA. The tests/templates directory contains functionality based templates which are extended to LAVA job definitions which tests the respective functionality on QEMU amd64, arm64 and arm architectures. CI jobs run until the final health of all the submitted jobs is reported. Test results are also pushed to [CIP SQUAD platform](https://squad.ciplatform.org/cip-core/).
+
+## Templates
+
+#### IEC_template.yml:
+This template is extended to three LAVA job definitions which runs [IEC layer test cases](https://gitlab.com/cip-project/cip-testing/cip-security-tests) on the QEMU security target. Here is a [reference](https://lava.ciplatform.org/scheduler/job/1143475/definition) to the IEC job definition.
+
+#### secureboot_template.yml:
+This template is extended to three LAVA job definitions which checks whether secure boot is enabled on the QEMU security target. Here is a [reference](https://lava.ciplatform.org/scheduler/job/1143474/definition) to the secure boot job definition.
+
+#### swupdate_template.yml:
+This template is extended to five LAVA job definitions in which three jobs verify successful software update, partition switch after reboot and checking whether bootloader environment variables(ustate) are updated. Here is a [reference](https://lava.ciplatform.org/scheduler/job/1143538/definition) to the software update job definition.
+
+The other two jobs i.e [kernel_panic.yml](https://lava.ciplatform.org/scheduler/job/1143642/definition) and [initramfs_crash.yml](https://lava.ciplatform.org/scheduler/job/1143643/definition) verify the roll back feature during a fail case scenarios.
+
+## LAVA Setup
+
+The above mentioned job definitions shall be sent to CIP LAVA Lab for testing. For local testing please follow the steps mentioned in [CIP LAVA Docker](https://gitlab.com/cip-project/cip-testing/lava-docker/-/tree/cip-lava-docker?ref_type=heads#linaros-automated-validation-architecture-lava-docker-container) to have your own setup.
+
+## LAVA template variables
+
+* `architecture` : This variable represents architecture of the QEMU security target on which the test is done.
+* `project_url` : Default value is `https://s3.eu-central-1.amazonaws.com/download2.cip-project.org/cip-core`.
+* `branch` : This variable represents the branch on which the pipeline is triggered.
+* `distribution` : This variable is assigned with the `release` assigned in gitlab CI configuration file.
+* `Firmware_args` : This variable is used only for `arm64` and `armhf` architectures and it has boot parameters for the U-boot firmware binary.
+* `Firmware_url` : This variable represents the firmware binary artifact uploaded in cip-project s3 bucket.
-- 
2.30.2



