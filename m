Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA369C35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 14:29:15 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.45100.1702909751576819729
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Dec 2023 06:29:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=qPaIhMS2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-2023121814290894e653e4849231ad7b-4apew5@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023121814290894e653e4849231ad7b
        for <cip-dev@lists.cip-project.org>;
        Mon, 18 Dec 2023 15:29:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=IHP8scI6e9dI+kYU2s4IqP7IcysVie6kDzQGmxKqpoQ=;
 b=qPaIhMS2ga1X9AXFNopVbLbWQB09GmKl1yWvhvhkok7gxCfDdxzyE7CAlcV7508NooS0Jd
 lV9FutuUCj0+XxpRcpi+hF8geAYn36JlRnOoInc5k3wif6IUvTOQqp2cQ5L0X72frHv557Cj
 keqdUdIlHlT424g2b7LDSw0Aj3BpE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] initramfs-overlay-hook: Get Storage mount point from INITRAMFS_OVERLAY_STORAGE_PATH
Date: Mon, 18 Dec 2023 15:28:48 +0100
Message-ID: <20231218142906.1507050-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Dec 2023 14:29:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14131

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to set the overlay storage  to another root directory. For example
to `/overlays` instead of `/var`.

This restores a similar behaviour as from before:
725dbc99cf9c4956fe7eb04d3932423782b7ce57.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
Changes v2:
 - Change wording in commit message
 - Add comments to the recipe variables

 .../initramfs-overlay-hook/files/overlay.script.tmpl      | 7 ++++---
 .../initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb  | 8 ++++++++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index d7da6fb..a321490 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -32,12 +32,13 @@ ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
 ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
 
 root_mount_storage=${rootmnt}${ovl_storage_path}
+storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
 
-if ! mountpoint -q "${rootmnt}/var"; then
+if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 	if ! mount -t $(get_fstype ${ovl_partition_device}) \
 		 ${ovl_partition_device} \
-		 ${rootmnt}/var; then
-		panic "Can't mount /var partition - overlay will not work!"
+		 ${rootmnt}${storage_mount_point}; then
+		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
 	fi
 fi
 
diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
index 9e78dc8..e8651af 100644
--- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
+++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.1.bb
@@ -17,8 +17,16 @@ SRC_URI += " \
     file://overlay.script.tmpl \
     "
 
+# The variable INITRAMFS_OVERLAY_PATHS contains the directories which are
+# overlayed(lower dir).
 INITRAMFS_OVERLAY_PATHS ??= "/etc"
+
+# The variable INITRAMFS_OVERLAY_STORAGE_PATH designates the path were the
+# changes to the overlayed directory are stored(upper dir).  The initramfs
+# also mounts the first directory after root to the
+# INITRAMFS_OVERLAY_STORAGE_DEVICE.
 INITRAMFS_OVERLAY_STORAGE_PATH ??= "/var/local"
+
 # override this to switch to UUID or PARTUUID based mounts
 INITRAMFS_OVERLAY_STORAGE_DEVICE ??= "/dev/disk/by-label/var"
 
-- 
2.43.0


