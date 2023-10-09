Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634E4E95A91
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 11:49:49 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.56097.1696837951516660665
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 00:52:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Air3Xljk;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-20231009075229ba953b8af00d9401c1-j6fnso@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20231009075229ba953b8af00d9401c1
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Oct 2023 09:52:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=AM/iAqXZyiTRwIlloeQKVHrg3tBo/J5kgPR6refcMFk=;
 b=Air3XljkWiT2TafmEmL3MFRDxTaVT5PcddcqmsNvSTZCQbc1y5lxWop55OFbS8h0Er4oKA
 BkvK7YTHIsEhBp8gpVzWDfUdqqDvLopWGVXhIWDSAK18S2xre0Q4bCKUDAXwPvKNTK10Ht84
 sSDRjPeZNCM/zcyqJokVwk8d/fGM0=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] update ISAR to latest version on master branch
Date: Mon,  9 Oct 2023 15:52:06 +0800
Message-Id: <20231009075206.194903-2-felix.moessbauer@siemens.com>
In-Reply-To: <20231009075206.194903-1-felix.moessbauer@siemens.com>
References: <20231009075206.194903-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 11:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13315

This includes the following changes:

- make deploy-ovmf compatible with schroot imaging
- make swupdate class compatible with schroot imaging
- avoid use of sudo when creating squashfs

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 classes/squashfs.bbclass            |  2 +-
 classes/swupdate.bbclass            |  5 +++--
 kas-cip.yml                         |  2 +-
 recipes-core/images/deploy-ovmf.inc | 10 ++++++----
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index bf72133..f57af7e 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -51,7 +51,7 @@ python __anonymous() {
 IMAGE_CMD:squashfs[depends] = "${PN}:do_transform_template"
 IMAGE_CMD:squashfs[vardepsexclude] += "SQUASHFS_CREATION_LIMITS"
 IMAGE_CMD:squashfs() {
-    ${SUDO_CHROOT} /bin/mksquashfs \
+    imager_run -p -d ${PP_WORK} -- /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
         -noappend ${SQUASHFS_CREATION_LIMITS} ${SQUASHFS_CREATION_ARGS}
 }
diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index aedaf02..55dad32 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -106,7 +106,7 @@ IMAGE_CMD:swu() {
     # Prepare for signing
     export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
 
-    sudo -E chroot ${BUILDCHROOT_DIR} sh -c ' \
+    imager_run -p -d ${PP_WORK} <<'EOIMAGER'
         # Fill in file check sums
         for file in ${SWU_ADDITIONAL_FILES}; do
             sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
@@ -138,7 +138,8 @@ IMAGE_CMD:swu() {
                 fi
                 echo "$file.${SWU_SIGNATURE_EXT}"
            fi
-        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"'
+        done | cpio -ovL --reproducible -H crc > "${SWU_BUILDCHROOT_IMAGE_FILE}"
+EOIMAGER
 }
 
 python do_check_swu_partition_uuids() {
diff --git a/kas-cip.yml b/kas-cip.yml
index c329248..84b7441 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: bf9c9fdd99bf26dca25fdf9e63b7eb5b053d962f
+    commit: dff8ad504b54a4e292a1b986cdc74ebc9e6e177a
     layers:
       meta:
 
diff --git a/recipes-core/images/deploy-ovmf.inc b/recipes-core/images/deploy-ovmf.inc
index 0ec8762..d2b8a27 100644
--- a/recipes-core/images/deploy-ovmf.inc
+++ b/recipes-core/images/deploy-ovmf.inc
@@ -11,11 +11,13 @@
 # This recipe deploys the OVMF binaries to run the image in QEMU
 # Note: x86 only
 
-IMAGER_INSTALL += "ovmf"
+INSTALL_deploy_ovmf_binaries += "ovmf"
 
+do_deploy_ovmf_binaries[network] += "${TASK_USE_SUDO}"
 do_deploy_ovmf_binaries[cleandirs] += "${DEPLOY_DIR_IMAGE}/OVMF"
+do_deploy_ovmf_binaries[depends] += "${SCHROOT_DEP}"
 do_deploy_ovmf_binaries() {
-    cp -v ${BUILDCHROOT_DIR}/usr/share/OVMF/*.fd ${DEPLOY_DIR_IMAGE}/OVMF
+    imager_run -p -d ${PP_WORK} -- \
+        /bin/bash -c "cp -v /usr/share/OVMF/*.fd ${PP_DEPLOY}/OVMF/"
 }
-
-addtask deploy_ovmf_binaries after do_install_imager_deps before do_image
+addtask deploy_ovmf_binaries after do_rootfs_install before do_image
-- 
2.39.2


