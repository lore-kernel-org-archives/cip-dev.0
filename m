Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305F9CA1012
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 09:52:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.35374.1756979555163657876
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Sep 2025 02:52:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=pvOVXg2T;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-202509040952322145cf8bbd000207f1-biuruk@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202509040952322145cf8bbd000207f1
        for <cip-dev@lists.cip-project.org>;
        Thu, 04 Sep 2025 11:52:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=VQSkicCP+ntt4jxsCBgN1KM5ZonTYEZO3nQGVx9J4rQ=;
 b=pvOVXg2Tb9hAlgzOF+icutt0EG6RI6C6eC9QEyPJZt6qwpElSRZE3allaxr09yF+R8odbs
 ufG5YOTejM36RPJhWGC4nT31HhhExJdDCKzBi8H9A0NdeliloFr0SYLTEDmKH284no2AJMST
 5dN7jHgXRL3SYW3gwnCD6oTCLen1REjdWEbsVDRB5lsv4NYujni8On8yfecpyETk4qk6SZcJ
 TIqbsSBHf/ovC+6UiqM1vXEER4RwA/7j0uFYinnnMGFkQrhLyXScHFO5UKBkvO7GpkrIK+KR
 77X1orb/ex5PRA4Gykep0bp8w8jq29x00+oJvJPVOPijGAqecX2DfWRg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v5 2/7] Add factory-reset initramfs hook
Date: Thu,  4 Sep 2025 11:39:25 +0200
Message-ID: <20250904095231.2039819-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
References: <20250904095231.2039819-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 09:52:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20008

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to reset the device back to first boot by
formatting the persistent partitions.

The reset occurs if a file defined by the variable
INITRAMFS_FACTORY_RESET_MARKER
exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.

In case of disk encryption it will invalidate the keys
stored in the TPM if INITRAMFS_FACTORY_RESET_CLEAR_TPM is set
to `1`.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-factory-reset-hook/files/hook   |  6 +++
 .../files/local-bottom                        | 48 +++++++++++++++++
 .../files/local-top                           | 52 +++++++++++++++++++
 .../files/reset-env.tmpl                      |  2 +
 .../initramfs-factory-reset-hook_0.1.bb       | 40 ++++++++++++++
 .../files/get-factory-reset-efivar.sh.tmpl    | 21 +++++++-
 .../files/get-factory-reset-file.sh.tmpl      | 20 ++++++-
 7 files changed, 186 insertions(+), 3 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
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
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
new file mode 100644
index 0000000..e807511
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom
@@ -0,0 +1,48 @@
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
+target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
+set -x
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
+			target=$(find /dev/mapper -iname "*$label")
+			fs_type=$(get_fstype ${target})
+			echo "luks device detected use $target"
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
index 0000000..68dda34
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
@@ -0,0 +1,40 @@
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
+INITRAMFS_FACTORY_RESET_CLEAR_TPM ??= '1'
+SRC_URI += " \
+    file://reset-env.tmpl \
+    file://hook"
+
+SRC_URI += "${@ 'file://local-top' if bb.utils.to_boolean(d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else 'file://local-bottom'}"
+
+TEMPLATE_FILES += "reset-env.tmpl"
+TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_DEVICES \
+                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+
+RDEPENDS = "factory-reset-helper"
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk, factory-reset-helper, findutils"
+DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
+HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename \
+                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
+                   chattr grep find"
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


