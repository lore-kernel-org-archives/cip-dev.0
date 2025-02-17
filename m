Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F29C021A0
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 10:02:09 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.47998.1739786523469296793
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 02:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=VdKbOsEt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1326448-202502171002019b6423dd4d0f0fa528-irruny@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202502171002019b6423dd4d0f0fa528
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Feb 2025 11:02:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=FvjxpwLPhC60O8dKmOG+L+5bumSSXTE8X05clI2YVvQ=;
 b=VdKbOsEtnicOYqZJzGC7bgbOdsrMQzDUSuknCk/dCuzhYXJiFSApe1vuXA5JG/mLdynHbl
 ySezNBVPQxn4DVBcJcHVnCl2+64xHTFody+MywLWb/Hgp3abEjHiYn+7ijbauWHM4FhccQbe
 WX4mbOeFNZYeCaAmETXT3fUFR4sr/7Ifze8FiEBh2HTcCgFg+5fawkU14OfnfgKKjwHYU/Vw
 wmVnzf/COfxynkEvBjzEBt8Dd9JzTeAXToLtO8ILvlYg9TTWZe4Ayp9ILxoxJiW5uVMhWDn5
 tYssBGl83Ui1NAWtnhMtfzkm1Nt+n7NeB8jB3tjKEQO7QZ6xgaqkJP9Q==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 3/3] Added support for rootfs-overlay.
Date: Mon, 17 Feb 2025 11:00:24 +0100
Message-ID: <20250217100024.42995-4-alexander.heinisch@siemens.com>
In-Reply-To: <20250217100024.42995-1-alexander.heinisch@siemens.com>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1326448:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Feb 2025 10:02:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17858

From: Alexander Heinisch <alexander.heinisch@siemens.com>

In addition to the overlays for e.g. /etc we now support persistent
overlays for rootfs as well.
To enable this behaviour you can either set INITRAMFS_OVERLAY_PATHS = "/"
or extend your existing config INITRAMFS_OVERLAY_PATHS = "/ /etc"

This helps when developing or debugging an existing image, while
still maintaining being as close to the prod image as possible.
That way all image features like swupdate / verity / aso. remain
intact with the sole exeception of having the possibility to
work on a rw rootfs.
Bare in mind while this comes in handy for debugging or developing
new features, such feature has to be used with care. e.g. when
updating the rootfs, overwritten files from the overlay could
potentially cause unexpected results!

Compared to typical overlays we have to move the storage device used
for persistence off the previous rootfs. Otherwise, the recursion in
the overlay setup would cause panics when finally switching root.
In addition to that we move all mountpoints setup prior to overlaying
to the new overlayed root.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../files/local-bottom.tmpl                   | 92 +++++++++++++++++--
 .../initramfs-overlay-hook_0.3.bb             |  2 +-
 2 files changed, 83 insertions(+), 11 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 71cc63c..a17e4a4 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -6,14 +6,19 @@
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#  Alexander Heinisch <alexander.heinisch@siemens.com>
 #
 
 ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
 
-root_mount_storage=${rootmnt}${ovl_storage_path}
+root_mount_storage=${ovl_storage_path}
 storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
 
+# Setup mountpoint for persistent storage
+# Either, it already got setup by a previous initramfs script,
+# then we have to move it from $rootmnt to $storage_mount_point or it has not
+# been setup yet, then check it and mount it under $storage_mount_point
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 	ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
 	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
@@ -21,6 +26,8 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 
 	partition_fstype=$(get_fstype "${ovl_partition_device}")
 
+	# FS checks should be moved to a separate hook / or at least initramfs lib
+	# so generic functionality can be reused here!
 	case $partition_fstype in
 	ext*)
 		fsck_ret=0
@@ -33,32 +40,97 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 		fi
 		;;
 	esac
+
+	# Mount overlay device to initramfs - will be moved to rootfs at the end
+	[ "$debug" = "y" ] && echo "Mount overlay device to initramfs - will be moved to rootfs at the end"
 	if ! mount -t ${partition_fstype} \
 		 -o ${ovl_mount_option} \
 		 ${ovl_partition_device} \
-		 ${rootmnt}${storage_mount_point}; then
+		 ${storage_mount_point}; then
 		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
 	fi
+else
+	# If the storage device is already mounted on the final rootfs
+	# move it to the initramfs. Otherwise, we cannot move back the
+	# storage mount to the resulting rootfs in the end.
+
+	[ "$debug" = "y" ] && echo "Move ${rootmnt}${storage_mount_point} to ${storage_mount_point}"
+	mount -n -o move ${rootmnt}${storage_mount_point} ${storage_mount_point}
 fi
 
+[ "$debug" = "y" ] && echo "Iterate overlay mount spec..."
+
 for ovl_lower_dir in ${ovl_lower_dirs}; do
-	# remove the first '/' and replace all '/' with '_'
-	# on variable $ovl_lower_dir
-	work_dir_name=$(awk -v var=$ovl_lower_dir \
-		'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
+	root_moved=false
+
+	if [ $ovl_lower_dir != "/" ]; then
+		log_begin_msg "Mounting overlay $ovl_lower_dir"
+
+		# remove the first '/' and replace all '/' with '_'
+		# on variable $ovl_lower_dir
+		work_dir_name=$(awk -v var=$ovl_lower_dir \
+			'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
+
+		lower_dir=${rootmnt}${ovl_lower_dir}
+		upper_dir=${root_mount_storage}${ovl_lower_dir}
+		work_dir=${root_mount_storage}/.${work_dir_name}-atomic
+		mount_dir=${lower_dir}
+	else
+		log_begin_msg "Mounting root overlay"
+
+		# When overlaying root we need to move the mountpoint
+		# from ${rootmnt} to a dedicated mountpoint inside
+		# the storage dir to prevent a "recursion" within
+		# ${lowerdir} and the final mountpoint of the overlay: ${rootmnt}
+		# While this is not a limitation of overlay itself
+		# such "recursion" leaves the mountpoint for lower-dir (the ro-rootfs)
+		# outside the tree of new root which panics when switching root
+
+		# create lower dir to move ro-rootfs to
+		lower_dir=${root_mount_storage}/lower-root
+		mkdir -p ${lower_dir}
+
+		# make the readonly root available
+		mount -n -o move ${rootmnt} ${lower_dir}
+		root_moved=true
 
-	lower_dir=${rootmnt}${ovl_lower_dir}
-	upper_dir=${root_mount_storage}${ovl_lower_dir}
-	work_dir=${root_mount_storage}/.${work_dir_name}-atomic
+		upper_dir=${root_mount_storage}/root
+		work_dir=${root_mount_storage}/.root-atomic
+
+		mount_dir=${rootmnt}
+	fi
 
 	mkdir -p ${upper_dir}
 	mkdir -p ${work_dir}
 
+	[ "$debug" = "y" ] && echo "Setup overlay L:${lower_dir} + U:${upper_dir} -> ${mount_dir}"
 	if ! mount -t overlay \
 		   -o lowerdir=${lower_dir},upperdir=${upper_dir},workdir=${work_dir} \
-		   overlay ${lower_dir}; then
+		   overlay ${mount_dir}; then
 		panic "Can't mount overlay for '$ovl_lower_dir' !"
 	fi
+
+	if ${root_moved}; then
+		# Loop over all mountpoints already setup before we established the root overlay
+		# and move them to the resulting overlayed rootfs
+		[ "$debug" = "y" ] && echo "Move all mountpoints already setup before we established the root overlay..."
+		cat /proc/mounts | grep "${root_mount_storage}/lower-root/" | awk '{print $2}' | \
+			while read -r old_mountpoint
+			do
+				new_mountpoint="${rootmnt}/${old_mountpoint#${root_mount_storage}/lower-root/}"
+
+				[ "$debug" = "y" ] && echo "Move ${old_mountpoint} to ${new_mountpoint}"
+				mount -n -o move ${old_mountpoint} ${new_mountpoint}
+			done
+	fi
+
+	log_end_msg
 done
 
+# Finally, move the overlay workdir from initramfs to the final rootfs
+[ "$debug" = "y" ] && echo "Move ${storage_mount_point} to ${rootmnt}${storage_mount_point}"
+mount -n -o move ${storage_mount_point} ${rootmnt}${storage_mount_point}
+
+log_success_msg "Overlays setup successfully"
+
 exit 0
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
index ec7f85b..af610e5 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
@@ -45,7 +45,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
 DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
 
 HOOK_ADD_MODULES = "overlay"
-HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
+HOOK_COPY_EXECS = "mkdir mountpoint awk e2fsck mke2fs grep"
 
 SCRIPT_PREREQ="crypt"
 
-- 
2.39.5


