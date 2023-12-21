Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761A2C46CD4
	for <webhook@archiver.kernel.org>; Thu, 21 Dec 2023 12:04:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.49479.1703160272765097407
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Dec 2023 04:04:33 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3BLC4Uuw041571; Thu, 21 Dec 2023 21:04:31 +0900
X-Iguazu-Qid: 2rWgKwcnFBzk4wZMqC
X-Iguazu-QSIG: v=2; s=0; t=1703160270; q=2rWgKwcnFBzk4wZMqC; m=Ex68g1XdMfIQ5Jdm3qqkK40zhOvBOUvpmCUosJ9wFvE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 3BLC4Sx94120509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Dec 2023 21:04:30 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] .gitlab-ci.yml: Add cve-checks job which runs when a tag is pushed
Date: Thu, 21 Dec 2023 17:34:23 +0530
X-TSB-HOP2: ON
Message-Id: <20231221120423.2388639-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231221120423.2388639-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20231221120423.2388639-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Dec 2023 12:04:24.0130 (UTC) FILETIME=[D6A26A20:01DA3405]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Dec 2023 12:04:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14187

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

The cve-checks job generate latest CVE reports using the cve_checker.py
script in debian-cve-checker container.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 1de6570..b8422be 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -63,6 +63,13 @@ default:
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
+cve-checks:
+  image: registry.gitlab.com/cip-playground/debian-cve-checker:latest
+  script:
+    - scripts/run-cve-checks.sh
+  only:
+    - tags
+
 # base image
 build:simatic-ipc227e-base:
   extends:
-- 
2.30.2



