Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E44EB64D9
	for <webhook@archiver.kernel.org>; Wed, 12 Jul 2023 11:32:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.5087.1689161520786813745
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Jul 2023 04:32:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36CBVvuO798813; Wed, 12 Jul 2023 20:31:58 +0900
X-Iguazu-Qid: 2rWhoCDaNKLamC2W9Z
X-Iguazu-QSIG: v=2; s=0; t=1689161517; q=2rWhoCDaNKLamC2W9Z; m=hFIuHs32rjzK45sydii3WP7TjOc0I9+ZcDwnldpb12s=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 36CBVtW7017610
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Jul 2023 20:31:57 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] security.yml: Add additional features to security image
Date: Wed, 12 Jul 2023 17:01:53 +0530
X-TSB-HOP2: ON
Message-Id: <20230712113153.1194397-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jul 2023 11:31:54.0126 (UTC) FILETIME=[756BEAE0:01D9B4B4]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jul 2023 11:32:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12327

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

From IEC certification perspective, a security image is needed which has the below features along with security customizations.
1. Data encryption (CR4.1)
2. Secure boot (EDR 3.14)
3. SWupdate (NDR 3.10)

The config.yaml will not have the extra enabled features as true. Hence they
should be passed in the image run command.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 doc/README.security-testing.md | 2 +-
 kas/opt/security.yml           | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
index c9540be..97000da 100644
--- a/doc/README.security-testing.md
+++ b/doc/README.security-testing.md
@@ -33,7 +33,7 @@ Save & Build
 ```
 # Boot the Linux image
 ```
-host$ ./start-qemu.sh x86
+host$ SECURE_BOOT="true" TPM2_ENCRYPTION="true" ./start-qemu.sh x86
 ```
 
 # Copy security tests in to the Linux image
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 1f3745b..b21f330 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -10,6 +10,9 @@
 #
 header:
   version: 12
+  includes:
+    - kas/opt/encrypt-partitions.yml
+    - kas/opt/ebg-secure-boot-snakeoil.yml
 
 target: cip-core-image-security
 
-- 
2.30.2



