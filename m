Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D6C3ABA4
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:33:38 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.45914.1745840010554029255
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 04:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=XfHZBvs3;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2025042811332888329f0ea9af5d2229-ugwcuj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2025042811332888329f0ea9af5d2229
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 13:33:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=w4OBuO1ot9+++mE19lO9gmZQKGqbgDYMd+DCOn5W1G8=;
 b=XfHZBvs3GYQZXLwLLfGlhVUQT1x/+Y+ipqxDO5Fw4LFyVWDK6QG4zRq0OGrXTJWEXANNc8
 vmiX9TQih2IV2bVZ8DDg1wDPtT2jiyWbVibYQyPURntAV55GsNvyb7Hb8seRYjvnO/fhasiQ
 bwHoC1Q3MrwMKhAaUSMAEe9Jp7ItV4VDkU20DtLR6G6n1ti2LxOf1AjJ248guexScY6hvHn1
 tGDBs+MtRLxQxG0/dhM1FOuDjtakYmvhSOxy9VI7sJWivOMGl3jlzqFNNMxFBilBVTXTEvdO
 9lv19tnEUY+B7/w/IBKFKOYx2ePR1fduuECrdwh41yI4/JU1LW0uAPaQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 4/4] port abrootfs env handling to new kernel cmdline infrastructure
Date: Mon, 28 Apr 2025 13:32:46 +0200
Message-ID: <20250428113325.3208873-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
References: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 11:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18694

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Previously the abrootfs env was injected as file into the initrd and then
sourced at runtime. As we now have infrastructure in place to add the
abrootfs env to the kernel cmdline, we replace the hard-coded values with
logic to extract it from the kernel cmdline. By that, we also remove the
dependency between the initramfs build and the abrootfs creation, which
reduces the set of dependencies (good for caching), as well as increases
the parallelism of the build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-abrootfs-hook/files/hook        |  5 -----
 .../files/local-top-complete                  | 21 ++++++++++++++++++-
 .../initramfs-abrootfs-hook_0.2.bb            | 21 +------------------
 wic/ebg-sysparts.inc                          |  4 ++--
 4 files changed, 23 insertions(+), 28 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/hook b/recipes-initramfs/initramfs-abrootfs-hook/files/hook
deleted file mode 100644
index 6d4a612..0000000
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/hook
+++ /dev/null
@@ -1,5 +0,0 @@
-# Copyright (C) Siemens AG, 2020-2022
-#
-# SPDX-License-Identifier: MIT
-
-copy_file library /usr/share/abrootfs/image-uuid.env /usr/share/abrootfs/image-uuid.env
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
index 7048ced..c6095d8 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
@@ -30,7 +30,24 @@ prereqs)
 esac
 
 . /scripts/functions
-. /usr/share/abrootfs/image-uuid.env
+
+load_abrootfs_env_from_cmdline()
+{
+    set -x
+    abrootfs_opts=$(cat /proc/cmdline | sed -n 's/.*cip.abrootfs_root_options=\([^ ]*\).*/\1/p' | sed 's/,/ /g')
+    for opt in $abrootfs_opts; do
+        key=$(echo $opt | sed 's/=.*//')
+        val=$(echo $opt | sed 's/^[^=]*=//')
+        case "$key" in
+            target-image-uuid)
+                TARGET_IMAGE_UUID="$val"
+                ;;
+            *)
+                ;;
+        esac
+    done
+}
+
 
 find_root_via_image_uuid()
 {
@@ -57,6 +74,8 @@ find_root_via_image_uuid()
 echo "ROOT=/dev/null" >/conf/param.conf
 wait_for_udev 10
 
+load_abrootfs_env_from_cmdline
+
 case "$ROOT" in
     PART*)
         # Root was given as PARTUUID= or PARTLABEL=.
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
index 592f305..f7569e2 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
@@ -15,26 +15,7 @@ DEBIAN_DEPENDS .= ", util-linux"
 DEBIAN_CONFLICTS = "initramfs-verity-hook"
 
 SRC_URI += " \
-    file://hook \
     file://local-top-complete"
 
-ABROOTFS_IMAGE_RECIPE ?= "cip-core-image"
+HOOK_COPY_EXECS = "lsblk sed"
 
-HOOK_COPY_EXECS = "lsblk"
-
-# This is defined in image.bbclass which cannot be used in a package recipe.
-# However, we need to use IMAGE_FULLNAME to pick up any extensions of it.
-IMAGE_FULLNAME ??= "${ABROOTFS_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
-
-IMAGE_UUID_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
-
-do_install[depends] += "${ABROOTFS_IMAGE_RECIPE}:do_generate_image_uuid"
-do_install[cleandirs] += "${D}/usr/share/abrootfs"
-
-do_install:append() {
-    if [ -f "${IMAGE_UUID_ENV_FILE}" ]; then
-        install -m 0600 "${IMAGE_UUID_ENV_FILE}" "${D}/usr/share/abrootfs/image-uuid.env"
-    else
-        bberror "Did not find ${IMAGE_UUID_ENV_FILE}. initramfs will not be build correctly!"
-    fi
-}
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
index ab6c817..7052813 100644
--- a/wic/ebg-sysparts.inc
+++ b/wic/ebg-sysparts.inc
@@ -4,5 +4,5 @@
 part --source efibootguard-efi  --fixed-size 16M --label efi   --align 1024 --part-type=EF00 --active --fsuuid 0x4321dcba --uuid c19e7e9f-bacf-49a6-b43d-2fc18d2a8d03
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
-part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
+part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,abrootfs_root=y" --fsuuid 0x4321dcbb --uuid e8567692-2dfa-459a-be15-f6e5ddcc8f49
+part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,abrootfs_root=y" --fsuuid 0x4321dcbc --uuid 94b2174d-c792-4e8e-8a34-b506e2927937
-- 
2.47.0


