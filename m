Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB2BC8302D
	for <webhook@archiver.kernel.org>; Mon, 30 Jun 2025 18:15:42 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.48073.1751307331284490973
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jun 2025 11:15:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=NFg4y1RK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-20250630181526da6a829fad3ecbc50b-2e69v2@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20250630181526da6a829fad3ecbc50b
        for <cip-dev@lists.cip-project.org>;
        Mon, 30 Jun 2025 20:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hmD5BFaN1vkiTkLPSmOdaO4c20+rZtRH6JkMzJeQqFc=;
 b=NFg4y1RKLP5AHz5xpNhjxh5R2MXoR52WFQfd497HNXGcsSZFNGk+Sn/BKj0KxVbgKtUydD
 7sU/d94Cg2vVTdUQ48qGaRwr8K01pqxK+qrRCrLs5V2lVIXLuJY5slRHGM7EzaX6EDR4+j6E
 xskBPcR2eXfNwZOM6AlpDoluDTa8cV8Ss6e2VTrx5/tV8MTW9hoKmrwlc4DmrIs5qzmvIEE5
 WEi2V/69nAZ4qEaZ1gzflvHhfl04Y9lSctrlGDwVCxvjioXO2nyQ54JskA6rqIMUgUryYOec
 +vvx96/rhMwJUxbMzDzwwPCHxPIhmZRvYPYRTDWi4vcfMr4AiI59DwYw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	felix.moessbauer@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][RFC 1/7] initramfs: Split handling of persistence mount and overlay setup.
Date: Mon, 30 Jun 2025 20:15:10 +0200
Message-Id: <20250630181516.1718712-2-alexander.heinisch@siemens.com>
In-Reply-To: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jun 2025 18:15:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19258

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
 .../files/local-bottom.tmpl                   | 31 +------------
 .../initramfs-overlay-hook_0.4.bb             | 42 ++++++++++++++++++
 .../files/local-bottom.tmpl                   | 43 +++++++++++++++++++
 .../files/persistence_recovery_action.script} |  4 +-
 .../initramfs-persistence-hook_0.1.bb}        | 29 +++++++------
 6 files changed, 105 insertions(+), 45 deletions(-)
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
 create mode 100644 recipes-initramfs/initramfs-persistent-storage/files/local-bottom.tmpl
 rename recipes-initramfs/{initramfs-overlay-hook/files/overlay_recovery_action.script => initramfs-persistent-storage/files/persistence_recovery_action.script} (64%)
 rename recipes-initramfs/{initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb => initramfs-persistent-storage/initramfs-persistence-hook_0.1.bb} (57%)

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 0e4cf74..12797d3 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -15,4 +15,5 @@ INITRAMFS_INSTALL += " \
     initramfs-overlay-hook \
     "
 
+INITRAMFS_INSTALL:append = " initramfs-persistence-hook"
 INITRAMFS_INSTALL:append:encrypt-partitions = " initramfs-crypt-hook"
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 71cc63c..31937e0 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -1,45 +1,18 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2024
+# Copyright (c) Siemens AG, 2022-2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
 #
 
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
-storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
-
-if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
-	ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
-	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
-	ovl_recovery_script="/scripts/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
-
-	partition_fstype=$(get_fstype "${ovl_partition_device}")
-
-	case $partition_fstype in
-	ext*)
-		fsck_ret=0
-		e2fsck -p -f "$ovl_partition_device" || fsck_ret="$?"
-
-		# e2fsck returns a 1 in case of repairing the file system
-		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
-		if [ "$fsck_ret" -gt "1" ]  && [ -x "$ovl_recovery_script" ]; then
-			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
-		fi
-		;;
-	esac
-	if ! mount -t ${partition_fstype} \
-		 -o ${ovl_mount_option} \
-		 ${ovl_partition_device} \
-		 ${rootmnt}${storage_mount_point}; then
-		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
-	fi
-fi
 
 for ovl_lower_dir in ${ovl_lower_dirs}; do
 	# remove the first '/' and replace all '/' with '_'
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
new file mode 100644
index 0000000..5ccc20c
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.4.bb
@@ -0,0 +1,42 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022 - 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-initramfs/initramfs-hook/hook.inc
+
+SRC_URI += " \
+    file://local-bottom.tmpl \
+    "
+
+# The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
+# overlayed(lower dir).
+INITRAMFS_OVERLAY_PATHS ??= "/etc"
+
+# The variable INITRAMFS_OVERLAY_STORAGE_PATH designates the path were the
+# changes to the overlayed directory are stored (upper dir). The initramfs
+# hook also mounts the first directory after root to
+# INITRAMFS_OVERLAY_STORAGE_DEVICE if it is not mounted yet.
+INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
+
+TEMPLATE_FILES += "local-bottom.tmpl"
+TEMPLATE_VARS += " \
+    INITRAMFS_OVERLAY_STORAGE_PATH \
+    INITRAMFS_OVERLAY_PATHS \
+    "
+
+DEPENDS += "initramfs-persistence-hook"
+DEBIAN_DEPENDS .= ", initramfs-persistence-hook, awk, coreutils, util-linux"
+
+HOOK_ADD_MODULES = "overlay"
+HOOK_COPY_EXECS = "awk"
+
+SCRIPT_PREREQ="persistence"
diff --git a/recipes-initramfs/initramfs-persistent-storage/files/local-bottom.tmpl b/recipes-initramfs/initramfs-persistent-storage/files/local-bottom.tmpl
new file mode 100644
index 0000000..dd655ea
--- /dev/null
+++ b/recipes-initramfs/initramfs-persistent-storage/files/local-bottom.tmpl
@@ -0,0 +1,43 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
+#
+
+pers_storage_path="${INITRAMFS_PERSISTENCE_STORAGE_PATH}"
+
+storage_mount_point="$(echo "${pers_storage_path}" | awk -F/ '{print FS$2}' )"
+
+if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
+	pers_partition_device="${INITRAMFS_PERSISTENCE_STORAGE_DEVICE}"
+	pers_mount_option="${INITRAMFS_PERSISTENCE_MOUNT_OPTION}"
+	pers_recovery_script="/scripts/${INITRAMFS_PERSISTENCE_RECOVERY_SCRIPT}"
+
+	partition_fstype=$(get_fstype "${pers_partition_device}")
+
+	case $partition_fstype in
+	ext*)
+		fsck_ret=0
+		e2fsck -p -f "$pers_partition_device" || fsck_ret="$?"
+
+		# e2fsck returns a 1 in case of repairing the file system
+		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
+		if [ "$fsck_ret" -gt "1" ]  && [ -x "$pers_recovery_script" ]; then
+			"$pers_recovery_script" "$partition_fstype" "$pers_partition_device"
+		fi
+		;;
+	esac
+	if ! mount -t ${partition_fstype} \
+		 -o ${pers_mount_option} \
+		 ${pers_partition_device} \
+		 ${rootmnt}${storage_mount_point}; then
+		panic "Can't mount ${storage_mount_point} partition - persistence will not work!"
+	fi
+fi
+
+exit 0
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script b/recipes-initramfs/initramfs-persistent-storage/files/persistence_recovery_action.script
similarity index 64%
rename from recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
rename to recipes-initramfs/initramfs-persistent-storage/files/persistence_recovery_action.script
index 0cd084b..afe3605 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay_recovery_action.script
+++ b/recipes-initramfs/initramfs-persistent-storage/files/persistence_recovery_action.script
@@ -9,6 +9,6 @@
 #
 
 partition_fstype="$1"
-ovl_partition_device="$2"
+partition_device="$2"
 
-mke2fs -q -FF -t "$partition_fstype" "$ovl_partition_device"
+mke2fs -q -FF -t "$partition_fstype" "$partition_device"
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-persistent-storage/initramfs-persistence-hook_0.1.bb
similarity index 57%
rename from recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
rename to recipes-initramfs/initramfs-persistent-storage/initramfs-persistence-hook_0.1.bb
index a5b39d9..44ee9e1 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-persistent-storage/initramfs-persistence-hook_0.1.bb
@@ -1,55 +1,56 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022 - 2024
+# Copyright (c) Siemens AG, 2022 - 2025
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
 #
 # SPDX-License-Identifier: MIT
 #
 
 require recipes-initramfs/initramfs-hook/hook.inc
 
-INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "overlay_recovery_action.script"
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??= "persistence_recovery_action.script"
+INITRAMFS_PERSISTENCE_RECOVERY_SCRIPT ??= "${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}"
 
 SRC_URI += " \
     file://local-bottom.tmpl \
-    file://${INITRAMFS_OVERLAY_RECOVERY_SCRIPT} \
+    file://${INITRAMFS_PERSISTENCE_RECOVERY_SCRIPT} \
     "
 
-# The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
-# overlayed(lower dir).
-INITRAMFS_OVERLAY_PATHS ??= "/etc"
-
 # The variable INITRAMFS_OVERLAY_STORAGE_PATH designates the path were the
 # changes to the overlayed directory are stored (upper dir). The initramfs
 # hook also mounts the first directory after root to
 # INITRAMFS_OVERLAY_STORAGE_DEVICE if it is not mounted yet.
 INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
+INITRAMFS_PERSISTENCE_STORAGE_PATH ??="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 
 # override this to switch to UUID or PARTUUID based mounts
 INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
+INITRAMFS_PERSISTENCE_STORAGE_DEVICE ??= "${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 
 # options to use for mounting INITRAMFS_OVERLAY_STORAGE_DEVICE
 INITRAMFS_OVERLAY_MOUNT_OPTION ??= "defaults,nodev,nosuid,noexec"
+INITRAMFS_PERSISTENCE_MOUNT_OPTION ??= "${INITRAMFS_OVERLAY_MOUNT_OPTION}"
 
 TEMPLATE_FILES += "local-bottom.tmpl"
-TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
-    INITRAMFS_OVERLAY_PATHS \
-    INITRAMFS_OVERLAY_STORAGE_DEVICE \
-    INITRAMFS_OVERLAY_MOUNT_OPTION \
-    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
+TEMPLATE_VARS += " \
+    INITRAMFS_PERSISTENCE_STORAGE_PATH \
+    INITRAMFS_PERSISTENCE_STORAGE_DEVICE \
+    INITRAMFS_PERSISTENCE_MOUNT_OPTION \
+    INITRAMFS_PERSISTENCE_RECOVERY_SCRIPT"
 
 DEBIAN_DEPENDS .= ", awk, coreutils, util-linux, e2fsprogs"
 
-HOOK_ADD_MODULES = "overlay"
+HOOK_ADD_MODULES = ""
 HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
 
 SCRIPT_PREREQ="crypt"
 
 do_install:append() {
-    install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
+    install -m 0755 "${WORKDIR}/${INITRAMFS_PERSISTENCE_RECOVERY_SCRIPT}" \
         "${D}/usr/share/initramfs-tools/scripts"
 }
-- 
2.39.5


