Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F98C87FD3
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:00:50 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.60292.1753963248825635949
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:00:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=gMVkWwGC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202507311200449c4cae2c5e3166a8bf-yqpguq@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202507311200449c4cae2c5e3166a8bf
        for <cip-dev@lists.cip-project.org>;
        Thu, 31 Jul 2025 14:00:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=L/MXSFqQu7eo+YyssZnV0r2BUvCekfF5slhbGGxHRLQ=;
 b=gMVkWwGCOBoZBWyYibubw2paTlU0F9kvmoZgsoBrEiBRWOD58gNccLtTCKJU8VGV+A3kvT
 FauIbAVsACt60TvLLD7FRsHGmCbX1kU3ryDIYhQmxEN6rXzKLyeuXXL5U1IUNDSVBXlNceXg
 BwqFA8kd6qL+7vtzeL17Cayu9nPL+whUPjnd01mc/2KOehB0EVrdPf/tVSduqiBpz59ojkQm
 VpiZsWzg19IKwNqSarlsry2nR3QO4iM+7+x+KBFr8AHYtp4oXruJxqOnT2plPj7GmT/ysDhO
 i+2ohQdOzqgVN9UenDsewjEYZ2AakN9df2XFziZGHoNs/1EBxKfWnqQg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	gokhan.cetin@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/7] add factory-reset initramfs hook
Date: Thu, 31 Jul 2025 13:58:42 +0200
Message-ID: <20250731120043.333345-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:00:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19645

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
 .../files/detect-marker-file                  | 14 +++++
 .../initramfs-factory-reset-hook/files/hook   |  7 +++
 .../files/local-top                           | 53 +++++++++++++++++++
 .../files/reset-env.tmpl                      |  2 +
 .../initramfs-factory-reset-hook_0.1.bb       | 46 ++++++++++++++++
 5 files changed, 122 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file b/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
new file mode 100644
index 0000000..d757b3e
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
@@ -0,0 +1,14 @@
+#!/bin/sh
+# Copyright (C) Siemens AG, 2025
+#
+# SPDX-License-Identifier: MIT
+#
+# This implementation check for the a existing file to trigger a
+# factory reset. Prints 'true' in case the marker was found
+
+check_for_factory_reset() {
+	if /usr/sbin/get-factory-reset.sh | grep -q "factory-reset"; then
+		echo "true"
+	fi
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
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/local-top b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
new file mode 100644
index 0000000..f84b9c4
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/local-top
@@ -0,0 +1,53 @@
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
index 0000000..127aaad
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
@@ -0,0 +1,2 @@
+INITRAMFS_FACTORY_RESET_DEVICES="${INITRAMFS_FACTORY_RESET_DEVICES}"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE="${INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE}"
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
new file mode 100644
index 0000000..5f19a50
--- /dev/null
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
@@ -0,0 +1,46 @@
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
+# list of partitions by label
+INITRAMFS_FACTORY_RESET_DEVICES ??= "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??= "ext4"
+SRC_URI += " \
+    file://reset-env.tmpl \
+    file://local-top \
+    file://${FACTORY_RESET_DETECT_MARKER} \
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
+    install -m 0755 "${WORKDIR}/${FACTORY_RESET_DETECT_MARKER}" \
+        "${D}/usr/share/factory-reset/factory_reset_marker"
+}
-- 
2.50.1


