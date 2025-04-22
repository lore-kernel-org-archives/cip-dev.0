Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB488C369D7
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:51:06 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web11.41956.1745333458464798609
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:50:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=ZdPddsBb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250422145056999da76331381dc34a-oposps@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250422145056999da76331381dc34a
        for <cip-dev@lists.cip-project.org>;
        Tue, 22 Apr 2025 16:50:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=w4OBuO1ot9+++mE19lO9gmZQKGqbgDYMd+DCOn5W1G8=;
 b=ZdPddsBbb8J8Yc51rN2Q6h2BNFiJfDlNC2q5R/2P+OK8dP3S4qj3q3N7xMNm6rwH662PS4
 RKVkGxFXodDrYTyKyP+il7A/3lQ0mbZsGy/dvhTzBHkEkJ6N9hmBQEWBQdp+obUhRgTZBTB8
 Y+6mIYVeCnoOcjQ8qcr8oZgY74pLZa3qiG62SRmoKJTjoUDU/loCmO4zuuRZ09e7FQoILUHZ
 USG298oeP+nemMW3H/YqpHd8wZlsiqwZLJu2KjDzQimD3YFyKg3V7Q3xZCIiS09WUXwkRWsm
 OagkttNbrO5uJlS7OygFOj+P3X7gYdWYOh3IGAsYC6aLNED5yn1dgK6g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 5/5] port abrootfs env handling to new kernel cmdline infrastructure
Date: Tue, 22 Apr 2025 16:35:26 +0200
Message-ID: <20250422145055.1095348-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
References: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 14:51:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18557

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


