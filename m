Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F60DC7EE30
	for <webhook@archiver.kernel.org>; Fri, 24 Feb 2023 16:28:41 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.22335.1677256117721168577
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Feb 2023 08:28:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=LOLlWKx6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2023022416283594341068cc56250848-aidl6r@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023022416283594341068cc56250848
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Feb 2023 17:28:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=HyFnQelvr7Es0a9yqm5fjkjXr9znD++K0Qw1zVvNBHE=;
 b=LOLlWKx6PKT/p0i5OsoznvbyqH2sxbnPEmFynGThOZ6DXOzjJpkSR2CIKOIsJgFH2Jmtjo
 vBPO+DC3Sdh/ilQ9z35c8MBkOIz559rGLccVu726oz04ZwZAIerW92Pg5slMsvsiJMHCvPH8
 3e7T1TYygA/ok9Od6MLkec6Zq3tWQ=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	christian.storm@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 6/8] overlay: add prerequisite 'encrypt_partition'
Date: Fri, 24 Feb 2023 17:28:30 +0100
Message-Id: <20230224162832.327030-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
References: <20230224162832.327030-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Feb 2023 16:28:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10819

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If /var shall be encrypted encrypt_partition needs to be executed
before the overlay script.

If the prerequisite is not available the overlay script will be executed.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-overlay-hook/files/overlay.hook        |  1 +
 .../initramfs-overlay-hook/files/overlay.script.tmpl | 12 +++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
index 5bec258..bc6a682 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
@@ -23,4 +23,5 @@ esac
 . /usr/share/initramfs-tools/hook-functions
 
 manual_add_modules overlay
+copy_exec /usr/bin/grep
 copy_exec /usr/bin/awk
diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index 87ec72f..9739197 100644
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
+if ! grep -q "${rootmnt}/${ovl_partition_label}" /proc/mounts ; then
+	if ! mount -t $(get_fstype /dev/disk/by-label/${ovl_partition_label}) \
+		 /dev/disk/by-label/${ovl_partition_label} \
+		 ${rootmnt}/${ovl_partition_label}; then
+		panic "Can't mount /${ovl_partition_label} partition - overlay will not work!"
+	fi
 fi
 
 for ovl_lower_dir in ${ovl_lower_dirs}; do
-- 
2.39.1


