Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DDFC27C55
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 09:52:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.37946.1717753954912853111
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 4579qXkk2331507; Fri, 7 Jun 2024 18:52:33 +0900
X-Iguazu-Qid: 2yAbLYkr6OeLRqz8NO
X-Iguazu-QSIG: v=2; s=0; t=1717753952; q=2yAbLYkr6OeLRqz8NO; m=7dzdPs4mt9DFhE6w063CfbYrPunH6fCCgMsoX2mMtOM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 4579qWBv2938455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jun 2024 18:52:32 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 3/4] .gitlab-ci.yml: Add test targets specific for CIP core functionalities
Date: Fri,  7 Jun 2024 15:22:28 +0530
X-TSB-HOP2: ON
Message-Id: <20240607095229.490871-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jun 2024 09:52:29.0102 (UTC) FILETIME=[68B8BCE0:01DAB8C0]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 09:52:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16136

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index aab55be..80f8659 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -358,6 +358,39 @@ build:qemu-riscv64:
     deploy: disable
   allow_failure: true
 
+.test-cip-core:
+  stage: test
+  needs: ["build:qemu-amd64-base","build:qemu-arm64-base","build:qemu-arm-base"]
+  tags:
+    - small
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
+    - scripts/submit_lava.sh secure-boot ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+
+test-qemu-swupdate:
+  extends:
+    - .test-cip-core
+  script:
+    - scripts/submit_lava.sh swupdate ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+
+test-qemu-IEC:
+  extends:
+   - .test-cip-core
+  script:
+    - scripts/submit_lava.sh IEC ${CI_COMMIT_SHA} ${release} ${CI_COMMIT_REF_SLUG}
+
 cve-checks:
   stage: cve-check
   needs: []
-- 
2.30.2



