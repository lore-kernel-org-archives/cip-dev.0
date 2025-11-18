Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE6CEDDB7
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 15:10:41 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14640.1763478633719824373
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 07:10:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=f4oKlSpJ;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20251118151031594f15370c00020722-8bvtax@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20251118151031594f15370c00020722
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 16:10:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=/H75rsV7cMVSefuUQyKGEy/aDVMRs9ZaN8kknMZxpsY=;
 b=f4oKlSpJnei0hwNgKAqqhmKrsnNrfKuNTlt6pQnKhA+Uv/N/tFvi8ReL4IXq2OoEbddSsQ
 8ZSL/f7XDRdi/shiIl+d1bkCwnWspX9O+8mSpek7TWyzoa78Md+wxZgWdZ8b15ggDhnieyyq
 WA1UWPkhBJQCPRm/PcF9eVGeXNdw+tRSgqyHZu/Ayztiz/2+7vXH0r1wubcFv4f38c/eND98
 /JxGQ0aBcaKB/z/ORklA4BGVx1bm/bJQ/FsIW25tkSt7bjOHFX7c+CGjRz/8O4qH0i66AY4k
 2GjO+9sGez1VsgGlRBc5BV5AGDpeimyxfkYfD058ggwZ2bp5ENLFjvHA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/5] initramfs-abrootfs-hook: Use initramfs-cip-functions
Date: Tue, 18 Nov 2025 15:14:45 +0100
Message-ID: <20251118151030.504765-3-Quirin.Gylstorff@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20619

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This use the functions from the new package to de-duplicate the
code used by initramfs-verity-hook and initramfs-abrootfs-hook.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/local-top-complete                  | 53 ++++---------------
 ..._0.2.bb => initramfs-abrootfs-hook_0.3.bb} |  3 +-
 2 files changed, 11 insertions(+), 45 deletions(-)
 rename recipes-initramfs/initramfs-abrootfs-hook/{initramfs-abrootfs-hook_0.2.bb => initramfs-abrootfs-hook_0.3.bb} (79%)

diff --git a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
index 74a7714..494fdeb 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-abrootfs-hook/files/local-top-complete
@@ -31,6 +31,8 @@ esac
 
 . /scripts/functions
 
+. /scripts/cip-initramfs-functions
+
 load_abrootfs_env_from_cmdline()
 {
     abrootfs_opts=$(cat /proc/cmdline | sed -n 's/.*cip.abrootfs_root_options=\([^ ]*\).*/\1/p' | sed 's/,/ /g')
@@ -47,10 +49,13 @@ load_abrootfs_env_from_cmdline()
     done
 }
 
+found_root=""
+scanned_partitions=""
 
 find_root_via_image_uuid()
 {
-    for part in $partitions; do
+    loc_partitions="$1"
+    for part in $loc_partitions; do
         if [ "$(blkid -p "${part}" --match-types novfat -s USAGE -o value)" = "filesystem" ]; then
             mount -o ro -t "$(get_fstype "${part}")" "${part}" "${rootmnt}"
             if [ -e "${rootmnt}/etc/os-release" ]; then
@@ -82,57 +87,17 @@ case "$ROOT" in
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
         # No Root device was given. Search for the matching IMAGE_UUID
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
diff --git a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
similarity index 79%
rename from recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
rename to recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
index f7569e2..c3ac22e 100644
--- a/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.2.bb
+++ b/recipes-initramfs/initramfs-abrootfs-hook/initramfs-abrootfs-hook_0.3.bb
@@ -11,7 +11,8 @@
 
 require recipes-initramfs/initramfs-hook/hook.inc
 
-DEBIAN_DEPENDS .= ", util-linux"
+RDEPENDS += "initramfs-cip-functions"
+DEBIAN_DEPENDS .= ", util-linux, initramfs-cip-functions"
 DEBIAN_CONFLICTS = "initramfs-verity-hook"
 
 SRC_URI += " \
-- 
2.51.2


