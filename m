Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156CC36002
	for <webhook@archiver.kernel.org>; Mon, 24 Mar 2025 11:25:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.37028.1742815511991188291
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Mar 2025 04:25:12 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52OBP9HE3080733; Mon, 24 Mar 2025 20:25:10 +0900
X-Iguazu-Qid: 2rWhg4sy1pP8px3ihl
X-Iguazu-QSIG: v=2; s=0; t=1742815509; q=2rWhg4sy1pP8px3ihl; m=QSLVIfCIVM8AZJ/n+RZbx/bKF21/EkSPk1K3E0gnLHs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 52OBP8rR1795673
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 20:25:09 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1] .gitlab-ci.yml: Deploy seperate home partition for qemu security targets
Date: Mon, 24 Mar 2025 16:51:55 +0530
X-TSB-HOP2: ON
Message-Id: <20250324112155.3051460-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Mar 2025 11:25:06.0783 (UTC) FILETIME=[65270EF0:01DB9CAF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Mar 2025 11:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18340

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

IEC layer tests run with /home as working directory. aide is unable to
detect changes made to a temporary file created under /home which is
now symlinked to /var/home. This resulted in failure of the following test cases
TC_CR3.4-RE2_1, TC_CR3.4_1, TC_CR6.2_1.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index ec9ec2e..146eb33 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -122,6 +122,7 @@ build:qemu-amd64-base:
     security_test: enable
     use_rt: disable
     build_swu_v2: enable
+    separate_home_partition: enable
 
 build:qemu-amd64-base-kernelci:
   extends:
@@ -142,6 +143,7 @@ build:qemu-arm64-base:
     security_test: enable
     use_rt: disable
     build_swu_v2: enable
+    separate_home_partition: enable
 
 build:qemu-arm64-base-kernelci:
   extends:
@@ -162,6 +164,7 @@ build:qemu-arm-base:
     security_test: enable
     use_rt: disable
     build_swu_v2: enable
+    separate_home_partition: enable
 
 build:qemu-arm-base-kernelci:
   extends:
-- 
2.30.2



