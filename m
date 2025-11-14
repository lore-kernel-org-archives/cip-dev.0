Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BECACE7AF6
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:20:09 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15634.1763119205948749715
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:20:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=mHBB4NRM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20251114112003b001720f09000207af-kr_2yg@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20251114112003b001720f09000207af
        for <cip-dev@lists.cip-project.org>;
        Fri, 14 Nov 2025 12:20:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=e0nHvbrP74A5+9YRLtGL23B6CqtYQo+rgnnwAm4A46M=;
 b=mHBB4NRMeOz3wNEGStQUHqnhoINrN5DokEeJ+dxl6nN31PzSEGsmWpwWR3i183DIEZG2Eo
 +NwRI+oM/YolfNQlg1V11ilXeZ0IF1dXTnRBOIUD5BlMSY8ZkEkxm7YRJcDIq5+C/Kr9+Nat
 7VnvqvTdjvq2H8WHh60YvObzTKrSNDtIDu8cI+oR2BbT2N3uyLCTLBnIVMLRU9tkoslTUl/k
 B+q1y+keebwFuTIkq7ZlAH/7XOaY2Tdw9RsWT1/vhjahmvIX05WO2EVuJT6ulus5uIqwdTwP
 ysbwgsv6bc3Cpe4ehYGJ7AAFFPj0dB+Qpt7bUJmv/L36OyqJdBTW59vw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 4/5] initramfs-factory-reset: de-duplicate code between local-top and local-bottom
Date: Fri, 14 Nov 2025 12:17:43 +0100
Message-ID: <20251114111925.903740-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
References: <20251114111925.903740-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20557

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The local-top and local-bottom functions are nearly identical. Use
a template and change the name during prepare_build to the indented
initramfs stage to maintain only one file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../{local-top => factory-reset-script.tmpl}  | 18 ++++---
 .../files/local-bottom                        | 48 -------------------
 ...bb => initramfs-factory-reset-hook_0.2.bb} | 18 +++++--
 3 files changed, 26 insertions(+), 58 deletions(-)
 rename recipes-initramfs/initramfs-factory-reset-hook/files/{local-top => factory-reset-script.tmpl} (70%)
 delete mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
 rename recipes-initramfs/initramfs-factory-reset-hook/{initramfs-factory-reset-hook_0.1.bb => initramfs-factory-reset-hook_0.2.bb} (63%)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
similarity index 70%
rename from recipes-initramfs/initramfs-factory-reset-hook/files/local-top
rename to recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
index a1aaf26..a6c622f 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-script.tmpl
@@ -28,12 +28,18 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
                 ;;
         esac
         if [ "$fs_type" = "luks" ]; then
-            # after this the data on the encrypted partition
-            # is inaccessible
-            tpm2_clear
-            # with encryption the original fs_type is hidden
-            # use a variable from the reset-env to set it
-            fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+            if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
+                # after this the data on the encrypted partition
+                # is inaccessible
+                tpm2_clear
+                # with encryption the original fs_type is hidden
+                # use a variable from the reset-env to set it
+                fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+            else
+                target=$(find /dev/mapper -iname "*$label")
+                fs_type=$(get_fstype "${target}")
+                echo "luks device detected use $target"
+            fi
         fi
         case ${fs_type} in
             ext*)
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
deleted file mode 100644
index 15d44c9..0000000
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
+++ /dev/null
@@ -1,48 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2025
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-. /usr/share/factory-reset/reset-env
-target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
-
-if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
-    log_begin_msg "Factory Reset"
-    for target in ${target_devices}; do
-        log_begin_msg "Reset device: $target"
-        fs_type=$(get_fstype "${target}")
-        case "$target" in
-            *by-partlabel*)
-                label="$(basename "${target}" )"
-                ;;
-            *)
-                label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
-                if [ -z "${label}" ]; then
-                    log_warning_msg "Could not find any label  for target '$target'"
-                fi
-                ;;
-        esac
-        if [ "$fs_type" = "luks" ]; then
-            target=$(find /dev/mapper -iname "*$label")
-            fs_type=$(get_fstype "${target}")
-            echo "luks device detected use $target"
-        fi
-        case ${fs_type} in
-            ext*)
-                /sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
-                ;;
-            btrfs)
-                /sbin/mkfs.btrfs -L "${label}" --force "${target}"
-                ;;
-            *)
-                log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
-                ;;
-        esac
-        log_end_msg "Reset device: $target"
-    done
-    log_end_msg "Factory Reset"
-fi
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
similarity index 63%
rename from recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
rename to recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
index 68dda34..28e1cf4 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.2.bb
@@ -14,16 +14,20 @@ DESCRIPTION = "Delete the content of the given Devices"
 # list of partitions by label
 INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
 INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
-INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '1'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '0'
+INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?= '1'
+
 SRC_URI += " \
+    file://factory-reset-script.tmpl \
     file://reset-env.tmpl \
     file://hook"
 
-SRC_URI += "${@ 'file://local-top' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else 'file://local-bottom'}"
+FACTORY_RESET_HOOK_TARGET = "${@ 'local-top' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else 'local-bottom'}"
 
-TEMPLATE_FILES += "reset-env.tmpl"
+TEMPLATE_FILES += "reset-env.tmpl factory-reset-script.tmpl"
 TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
-                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
+                   INITRAMFS_FACTORY_RESET_CLEAR_TPM"
 
 RDEPENDS = "factory-reset-helper"
 DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
@@ -33,6 +37,12 @@ HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
                    chattr grep find"
 HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
 
+# rename the script
+do_prepare_build:append() {
+    rm -f ${WORKDIR}/local-top ${WORKDIR}/local-bottom
+    install ${WORKDIR}/factory-reset-script ${WORKDIR}/${FACTORY_RESET_HOOK_TARGET}
+}
+
 do_install[cleandirs] += "${D}/usr/share/factory-reset/"
 do_install:prepend() {
     install -m 0755 "${WORKDIR}/reset-env" \
-- 
2.51.0


