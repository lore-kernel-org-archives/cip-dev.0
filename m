Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E62C369D3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:33:38 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.45913.1745840010042209423
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 04:33:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=S9G7WsGh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202504281133274cbb968f3120a1fa0e-1s_jg4@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202504281133274cbb968f3120a1fa0e
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 13:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=X2xtwoh0tdGyqVf+Hpgidc4C72lHN/3EXkUDRB5MsUw=;
 b=S9G7WsGhPzZFy0fSoteFRxwQpLB2R3TycQAjvwMvRIxQ3OqTG8I5KEsO0RRzxxCdUXPHkg
 EEJoc+1rsPyZPPGCFaVXOOitv8x6Sm5w7txg53hfVviAHwbg57qbkGNaX/PyLw955XbcFBF3
 dxcAADACAYh72Fxo0CzhYPOaXSIjU5PHY1j/pVqEDLrRvNVWp0l8setfem/HDYwdn0ZYMNpg
 7iRj7ASnyG1b9hL6YBcjK00E0eTmlNs6UgcpIPCE8uFy9n3Xi2MBb/sTPSjC1RkfEIXvIkdi
 IlD1RraP/a5JgOjNQZxoCDyoysNShomD9CASXuchvv3PWeD0C7vdFwLw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 2/4] port verity env handling to new kernel cmdline infrastructure
Date: Mon, 28 Apr 2025 13:32:44 +0200
Message-ID: <20250428113325.3208873-3-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18693

From: Felix Moessbauer <felix.moessbauer@siemens.com>

Previously the verity env was injected as file into the initrd and then
sourced at runtime. As we now have infrastructure in place to add the
verity env to the kernel cmdline, we replace the hard-coded values with
logic to extract it from the kernel cmdline. By that, we also remove the
dependency between the initramfs build and the verity creation, which
reduces the set of dependencies (good for caching), as well as increases
the parallelism of the build.

Once widely supported, the initrd scripts can be completely replaced by
the systemd-veritysetup-generator (identical syntax).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
[Quirin: fix typos in commit message]
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
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
2.47.0


