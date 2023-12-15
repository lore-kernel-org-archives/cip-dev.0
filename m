Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D804C4167B
	for <webhook@archiver.kernel.org>; Fri, 15 Dec 2023 19:55:36 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.73994.1702670130680750415
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Dec 2023 11:55:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=We65utnM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2023121519552713103db1299ec92b85-k8qlvz@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023121519552713103db1299ec92b85
        for <cip-dev@lists.cip-project.org>;
        Fri, 15 Dec 2023 20:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=7kMFFav7ak93IeQux2NDi2rxXwOyxRL+4jrHrIPPE54=;
 b=We65utnM8ns5aN4z2QWIlILBmh3myL3b+R5JlIAlbYa17AU87OeraAPKafZgCtXettgCSS
 mz8iPRjl+jac1Owno+tt2z1POKm6p/uZiKw0KWslJbjRnsKRmW4RS2b8zmgABKMYfYyGb7XP
 5Go9jlZ0WJqNMJpleoYEQlEhMsrLU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] initramfs-overlay-hook: Get Storage mount point from INITRAMFS_OVERLAY_STORAGE_PATH
Date: Fri, 15 Dec 2023 20:54:50 +0100
Message-ID: <20231215195526.1117565-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Dec 2023 19:55:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14128

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to set the overlay storage to another root directory for
example to store the overlay is /overlays.

This restores a similar behaviour as from before: 725dbc99cf9c4956fe7eb04d3932423782b7ce57.


Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.script.tmpl      | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index d7da6fb..e9a5e40 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -1,4 +1,5 @@
 #!/bin/sh
+# vim: ft=sh
 #
 # CIP Core, generic profile
 #
@@ -32,12 +33,13 @@ ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
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
 
-- 
2.43.0


