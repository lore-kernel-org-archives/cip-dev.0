Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E26C41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 09:52:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.37871.1717753954867932061
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jun 2024 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 4579qWT2304141; Fri, 7 Jun 2024 18:52:33 +0900
X-Iguazu-Qid: 2rWhTy7tCn7r3If7dw
X-Iguazu-QSIG: v=2; s=0; t=1717753952; q=2rWhTy7tCn7r3If7dw; m=yPP5B3Ap8ZR4TbBPK7Om4bZn8xeoMLBeeJyTIPEl4G0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 4579qUXm2787677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 7 Jun 2024 18:52:31 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v3 1/4] tests/templates: Include functionality based templates
Date: Fri,  7 Jun 2024 15:22:26 +0530
X-TSB-HOP2: ON
Message-Id: <20240607095229.490871-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20240607095229.490871-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jun 2024 09:52:28.0914 (UTC) FILETIME=[689C0D20:01DAB8C0]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jun 2024 09:52:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16137

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

These templates shall be extended to form architecture specific LAVA job
definitions

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 tests/templates/IEC_template.yml        |  74 ++++++++++++++
 tests/templates/secureboot_template.yml |  65 ++++++++++++
 tests/templates/swupdate_template.yml   | 125 ++++++++++++++++++++++++
 3 files changed, 264 insertions(+)
 create mode 100644 tests/templates/IEC_template.yml
 create mode 100644 tests/templates/secureboot_template.yml
 create mode 100644 tests/templates/swupdate_template.yml

diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
new file mode 100644
index 0000000..c8bdd41
--- /dev/null
+++ b/tests/templates/IEC_template.yml
@@ -0,0 +1,74 @@
+device_type: qemu
+job_name: qemu #architecture# IEC layer testing
+timeouts:
+  job:
+    minutes: 30
+  action:
+   minutes: 20
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
+    timeout:
+      minutes: 15
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+                    -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
+        url: #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
+        compression: xz
+
+      #Firmware#
+        #Firmware_args#
+        #Firmware_url#
+
+# BOOT BLOCK
+- boot:
+    timeout:
+      minutes: 15
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
+- test:
+     timeout:
+       minutes: 30
+     definitions:
+     - repository: https://gitlab.com/cip-project/cip-testing/cip-security-tests.git
+       from: git
+       branch: master
+       path: iec-security-tests/Singlenode-TestDefinition.yaml
+       name: Security-Testcases
+
+context:
+  arch: #architecture#
+  guestfs_interface: virtio
+  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
new file mode 100644
index 0000000..5996dbd
--- /dev/null
+++ b/tests/templates/secureboot_template.yml
@@ -0,0 +1,65 @@
+device_type: qemu
+job_name: qemu #architecture# secure boot testing
+timeouts:
+  job:
+    minutes: 30
+  action:
+   minutes: 20
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
+    timeout:
+      minutes: 15
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+                    -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
+        url: #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
+        compression: xz
+
+      #Firmware#
+        #Firmware_args#
+        #Firmware_url#
+
+# BOOT BLOCK
+- boot:
+    timeout:
+      minutes: 15
+    method: qemu
+    media: tmpfs
+    prompts: ["root@demo:~#"]
+    auto_login:
+      login_prompt: "demo login:"
+      username: "root"
+      password_prompt: "Password:"
+      password: "CIPsecurity@123"
+    parameters:
+      kernel-start-message: "EFI stub: UEFI Secure Boot is enabled."
+
+context:
+  arch: #architecture#
+  guestfs_interface: virtio
+  lava_test_results_dir: '/home/lava-%s'
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
new file mode 100644
index 0000000..d012ed4
--- /dev/null
+++ b/tests/templates/swupdate_template.yml
@@ -0,0 +1,125 @@
+device_type: qemu
+job_name: qemu #architecture# software update testing
+timeouts:
+  job:
+    minutes: 30
+  action:
+   minutes: 20
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
+      minutes: 15
+    to: tmpfs
+    images:
+      system:
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+                    -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
+                    -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
+        url: #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.wic.xz
+        compression: xz
+
+      #Firmware#
+        #Firmware_args#
+        #Firmware_url#
+
+# BOOT BLOCK
+- boot:
+    timeout:
+      minutes: 15
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
+# Sleep 200s is added to make the job incomplete with a timeout if software update application failed
+- test:
+    timeout:
+      minutes: 5
+    definitions:
+    - repository:
+        metadata:
+          format: Lava-Test Test Definition 1.0
+          name: sample-test
+          description: "Test software update"
+        run:
+          steps:
+            - if swupdate -d "-u #project_url#/#branch#/qemu-#architecture#/cip-core-image-security-cip-core-#distribution#-qemu-#architecture#.swu"; then echo software update is successful!!; else sleep 200s; fi
+      from: inline
+      name: sample-test-1
+      path: inline/sample-test.yaml
+
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
+       kernel-start-message: "kernel: C:BOOT1:linux.efi"
+
+# sleep 180s is added to make the job incomplete if ustate is not 2 in the updated partition
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
+            - if [ $(bg_printenv | grep ustate | awk 'FNR == 2{print $2}') = 2 ]; then bg_setenv -c; else sleep 180s; fi
+      from: inline
+      name: sample-test-2
+      path: inline/sample-test.yaml
+
+context:
+  arch: #architecture#
+  guestfs_interface: virtio
+  lava_test_results_dir: '/home/lava-%s'
-- 
2.30.2



