Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B04C3ABC4
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 12:08:14 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.74170.1746533290879385252
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 05:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=CRAL1Hig;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20250506120808412e5330e218b2f3cd-ed8d1s@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20250506120808412e5330e218b2f3cd
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 May 2025 14:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=DE+74FachdA6NKUdOj91L8hn+OhlcmKydClcB3XsMOs=;
 b=CRAL1Higkt67T4LAeSSq44Owd70PQlFw1I9X6vOUpC46HMBKp3jE7tkqzuKSlVbZ2NjDRX
 4ymudTsySxha7F+RofGLcfotd1sYkK8ogTlHlQone0M17Red2ufTf+IdGs2mydseIDTG01wQ
 0bvvttjAmJVi5Csip2Mf7U9Otkf/z/E2owDpAPMbDJ1ulcyL2JrF5PuV1WcTg8T4ZGMw2JCm
 CLEsW5zfNBLPMySYWtMEvp62zPhMZ3qFyxJHikzIpI4SZQ98TR5hb0lu76tAFBj0SaKePXHG
 8dbynVUlr9jhGaZXsKjrYW827tVN5WmgLirGrB9eeDbpopYmqxo4ucxw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 1/6] add factory-reset initramfs hook
Date: Tue,  6 May 2025 14:07:43 +0200
Message-ID: <20250506120807.255675-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 May 2025 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18763

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
 .../files/detect-marker-file                  | 33 +++++++++
 .../initramfs-factory-reset-hook/files/hook   |  7 ++
 .../files/local-top-complete                  | 67 +++++++++++++++++++
 .../files/reset-env.tmpl                      |  4 ++
 .../initramfs-factory-reset-hook_0.1.bb       | 52 ++++++++++++++
 5 files changed, 163 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file b/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
new file mode 100644
index 0000000..30e399e
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
@@ -0,0 +1,33 @@
+#!/bin/sh
+# Copyright (C) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+#
+# This implementation check for the a existing file to trigger a
+# factory reset. Prints 'true' in case the marker was found
+
+check_for_factory_reset() {
+	marker="$(basename ${INITRAMFS_FACTORY_RESET_MARKER})"
+	marker_storage_device="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
+	storage_mnt="$(findmnt findmnt  --first-only --output TARGET --noheadings "${marker_storage_device}")"
+	tmp_mount=$(mktemp -d)
+	# check for marker
+	if [ -z "${storage_mnt}" ]; then
+		if ! mount -t "$(get_fstype "${marker_storage_device}")" \
+			 "${marker_storage_device}" \
+			 "${tmp_mount}"; then
+			panic "Can't mount ${marker_storage_device}!"
+		fi
+		storage_mnt="$tmp_mount"
+	fi
+	if [ -e "${storage_mnt}/${marker}" ]; then
+		echo "true"
+		# delete marker
+		rm "${storage_mnt}/${marker}"
+	fi
+	if mountpoint -q "$tmp_mount"; then
+		umount "$tmp_mount"
+	fi
+	rmdir "$tmp_mount"
+}
+
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/hook b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
new file mode 100644
index 0000000..4b4ff25
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/hook
@@ -0,0 +1,7 @@
+# Copyright (C) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+
+copy_file library /usr/share/factory-reset/factory_reset_marker /usr/share/factory-reset/factory_reset_marker
+copy_file library /usr/share/factory-reset/reset-env /usr/share/factory-reset/reset-env
+
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
new file mode 100644
index 0000000..82d8d42
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
@@ -0,0 +1,67 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+prereqs() {
+	# no prereqs we want in front of crypt
+	echo ""
+}
+case $1 in
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+
+set -x
+. /scripts/functions
+. /usr/share/factory-reset/reset-env
+. /usr/share/factory-reset/factory_reset_marker
+
+target_devices="${INITRAMFS_FACTORY_RESET_DEVICES}"
+
+if [ "$(check_for_factory_reset)" = "true" ]; then
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
index 0000000..ed68398
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
@@ -0,0 +1,4 @@
+INITRAMFS_FACTORY_RESET_MARKER="${INITRAMFS_FACTORY_RESET_MARKER}"
+INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE="${INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE}"
+INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
new file mode 100644
index 0000000..9e765b9
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
@@ -0,0 +1,52 @@
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
+# find the file defined by INITRAMFS_FACTORY_RESET_MARKER in
+# INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE. Important
+# this function does not work with disk encryption.
+FACTORY_RESET_DETECT_MARKER ?= "detect-marker-file"
+
+# if this file exists execute a factory reset for the given
+# list of factory-reset targets.
+INITRAMFS_FACTORY_RESET_MARKER ?= ".factory-reset"
+# use labels as crypt setup replaces the label links if
+# an partition is encrypted
+INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-partlabel/var"
+
+# list of partitions by label
+INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
+SRC_URI += " \
+    file://reset-env.tmpl \
+    file://local-top-complete \
+    file://${FACTORY_RESET_DETECT_MARKER} \
+    file://hook"
+
+TEMPLATE_FILES += "reset-env.tmpl"
+TEMPLATE_VARS += " INITRAMFS_FACTORY_RESET_MARKER \
+                   INITRAMFS_FACTORY_RESET_MARKER_STORAGE_DEVICE \
+                   INITRAMFS_FACTORY_RESET_DEVICES \
+                   INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk"
+DEBIAN_DEPENDS:append:encrypt-partitions = ", tpm2-tools"
+HOOK_COPY_EXECS = "mountpoint findmnt mktemp rmdir basename mke2fs mkfs.btrfs awk blkid rm"
+HOOK_COPY_EXECS:append:encrypt-partitions = " tpm2_clear"
+
+do_install[cleandirs] += "${D}/usr/share/factory-reset/"
+do_install:prepend() {
+    install -m 0755 "${WORKDIR}/reset-env" \
+        "${D}/usr/share/factory-reset/reset-env"
+    install -m 0755 "${WORKDIR}/${FACTORY_RESET_DETECT_MARKER}" \
+        "${D}/usr/share/factory-reset/factory_reset_marker"
+}
-- 
2.47.0


