Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF3C87FCB
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 09:23:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.31070.1753867421826875537
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 02:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56U9NdIq2857445; Wed, 30 Jul 2025 18:23:39 +0900
X-Iguazu-Qid: 2yAbAvUQQ1KHcYMKur
X-Iguazu-QSIG: v=2; s=0; t=1753867418; q=2yAbAvUQQ1KHcYMKur; m=h+eNvDiWqrHz2K5mn1vayp+kCzunWzOLHTAPgsJngrA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 56U9Nb1X347476
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Jul 2025 18:23:38 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH] Add additional test for secure boot to test rootfs corruption
Date: Wed, 30 Jul 2025 14:44:00 +0530
X-TSB-HOP2: ON
Message-Id: <20250730091400.950461-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Jul 2025 09:23:33.0137 (UTC) FILETIME=[9EAD0010:01DC0133]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 09:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19621

Add a test case to verify and detect rootfs corruption i.e dm-verity corrupt case.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 .gitlab-ci.yml                                | 24 +++++++++++++++++++
 scripts/submit_lava.sh                        | 16 +++++++++++++
 .../secureboot_corrupt_rootfs_steps.yml       |  7 ++++++
 3 files changed, 47 insertions(+)
 create mode 100644 tests/templates/secureboot_corrupt_rootfs_steps.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 7c05ad4..628e624 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -508,6 +508,30 @@ test:qemu-arm-secure-boot-unsigned-bootloader:
     target: qemu-arm
     test_function: secure-boot-unsigned-bootloader
 
+test:qemu-amd64-secure-boot-corrupt-rootfs:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-base"]
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot-corrupt-rootfs
+
+test:qemu-arm64-secure-boot-corrupt-rootfs:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-base"]
+  variables:
+    target: qemu-arm64
+    test_function: secure-boot-corrupt-rootfs
+
+test:qemu-arm-secure-boot-corrupt-rootfs:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm-base"]
+  variables:
+    target: qemu-arm
+    test_function: secure-boot-corrupt-rootfs
+
 test:qemu-amd64-secure-boot-mismatch-keys:
   extends:
     - .test-cip-core
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 6cb0837..5cb4430 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -118,6 +118,22 @@ create_job_qemu () {
 		if [ "$2" = "qemu-arm" ]; then
 			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
 		fi
+	elif [ "$1" = "secure-boot-corrupt-rootfs" ]; then
+		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_corrupt_rootfs_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		cd -
+
+		sed -i "s@#END_MONITOR#@reboot: Restarting system with command 'dm-verity device corrupted'@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		sed -i "s@#START_MONITOR#@EFI stub: UEFI Secure Boot is enabled.@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		sed -i "s@#ARTIFACT#@rootfs@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+
+		if [ "$2" = "qemu-arm64" ]; then
+			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		fi
+		if [ "$2" = "qemu-arm" ]; then
+			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		fi
 	elif [ "$1" = "secure-boot-mismatch-keys" ]; then
 		if [ "$2" = "qemu-amd64" ]; then
 			cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_mismatch_keys_${2}.yml"
diff --git a/tests/templates/secureboot_corrupt_rootfs_steps.yml b/tests/templates/secureboot_corrupt_rootfs_steps.yml
new file mode 100644
index 0000000..b6f6628
--- /dev/null
+++ b/tests/templates/secureboot_corrupt_rootfs_steps.yml
@@ -0,0 +1,7 @@
+          - "apt-get update"
+          - "apt install -y fdisk"
+          - "rootfs_start_sector=$(fdisk -l -o Name,Start cip-core-image-security-cip-core-#distribution#-#architecture#.wic | awk -v name=systema '$0 ~ name {print $2}')"
+          - "rootfs_start=$((${rootfs_start_sector} * 512))"
+          # The value 96 is squashfs superblock header size, so skip header and corrupt the data after that.
+          - "offset=$((${rootfs_start} + 96))"
+          - "dd if=/dev/zero of=cip-core-image-security-cip-core-#distribution#-#architecture#.wic bs=1 seek=${offset} count=8 conv=notrunc"
-- 
2.39.5



