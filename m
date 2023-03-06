Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789BCC6FD1D
	for <webhook@archiver.kernel.org>; Mon,  6 Mar 2023 12:39:34 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.32036.1678106372691492448
 for <cip-dev@lists.cip-project.org>;
 Mon, 06 Mar 2023 04:39:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qNnaSr+c;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20230306123929812435ba8fd57b57cc-b3pyqx@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20230306123929812435ba8fd57b57cc
        for <cip-dev@lists.cip-project.org>;
        Mon, 06 Mar 2023 13:39:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=3dMvYUVMOid6+jVVUtJrj++qcM6+J+sP39Go8KpCH4c=;
 b=qNnaSr+c1sQk2hJ6t9vsmF4Nw8689LPiyHYgvJjyyc8bBUcOsJt6B0YCSsTWGoIMzxXtMi
 ulDCl4UcJfWe9Zj26Bxvgbgn53FZHfhEyJD6iTgz3P+iaQxCdakQ/JHVZzlX9JMuzi1RerFw
 jEihP6PkiOYaXkuu9HEgkJdnZ/uCk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 5/7] overlay: add prerequisite 'encrypt_partition'
Date: Mon,  6 Mar 2023 13:39:24 +0100
Message-Id: <20230306123926.243471-6-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Mar 2023 12:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10943

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If /var shall be encrypted encrypt_partition needs to be executed
before the overlay script.

If the prerequisite is not available the overlay script will be executed.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.hook        |  1 +
 .../initramfs-overlay-hook/files/overlay.script.tmpl | 12 +++++++-----
 .../initramfs-overlay-hook_0.1.bb                    |  2 +-
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index 5bec258..8b00ecf 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -23,4 +23,5 @@ esac
 . /usr/share/initramfs-tools/hook-functions
 
 manual_add_modules overlay
+copy_exec /usr/bin/mountpoint
 copy_exec /usr/bin/awk
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 87ec72f..71d2599 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -9,7 +9,7 @@
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
 #
 
-PREREQ=""
+PREREQ="encrypt_partition"
 
 prereqs()
 {
@@ -33,10 +33,12 @@ ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
 
-if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
-	   /dev/disk/by-label/${ovl_partition_label} \
-	   ${rootmnt}/${ovl_partition_label}; then
-	panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
+if ! mountpoint -q "${rootmnt}/${ovl_partition_label}"; then
+	if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
+		 /dev/disk/by-label/${ovl_partition_label} \
+		 ${rootmnt}/${ovl_partition_label}; then
+		panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
+	fi
 fi
 
 for ovl_lower_dir in ${ovl_lower_dirs}; do
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
index 78831ba..566bd15 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -26,7 +26,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
     INITRAMFS_OVERLAY_PATHS \
     INITRAMFS_OVERLAY_STORAGE_PARTITION_LABEL"
 
-DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils"
+DEBIAN_DEPENDS = "initramfs-tools, awk, coreutils, util-linux"
 
 do_install[cleandirs] += " \
     ${D}/usr/share/initramfs-tools/hooks \
-- 
2.39.2


