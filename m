Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34862C369D7
	for <webhook@archiver.kernel.org>; Thu, 24 Apr 2025 09:23:13 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.11127.1745486586085197190
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Apr 2025 02:23:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=b6A/uXPz;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20250424092303bb2e12b86ed3bd3e91-dhl1_1@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250424092303bb2e12b86ed3bd3e91
        for <cip-dev@lists.cip-project.org>;
        Thu, 24 Apr 2025 11:23:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=z+KIEzDtaCev9MZxfkVfkX75JWZHhBN3glmJv0PrJOE=;
 b=b6A/uXPz3M4ym+Lv84gmXe2CcKnG9pykJL0X0Nt4WJtC9ndCdwv04jdB3yYrFwxjnSa3mD
 p18rHoyVqDk5miKj69rCPHIbvN2f+RbxcC4sodbM1pDiEIkH5J+vNBuqC22jwQzDRQYaAEpA
 GF1b/G6M2p1YKBl62w+2RtphQwkZX8RWfiD652Rqzy1vaE+6s449LQ2TVkj1hdZUUP0q+1jx
 wWt281D9Me3ixqUpeGfRFJid89E/7vezgOYziT66EhHKNp4/910lOH/BmcZRpadHz7fsNBll
 GP1j6FKZd9f4gJgRAGrwMtLx46qdHb40Vp6AogX0ed1KfOIpwB+O7dlw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [PATCH 1/2] initramfs: add hook for data-reset
Date: Thu, 24 Apr 2025 11:22:21 +0200
Message-ID: <20250424092302.2066773-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
References: <20250424092302.2066773-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Apr 2025 09:23:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18595

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to reset the device data by deleting
all files in the persistent partitions.

The reset occurs if a file defined by the variable
INITRAMFS_DATA_RESET_MARKER
exists in the device INITRAMFS_DATA_RESET_MARKER_DEVICE.

This feature allows to add device specific trigger to restore
the persistent file system to the first-boot state.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/local-bottom-complete.tmpl          | 76 +++++++++++++++++++
 .../initramfs-data-reset-hook_0.1.bb          | 36 +++++++++
 2 files changed, 112 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
new file mode 100644
index 0000000..f02f95c
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-bottom-complete.tmpl
@@ -0,0 +1,76 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+prereqs()
+{
+	# Make sure that this script is run last in local-top
+	# but before overlay
+	local req
+	for req in "${0%/*}"/*; do
+		script="${req##*/}"
+		if [ "$script" != "${0##*/}" ] &&
+			[ "$script" != "overlay" ] ; then
+			printf '%s\n' "$script"
+		fi
+	done
+}
+case $1 in
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+. /scripts/functions
+
+marker="${INITRAMFS_DATA_RESET_MARKER}"
+marker_storage_device="${INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE}"
+target_devices="${INITRAMFS_DATA_RESET_DEVICES}"
+
+storage_mnt="$(findmnt "${marker_storage_device}")"
+factory_reset=false
+tmp_mount=$(mktemp -d)
+# check for marker
+if [ -z "${storage_mnt}" ]; then
+	if ! mount -t "$(get_fstype "${marker_storage_device}")" \
+		 "${marker_storage_device}" \
+		 "${tmp_mount}"; then
+		panic "Can't mount ${marker_storage_device}!"
+	fi
+	storage_mnt="$tmp_mount"
+fi
+if [ -e "${storage_mnt}${marker}" ]; then
+	factory_reset=true
+fi
+if mountpoint -q "$tmp_mount"; then
+	umount "$tmp_mount"
+fi
+if [ "${factory_reset}" = "true" ]; then
+	log_begin_msg "Factory Reset"
+	for target in ${target_devices}; do
+		target_mnt="$(findmnt "${target}")"
+		if [ -z "$target_mnt" ]; then
+			if ! mount -t "$(get_fstype "${target}")" \
+		 		"${marker_storage_device}" \
+		 		"${tmp_mount}"; then
+				panic "Can't mount ${target}!"
+			fi
+			target_mnt="$tmp_mount"
+		fi
+
+		# delete all files in the target mount point
+		find "${target_mnt}" ! -wholename "${target_mnt}" \
+			! -name "lost+found" -exec rm -rf {} +
+
+		if mountpoint -q "$tmp_mount"; then
+			umount "$tmp_mount"
+		fi
+	done
+	log_end_msg "Factory Reset"
+fi
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
new file mode 100644
index 0000000..6dfd896
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-data-reset-hook_0.1.bb
@@ -0,0 +1,36 @@
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
+SRC_URI += " \
+    file://local-bottom-complete.tmpl"
+
+DESCRIPTION = "Delete the content of the given Devices"
+
+# if this file exists execute a factory reset for the given
+# list of factory-reset targets.
+INITRAMFS_DATA_RESET_MARKER ?= "/.data-reset"
+
+# use labels as crypt setup replaces the label links if
+# an partition is encrypted
+INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
+
+# list of partitions by label
+INITRAMFS_DATA_RESET_DEVICES ??= "/dev/disk/by-label/var"
+
+TEMPLATE_FILES += "local-bottom-complete.tmpl"
+TEMPLATE_VARS += " INITRAMFS_DATA_RESET_MARKER \
+                   INITRAMFS_DATA_RESET_MARKER_STORAGE_DEVICE \
+                   INITRAMFS_DATA_RESET_DEVICES"
+
+DEBIAN_DEPENDS .= ", coreutils, util-linux"
+
+HOOK_ADD_MODULES = "factory-reset"
+HOOK_COPY_EXECS = "mountpoint findmnt mktemp rm find"
-- 
2.47.0


