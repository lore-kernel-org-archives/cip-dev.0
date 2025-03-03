Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90107C282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 11:23:54 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.50853.1741001026117652234
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Mar 2025 03:23:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VwlCRtvr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202503031123443a13a9ae9536685fe0-kj2ckb@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202503031123443a13a9ae9536685fe0
        for <cip-dev@lists.cip-project.org>;
        Mon, 03 Mar 2025 12:23:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=XnKkV9GhlVxSjonR95p84vleAVeRntYAjoBNL8U53aw=;
 b=VwlCRtvrE2RZpkP4uyxq6TtSnu5ghyuGQrsUj04mj4syCgjT/OEi02zU+LpponiaDpBXy5
 OQw+sUoKq8kFMkJTE7C8j4yKaDi9cO+gKYgVoW4EddB+uGKw1//pVaSg0rNmmpLvzvIG51X3
 hSgVMNjA/fMO2sMjMI71CHXuy+42P5mB+ySPzcuqAMhBnhM4gqCtWemD9xJHov3rkpMEX2EK
 7qXD3GyWoxhJr8/wGZS6DbirJCEH4PND0+n3QBiX64+nRcptKo0gYW4G/WT5Zoaw/pP3vcDV
 khp/6nrt940jfWfJ6ciuoEP4cOWI6V9Dj/8ZNSQi6eqigxD3r4oBjCsA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	ludwig.nussel@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 4/4] Move content of home to IMMUTABLE_DATA_DIR
Date: Mon,  3 Mar 2025 12:21:48 +0100
Message-ID: <20250303112342.851020-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
References: <20250303112342.851020-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 11:23:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18001

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This reduces the amount of necessary partitions. It also
allows to use a A/B-update scheme for the var partition.

This fixes issue #123.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/123
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/read-only-rootfs.bbclass              | 19 +++++++++++++++--
 kas/opt/encrypt-all.yml                       |  2 +-
 kas/opt/separate-home-partition.yml           | 21 +++++++++++++++++++
 ...ook_0.6.bb => initramfs-crypt-hook_0.7.bb} |  2 +-
 4 files changed, 40 insertions(+), 4 deletions(-)
 create mode 100644 kas/opt/separate-home-partition.yml
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.6.bb => initramfs-crypt-hook_0.7.bb} (98%)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 0c8ae24..4e70d81 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -14,8 +14,12 @@ INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
 
 do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
 
-IMAGE_INSTALL += "home-fs"
-WIC_HOME_PARTITION = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
+WIC_HOME_PARTITION:separate-home-part = "part /home --source rootfs --change-directory=home --fstype=ext4 --label home --align 1024  --size 1G --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002 --uuid c07d5e8f-3448-46dc-9c0f-58904f369524"
+
+WIC_HOME_PARTITION = ""
+IMAGE_INSTALL += " move-homedir-var"
+IMAGE_INSTALL:append:separate-home-part = " home-fs"
+IMAGE_INSTALL:remove:separate-home-part = " move-homedir-var"
 
 IMAGE_INSTALL:append:buster   = " tmp-fs"
 IMAGE_INSTALL:append:bullseye = " tmp-fs"
@@ -37,6 +41,17 @@ copy_dpkg_state() {
     sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
 
+ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
+ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
+copy_home_to_immutable_data() {
+    IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/"
+    sudo mkdir -p "$IMMUTABLE_HOME_DIR"
+    sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
+    # as the rootfs is read-only we need to create the link
+    # between /var/home and /home during creation.
+    sudo chroot ${IMAGE_ROOTFS} ln -s /var/home /home
+}
+
 RO_ROOTFS_EXCLUDE_DIRS ??= ""
 EROFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
 SQUASHFS_EXCLUDE_DIRS = "${RO_ROOTFS_EXCLUDE_DIRS}"
diff --git a/kas/opt/encrypt-all.yml b/kas/opt/encrypt-all.yml
index b6d4041..faf7206 100644
--- a/kas/opt/encrypt-all.yml
+++ b/kas/opt/encrypt-all.yml
@@ -20,4 +20,4 @@ local_conf_header:
     # As we use a weak default assignment in the intramfs-crypt-hook recipe we need
     # to set all partitions
     CRYPT_PARTITIONS = "${ABROOTFS_PART_UUID_A}::reencrypt ${ABROOTFS_PART_UUID_B}::reencrypt \
-                         home:/home:reencrypt var:/var:reencrypt"
+                         var:/var:reencrypt"
diff --git a/kas/opt/separate-home-partition.yml b/kas/opt/separate-home-partition.yml
new file mode 100644
index 0000000..aaf349b
--- /dev/null
+++ b/kas/opt/separate-home-partition.yml
@@ -0,0 +1,21 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file adds swupdate and generates a ${IMAGE_NAME}.swu
+# from the first wic partition
+
+header:
+  version: 14
+
+local_conf_header:
+  separate-home-partition: |
+    OVERRIDES .= ":separate-home-part"
+  add-home-partition-to-crypt: |
+    CRYPT_PARTITIONS:append:separate-home-part = " home:/home:reencrypt"
diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
similarity index 98%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
index df335c9..80a4755 100644
--- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb
+++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.7.bb
@@ -70,7 +70,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
             file://pwquality.conf"
 
 # CRYPT_PARTITIONS elements are <partition-label>:<mountpoint>:<reencrypt or format>[:expand]
-CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
+CRYPT_PARTITIONS ??= "var:/var:reencrypt"
 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
 # in a newly formatted LUKS Partition
 CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
-- 
2.47.0


