Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DABC27C4F
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 07:09:35 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.77630.1717398566988618335
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 00:09:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45379PUJ2114612; Mon, 3 Jun 2024 16:09:25 +0900
X-Iguazu-Qid: 2yAbNsrDKYJ7g2J7tF
X-Iguazu-QSIG: v=2; s=0; t=1717398565; q=2yAbNsrDKYJ7g2J7tF; m=eR+7RHrCc5zyrzYhikCVp8mxH1r3bFwOSw2bu/zxZ4M=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 45379Pm71718868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 3 Jun 2024 16:09:25 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] .gitlab-ci.yml: Add test targets specific for CIP core functionalities
Date: Mon,  3 Jun 2024 12:39:20 +0530
X-TSB-HOP2: ON
Message-Id: <20240603070920.2942859-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240603070920.2942859-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jun 2024 07:09:19.0612 (UTC) FILETIME=[F4141BC0:01DAB584]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 07:09:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16082

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index aab55be..0a22a3f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -358,6 +358,39 @@ build:qemu-riscv64:
     deploy: disable
   allow_failure: true
 
+.test-cip-core:
+  stage: test
+  needs: ["build:qemu-amd64-base","build:qemu-arm64-base","build:qemu-arm-base"]
+  tags:
+    - large
+  allow_failure: true
+  artifacts:
+    name: "$CI_JOB_NAME"
+    when: always
+    expire_in: 1 day
+    paths:
+      - results
+    reports:
+      junit: results/results*.xml
+
+test-qemu-secure-boot:
+  extends:
+    - .test-cip-core
+  script:
+    - scripts/submit_lava.sh secure-boot ${CI_COMMIT_SHA} ${release}
+
+test-qemu-swupdate:
+  extends:
+    - .test-cip-core
+  script:
+    - scripts/submit_lava.sh swupdate ${CI_COMMIT_SHA} ${release}
+
+test-qemu-IEC:
+  extends:
+   - .test-cip-core
+  script:
+    - scripts/submit_lava.sh IEC ${CI_COMMIT_SHA} ${release}
+
 cve-checks:
   stage: cve-check
   needs: []
-- 
2.30.2



