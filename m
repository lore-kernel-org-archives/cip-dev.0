Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED54C02192
	for <webhook@archiver.kernel.org>; Wed,  5 Feb 2025 13:37:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.11897.1738762653652581948
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Feb 2025 05:37:34 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 515DbVsx545170; Wed, 5 Feb 2025 22:37:31 +0900
X-Iguazu-Qid: 2rWhMjEQIBpC4Tvj5E
X-Iguazu-QSIG: v=2; s=0; t=1738762651; q=2rWhMjEQIBpC4Tvj5E; m=rReJCI1DFN1dmYjFmztt+3utmc/MnTY+0ximmgY1bJE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 515DbUPb4126248
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 5 Feb 2025 22:37:31 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] README.security-testing.md: Update steps to verify IEC layer on security image
Date: Wed,  5 Feb 2025 19:04:15 +0530
X-TSB-HOP2: ON
Message-Id: <20250205133415.72913-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 05 Feb 2025 13:37:28.0896 (UTC) FILETIME=[199B1400:01DB77D3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Feb 2025 13:37:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17755

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 doc/README.security-testing.md | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
index c9540be..213fc82 100644
--- a/doc/README.security-testing.md
+++ b/doc/README.security-testing.md
@@ -1,34 +1,24 @@
 # CIP security testing
 This document explains how to verify basic implementations of [CIP security requirements](https://gitlab.com/cip-project/cip-documents/-/blob/master/security/security_requirements.md) in the isar-cip-core security image using [cip-security-tests](https://gitlab.com/cip-project/cip-testing/cip-security-tests).
 
-# Pre-requisite
+# Pre-requisites
 - Necessary debian packages to implement CIP security requirements, include them in the recipe [cip-core-image-security.bb](recipes-core/images/cip-core-image-security.bb)
 
 - Pre configurations in the image, should be added in the `postinst` script of security-customizations [security-customizations/files/postinst](recipes-core/security-customizations/files/postinst)
 
-- To run `cip-security-tests` the image should need additional package `sshpass` and rootfs size should need atleast 5GB, add the below configuration in kas/opt/security.yml file
-    ```
-    local_conf_header:
-        security_testing: |
-            IMAGE_PREINSTALL:append=" sshpass"
-            ROOTFS_EXTRA="5120"
-    ```
-
-
 # Build CIP security Linux image
 Clone isar-cip-core repository
 ```
 host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
 host$ cd isar-cip-core
 ```
-Build Security Linux image by selecting necessary options
+Build Security Linux image by selecting necessary options. The board, Kernel version and Debian release options chosen below are shown as an example.
 ```
 host$ ./kas-container menu
     Select QEMU AMD64 (x86-64) as Target Board
-    Select Kernel 5.10.x-cip as Kernel Options
+    Select Kernel 5.10.x-cip as CIP Kernel version
     Select bullseye (11) as Debian Release
-    Select Flashable image as Image formats
-    Select Security extensions Options
+    Select Security extensions Option under Image features
 Save & Build
 ```
 # Boot the Linux image
@@ -41,22 +31,22 @@ host$ ./start-qemu.sh x86
 ```
 host$ git clone https://gitlab.com/cip-project/cip-testing/cip-security-tests
 ```
-- Add test user in Linux image to use while scp the `cip-security-tests`
+- Add test user in Linux image to scp and run the `cip-security-tests`
 ```
 image$ adduser test
 ```
 - Copy `cip-security-tests` to Linux image using scp command
 ```
-host$  scp -r -P 22222 TCs/ test@127.0.0.1:/home/test/
+host$ scp -r -P 22222 cip-security-tests/ test@127.0.0.1:/home/test/
 ```
 
-# Run the test in Linux image
+# Run the tests in Linux image
 - Go to following directory and execute IEC Layer test
 ```
-image$ cd /home/test/TCs/cip-security-tests/iec-security-tests/singlenode-testcases/
+image$ cd /home/test/cip-security-tests/iec-security-tests/singlenode-testcases/
 image$ ./run_all.sh
 ```
-`run_all.sh` generates the test result in file `result_file.txt`, and output look like below.
+`run_all.sh` generates the test result in file `result_file.txt`, and the output looks like below.
 ```
 TC_CR1.1-RE1_1+pass+11
 TC_CR1.11_1+pass+22
-- 
2.30.2



