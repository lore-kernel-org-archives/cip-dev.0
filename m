Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFF6C47DD6
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 17:59:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.20568.1705600789376367132
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Jan 2024 09:59:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 40IHxlFM672856; Fri, 19 Jan 2024 02:59:48 +0900
X-Iguazu-Qid: 2yAa86qROgT3rA6aky
X-Iguazu-QSIG: v=2; s=0; t=1705600787; q=2yAa86qROgT3rA6aky; m=mS+AE5UmBZ8cI4i0vwRj16vbSp5HPFUtCXypdLNun7M=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 40IHxkpf3702282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jan 2024 02:59:47 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 3/3] .gitlab-ci.yml: Run cve-checks job only when it is manually triggered in the pipeline
Date: Thu, 18 Jan 2024 23:29:42 +0530
X-TSB-HOP2: ON
Message-Id: <20240118175942.1052089-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240118175942.1052089-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240118175942.1052089-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Jan 2024 17:59:42.0008 (UTC) FILETIME=[1CA57380:01DA4A38]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Jan 2024 17:59:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14404

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

The cve-checks job generates CVE reports from latest copy of dpkg status files
using cve_checker.py script in debian-cve-checker. This job can only be triggered
manually with no dependency on build jobs running in build stage. This dependency
is removed so that one does not have to wait until all the jobs running in build
stage are passed or is unable to run the cve-checks at all because some job has
failed in the build stage.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1de6570..2527427 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -29,6 +29,7 @@ variables:
 stages:
   - build
   - test
+  - cve-check
 
 default:
   before_script:
@@ -341,4 +342,17 @@ build:qemu-riscv64:
     deploy: disable
   allow_failure: true
 
+cve-checks:
+  stage: cve-check
+  needs: []
+  image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
+  script:
+    - scripts/run-cve-checks.sh
+  when: manual
+  allow_failure: true
+  artifacts:
+    expire_in: 1 day
+    paths:
+      - cve-reports
+
 include: '.reproducible-check-ci.yml'
-- 
2.30.2



