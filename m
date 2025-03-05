Return-Path: <ch@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7CEC19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 12:00:32 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.11600.1741176027158394964
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Mar 2025 04:00:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=eoOqhr0L;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: ch@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A9C610381917;
	Wed,  5 Mar 2025 13:00:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1741176025; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0GlwVKv11gA9qDnee0LQP54AxnuVIYBEB4M4WRqYeQI=;
	b=eoOqhr0LCcWgrd94qNVTc0T93LvP6Qk7rvLwMlIkmlZPB3XHwKBzUa/lDwwh3E4JJFjl+G
	R9DIXrKB9WWtXjC4pqr5u9MlUL1GBgYlw4M9JsIAe5bKyLB8U3NU4/6gVxrV5Oy1kBq22b
	/5dpV47WGGqrDw75J9gdjMHJ7Pjv8/RSNkqcLhLbjcpm12v71cYhEuxPhtOdEyt/r1bwh/
	wPnv1ONKtlvzZu35PePYIlp9UkgGIvvCU/LJ4t46sNrrSXz+Kcx4Op3P6MQCdWq0C88tdN
	VfAVBJImOQVc2idVnUfQ0iqLbO5Y0dhWvu7YoUGWsDv3OpJ00ELhoBUZKjoeUw==
From: Claudius Heine <ch@denx.de>
Date: Wed, 05 Mar 2025 13:00:19 +0100
Subject: [PATCH v4 1/5] initramfs-crypt-hook: make sure that mount path
 exists
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-initramfs-crypt-hook-patches-2-v4-1-4170912e5261@denx.de>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
In-Reply-To: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>, 
 Quirin Gylstorff <quirin.gylstorff@siemens.com>, 
 Claudius Heine <ch@denx.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Mar 2025 12:00:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18042

Wherever or not the mount directory (and their parents) gets created
seem to be inconsistent; mentioning a missing mount point in the
`/etc/fstab` might cause the boot to fail, while using systemd `.mount`
units will just create the mount point.

Wic creates missing mount points that where mentioned in the `.wks`
file; so moving from such a setup to letting `initramfs-crypt-hook`
mount the file system at boot inside the ramdisk, the mount would
suddenly fail.

Therefore creating the mount point for your, if it doesn't exists seem to
provide a smoother transition.

Signed-off-by: Claudius Heine <ch@denx.de>
---
 recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
index b991cb49fbdfdc4b2ffc81c1424fb3c695a973cd..80553d1cd8ccde7a6cc9b324c6e5faba8d8f3579 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
@@ -41,6 +41,7 @@ mount_partition() {
 	partition_mountpoint=$2
 	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
 	if ! mountpoint -q "${partition_mountpoint}"; then
+		mkdir -p "${partition_mountpoint}"
 		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
 			 "${partition_mountpoint}"; then
 			panic "Can't mount partition '${partition_dev_path}'!"

-- 
2.47.2


