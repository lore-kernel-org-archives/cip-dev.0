Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8E9C677F1
	for <webhook@archiver.kernel.org>; Tue, 17 Jan 2023 13:16:04 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.195729.1673961354948210789
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jan 2023 05:15:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=SMi4Xfhx;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20230117131551dbff47c15afc394d9b-14onwo@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20230117131551dbff47c15afc394d9b
        for <cip-dev@lists.cip-project.org>;
        Tue, 17 Jan 2023 14:15:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=WaAavweRGy3BNdAjN3a3JNnWfesMZhntPyBr1IMPRcw=;
 b=SMi4XfhxNcSykcbiOysLX9gdkzGRg0wOcimOVlvxnSJE8J+nVFDtL2XDB/Ot/d/7AdpIkr
 jHelgU++Aq5yNjmK/l28M2X3I0D9DJmKdGLO5jMOtXdATYpieGyKjfSHY+lSY/shTwOlb/Dj
 hEOe+l45uIREGJZQMktZ25Q/gGwLs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3] Create a generic initramfs overlay
Date: Tue, 17 Jan 2023 14:15:50 +0100
Message-Id: <20230117131550.249530-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jan 2023 13:16:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10373

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows the user to generate multible overlays in a given
location.

The configuration used the following variables:
 - INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL: Label of the partition to store the overlays
 - INITRAMFS_OVERLAY_PATHS: space separated list of overlay directories (lower overlay directories)
 - INITRAMFS_OVERLAY_STORAGE_PATH: path on the storage partition where the upper directory is stored

The script tries to mount the top directory of INITRAMFS_OVERLAY_STORAGE_PATH. If the mount fails
the boot is aborted.

e.g.:
```
INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
INITRAMFS_OVERLAY_PATHS ??= "/etc /usr/share/foo /usr/share/bar/foo"
INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
```
1. This will mount the partition labeled var to /var
2. This will create  the following overlays:

```
overlay on /etc type overlay (rw,relatime,lowerdir=/root/etc,upperdir=/root/var/local/etc,workdir=/root/var/local/.etc-atomic)
overlay on /usr/share/foo type overlay (rw,relatime,lowerdir=/root/usr/share/foo,upperdir=/root/var/local/usr/share/foo,workdir=/root/var/local/.usr_share_foo-atomic)
overlay on /usr/share/bar/foo type overlay (rw,relatime,lowerdir=/root/usr/share/bar/foo,upperdir=/root/var/local/usr/share/bar/foo,workdir=/root/var/local/.usr_share_bar_foo-atomic)
```

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - INITRAMFS_OVERLAY_STORAGE_PATH contains the full path
 - updated copyright
 - formatting
 - fix typos in commit message

Changes v3:
 - add awk to generate a unique wordir name from the full overlay path
 - allow absolute paths in INITRAMFS_OVERLAY_PATHS
 - ensure that subpath, e.g. `/usr/share/bar/foo` are possible in INITRAMFS_OVERLAY_PATHS
 - adapt commit message

Should we split mounting /var in a seperate hook with a build time dependency and only check if 
INITRAMFS_OVERLAY_STORAGE_PATH is writable instead of adding the mount logic directly?

 .../cip-core-initramfs/cip-core-initramfs.bb  |  4 +-
 .../files/etc-overlay.script                  | 36 -----------
 .../initramfs-etc-overlay-hook_0.1.bb         | 30 ----------
 .../files/overlay.hook}                       |  1 +
 .../files/overlay.script.tmpl                 | 60 +++++++++++++++++++
 .../initramfs-overlay-hook_0.1.bb             | 40 +++++++++++++
 6 files changed, 103 insertions(+), 68 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
 delete mode 100644 recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
 rename recipes-initramfs/{initramfs-etc-overlay-hook/files/etc-overlay.hook => initramfs-overlay-hook/files/overlay.hook} (92%)
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
 create mode 100644 recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb

diff --git a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
index 9e0ee26..2935ed8 100644
--- a/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
+++ b/recipes-initramfs/cip-core-initramfs/cip-core-initramfs.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021 - 2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -12,5 +12,5 @@
 inherit initramfs
 
 INITRAMFS_INSTALL += " \
-    initramfs-etc-overlay-hook \
+    initramfs-overlay-hook \
     "
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script b/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
deleted file mode 100644
index 6e5aacd..0000000
--- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.script
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-
-PREREQ=""
-
-prereqs()
-{
-	echo "$PREREQ"
-}
-
-case $1 in
-# get pre-requisites
-prereqs)
-	prereqs
-	exit 0
-	;;
-esac
-
-. /scripts/functions
-
-if ! mount -t $(get_fstype /dev/disk/by-label/var) /dev/disk/by-label/var ${rootmnt}/var; then
-	panic "Can't mount /var partition - overlay will not work!"
-fi
-
-mkdir -p ${rootmnt}/var/local/etc
-mkdir -p ${rootmnt}/var/local/.atomic
-if ! mount -t overlay -o lowerdir=${rootmnt}/etc,upperdir=${rootmnt}/var/local/etc,workdir=${rootmnt}/var/local/.atomic overlay ${rootmnt}/etc; then
-	panic "Can't mount overlay!"
-fi
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
deleted file mode 100644
index 37a04ec..0000000
--- a/recipes-initramfs/initramfs-etc-overlay-hook/initramfs-etc-overlay-hook_0.1.bb
+++ /dev/null
@@ -1,30 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-inherit dpkg-raw
-
-SRC_URI += " \
-    file://etc-overlay.hook \
-    file://etc-overlay.script \
-    "
-
-DEBIAN_DEPENDS = "initramfs-tools"
-
-do_install[cleandirs] += " \
-    ${D}/usr/share/initramfs-tools/hooks \
-    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
-
-do_install() {
-    install -m 0755 "${WORKDIR}/etc-overlay.hook" \
-        "${D}/usr/share/initramfs-tools/hooks/etc-overlay"
-    install -m 0755 "${WORKDIR}/etc-overlay.script" \
-        "${D}/usr/share/initramfs-tools/scripts/local-bottom/etc-overlay"
-}
diff --git a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
similarity index 92%
rename from recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
rename to recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index bfaa7b6..5bec258 100644
--- a/recipes-initramfs/initramfs-etc-overlay-hook/files/etc-overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -23,3 +23,4 @@ esac
 . /usr/share/initramfs-tools/hook-functions
 
 manual_add_modules overlay
+copy_exec /usr/bin/awk
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
new file mode 100644
index 0000000..9cbe537
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -0,0 +1,60 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022-2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+
+PREREQ=""
+
+prereqs()
+{
+	echo "$PREREQ"
+}
+
+case $1 in
+# get pre-requisites
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+. /scripts/functions
+
+
+ovl_partition_label="${INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL}"
+ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
+ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
+
+root_mount_storage=${rootmnt}${ovl_storage_path}
+
+if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
+	/dev/disk/by-label/${ovl_partition_label} \
+	${rootmnt}/${ovl_partition_label}; then
+	panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
+fi
+
+for ovl_lower_dir in ${ovl_lower_dirs}; do
+	# remove the first '/' and replace all '/' with '_'
+	# on variable $ovl_lower_dir
+	work_dir_name=$(awk -v var=$ovl_lower_dir \
+		'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
+
+	lower_dir=${rootmnt}${ovl_lower_dir}
+	upper_dir=${root_mount_storage}${ovl_lower_dir}
+	work_dir=${root_mount_storage}/.${work_dir_name}-atomic
+
+	mkdir -p ${upper_dir}
+	mkdir -p ${work_dir}
+
+	if ! mount -t overlay \
+		-o lowerdir=${lower_dir},upperdir=${upper_dir},workdir=${work_dir} \
+		overlay ${lower_dir}; then
+		panic "Can't mount overlay for '$ovl_lower_dir' !"
+	fi
+done
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
new file mode 100644
index 0000000..78831ba
--- /dev/null
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -0,0 +1,40 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022 - 2023
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+SRC_URI += " \
+    file://overlay.hook \
+    file://overlay.script.tmpl \
+    "
+
+INITRAMFS_OVERLAY_PATHS ??= "/etc"
+INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
+INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL ??= "var"
+
+TEMPLATE_FILES = "overlay.script.tmpl"
+TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
+    INITRAMFS_OVERLAY_PATHS \
+    INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL"
+
+DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+
+do_install() {
+    install -m 0755 "${WORKDIR}/overlay.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/overlay"
+    install -m 0755 "${WORKDIR}/overlay.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-bottom/overlay"
+}
-- 
2.39.0


