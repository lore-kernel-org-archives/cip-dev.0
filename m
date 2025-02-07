Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45914C02199
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 15:08:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.71586.1738940878777268526
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 07:07:59 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 517F7vYK3279582; Sat, 8 Feb 2025 00:07:57 +0900
X-Iguazu-Qid: 2yAbuzQy0fvU6hCJbn
X-Iguazu-QSIG: v=2; s=0; t=1738940876; q=2yAbuzQy0fvU6hCJbn; m=4RI7522cBYQHPojCTif1v5oOYhN+kcvupjtUadWz1Xg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 517F7tMv1285140
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 8 Feb 2025 00:07:56 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 2/5] tests/templates: Add template files required to generate M-COM job defintions
Date: Fri,  7 Feb 2025 20:34:36 +0530
X-TSB-HOP2: ON
Message-Id: <20250207150439.392479-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250207150439.392479-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Feb 2025 15:07:52.0813 (UTC) FILETIME=[0F56A1D0:01DB7972]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 15:08:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17772

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/M-COM-x86.yml                 | 52 +++++++++++++++++++
 .../templates/swupdate-test-action-M-COM.yml  | 18 +++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tests/templates/M-COM-x86.yml
 create mode 100644 tests/templates/swupdate-test-action-M-COM.yml

diff --git a/tests/templates/M-COM-x86.yml b/tests/templates/M-COM-x86.yml
new file mode 100644
index 0000000..4716225
--- /dev/null
+++ b/tests/templates/M-COM-x86.yml
@@ -0,0 +1,52 @@
+# Copyright (c) 2025, Siemens AG, Quirin Gylstorff <quirin.gylstorff@siemens.com>
+# SPDX-License-Identifier:      AGPL-3.0
+# This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, version 3.
+# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+job_name: mtda-mcom-#test_function#
+device_type: mcom-mtda
+timeouts:
+  job:
+    minutes: 180
+  action:
+    minutes: 95
+  connection:
+    minutes: 25
+priority: medium
+visibility: public
+context:
+  lava_test_results_dir: /home/lava/%s
+notify:
+  criteria:
+    status: finished
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results@lists.cip-project.org
+
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 60
+    to: flasher
+    images:
+      image:
+        url: #project_url#/#branch#/x86-uefi/cip-core-image-security-cip-core-#distribution#-x86-uefi.wic.xz
+
+# BOOT BLOCK
+- boot:
+    method: minimal
+    timeout:
+      minutes: 30
+    reset: true
+    failure_retry: 1
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+    transfer_overlay:
+      transfer_method: http
+      download_command: "curl -H 'Connection: close' -v --trace-time --output overlay-1.1.1.4.tar.gz"
+      unpack_command: rm -rf /home/lava; mkdir /home/lava; tar -C /home/lava/ -xf
diff --git a/tests/templates/swupdate-test-action-M-COM.yml b/tests/templates/swupdate-test-action-M-COM.yml
new file mode 100644
index 0000000..02b0b03
--- /dev/null
+++ b/tests/templates/swupdate-test-action-M-COM.yml
@@ -0,0 +1,18 @@
+# TEST BLOCK 1
+# Fail the job if software update application failed
+- test:
+    timeout:
+      minutes: 15
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "Test software update"
+        run:
+          steps:
+            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-bookworm-x86-uefi.swu --output test.swu
+            - if swupdate -i test.swu; then echo software update is successful!!; else lava-test-raise "Fail job"; fi
+      from: inline
+      name: sample-test-1
+      path: inline/sample-test.yaml
-- 
2.30.2



