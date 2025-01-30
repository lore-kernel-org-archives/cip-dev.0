Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF341C02190
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:39:28 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.12046.1738229960994990639
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:39:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=aV4U58uE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-2025013009391850fe69ba3998d02edd-_v722h@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025013009391850fe69ba3998d02edd
        for <cip-dev@lists.cip-project.org>;
        Thu, 30 Jan 2025 10:39:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=CbAEtq8IlQeiviEuVLbDphUu0wXUUOQTceXbOiI7Q9w=;
 b=aV4U58uEan0+NncmeIBkJ6PcA9iEqd86cfSdtYYMLxx3ar1Xt7DLoJGmnVyp1FRJ3pA/BJ
 nBhTbY6ziRBsBCEF50EFdIxfXaaQU2JYbFqVKsr1lAS8lOY1S1/W0SiDMTy/2zYVaxYtoT0+
 j/YMXJt8UMwZeqrOkg8Xo53sYVUjb0cNCzWY56Zl1VqKvTVLUIQ85BNvdSDGRO7EGaT8oS5U
 vY88qP7DZ1dUbUzfRbf7dN6oCpBMzKBhd8MEblVstNZ6PdNQdLemCFq+6QjERRgHvWOrFaYq
 fOxSh0c49EaWYWUDmNUZRmB9yBKdUavTDs5H9/m8pnV2xje7msj3Zh9Q==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Christian Storm <christian.storm@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][RFC][PATCH 03/10] initramfs: Add hook for managing /var in A/B fashion
Date: Thu, 30 Jan 2025 10:39:10 +0100
Message-ID: <37b9560989414bfd128bfe7e1d5afec53a148179.1738229957.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1738229957.git.jan.kiszka@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:39:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17699

From: Jan Kiszka <jan.kiszka@siemens.com>

This hook manages snapshots of the filesystem backing /var in an A/B
way, aligned with rootfs instances. That means when an new version is
first booted in testing mode (EFI Boot Guard ustate=2), a snapshot of
the current version is taken before that snapshot is mounted as /var.
On rollback, the previous version will still be available and will be
used again. After committing a new version, garbage collection of the
previous snapshot is happening on next boot.

This first version of the hook is written around EFI Boot Guard as A/B
boot manager and btrfs as mechanism (here in form of a filesystem) to
create and manage snapshots with low overhead. Other implementations
are imaginable and would only require small refactorings to enable them
as configurable alternatives.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/local-bottom.tmpl                   | 86 +++++++++++++++++++
 .../initramfs-abvar-hook_0.1.bb               | 31 +++++++
 2 files changed, 117 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
 create mode 100644 recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
new file mode 100644
index 00000000..91b8d017
--- /dev/null
+++ b/recipes-initramfs/initramfs-abvar-hook/files/local-bottom.tmpl
@@ -0,0 +1,86 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+
+var_device="${INITRAMFS_VAR_DEVICE}"
+var_opts="${INITRAMFS_VAR_MOUNT_OPTIONS}"
+btrfs_mnt="/.var-btrfs"
+snap_prefix="abvar-"
+
+. "${rootmnt}/etc/os-release"
+
+get_default_subvolume()
+{
+	subvol=$(btrfs subvolume get-default "$1" | grep path || true)
+	echo "${subvol##*path }"
+}
+
+ustate_val=$(bg_printenv -c -r -o ustate)
+
+# when in testing state or on first boot, create new snapshot
+if [ "$ustate_val" = "USTATE=2" ] ||
+    ! mount -t btrfs -o "$var_opts,subvol=/$snap_prefix$IMAGE_UUID" \
+	"$var_device" "${rootmnt}/var" 2>/dev/null; then
+	log_begin_msg "Creating new /var snapshot for image $IMAGE_UUID"
+
+	mkdir "$btrfs_mnt"
+	mount -t btrfs -o subvol=/ "$var_device" "$btrfs_mnt"
+
+	# delete any dangling previous snapshot
+	btrfs subvolume delete "$btrfs_mnt/$snap_prefix$IMAGE_UUID" \
+		2>/dev/null || true
+
+	default_subvol=$(get_default_subvolume "$btrfs_mnt")
+	btrfs subvolume snapshot "$btrfs_mnt/$default_subvol" \
+		"$btrfs_mnt/$snap_prefix$IMAGE_UUID"
+
+	umount "$btrfs_mnt"
+	rmdir "$btrfs_mnt"
+
+	log_end_msg
+
+	mount -t btrfs -o "$var_opts,subvol=/$snap_prefix$IMAGE_UUID" \
+		"$var_device" "${rootmnt}/var"
+else
+	default_subvol=$(get_default_subvolume "${rootmnt}/var")
+fi
+
+active_entry=$(btrfs subvolume list -a "${rootmnt}/var" |
+	grep "<FS_TREE>/$snap_prefix$IMAGE_UUID")
+active_id="${active_entry#ID }"
+active_id="${active_id%% *}"
+
+# adjust default subvolume to the active one
+if [ "$default_subvol" != "$snap_prefix$IMAGE_UUID" ]; then
+	log_begin_msg "Adjusting /var subvolume default to $IMAGE_UUID"
+	btrfs subvolume set-default "$active_id" "${rootmnt}/var"
+	log_end_msg
+fi
+
+if [ "$(bg_printenv -c -r -o ustate)" != "USTATE=0" ]; then
+	# still testing the current version, skip cleanup
+	exit 0
+fi
+
+# get rid of obsolete snapshots, ie. everything but the active one
+log_begin_msg "Performing /var snapshot housekeeping"
+
+IFS="
+"
+for entry in $(btrfs subvolume list -aqu "${rootmnt}/var" |
+		grep "<FS_TREE>/$snap_prefix"); do
+	entry_id="${entry#ID }"
+	entry_id="${entry_id%% *}"
+
+	if [ "$entry_id" != "$active_id" ]; then
+		btrfs subvolume delete -i "$entry_id" "${rootmnt}/var"
+	fi
+done
+unset IFS
+
+log_end_msg
diff --git a/recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb b/recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
new file mode 100644
index 00000000..c7b58243
--- /dev/null
+++ b/recipes-initramfs/initramfs-abvar-hook/initramfs-abvar-hook_0.1.bb
@@ -0,0 +1,31 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+require recipes-initramfs/initramfs-hook/hook.inc
+
+SRC_URI += " \
+    file://local-bottom.tmpl"
+
+# override this to switch to UUID or PARTUUID based mounts
+INITRAMFS_VAR_DEVICE ??= "/dev/disk/by-label/var"
+
+INITRAMFS_VAR_MOUNT_OPTIONS ??= "defaults,nodev,nosuid,noexec"
+
+TEMPLATE_FILES += "local-bottom.tmpl"
+TEMPLATE_VARS += "\
+    INITRAMFS_VAR_DEVICE \
+    INITRAMFS_VAR_MOUNT_OPTIONS"
+
+HOOK_ADD_MODULES = "btrfs"
+HOOK_COPY_EXECS = "btrfs grep rmdir bg_printenv"
+
+DEBIAN_DEPENDS .= ", btrfs-progs, efibootguard"
+
+SCRIPT_PREREQ = "crypt"
-- 
2.43.0


