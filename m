Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27DAD11705
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3934.1764667289525522672
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=iH1HsDFW;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20251202092122e02db4ee7b000207fa-dj74sz@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251202092122e02db4ee7b000207fa
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=04UTTtT/Y1FRHi0TMNQbXp9VPJ6x5UVTDn9sXPGUFzQ=;
 b=iH1HsDFWsG8jCinLgeeuEJhh5xm4ijmgnTcjIrkS4KMyvoeFOQ2ZtwsEUx/2MCf4LBfqOE
 KtlT7rAAZwmjK4D6gDyxOMEtCikQSkP2caorTM+9yc4JqzCaoMFDewouSkm6LNOoiNG3o3EM
 2EV0Z9yx3O4/SKm2kXAZQAqCJi9pX02SB4s984z0hZMJdbmmpTKKr9yzYARsLCSpeClVogiE
 gZ2DAYi2rhrPGBkx8CWs2F2RSagKSb3bogmEDBu7U+qCx97RdDvlYnPAJVmbMRkfZdnn8+7R
 x4QbFYOon8UrMoukXRnfJas5qxXsKjYj3k82lgmgJPyYfWst3pzYj4Yw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 12/14] ci: submit_lava.sh: Reduce number of sed calls
Date: Tue,  2 Dec 2025 10:21:17 +0100
Message-ID: <0c117d5934a592cf8e84ff18a37aed45b5f58e2a.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20800

From: Jan Kiszka <jan.kiszka@siemens.com>

Avoids parameter repetition and reduces the number process invocations.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 85 +++++++++++++++++++++++++-----------------
 1 file changed, 50 insertions(+), 35 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index c00b59ad..f63a9973 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -47,9 +47,10 @@ clean_up () {
 
 # This method is called only for arm64 and arm targets while building job definitions
 add_firmware_artifacts () {
-	sed -i "s@#Firmware#@firmware:@g" "$1"
-	sed -i "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" "$1"
-	sed -i "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/${2}/firmware.bin@g" "$1"
+	sed -e "s@#Firmware#@firmware:@g" \
+	    -e "s@#Firmware_args#@image_arg: '-bios {firmware}'@g" \
+	    -e "s@#Firmware_url#@url: ${PROJECT_URL}/${COMMIT_BRANCH}/${2}/firmware.bin@g" \
+	    -i "$1"
 }
 
 # This method creates LAVA job definitions for QEMU amd64, arm64 and armhf
@@ -64,14 +65,17 @@ create_job_qemu () {
 
 	elif [ "$1" = "kernel-panic" ] || [ "$1" = "initramfs-crash" ]; then
 		cp $LAVA_TEMPLATES/swupdate_template.yml "${job_dir}/${1}.yml"
-		sed -i "s@software update testing@${1}_rollback_testing@g" "${job_dir}"/*.yml
-		sed -i -e "s@#updatestate#@3@g" -e "s@) = 2@) = 3@g" "${job_dir}"/*.yml
+		sed -e "s@software update testing@${1}_rollback_testing@g" \
+		    -e "s@#updatestate#@3@g" -e "s@) = 2@) = 3@g" \
+		    -i "${job_dir}"/*.yml
 		if [ "$1" = "kernel-panic" ]; then
-			sed -i "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" "${job_dir}"/*.yml
-			sed -i "s@#branch#@maintain-lava-artifact@g" "${job_dir}"/*.yml
+			sed -e "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" \
+			    -e "s@#branch#@maintain-lava-artifact@g" \
+			    -i "${job_dir}"/*.yml
 		else
-			sed -i "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" "${job_dir}"/*.yml
-			sed -i "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" "${job_dir}"/*.yml
+			sed -e "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" \
+			    -e "s@echo software update is successful!!@dd if=/dev/urandom of=/dev/sda5 bs=512 count=1@g" \
+			    -i "${job_dir}"/*.yml
 		fi
 	elif [ "$1" = "secure-boot-unsigned-kernel" ]; then
 		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_unsigned_kernel_${2}.yml"
@@ -79,16 +83,18 @@ create_job_qemu () {
 		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_unsigned_kernel_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
 		cd -
 		if [ "$2" = "qemu-amd64" ]; then
-			sed -i "s@#END_MONITOR#@Access Denied@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-			sed -i "s@#START_MONITOR#@Cannot load specified kernel image@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-			sed -i "s@#ARTIFACT#@linux@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -e "s@#END_MONITOR#@Access Denied@g" \
+			    -e "s@#START_MONITOR#@Cannot load specified kernel image@g" \
+			    -e "s@#ARTIFACT#@linux@g" \
+			    -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
 		fi
 
 		if [ "$2" = "qemu-arm64" ] || [ "$2" = "qemu-arm" ]; then
-			sed -i "s@sda@vda@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-			sed -i "s@#END_MONITOR#@Application failed@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-			sed -i "s@#START_MONITOR#@Image not authenticated@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
-			sed -i "s@#ARTIFACT#@linux@g" "${job_dir}/${1}_unsigned_kernel_${2}.yml"
+			sed -e "s@sda@vda@g" \
+			    -e "s@#END_MONITOR#@Application failed@g" \
+			    -e "s@#START_MONITOR#@Image not authenticated@g" \
+			    -e "s@#ARTIFACT#@linux@g" \
+			    -i "${job_dir}/${1}_unsigned_kernel_${2}.yml"
 		fi
 	elif [ "$1" = "secure-boot-unsigned-bootloader" ]; then
 		cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
@@ -97,17 +103,18 @@ create_job_qemu () {
 		cd -
 
 		if [ "$2" = "qemu-amd64" ]; then
-			sed -i "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-			sed -i "s@#START_MONITOR#@Access Denied@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-			sed -i "s@#ARTIFACT#@bootloader@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+			sed -e "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" \
+			    -e "s@#START_MONITOR#@Access Denied@g" \
+			    -e "s@#ARTIFACT#@bootloader@g" \
+			    -i "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
 		fi
 
 		if [ "$2" = "qemu-arm64" ] || [ "$2" = "qemu-arm" ]; then
-			sed -i "s@sda@vda@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-
-			sed -i "s@#END_MONITOR#@EFI Boot failed!@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-			sed -i "s@#START_MONITOR#@Image not authenticated@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
-			sed -i "s@#ARTIFACT#@bootloader@g" "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
+			sed -e "s@sda@vda@g" \
+			    -e "s@#END_MONITOR#@EFI Boot failed!@g" \
+			    -e "s@#START_MONITOR#@Image not authenticated@g" \
+			    -e "s@#ARTIFACT#@bootloader@g" \
+			    -i "${job_dir}/${1}_unsigned_bootloader_${2}.yml"
 		fi
 
 		if [ "$2" = "qemu-arm64" ]; then
@@ -122,9 +129,10 @@ create_job_qemu () {
 		sed -e '/#POSTPROCESS_STEPS#/ {' -e 'r secureboot_corrupt_rootfs_steps.yml' -e 'd' -e '}' -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
 		cd -
 
-		sed -i "s@#END_MONITOR#@reboot: Restarting system with command 'dm-verity device corrupted'@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
-		sed -i "s@#START_MONITOR#@EFI stub: UEFI Secure Boot is enabled.@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
-		sed -i "s@#ARTIFACT#@rootfs@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
+		sed -e "s@#END_MONITOR#@reboot: Restarting system with command 'dm-verity device corrupted'@g" \
+		    -e "s@#START_MONITOR#@EFI stub: UEFI Secure Boot is enabled.@g" \
+		    -e "s@#ARTIFACT#@rootfs@g" \
+		    -i "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
 
 		if [ "$2" = "qemu-arm64" ]; then
 			sed -i "s@bootx64.efi@bootaa64.efi@g" "${job_dir}/${1}_corrupt_rootfs_${2}.yml"
@@ -136,10 +144,11 @@ create_job_qemu () {
 		if [ "$2" = "qemu-amd64" ]; then
 			cp $LAVA_TEMPLATES/secureboot_negative_test.yml "${job_dir}/${1}_mismatch_keys_${2}.yml"
 
-			sed -i "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
-			sed -i "s@#START_MONITOR#@Access Denied@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
-			sed -i "s@#ARTIFACT#@keys@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
-			sed -i "s@#POSTPROCESS_STEPS#@- echo 'no postprocess steps'@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+			sed -e "s@#END_MONITOR#@BdsDxe: failed to load Boot@g" \
+			    -e "s@#START_MONITOR#@Access Denied@g" \
+			    -e "s@#ARTIFACT#@keys@g" \
+			    -e "s@#POSTPROCESS_STEPS#@- echo 'no postprocess steps'@g" \
+			    -i "${job_dir}/${1}_mismatch_keys_${2}.yml"
 		fi
 	elif [ "$1" = "swupdate-corrupt-swu" ]; then
 		cp $LAVA_TEMPLATES/swupdate_negative_test.yml "${job_dir}/${1}_corrupt_swu_${2}.yml"
@@ -174,8 +183,11 @@ create_job_qemu () {
 		add_firmware_artifacts "${job_dir}"/*.yml "$2"
 	fi
 
-	sed -i -e "s@#distribution#@${RELEASE}@g" -e "s@#project_url#@${PROJECT_URL}@g" "${job_dir}"/*.yml
-	sed -i -e "s@#architecture#@${2}@g" -e "s@#imageargs#@${image_args[$2]}@g" "${job_dir}"/*.yml
+	sed -e "s@#distribution#@${RELEASE}@g" \
+	    -e "s@#project_url#@${PROJECT_URL}@g" \
+	    -e "s@#architecture#@${2}@g" \
+	    -e "s@#imageargs#@${image_args[$2]}@g" \
+	    -i "${job_dir}"/*.yml
 
 	if [ "$1" = "secure-boot-mismatch-keys" ]; then
 		if [ "${RELEASE}" = "trixie" ]; then
@@ -216,8 +228,11 @@ create_job_mcom () {
 		grep -A 16 "# TEST BLOCK 2" "$LAVA_TEMPLATES/$1_template.yml" >> "${job_dir}/${1}_${2}.yml"
 		sed -i -e "s@#updatestate#@2@g" -e "s@overlay-1.1.1.4@overlay-2.1.1.4@g" "${job_dir}/${1}_${2}.yml"
 	fi
-	sed -i -e "s@#test_function#@${1}@g" -e "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}/${1}_${2}.yml"
-	sed -i -e "s@#distribution#@${RELEASE}@g" -e "s@#project_url#@${PROJECT_URL}@g" "${job_dir}/${1}_${2}.yml"
+	sed -e "s@#test_function#@${1}@g" \
+	    -e "s@#branch#@${COMMIT_BRANCH}@g" \
+	    -e "s@#distribution#@${RELEASE}@g" \
+	    -e "s@#project_url#@${PROJECT_URL}@g" \
+	    -i "${job_dir}/${1}_${2}.yml"
 }
 
 # This method attaches SQUAD watch job to the submitted LAVA job
-- 
2.51.0


