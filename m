Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E67CEDDBB
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 15:10:41 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14641.1763478633913345674
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 07:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=B4hGWXYY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202511181510316f6ffdd37400020775-ygqq42@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511181510316f6ffdd37400020775
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 16:10:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=bT135yBPSolkBbB3pl32BE/OZLKbN8RAjZDpONB8WLE=;
 b=B4hGWXYYUgJQ6P/eVcwS0k/rPXpQg2rPBIzeshuIhn9nknqiujmKYbyq9/AshbhdhYEobW
 /Lh63sNSGzxbLBSEaIRHGAEkWNlt6C7vxYNh16jAroRcGfOUGDRol/JX216Kx45pni/5KwNz
 uYF+7DuDWOLoM4dqu/gyW/huZ527LACyfHXj64R0xIodsH5jdsAS0dsXGZZXyz3WJBUH7Ufu
 ykSSsxvCsOnxW+6RZF7QjmAcvWvencwXvrRAJFlWS0p0IcgMc+QjB9+O7x2Q4OV7z73g1Ozp
 3C6YeYeDWvanoRScemu8qNqWT0xxnyMzqqFtT19zJ1QZxKMRIOGYAo5g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/5] initramfs-verity-hook: Use initramfs-cip-functions
Date: Tue, 18 Nov 2025 15:14:46 +0100
Message-ID: <20251118151030.504765-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
References: <20251118151030.504765-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 15:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20618

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This use the functions from the new package to de-duplicate the
code used by initramfs-verity-hook and initramfs-abrootfs-hook.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/local-top-complete.tmpl             | 55 ++++---------------
 ...ok_0.2.bb => initramfs-verity-hook_0.3.bb} |  3 +-
 2 files changed, 12 insertions(+), 46 deletions(-)
 rename recipes-initramfs/initramfs-verity-hook/{initramfs-verity-hook_0.2.bb => initramfs-verity-hook_0.3.bb} (85%)

diff --git a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
index 991178c..db805c0 100644
--- a/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
+++ b/recipes-initramfs/initramfs-verity-hook/files/local-top-complete.tmpl
@@ -33,6 +33,8 @@ esac
 . /scripts/functions
 . /lib/cryptsetup/functions
 
+. /scripts/cip-initramfs-functions
+
 load_verity_env_from_cmdline()
 {
     local verity_opts
@@ -71,9 +73,13 @@ load_verity_env_from_cmdline()
     done
 }
 
+found_root=""
+scanned_partitions=""
+
 find_root_via_image_uuid()
 {
-    for part in ${partitions}; do
+    loc_partitions="$1"
+    for part in ${loc_partitions}; do
         if [ "$(blkid -p ${part} --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
             verity_uuid=$(
                 veritysetup dump "${part}" --hash-offset "${HASH_OFFSET}" | \
@@ -99,7 +105,6 @@ find_root_via_image_uuid()
 # broken trust chain.
 echo "ROOT=/dev/null" >/conf/param.conf
 wait_for_udev 10
-
 load_verity_env_from_cmdline
 
 case "$ROOT" in
@@ -109,57 +114,17 @@ case "$ROOT" in
         found_root=$(blkid --list-one --output device --match-token "$ROOT")
         if [ -z "${found_root}" ]; then
             log_begin_msg "Waiting for ${ROOT}"
-            while true; do
-                sleep 1
-                time_elapsed="$(time_elapsed)"
-
-                found_root=$(blkid --list-one --output device --match-token "$ROOT")
-                if [ -n "${found_root}" ]; then
-                    log_end_msg 1
-                    break
-                fi
-                if [ "${time_elapsed}" -ge 30 ]; then
-                    log_end_msg 0
-                    break
-                fi
-            done
+            wait_30sec_for_condition find_root_by_part
         fi
         ;;
     "")
         # No Root device was given. Use veritysetup verify to search matching roots
         partitions="$(blkid -o device)"
-        find_root_via_image_uuid
+        find_root_via_image_uuid "$partitions"
         if [ -z "${found_root}" ]; then
             log_begin_msg "Waiting for IMAGE_UUID=${TARGET_IMAGE_UUID}"
             scanned_partitions="${partitions}"
-            while true; do
-                sleep 1
-                time_elapsed="$(time_elapsed)"
-
-                unset partitions
-                for part in $(blkid -o device); do
-                    unset found
-                    for scanned_part in ${scanned_partitions}; do
-                        if [ "${scanned_part}" = "${part}" ]; then
-                            found=1
-                            break
-                        fi
-                    done
-                    if [ -z "${found}" ]; then
-                        partitions="${partitions} ${part}"
-                    fi
-                done
-                find_root_via_image_uuid
-                if [ -n "${found_root}" ]; then
-                    log_end_msg 1
-                    break
-                fi
-                if [ "${time_elapsed}" -ge 30 ]; then
-                    log_end_msg 0
-                    break
-                fi
-                scanned_partitions="${scanned_partitions} ${partitions}"
-            done
+            wait_30sec_for_condition scan_for_partitions
         fi
         ;;
 esac
diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
similarity index 85%
rename from recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
rename to recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
index 668419e..37781c9 100644
--- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.3.bb
@@ -21,7 +21,8 @@ VERITY_BEHAVIOR_ON_CORRUPTION ?= "--restart-on-corruption"
 TEMPLATE_FILES += "local-top-complete.tmpl"
 TEMPLATE_VARS += "VERITY_BEHAVIOR_ON_CORRUPTION"
 
-DEBIAN_DEPENDS .= ", cryptsetup"
+RDEPENDS += "initramfs-cip-functions"
+DEBIAN_DEPENDS .= ", cryptsetup, initramfs-cip-functions"
 DEBIAN_CONFLICTS = "initramfs-abrootfs-hook"
 
 HOOK_ADD_MODULES = "dm_mod dm_verity"
-- 
2.51.2


