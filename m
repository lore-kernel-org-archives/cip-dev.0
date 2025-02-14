Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF4EC021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 06:47:18 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.19841.1739535839273368064
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Feb 2025 04:24:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm2 header.b=GyvU+DSv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1321639-202502141223570472f7bbaff7218c1e-4pfczn@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202502141223570472f7bbaff7218c1e
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Feb 2025 13:23:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=kz2YKkSg8UnPjMwOaE5iOAkGu+DfcvDzUh2WjP1JV2I=;
 b=GyvU+DSvd76QyBdyfFj+1WnP0iuraQRxrQQE7bfV1dYOmtBJoCXZdp+AH7vKM0CCFrZt5p
 MppzdrEoMV2MQO0zLP0Ab8Z1VSp0gwYP2AIwEmK1Zygc1xVPPODW9puZ4YmFNYpPJlFJrtGs
 VLEdHFvxgvYCK1w9AlP3OVGv8cCFZH5933tDskt4G6RuVm9v0QD6izwNI9QcJi0SpxyXPRc2
 ysIxoyg0g6r74XaThGqMtkKnI5AP+UliQFgqzETkig+b+M71gye2Wyh0V2YG1v2CYiP27pOB
 B7kwUNlqsmqkq8FAksOnVSyrDTeoCJZleBdzySXYWNBzPtZfnnEHMh7w==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC 2/2] port verity env handling to new kernel cmdline infrastructure
Date: Fri, 14 Feb 2025 13:23:29 +0100
Message-ID: <20250214122329.2766449-2-felix.moessbauer@siemens.com>
In-Reply-To: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
References: <20250214122329.2766449-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 06:47:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17850

Previously the verity env was injected as file into the initrd and then
sourced at runtime. As we now have infrastructure in place to add the
verity env to the kernel cmdline, we replace the hard-coded values with
logic to extract it from the kernel cmdline. By that, we also remove the
dependency between the initrmfs build and the verity creation, which
reduces the set of dependencies (good for caching), as well as increases
the parallism of the build.

Once widely supported, the initrd scripts can be completely replaced by
the systemd-veritysetup-generator (identical syntax).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas/opt/security.yml                          |  1 -
 .../initramfs-verity-hook/files/hook          |  1 -
 .../files/local-top-complete.tmpl             | 41 ++++++++++++++++++-
 .../initramfs-verity-hook_0.2.bb              | 24 +----------
 wic/ebg-signed-sysparts.inc                   |  4 +-
 5 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 4aa40e0..317af85 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -23,6 +23,5 @@ local_conf_header:
     USER_root[flags] = "clear-text-password"
   adjust-swupdate: |
     ABROOTFS_IMAGE_RECIPE = "cip-core-image-security"
-    VERITY_IMAGE_RECIPE = "cip-core-image-security"
   security-override: |
     OVERRIDES .= ":security"
diff --git a/recipes-initramfs/initramfs-verity-hook/files/hook b/recipes-initramfs/initramfs-verity-hook/files/hook
index 1550daf..557e4f3 100644
--- a/recipes-initramfs/initramfs-verity-hook/files/hook
+++ b/recipes-initramfs/initramfs-verity-hook/files/hook
@@ -2,4 +2,3 @@
 # Copyright (c) Siemens AG, 2021-2024
 
 copy_file library /lib/cryptsetup/functions /lib/cryptsetup/functions
-copy_file library /usr/share/verity-env/verity.env /usr/share/verity-env/verity.env
diff --git a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
index 8865b0f..991178c 100644
--- a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
+++ b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
@@ -32,7 +32,44 @@ esac
 
 . /scripts/functions
 . /lib/cryptsetup/functions
-. /usr/share/verity-env/verity.env
+
+load_verity_env_from_cmdline()
+{
+    local verity_opts
+    local key
+    local val
+    local opt
+    verity_opts=$(cat /proc/cmdline | sed -n 's/.*cip.verity_root_options=\([^ ]*\).*/\1/p' | sed 's/,/ /g')
+    for opt in $verity_opts; do
+        key=$(echo $opt | sed 's/=.*//')
+        val=$(echo $opt | sed 's/^[^=]*=//')
+        case "$key" in
+            uuid)
+                UUID="$val"
+                ;;
+            salt)
+                SALT="$val"
+                ;;
+            data-blocks)
+                DATA_BLOCKS="$val"
+                ;;
+            data-block-size)
+                DATA_BLOCK_SIZE="$val"
+                ;;
+            hash-block-size)
+                HASH_BLOCK_SIZE="$val"
+                ;;
+            hash-offset)
+                HASH_OFFSET="$val"
+                ;;
+            hash)
+                ROOT_HASH="$val"
+                ;;
+            *)
+                ;;
+        esac
+    done
+}
 
 find_root_via_image_uuid()
 {
@@ -63,6 +100,8 @@ find_root_via_image_uuid()
 echo "ROOT=/dev/null" >/conf/param.conf
 wait_for_udev 10
 
+load_verity_env_from_cmdline
+
 case "$ROOT" in
     PART*)
         # Root was given as PARTUUID= or PARTLABEL=.
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
index a6c4666..668419e 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
@@ -25,26 +25,4 @@ DEBIAN_DEPENDS .= ", cryptsetup"
 DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
 
 HOOK_ADD_MODULES = "dm_mod dm_verity"
-HOOK_COPY_EXECS = "veritysetup dmsetup"
-
-VERITY_IMAGE_RECIPE ?= "cip-core-image"
-
-# This is defined in image.bbclass which cannot be used in a package recipe.
-# However, we need to use IMAGE_FULLNAME to pick up any extensions of it.
-IMAGE_FULLNAME ??= "${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}"
-
-VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.verity.env"
-
-do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
-do_install[cleandirs] += "${D}/usr/share/verity-env"
-
-do_install:append() {
-    # Insert the veritysetup commandline into the script
-    if [ -f "${VERITY_ENV_FILE}" ]; then
-        install -m 0600 "${VERITY_ENV_FILE}" "${D}/usr/share/verity-env/verity.env"
-    else
-        bberror "Did not find ${VERITY_ENV_FILE}. initramfs will not be build correctly!"
-    fi
-}
-
-addtask install after do_transform_template
+HOOK_COPY_EXECS = "veritysetup dmsetup sed"
diff --git a/wic/ebg-signed-sysparts.inc b/wic/ebg-signed-sysparts.inc
index 9292eee..b888239 100644
--- a/wic/ebg-signed-sysparts.inc
+++ b/wic/ebg-signed-sysparts.inc
@@ -4,5 +4,5 @@
 part --source efibootguard-efi  --size 16M --label efi   --align 1024 --part-type=EF00 --active --sourceparams "signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcba --uuid d1360f76-b09a-4bcc-b923-8195088cbe02
 
 # EFI Boot Guard environment/config partitions plus Kernel files
-part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
-part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
+part --source efibootguard-boot --fixed-size 64M --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbb --uuid f870258b-706f-4a66-8d58-b5a75ce61b8b
+part --source efibootguard-boot --fixed-size 64M --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,signwith=/usr/bin/sign_secure_image.sh,verity_root=y" --fsuuid 0x4321dcbc --uuid 6e41f2a7-e3eb-403f-8637-b111e4482ee9
-- 
2.47.2


