Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30369C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:10:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.208759.1724069449876206202
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:10:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Xxm5y/wY;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2024081912104671eabc0a87a7bd58fc-bv6i2t@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2024081912104671eabc0a87a7bd58fc
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Aug 2024 14:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=uKxTqm4w0XZfVIgD+8MYhCdgiQC128p9SiNfyfguo8w=;
 b=Xxm5y/wYuaJ1nn1zCoDa3r1uf2JjgVkx8lFw0+fRjQEj7M5JphbcdqjYu2C50Od0+XiTs+
 +GgqFjvHPAAzYYLIoV6mDxwTag/aB+gbPC9gWfb4kvv+H0d4QgHV2bTJtc8suE8DWrdAhJzR
 X+Oqagc8LNqBfKsWr7Mfkyn45cnQgvvCFsOkprLqBJkOicHHXDwGF/ARFiZivh+U5I842RHb
 L0mzHLQb8vVOs826jTVsgVEJzUSnFKcXZOcxPceUFUq/ofy2tjGa0reZbah15YFI239b86y8
 Qd3hwA7nVNZQUe75d/mDyg/UPtiHFD5s5ZhPAI3rw+N4QX3liyKYtXHg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	Sai.Sathujoda@toshiba-tsip.com,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC] fix: Check return code value of e2fsck
Date: Mon, 19 Aug 2024 14:09:14 +0200
Message-ID: <20240819121045.1533891-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:10:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16799

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the overlay script in case of a recoverable file system error.
In that case we execute the erronously the recouvery script and mke2fs
ask if the filesystem should be overwritten.

The issue was introduced with:

8644fb1 initramfs-overlay-hook: Check file system of INITRAMFS_OVERLAY_STORAGE_DEVICE

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
This fixes the issue but we need to address the problem in case of a
return code of 2 which requires a reboot of the system. Should we:
1. panic
2. silently reboot
3. execute the user defined recovery action (add the return value as a
  additional argument)
4. do nothing
In my testing i used 4.

Also should we force mke2fs?

 .../initramfs-overlay-hook/files/overlay.script.tmpl   | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
index c655a4f..02df53d 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/overlay.script.tmpl
@@ -40,7 +40,15 @@ partition_fstype=$(get_fstype "${ovl_partition_device}")
 if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 	case $partition_fstype in
 	ext*)
-		if ! e2fsck -p -f "$ovl_partition_device" && [ -x "$ovl_recovery_script" ]; then
+		e2fsck -p -f "$ovl_partition_device"
+		fsck_ret="$?"
+		# e2fsck returns 1 in case ofrepairing the file system or a 2 in case
+		# a reboot is required.
+		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
+		if [ "$fsck_ret" -gt "1" ]; then
+			# TODO should we force are reboot or customer action
+			panic "fsck requires a reboot"
+		elif [ "$fsck_ret" -gt "2" ]  && [ -x "$ovl_recovery_script" ]; then
 			"$ovl_recovery_script" "$partition_fstype" "$ovl_partition_device"
 		fi
 		;;
-- 
2.43.0


