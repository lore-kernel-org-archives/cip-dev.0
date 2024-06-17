Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A0EC27C79
	for <webhook@archiver.kernel.org>; Mon, 17 Jun 2024 18:22:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.64711.1718648518963651757
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 11:21:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 45HILvY6062057; Tue, 18 Jun 2024 03:21:57 +0900
X-Iguazu-Qid: 2yAb3nxBrIv0BMVZj6
X-Iguazu-QSIG: v=2; s=0; t=1718648517; q=2yAb3nxBrIv0BMVZj6; m=53NbiXbJhdS4N1oEsx7+jrHglIbfeXARKkEczsS1lnw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 45HILuBO3710907
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 03:21:57 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 3/3] tests: Modify the replacable strings and increase timeouts in the templates
Date: Mon, 17 Jun 2024 23:51:47 +0530
X-TSB-HOP2: ON
Message-Id: <20240617182147.1724078-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 17 Jun 2024 18:21:45.0972 (UTC) FILETIME=[362A9340:01DAC0E3]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jun 2024 18:22:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16268

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml        | 16 ++++++++--------
 tests/templates/secureboot_template.yml | 14 +++++++-------
 tests/templates/swupdate_template.yml   | 18 +++++++++---------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index c8bdd41..092af45 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -1,10 +1,10 @@
 device_type: qemu
-job_name: qemu #architecture# IEC layer testing
+job_name: #architecture# IEC layer testing
 timeouts:
   job:
-    minutes: 30
+    minutes: 50
   action:
-   minutes: 20
+   minutes: 40
   actions:
     power-off:
       seconds: 60
@@ -30,14 +30,14 @@ actions:
 # DEPLOY BLOCK
 - deploy:
     timeout:
-      minutes: 15
+      minutes: 30
     to: tmpfs
     images:
       system:
         image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
-        url: #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
         compression: xz
 
       #Firmware#
@@ -47,7 +47,7 @@ actions:
 # BOOT BLOCK
 - boot:
     timeout:
-      minutes: 15
+      minutes: 25
     method: qemu
     media: tmpfs
     prompts: ["root@demo:~#"]
@@ -60,7 +60,7 @@ actions:
 # TEST_BLOCK
 - test:
      timeout:
-       minutes: 30
+       minutes: 40
      definitions:
      - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
        from: git
@@ -69,6 +69,6 @@ actions:
        name: Security-Testcases
 
 context:
-  arch: #architecture#
+  arch: #context-architecture#
   guestfs_interface: virtio
   lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
index 5996dbd..1b8e882 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -1,10 +1,10 @@
 device_type: qemu
-job_name: qemu #architecture# secure boot testing
+job_name: #architecture# secure boot testing
 timeouts:
   job:
-    minutes: 30
+    minutes: 50
   action:
-   minutes: 20
+   minutes: 40
   actions:
     power-off:
       seconds: 60
@@ -30,14 +30,14 @@ actions:
 # DEPLOY BLOCK
 - deploy:
     timeout:
-      minutes: 15
+      minutes: 30
     to: tmpfs
     images:
       system:
         image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
-        url: #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
         compression: xz
 
       #Firmware#
@@ -47,7 +47,7 @@ actions:
 # BOOT BLOCK
 - boot:
     timeout:
-      minutes: 15
+      minutes: 25
     method: qemu
     media: tmpfs
     prompts: ["root@demo:~#"]
@@ -60,6 +60,6 @@ actions:
       kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
 
 context:
-  arch: #architecture#
+  arch: #context-architecture#
   guestfs_interface: virtio
   lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index d012ed4..bf6777c 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -1,10 +1,10 @@
 device_type: qemu
-job_name: qemu #architecture# software update testing
+job_name: #architecture# software update testing
 timeouts:
   job:
-    minutes: 30
+    minutes: 50
   action:
-   minutes: 20
+   minutes: 40
   actions:
     power-off:
       seconds: 60
@@ -30,14 +30,14 @@ actions:
 # DEPLOY BLOCK
 - deploy:
     timeout:
-      minutes: 15
+      minutes: 30
     to: tmpfs
     images:
       system:
         image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
-        url: #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
         compression: xz
 
       #Firmware#
@@ -47,7 +47,7 @@ actions:
 # BOOT BLOCK
 - boot:
     timeout:
-      minutes: 15
+      minutes: 25
     method: qemu
     media: tmpfs
     prompts: ["root@demo:~#"]
@@ -61,7 +61,7 @@ actions:
 # Sleep 200s is added to make the job incomplete with a timeout if software update application failed
 - test:
     timeout:
-      minutes: 5
+      minutes: 15
     definitions:
     - repository:
         metadata:
@@ -70,7 +70,7 @@ actions:
           description: "Test software update"
         run:
           steps:
-            - if swupdate -d "-u #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.swu"; then echo software update is successful!!; else sleep 200s; fi
+            - if swupdate -d "-u #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu"; then echo software update is successful!!; else sleep 200s; fi
       from: inline
       name: sample-test-1
       path: inline/sample-test.yaml
@@ -120,6 +120,6 @@ actions:
       path: inline/sample-test.yaml
 
 context:
-  arch: #architecture#
+  arch: #context-architecture#
   guestfs_interface: virtio
   lava_test_results_dir: '/home/lava-%s'
-- 
2.30.2



