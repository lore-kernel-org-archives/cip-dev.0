Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15270D11709
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:39 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4099.1764667290648377587
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=QeOMo3XK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-20251202092122a6976569ff000207cf-9dkudq@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20251202092122a6976569ff000207cf
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=y6sKgmd/q9RnOBAwBmObSY+jeWFRT9RFwjLCwKrUzF8=;
 b=QeOMo3XKxwCNcpaAh/qbr2HBXCUlbrrzvCkjiDwvtvXk+MCboddxC0DOA/JZqWxW1Ee8Gb
 ZvLN0GS+jXaO8uA4uFYonHTkSWvtvA4llZp61vVMLajPsgoEp6nbOuJCfdk3UlETTBG8+Yaj
 1SdhRqsLB7ToIzSO8gTgeWwmVPuUivtPo5wIIUNaE3Eqo12p91Whlz/N7jGUz/pVNnD9AoGp
 onrIWywpU/j9bwqQmzWu4GoJvQ4wDYIzAp8ztbevEs8ISgRPjNj5vk6ItsOU34xkiM2g9/yK
 NiaPbS1V+EST7wuYwOXMtDTyoqS+vR0/US8+69p2HNKgKprZ69PcxGLw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 13/14] ci: Build and deploy kernel-panic update artifact
Date: Tue,  2 Dec 2025 10:21:18 +0100
Message-ID: <e1c4b6fa8ea53fdcfa149dbdcc986c9c3a52c36b.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20799

From: Jan Kiszka <jan.kiszka@siemens.com>

This was so far fetched from a stale branch which will no longer work
when starting to support multiple Debian releases. Another issue of the
previous approach was that it never updated the artifact to that
potentially required changes prior to the intentional crash were not
included.

Closes: #143
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml             | 22 +++++++++++++++-------
 scripts/deploy-cip-core.sh |  3 ++-
 scripts/submit_lava.sh     | 11 ++++-------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3b0c9239..b01daae2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -21,7 +21,7 @@ variables:
   dtb: none
   deploy: disable
   deploy_kernelci: disable
-  build_swu_v2: disable
+  build_updates: disable
   swupdate_version: default
   test_function: swupdate
   separate_home_partition: disable
@@ -73,7 +73,7 @@ default:
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} wic; fi
-    - if [ "${build_swu_v2}" = "enable" ]; then
+    - if [ "${build_updates}" = "enable" ]; then
           mkdir build/previous-image;
           if [ "${extension}" = "security" ] || [ "${extension}" = "ebg-secure-boot-snakeoil" ]; then
               cp build/tmp/deploy/images/${target}/*.verity build/previous-image;
@@ -82,8 +82,16 @@ default:
           fi;
           cp build/tmp/deploy/images/${target}/linux.efi build/previous-image;
           echo "PV = \"2.0\"" >> recipes-core/images/cip-core-image.inc;
+          kas build ${base_yaml}:kas/opt/delta-update.yml:kas/opt/kernel-panic.yml;
+          for swu in build/tmp/deploy/images/${target}/*.swu; do
+              mv "$swu" build/previous-image/$(basename "${swu%.swu}-broken.swu");
+          done;
+          echo "PV = \"2.1\"" >> recipes-core/images/cip-core-image.inc;
           kas build ${base_yaml}:kas/opt/delta-update.yml;
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
+          for swu in build/previous-image/*-broken.swu; do
+              mv "$swu" build/tmp/deploy/images/${target};
+          done;
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swus;
       fi
     - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi
 
@@ -130,7 +138,7 @@ build:qemu-amd64-base:
     extension: security
     security_test: enable
     use_rt: disable
-    build_swu_v2: enable
+    build_updates: enable
     separate_home_partition: enable
     deploy: enable
 
@@ -151,7 +159,7 @@ build:qemu-arm64-base:
     extension: security
     security_test: enable
     use_rt: disable
-    build_swu_v2: enable
+    build_updates: enable
     separate_home_partition: enable
     deploy: enable
 
@@ -172,7 +180,7 @@ build:qemu-arm-base:
     extension: security
     security_test: enable
     use_rt: disable
-    build_swu_v2: enable
+    build_updates: enable
     separate_home_partition: enable
     deploy: enable
 
@@ -263,7 +271,7 @@ build:x86-uefi-secure-boot:
     use_rt: disable
     watchdog: disable
     security_test: enable
-    build_swu_v2: enable
+    build_updates: enable
     separate_home_partition: enable
     deploy: enable
 
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 5b2615be..e623f27b 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -47,8 +47,9 @@ fi
 
 if [ -f "${BASE_PATH}.wic" ]; then
 	echo "Uploading artifacts..."
-	if [ "$DEPLOY" = "swu" ]; then
+	if [ "$DEPLOY" = "swus" ]; then
 		aws s3 cp --no-progress --acl public-read "${BASE_PATH}.swu" "${S3_TARGET}"
+		aws s3 cp --no-progress --acl public-read "${BASE_PATH}-broken.swu" "${S3_TARGET}"
 	elif [ "$DEPLOY" = "wic-partitions" ]; then
 		# deploy individual wic partitions, helpful for RB tests
 		cd build/tmp/deploy/images/"$TARGET"
diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index f63a9973..b3180a14 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -70,7 +70,7 @@ create_job_qemu () {
 		    -i "${job_dir}"/*.yml
 		if [ "$1" = "kernel-panic" ]; then
 			sed -e "s@kernel: C:BOOT1:linux.efi@Kernel panic - not syncing: sysrq triggered crash@g" \
-			    -e "s@#branch#@maintain-lava-artifact@g" \
+			    -e "s@\.swu@-broken.swu@" \
 			    -i "${job_dir}"/*.yml
 		else
 			sed -e "s@kernel: C:BOOT1:linux.efi@Can't open verity rootfs - continuing will lead to a broken trust chain!@g" \
@@ -175,15 +175,12 @@ create_job_qemu () {
 		cp $LAVA_TEMPLATES/secureboot_template.yml "${job_dir}/${1}_${2}.yml"
 	fi
 
-	if [ "$1" != "kernel-panic" ]; then
-		sed -i "s@#branch#@${COMMIT_BRANCH}@g" "${job_dir}"/*.yml
-	fi
-
 	if [ "$2" != "qemu-amd64" ]; then
 		add_firmware_artifacts "${job_dir}"/*.yml "$2"
 	fi
 
-	sed -e "s@#distribution#@${RELEASE}@g" \
+	sed -e "s@#branch#@${COMMIT_BRANCH}@g" \
+	    -e "s@#distribution#@${RELEASE}@g" \
 	    -e "s@#project_url#@${PROJECT_URL}@g" \
 	    -e "s@#architecture#@${2}@g" \
 	    -e "s@#imageargs#@${image_args[$2]}@g" \
@@ -198,7 +195,7 @@ create_job_qemu () {
 		sed -i "s@${RELEASE}-ovmf@${KEYS_DISTRO}-ovmf@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
 	fi
 
-	# Target is recieved from gitlab job in form of qemu-"architecture"
+	# Target is received from gitlab job in form of qemu-"architecture"
 	# In the template context field needs only architecture excepting the device type
 	local arch
 	arch=$(echo "$2" | cut -d '-' -f 2)
-- 
2.51.0


