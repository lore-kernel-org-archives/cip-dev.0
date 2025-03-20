Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98975C35FFF
	for <webhook@archiver.kernel.org>; Thu, 20 Mar 2025 13:17:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.7146.1742476666346806710
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Mar 2025 06:17:47 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52KDHhAK2163350; Thu, 20 Mar 2025 22:17:44 +0900
X-Iguazu-Qid: 2yAbj3N9YijUOT45se
X-Iguazu-QSIG: v=2; s=0; t=1742476662; q=2yAbj3N9YijUOT45se; m=SVT2TZ6Kl5jsDx2ZJmT98YA+s7ANY5wMM7Hk7vLpbw0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 52KDHfMD1859736
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Mar 2025 22:17:42 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1] tests/templates: Reconfigure the usage of -smp options
Date: Thu, 20 Mar 2025 18:44:29 +0530
X-TSB-HOP2: ON
Message-Id: <20250320131429.2161150-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 20 Mar 2025 13:17:40.0620 (UTC) FILETIME=[7519CCC0:01DB999A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Mar 2025 13:17:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18298

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Due to the following kernel warning message observed during boot
time, the -smp option for arm is set to 2.

[ 0.000000] DT /cpu 3 nodes greater than max cores 2, capping them

The QEMU start arguments declared in the template files are common
amongst x86, arm64 and arm. But now the value of smp declared for
arm differs from x86 and arm64. So move the -smp option from the
functionality template files to the job submit script where the
respective architecture specific QEMU start arguments shall be
used while preparing job definitions.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh                       | 6 +++---
 tests/templates/IEC_template.yml             | 2 +-
 tests/templates/secureboot_negative_test.yml | 2 +-
 tests/templates/secureboot_template.yml      | 2 +-
 tests/templates/swupdate_negative_test.yml   | 2 +-
 tests/templates/swupdate_template.yml        | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index a9bb011..9da083a 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -29,9 +29,9 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
 # Create a dictionary to handle image arguments based on architecture
 declare -A image_args
-image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
-image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
-image_args[qemu-arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
+image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
+image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
+image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 
 set_up (){
 	echo "Installing dependencies to run this script..."
diff --git a/tests/templates/IEC_template.yml b/tests/templates/IEC_template.yml
index a196bb5..3c33773 100644
--- a/tests/templates/IEC_template.yml
+++ b/tests/templates/IEC_template.yml
@@ -34,7 +34,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
diff --git a/tests/templates/secureboot_negative_test.yml b/tests/templates/secureboot_negative_test.yml
index 568b5b6..2fcdbfa 100644
--- a/tests/templates/secureboot_negative_test.yml
+++ b/tests/templates/secureboot_negative_test.yml
@@ -51,7 +51,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: downloads://cip-core-image-security-cip-core-#distribution#-#architecture#.wic
diff --git a/tests/templates/secureboot_template.yml b/tests/templates/secureboot_template.yml
index 1b8e882..e29b64a 100644
--- a/tests/templates/secureboot_template.yml
+++ b/tests/templates/secureboot_template.yml
@@ -34,7 +34,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
diff --git a/tests/templates/swupdate_negative_test.yml b/tests/templates/swupdate_negative_test.yml
index 42297a8..bb79b07 100644
--- a/tests/templates/swupdate_negative_test.yml
+++ b/tests/templates/swupdate_negative_test.yml
@@ -42,7 +42,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
diff --git a/tests/templates/swupdate_template.yml b/tests/templates/swupdate_template.yml
index 67bee03..e1f71a9 100644
--- a/tests/templates/swupdate_template.yml
+++ b/tests/templates/swupdate_template.yml
@@ -34,7 +34,7 @@ actions:
     to: tmpfs
     images:
       system:
-        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio -smp 4
+        image_arg: '-drive file={system},discard=unmap,if=none,id=disk,format=raw -m 1G -serial mon:stdio
                     -nographic -netdev user,id=net,hostfwd=tcp:127.0.0.1:22222-:22 -chardev socket,id=chrtpm,path=/tmp/qemu-swtpm.sock
                     -tpmdev emulator,id=tpm0,chardev=chrtpm #imageargs#'
         url: #project_url#/#branch#/#architecture#/cip-core-image-security-cip-core-#distribution#-#architecture#.wic.xz
-- 
2.30.2



