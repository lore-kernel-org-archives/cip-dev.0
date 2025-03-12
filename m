Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AD6C28B2F
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 13:22:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.37046.1741785755714660641
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 06:22:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52CDMYv8670331; Wed, 12 Mar 2025 22:22:34 +0900
X-Iguazu-Qid: 2rWhyCKR5ZO5ohRZlx
X-Iguazu-QSIG: v=2; s=0; t=1741785753; q=2rWhyCKR5ZO5ohRZlx; m=vJ9BiQqiC/hH3ggLvFlW7mzGryNeGSBK3we5jBn5rPo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 52CDMXTB4099436
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 22:22:33 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 4/4] .gitlab-ci.ymll: Enable security_test option for base images
Date: Wed, 12 Mar 2025 18:44:03 +0530
X-TSB-HOP2: ON
Message-Id: <20250312131403.1360421-5-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Mar 2025 13:22:28.0919 (UTC) FILETIME=[CDA2BC70:01DB9351]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 13:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18090

This is required as it installs additional packages (e.g curl) which are
required for testing purpose.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d44b164..ec9ec2e 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -119,6 +119,7 @@ build:qemu-amd64-base:
   variables:
     target: qemu-amd64
     extension: security
+    security_test: enable
     use_rt: disable
     build_swu_v2: enable
 
@@ -138,6 +139,7 @@ build:qemu-arm64-base:
   variables:
     target: qemu-arm64
     extension: security
+    security_test: enable
     use_rt: disable
     build_swu_v2: enable
 
@@ -157,6 +159,7 @@ build:qemu-arm-base:
   variables:
     target: qemu-arm
     extension: security
+    security_test: enable
     use_rt: disable
     build_swu_v2: enable
 
-- 
2.39.2



