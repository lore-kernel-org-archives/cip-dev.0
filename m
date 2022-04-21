Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6DFC83038
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:12 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web09.20362.1650541967244335778
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Apr 2022 04:52:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=iSafTU/R;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-202204211152446c668f63a32dbc524e-su4bik@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 202204211152446c668f63a32dbc524e
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Apr 2022 13:52:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=NUeWZNryqmdwf4JgxFJamFq7BAe3/eTF5c7BpHhVDIk=;
 b=iSafTU/Rks0aSjY6B+4kP/nGoH4HsSLQ0x+r9fdMV95BmaeNPzimopZDAL3cZ4HUIlJxAf
 w5KZp06p3VxwH/RqoKQNN/R7Og0+u6iYl2wDpyQGOAMYUVXhW4QZbOdKUOLssZ6n0dzG80oV
 H2WpRc2uIWw+OYbLPiwQ8pc7QXjjA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] initramfs-abrootfs-hook: Convert to an
 initramfs-class recipe
Date: Thu, 21 Apr 2022 13:52:42 +0200
Message-Id: 
 <bec2642fc52c2cb38eade4569b88315dfa5dade6.1650541963.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650541963.git.jan.kiszka@siemens.com>
References: <cover.1650541963.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Apr 2022 16:46:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8166

From: Jan Kiszka <jan.kiszka@siemens.com>

This unifies the pattern we generate initramfs images for non-secure and
secure SWUpdate images. Besides cleaning up the related abrootfs
selection hook, the unification is a precondition for adding another
initramfs recipe later that will be shared between both image types

The pattern followed in the new initramfs-abrootfs-hook script is now
similar to initramfs-verity-hook: a local-top hook is used, rather than
a patch for Debian's local script. This hook looks for the matching
rootfs by read-only mounting candidates, comparing the contained UUID
against the one stored in the initramfs, unmounting again, and then
setting the ROOT variable on match.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/image_uuid.bbclass                    |  6 +-
 classes/secure-wic-swu-img.bbclass            |  4 --
 classes/wic-swu-img.bbclass                   |  6 ++
 kas/opt/ebg-secure-boot-snakeoil.yml          |  1 +
 kas/opt/ebg-swu.yml                           |  2 +-
 .../cip-core-initramfs/cip-core-initramfs.bb  |  4 --
 .../{initramfs.lsblk.hook => abrootfs.hook}   | 11 +---
 .../files/abrootfs.script                     | 66 +++++++++++++++++++
 .../files/initramfs.image_uuid.hook           | 33 ----------
 .../initramfs-abrootfs-hook/files/postinst    |  6 --
 .../initramfs-abrootfs-hook_0.1.bb            | 41 +++++++-----
 11 files changed, 104 insertions(+), 76 deletions(-)
 rename recipes-initramfs/initramfs-abrootfs-hook/files/{initramfs.lsblk.hook => abrootfs.hook} (62%)
 create mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/postinst

diff --git a/classes/image_uuid.bbclass b/classes/image_uuid.bbclass
index 2813ed9..7294eb3 100644
--- a/classes/image_uuid.bbclass
+++ b/classes/image_uuid.bbclass
@@ -1,10 +1,11 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
@@ -27,7 +28,6 @@ do_generate_image_uuid() {
         sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
     image_do_mounts
 
-    # update initramfs to add uuid
-    sudo chroot '${IMAGE_ROOTFS}' update-initramfs -u
+    echo "TARGET_IMAGE_UUID=\"${IMAGE_UUID}\"" > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
 }
 addtask generate_image_uuid before do_copy_boot_files after do_rootfs_install
diff --git a/classes/secure-wic-swu-img.bbclass b/classes/secure-wic-swu-img.bbclass
index 85342fe..5e8e48a 100644
--- a/classes/secure-wic-swu-img.bbclass
+++ b/classes/secure-wic-swu-img.bbclass
@@ -9,10 +9,6 @@
 # SPDX-License-Identifier: MIT
 #
 
-INITRAMFS_RECIPE ?= "cip-core-initramfs"
-do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
-INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
-
 inherit verity-img
 inherit wic-swu-img
 
diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
index 231b249..b93a96a 100644
--- a/classes/wic-swu-img.bbclass
+++ b/classes/wic-swu-img.bbclass
@@ -16,6 +16,12 @@ inherit wic-img
 inherit swupdate-img
 
 IMAGE_INSTALL += "etc-overlay-fs"
+
+INITRAMFS_RECIPE ?= "cip-core-initramfs"
+INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
+
+do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
+
 IMAGE_INSTALL += "home-fs"
 IMAGE_INSTALL += "tmp-fs"
 
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index 14a5d6a..b329f41 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -25,6 +25,7 @@ local_conf_header:
   secure-boot-image: |
     IMAGE_FSTYPES = "secure-wic-swu-img"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
+    INITRAMFS_INSTALL_append = " initramfs-verity-hook"
 
   secure-boot: |
     # Add snakeoil binaries for qemu
diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
index d811929..5e4e771 100644
--- a/kas/opt/ebg-swu.yml
+++ b/kas/opt/ebg-swu.yml
@@ -17,7 +17,7 @@ header:
 
 local_conf_header:
   initramfs: |
-    IMAGE_INSTALL += "initramfs-abrootfs-hook"
+    INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
 
   image-option-uuid: |
     CIP_IMAGE_OPTIONS_append = " image-uuid.inc"
diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 825fb9f..649daa2 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -10,7 +10,3 @@
 #
 
 inherit initramfs
-
-INITRAMFS_INSTALL += " \
-    initramfs-verity-hook \
-    "
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.lsblk.hook b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
similarity index 62%
rename from recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.lsblk.hook
rename to recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
index cf32404..bacbc2e 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.lsblk.hook
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
@@ -1,9 +1,8 @@
-# This software is a part of ISAR.
-# Copyright (C) Siemens AG, 2020
+#!/bin/sh
+# Copyright (C) Siemens AG, 2020-2022
 #
 # SPDX-License-Identifier: MIT
 
-#!/bin/sh
 PREREQ=""
 
 prereqs()
@@ -21,9 +20,5 @@ esac
 . /usr/share/initramfs-tools/scripts/functions
 . /usr/share/initramfs-tools/hook-functions
 
-if [ ! -x /usr/bin/lsblk ]; then
-	echo "Warning: couldn't find /usr/bin/lsblk!"
-	exit 0
-fi
-
 copy_exec /usr/bin/lsblk
+copy_file library /usr/share/abrootfs/image-uuid.env /usr/share/abrootfs/image-uuid.env
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
new file mode 100644
index 0000000..b61fe30
--- /dev/null
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.script
@@ -0,0 +1,66 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020-2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+prereqs()
+{
+    # Make sure that this script is run last in local-top
+    local req
+    for req in "${0%/*}"/*; do
+        script="${req##*/}"
+        if [ "$script" != "${0##*/}" ]; then
+            printf '%s\n' "$script"
+        fi
+    done
+}
+case $1 in
+prereqs)
+    prereqs
+    exit 0
+    ;;
+esac
+
+. /scripts/functions
+. /usr/share/abrootfs/image-uuid.env
+
+# Even if this script fails horribly, make sure there won't be a chance the
+# current $ROOT will be attempted.  As this device most likely contains a
+# perfectly valid filesystem, it would be mounted successfully, leading to a
+# broken boot.
+echo "ROOT=/dev/null" >/conf/param.conf
+wait_for_udev 10
+case "$ROOT" in
+    PART*)
+        # root was given as PARTUUID= or PARTLABEL=. Use blkid to find the matching
+        # partition
+        ROOT=$(blkid --list-one --output device --match-token "$ROOT")
+        ;;
+    "")
+        # No Root device was given. Use find the matching IMAGE_UUID
+        partitions=$(blkid -o device)
+        for part in $partitions; do
+            if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
+                mount -o ro -t $(get_fstype $part) $part ${rootmnt}
+                . ${rootmnt}/etc/os-release
+                umount ${rootmnt}
+                if [ "${IMAGE_UUID}" = "${TARGET_IMAGE_UUID}" ]; then
+                    ROOT="$part"
+                    break
+                fi
+            fi
+        done
+        ;;
+esac
+
+if [ -z "${ROOT}" ]; then
+    panic "Can't find the root device with matching UUID!"
+fi
+
+echo "ROOT=${ROOT}" >/conf/param.conf
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook b/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
deleted file mode 100644
index 910ce84..0000000
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/initramfs.image_uuid.hook
+++ /dev/null
@@ -1,33 +0,0 @@
-# This software is a part of ISAR.
-# Copyright (C) Siemens AG, 2020
-#
-# SPDX-License-Identifier: MIT
-
-#!/bin/sh
-set -x
-PREREQ=""
-
-prereqs()
-{
-     echo "$PREREQ"
-}
-
-case $1 in
-prereqs)
-     prereqs
-     exit 0
-     ;;
-esac
-
-. /usr/share/initramfs-tools/scripts/functions
-. /usr/share/initramfs-tools/hook-functions
-
-if [ ! -e /etc/os-release ]; then
-	echo "Warning: couldn't find /etc/os-release!"
-	exit 0
-fi
-
-IMAGE_UUID=$(sed -n 's/^IMAGE_UUID="\(.*\)"/\1/p' /etc/os-release)
-echo "${IMAGE_UUID}" > "${DESTDIR}/conf/image_uuid"
-
-exit 0
\ No newline at end of file
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/postinst b/recipes-initramfs/initramfs-abrootfs-hook/files/postinst
deleted file mode 100644
index e065524..0000000
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/postinst
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-
-# patch local script
-patch -s -p0 /usr/share/initramfs-tools/scripts/local /usr/share/initramfs-abrootfs-hook/debian-local.patch
-
-update-initramfs -v -u
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
index 9c1776a..1693e85 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.1.bb
@@ -1,33 +1,40 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2020-2022
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Jan Kiszka <jan.kiszka@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 
 
 inherit dpkg-raw
 
-DEBIAN_DEPENDS += ", busybox, patch"
+DEBIAN_DEPENDS = "initramfs-tools"
 
-SRC_URI += "file://postinst \
-            file://initramfs.lsblk.hook \
-            file://initramfs.image_uuid.hook \
-            file://debian-local-patch"
+SRC_URI += "file://abrootfs.hook \
+            file://abrootfs.script"
+
+ABROOTFS_IMAGE_RECIPE ?= "cip-core-image"
+
+IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.uuid.env"
+
+do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/abrootfs \
+    ${D}/usr/share/initramfs-tools/scripts/local-top"
 
 do_install() {
-    # add patch for local to /usr/share/initramfs-abrootfs-hook
-    TARGET=${D}/usr/share/initramfs-abrootfs-hook
-    install -m 0755 -d ${TARGET}
-    install -m 0644 ${WORKDIR}/debian-local-patch ${TARGET}/debian-local.patch
-
-    # add hooks for secure boot
-    HOOKS=${D}/etc/initramfs-tools/hooks
-    install -m 0755 -d ${HOOKS}
-    install -m 0740 ${WORKDIR}/initramfs.lsblk.hook ${HOOKS}/lsblk.hook
-    install -m 0740 ${WORKDIR}/initramfs.image_uuid.hook ${HOOKS}/image_uuid.hook
+    if [ -f "${IMAGE_UUID_ENV_FILE}" ]; then
+        install -m 0600 "${IMAGE_UUID_ENV_FILE}" "${D}/usr/share/abrootfs/image-uuid.env"
+    else
+        bberror "Did not find ${IMAGE_UUID_ENV_FILE}. initramfs will not be build correctly!"
+    fi
+    install -m 0755 "${WORKDIR}/abrootfs.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-top/abrootfs"
+    install -m 0755 "${WORKDIR}/abrootfs.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/abrootfs"
 }
-addtask do_install after do_transform_template
-- 
2.34.1


