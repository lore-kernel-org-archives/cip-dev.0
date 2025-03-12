Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B0BC35FF3
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 13:22:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.37045.1741785755231571759
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 06:22:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 52CDMXAI670316; Wed, 12 Mar 2025 22:22:33 +0900
X-Iguazu-Qid: 2rWhSHZE4oKainThNQ
X-Iguazu-QSIG: v=2; s=0; t=1741785752; q=2rWhSHZE4oKainThNQ; m=a8OPudYSJDW8GolUa2J7x36Stw9d802CGsXqDczwMsg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 52CDMVjm602595
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 22:22:32 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1 2/4] Update script to generate additional LAVA job defintion
Date: Wed, 12 Mar 2025 18:44:01 +0530
X-TSB-HOP2: ON
Message-Id: <20250312131403.1360421-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20250312131403.1360421-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Mar 2025 13:22:28.0810 (UTC) FILETIME=[CD921AA0:01DB9351]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Mar 2025 13:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18089

To cover the negative test cases of swupdate and secure boot, update the
script to generate the test definition based on the negative test
scenario.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index 49a4401..f35ff0c 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -71,6 +71,70 @@ create_job_qemu () {
 			sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" "${job_dir}"/*.yml
 			sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/*.yml
 		fi
+	elif [ "$1" = "secure-boot-unsigned-kernel" ]; then
+		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_unsigned_kernel_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+		cd -
+		if [ "$2" = "qemu-amd64" ]; then
+			sed -i "s@#END_MONITOR#@Access Denied@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -i "s@#START_MONITOR#@Cannot load specified kernel image@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -i "s@#ARTIFACT#@linux@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+		fi
+
+		if [ "$2" = "qemu-arm64" ] || [ "$2" = "qemu-arm" ]; then
+			sed -i "s@sda@vda@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -i "s@#END_MONITOR#@Application failed@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -i "s@#START_MONITOR#@Image not authenticated@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -i "s@#ARTIFACT#@linux@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+		fi
+	elif [ "$1" = "secure-boot-unsigned-bootloader" ]; then
+		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_unsigned_bootloader_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+		cd -
+
+		if [ "$2" = "qemu-amd64" ]; then
+			sed -i "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+			sed -i "s@#START_MONITOR#@Access Denied@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+			sed -i "s@#ARTIFACT#@bootloader@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+		fi
+
+		if [ "$2" = "qemu-arm64" ] || [ "$2" = "qemu-arm" ]; then
+			sed -i "s@sda@vda@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+
+			sed -i "s@#END_MONITOR#@EFI Boot failed!@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+			sed -i "s@#START_MONITOR#@Image not authenticated@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+			sed -i "s@#ARTIFACT#@bootloader@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+		fi
+
+		if [ "$2" = "qemu-arm64" ]; then
+			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+		fi
+		if [ "$2" = "qemu-arm" ]; then
+			sed -i "s@bootx64.efi@bootarm.efi@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+		fi
+	elif [ "$1" = "swupdate-corrupt-swu" ]; then
+		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_corrupt_swu_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#TEST_BLOCK_STEPS#/ {' -e 'r swupdate_corrupt_swu_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_swu_${2}.yml"
+		cd -
+	elif [ "$1" = "swupdate-corrupt-swu-artifact" ]; then
+		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_corrupt_swu_artifact_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#TEST_BLOCK_STEPS#/ {' -e 'r swupdate_corrupt_swu_artifact_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_swu_artifact_${2}.yml"
+		cd -
+	elif [ "$1" = "swupdate-reboot-without-confirm" ]; then
+		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}_reboot_without_confirm_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#REBOOT_WITHOUT_CONFIRM_STEPS#/ {' -e 'r swupdate_reboot_without_confirm.yml' -e 'd' -e '}' -i "${job_dir}/${1}_reboot_without_confirm_${2}.yml"
+		cd -
+		sed -i "s@bg_setenv -c@echo No update confirm@g" "${job_dir}/${1}_reboot_without_confirm_${2}.yml"
+	elif [ "$1" = "swupdate-apply-same-image-swu" ]; then
+		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_same_uuid_${2}.yml"
+		cd $LAVA_TEMPLATES
+		sed -e '/#TEST_BLOCK_STEPS#/ {' -e 'r swupdate_same_uuid_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_same_uuid_${2}.yml"
+		cd -
 	else
 		cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}/${1}_${2}.yml"
 	fi
-- 
2.39.2



