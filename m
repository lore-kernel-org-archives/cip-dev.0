Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C33C35FF1
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 13:22:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.37044.1741785754942098814
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 06:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 52CDMXxb1967579; Wed, 12 Mar 2025 22:22:33 +0900
X-Iguazu-Qid: 2rWhMjEQJ9IAmf6EC1
X-Iguazu-QSIG: v=2; s=0; t=1741785752; q=2rWhMjEQJ9IAmf6EC1; m=G0B4KdgW4R+FQPDBDuk0gYxLdsRjZB+X8LeIEYlLaok=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 52CDMVM3602591
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 22:22:32 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 1/4] Add additional test cases for swupdate and secure boot in LAVA
Date: Wed, 12 Mar 2025 18:44:00 +0530
X-TSB-HOP2: ON
Message-Id: <20250312131403.1360421-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Mar 2025 13:22:28.0779 (UTC) FILETIME=[CD8D5FB0:01DB9351]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 13:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18088

To improve the test coverage of swupdate and secure boot features add
the negative test cases and the required steps to achieve them.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 tests/templates/secureboot_negative_test.yml  | 81 +++++++++++++++++
 .../secureboot_unsigned_bootloader_steps.yml  |  7 ++
 .../secureboot_unsigned_kernel_steps.yml      |  7 ++
 .../swupdate_corrupt_swu_artifact_steps.yml   |  9 ++
 .../templates/swupdate_corrupt_swu_steps.yml  |  6 ++
 tests/templates/swupdate_negative_test.yml    | 89 +++++++++++++++++++
 .../swupdate_reboot_without_confirm.yml       | 43 +++++++++
 tests/templates/swupdate_same_uuid_steps.yml  |  9 ++
 tests/templates/swupdate_template.yml         |  2 +
 9 files changed, 253 insertions(+)
 create mode 100644 tests/templates/secureboot_negative_test.yml
 create mode 100644 tests/templates/secureboot_unsigned_bootloader_steps.yml
 create mode 100644 tests/templates/secureboot_unsigned_kernel_steps.yml
 create mode 100644 tests/templates/swupdate_corrupt_swu_artifact_steps.yml
 create mode 100644 tests/templates/swupdate_corrupt_swu_steps.yml
 create mode 100644 tests/templates/swupdate_negative_test.yml
 create mode 100644 tests/templates/swupdate_reboot_without_confirm.yml
 create mode 100644 tests/templates/swupdate_same_uuid_steps.yml

diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
new file mode 100644
index 0000000..568b5b6
--- /dev/null
+++ b/tests/templates/secureboot_negative_test.yml
@@ -0,0 +1,81 @@
+device_type: qemu
+job_name: #architecture# secure boot testing
+timeouts:
+  job:
+    minutes: 50
+  action:
+   minutes: 40
+  actions:
+    power-off:
+      seconds: 60
+priority: medium
+tags:
+- swtpm-jobs
+visibility: public
+notify:
+  criteria:
+    status: finished
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results@lists.cip-project.org
+
+# ACTION BLOCK
+actions:
+- command:
+    name: start_tpm
+    timeout:
+          minutes: 20
+
+# DEPLOY BLOCK
+- deploy:
+    to: downloads
+    timeout:
+      minutes: 30
+    images:
+      system:
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
+        compression: xz
+    postprocess:
+      docker:
+        image: debian:bookworm
+        steps:
+        #POSTPROCESS_STEPS#
+    timeout:
+      minutes: 30
+    to: downloads
+
+- deploy:
+    timeout:
+      minutes: 30
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+                    -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
+        url: downloads://cip-core-image-security-cip-core-#distribution#-#architecture#.wic
+
+      #Firmware#
+        #Firmware_args#
+        #Firmware_url#
+
+# BOOT BLOCK
+- boot:
+    timeout:
+      minutes: 25
+    method: qemu
+    media: tmpfs
+- test:
+    monitors:
+    - end: "#END_MONITOR#"
+      name: corrupted-#ARTIFACT#-image
+      pattern: _unused_
+      start: "#START_MONITOR#"
+    timeout:
+      minutes: 25
+
+context:
+  arch: #context-architecture#
+  guestfs_interface: virtio
+  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/secureboot_unsigned_bootloader_steps.yml b/tests/templates/secureboot_unsigned_bootloader_steps.yml
new file mode 100644
index 0000000..8d64b05
--- /dev/null
+++ b/tests/templates/secureboot_unsigned_bootloader_steps.yml
@@ -0,0 +1,7 @@
+          - "apt-get update"
+          - "apt install --yes guestfish sbsigntool"
+          - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-out /EFI/BOOT/bootx64.efi ."
+          - "sbverify --list bootx64.efi"
+          - "sbattach --remove bootx64.efi"
+          - "sbverify --list bootx64.efi"
+          - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda1 / : copy-in bootx64.efi /EFI/BOOT/"
diff --git a/tests/templates/secureboot_unsigned_kernel_steps.yml b/tests/templates/secureboot_unsigned_kernel_steps.yml
new file mode 100644
index 0000000..f097ed6
--- /dev/null
+++ b/tests/templates/secureboot_unsigned_kernel_steps.yml
@@ -0,0 +1,7 @@
+          - "apt-get update"
+          - "apt install --yes guestfish sbsigntool"
+          - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-out /linux.efi ."
+          - "sbverify --list linux.efi"
+          - "sbattach --remove linux.efi"
+          - "sbverify --list linux.efi"
+          - "guestfish add cip-core-image-security-cip-core-#distribution#-#architecture#.wic : run : mount /dev/sda2 / : copy-in linux.efi /"
diff --git a/tests/templates/swupdate_corrupt_swu_artifact_steps.yml b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
new file mode 100644
index 0000000..2fad3fd
--- /dev/null
+++ b/tests/templates/swupdate_corrupt_swu_artifact_steps.yml
@@ -0,0 +1,9 @@
+            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+            - mkdir -p swu
+            - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+            - dd if=/dev/zero of=/root/swu/cip-core-image-security-cip-core-#distribution#-#architecture#.delta_update bs=1 count=256
+            - cd /root/swu
+            - for file in sw-description sw-description.sig cip-core-image-security-cip-core-#distribution#-#architecture#.delta_update linux.efi; do echo "${file}"; done | cpio -ovL --reproducible -H crc > cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+            - swupdate -l 5 -i cip-core-image-security-cip-core-#distribution#-#architecture#.swu > /root/swupdate.txt
+            - cat /root/swupdate.txt
+            - if grep -q "Image invalid or corrupted" /root/swupdate.txt; then echo "kernel file corrupt test verification successful!!"; else lava-test-raise "Fail job"; fi
diff --git a/tests/templates/swupdate_corrupt_swu_steps.yml b/tests/templates/swupdate_corrupt_swu_steps.yml
new file mode 100644
index 0000000..74c9217
--- /dev/null
+++ b/tests/templates/swupdate_corrupt_swu_steps.yml
@@ -0,0 +1,6 @@
+            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+            - mkdir -p swu
+            - dd if=/dev/zero of=/root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu bs=1M count=5
+            - swupdate -l 5 -i /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu > /root/swupdate.txt
+            - cat /root/swupdate.txt
+            - if grep -q "CPIO Header corrupted, cannot be parsed" /root/swupdate.txt; then echo ".swu file corrupt test verification successful!!!"; else lava-test-raise "Fail job"; fi
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
new file mode 100644
index 0000000..57f9f1c
--- /dev/null
+++ b/tests/templates/swupdate_negative_test.yml
@@ -0,0 +1,89 @@
+device_type: qemu
+job_name: #architecture# software update testing
+timeouts:
+  job:
+    minutes: 50
+  action:
+   minutes: 40
+  actions:
+    power-off:
+      seconds: 60
+tags:
+- swtpm-jobs
+priority: medium
+visibility: public
+notify:
+  criteria:
+    status: finished
+  recipients:
+  - to:
+     method: email
+     email: cip-testing-results@lists.cip-project.org
+
+# ACTION BLOCK
+actions:
+- command:
+    name: start_tpm
+    timeout:
+          minutes: 20
+
+# DEPLOY BLOCK
+- deploy:
+    timeout:
+      minutes: 10
+    to: downloads
+    images:
+      image:
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+
+- deploy:
+    timeout:
+      minutes: 30
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+                    -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
+        url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
+        compression: xz
+
+      #Firmware#
+        #Firmware_args#
+        #Firmware_url#
+
+# BOOT BLOCK
+- boot:
+    timeout:
+      minutes: 25
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+
+# TEST_BLOCK
+# Fail the job if software update application error is not as expected
+- test:  
+    timeout:
+      minutes: 25
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "Test software update by modifying the files"
+        run:
+          steps:
+            #TEST_BLOCK_STEPS#
+      from: inline
+      name: sample-test-1
+      path: inline/sample-test.yaml
+
+context:
+  arch: #context-architecture#
+  guestfs_interface: virtio
+  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/swupdate_reboot_without_confirm.yml b/tests/templates/swupdate_reboot_without_confirm.yml
new file mode 100644
index 0000000..9b1ed25
--- /dev/null
+++ b/tests/templates/swupdate_reboot_without_confirm.yml
@@ -0,0 +1,43 @@
+# qemu-swtpm.sock will be gone after soft reboot.
+# So the swtpm socket need to be started again for proper reboot
+# To start the swtpm daemon, first the existing one should be killed
+- command:
+    name: manual_kill
+    timeout:
+          minutes: 1
+# Start the swtpm daemon
+- command:
+    name: start_tpm
+    timeout:
+          minutes: 1
+
+- boot:
+    timeout:
+      minutes: 5
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+    parameters:
+       kernel-start-message: "kernel: C:BOOT0:linux.efi" 
+
+# Fail the job if ustate is not 3 (failed) after reboot
+- test:
+    timeout:
+      minutes: 5
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "check boot loader environment variables"
+        run:
+          steps:
+            - if [ $(bg_printenv | grep ustate | awk 'FNR == 2{print $2}') = 3 ]; then echo ustate status failed; else lava-test-raise "Fail job"; fi
+      from: inline
+      name: sample-test-3
+      path: inline/sample-test.yaml
diff --git a/tests/templates/swupdate_same_uuid_steps.yml b/tests/templates/swupdate_same_uuid_steps.yml
new file mode 100644
index 0000000..3ff2e02
--- /dev/null
+++ b/tests/templates/swupdate_same_uuid_steps.yml
@@ -0,0 +1,9 @@
+            - curl -v --trace-time http://$LAVA_DISPATCHER_IP/tmp/$LAVA_JOB_ID/downloads/common/cip-core-image-security-cip-core-#distribution#-#architecture#.swu --output /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+            - mkdir -p swu
+            - cpio -ivd --directory=/root/swu < /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu
+            - current_uuid=$( cat /etc/os-release | grep IMAGE_UUID= | cut -d'"' -f 2)
+            - swu_uuid=$(cat /root/swu/sw-description | grep IMAGE_UUID | cut -d'=' -f3 | cut -c 1-36)
+            - sed -i s/$current_uuid/$swu_uuid/g /etc/os-release
+            - swupdate -l 5 -i /root/cip-core-image-security-cip-core-#distribution#-#architecture#.swu > /root/swupdate.txt
+            - cat /root/swupdate.txt
+            - if grep -q "'configfilecheck()' failed" /root/swupdate.txt; then echo "test verification successful!!!"; else lava-test-raise "Fail job"; fi
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index e12fb32..67bee03 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -120,6 +120,8 @@ actions:
       name: sample-test-2
       path: inline/sample-test.yaml
 
+#REBOOT_WITHOUT_CONFIRM_STEPS#
+
 context:
   arch: #context-architecture#
   guestfs_interface: virtio
-- 
2.39.2



