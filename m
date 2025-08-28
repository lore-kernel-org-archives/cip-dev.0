Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A69BCA0FF2
	for <webhook@archiver.kernel.org>; Thu, 28 Aug 2025 11:07:24 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.18175.1756379236561510982
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 Aug 2025 04:07:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=XuQK8MBE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-20250828110713d93ec33ff2000207cb-0g3h7t@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250828110713d93ec33ff2000207cb
        for <cip-dev@lists.cip-project.org>;
        Thu, 28 Aug 2025 13:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=swUGpy38QElnjeC4ZW5WxhUAL3bd3MvnU2gHfa7or14=;
 b=XuQK8MBE2fhDOKPBdIRn15kpIN4uhqy/Ody8D83U+LNkK9YQbryTdb0vOlc9g7So9LClq2
 51qTVV8mYlyyY84QLtaGNUuxOKs4P4J00rfF56a0Y6wsDQJm71nN2HvDCskjpGB7CA8tuIB5
 PCSDiY8hhGkQqK6Or2NmD1bPp7QrpjOFFVhwV/kwgvuLWaZbMkMHs4QwnWymhwKH4y3jo/Pj
 oD/npr3cVqeOIcYEVc6505EWh8mPZtmqP3+YLIK/DV1lYsgLQulMEZ2u27lX5sBtbmlC/caP
 SNTSF5+nhp8WnzsU44WrYCYFgn1GN0EHBNODT9jr8ChyyBrvLbxEIZIA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 2/7] Add factory-reset initramfs hook
Date: Thu, 28 Aug 2025 13:06:49 +0200
Message-ID: <20250828110712.392641-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 Aug 2025 11:07:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19987

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to reset the device back to first boot by
formatting the persistent partitions.

The reset occurs if a file defined by the variable
INITRAMFS_FACTORY_RESET_MARKER
exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.

In case of disk encryption it will invalidate the keys
stored in the TPM.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-factory-reset-hook/files/hook   |  6 +++
 .../files/local-top                           | 52 +++++++++++++++++++
 .../files/reset-env.tmpl                      |  2 +
 .../initramfs-factory-reset-hook_0.1.bb       | 38 ++++++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 21 +++++++-
 .../files/get-factory-reset-file.sh.tmpl      | 20 ++++++-
 6 files changed, 136 insertions(+), 3 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/hook b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
new file mode 100644
index 0000000..7c558d3
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
@@ -0,0 +1,6 @@
+# Copyright (C) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+
+copy_file library /usr/share/factory-reset/reset-env /usr/share/factory-reset/reset-env
+
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
new file mode 100644
index 0000000..d61ffe8
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
@@ -0,0 +1,52 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+. /usr/share/factory-reset/reset-env
+
+target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
+
+if /usr/sbin/get-factory-reset.sh --delete | grep -q "factory-reset"; then
+	log_begin_msg "Factory Reset"
+	for target in ${target_devices}; do
+		log_begin_msg "Reset device: $target"
+		fs_type=$(get_fstype ${target})
+		case "$target" in
+			*by-partlabel*)
+				label="$(basename "${target}" )"
+			;;
+			*)
+				label=$(blkid --match-tag LABEL "$target" | awk -F= '{gsub(/"/,"");print $2}' )
+				if [ -z "${label}" ]; then
+					log_warning_msg "Could not find any label  for target '$target'"
+				fi
+			;;
+		esac
+		if [ "$fs_type" = "luks" ]; then
+			# after this the data on the encrypted partition
+			# is inaccessible
+			tpm2_clear
+			# with encryption the original fs_type is hidden
+			# use a variable from the reset-env to set it
+			fs_type="$INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+		fi
+		case ${fs_type} in
+		ext*)
+			/sbin/mke2fs -L "${label}" -F -t ext4 "${target}"
+			;;
+		btrfs)
+			/sbin/mkfs.btrfs -L "${label}" --force "${target}"
+			;;
+		*)
+			log_warning_msg "Unrecognized filesystem type ${fs_type} - could not format"
+			;;
+		esac
+		log_end_msg "Reset device: $target"
+	done
+	log_end_msg "Factory Reset"
+fi
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
new file mode 100644
index 0000000..127aaad
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
@@ -0,0 +1,2 @@
+INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
new file mode 100644
index 0000000..6bae8cb
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
@@ -0,0 +1,38 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-initramfs/initramfs-hook/hook.inc
+DESCRIPTION = "Delete the content of the given Devices"
+
+# list of partitions by label
+INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
+SRC_URI += " \
+    file://reset-env.tmpl \
+    file://local-top \
+    file://hook"
+
+TEMPLATE_FILES += "reset-env.tmpl"
+TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
+                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+
+RDEPENDS = "factory-reset-helper"
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper"
+DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
+HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
+                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
+                   chattr grep"
+HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
+
+do_install[cleandirs] += "${D}/usr/share/factory-reset/"
+do_install:prepend() {
+    install -m 0755 "${WORKDIR}/reset-env" \
+        "${D}/usr/share/factory-reset/reset-env"
+}
diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
index 4af5500..8d1b126 100644
--- a/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
+++ b/recipes-support/factory-reset-helper/files/get-factory-reset-efivar.sh.tmpl
@@ -9,6 +9,21 @@
 #
 # SPDX-License-Identifier: MIT
 
+# shellcheck disable=SC2221,SC2222
+while [ $# -gt 0 ]; do
+  case $1 in
+  -d|--delete)
+  DELETE_MARKER=true
+  shift
+  ;;
+  -*|--*)
+  echo "Unkown option '$1'"
+  usage
+  exit 1
+  ;;
+  esac
+done
+
 marker_file="/sys/firmware/efi/efivars/${FACTORY_RESET_MARKER}-${FACTORY_RESET_EFIVARS_GUID}"
 
 if ! mountpoint -q /sys/firmware/efi/efivars; then
@@ -19,7 +34,9 @@ if ! mountpoint -q /sys/firmware/efi/efivars; then
 fi
 if [ -e "$marker_file" ]; then
 	echo "factory-reset was triggered"
-	chattr -i "$marker_file"
-	rm "$marker_file"
+	if [ "$DELETE_MARKER" = "true" ]; then
+		chattr -i "$marker_file"
+		rm "$marker_file"
+	fi
 fi
 
diff --git a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
index 281ea3d..fbe5f96 100644
--- a/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
+++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.tmpl
@@ -9,6 +9,22 @@
 #
 # SPDX-License-Identifier: MIT
 
+# shellcheck disable=SC2221,SC2222
+while [ $# -gt 0 ]; do
+  case $1 in
+  -d|--delete)
+  DELETE_MARKER=true
+  shift
+  ;;
+  -*|--*)
+  echo "Unkown option '$1'"
+  usage
+  exit 1
+  ;;
+  esac
+done
+
+
 marker="$(basename ${FACTORY_RESET_MARKER})"
 marker_storage_device="${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
 storage_mnt="$(findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
@@ -40,7 +56,9 @@ fi
 if [ -e "${storage_mnt}/${marker}" ]; then
 	echo "factory-reset was triggered"
 	# delete marker
-	rm "${storage_mnt}/${marker}"
+	if [ "$DELETE_MARKER" = "true" ]; then
+		rm "${storage_mnt}/${marker}"
+	fi
 fi
 if mountpoint -q "$tmp_mount"; then
 	umount "$tmp_mount"
-- 
2.50.1


