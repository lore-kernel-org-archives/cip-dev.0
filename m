Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4D2C021A7
	for <webhook@archiver.kernel.org>; Mon, 17 Feb 2025 10:02:09 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.47997.1739786523022256239
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Feb 2025 02:02:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=Cguej/ka;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1326448-20250217100159d641ee7092d0918821-lt_glm@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20250217100159d641ee7092d0918821
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Feb 2025 11:01:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=RCIqP8Up/owplNTah+TBhxNDo1QImgBaDC3nrnkA9SY=;
 b=Cguej/ka2TvoKTsygHurKolu/N0CQ+Kzr2pGMSHmFbaMx2jnDZtKGap73FfQ7kZjv/Tbiu
 Iaj7Kiu0AvOyS+9Z01fKWxehZBDV/TF+nXxBihJXoSa2hxMX8xPoty+DV9/qBk3pT8hE/DZI
 M5KqZyD0K8aT8Ao40GUw6leUC6NgVam6CuxA20EHG0kJZjP9bmyVo8RBn1tVhDktz50QKHFS
 fGDQPioZmVlLKyVT0VUsGcHd1jXwdtE7KBYuUgD80hp6j/T2XZsqwErPypw/vXJjx0Oqgbr/
 4PkOIZJWR1OVNp/0MF8GKe3L4XhKduzPnfbjHeCxS8jssw4vOnWIm++A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 2/3] Fix return value handling on filesystem check
Date: Mon, 17 Feb 2025 11:00:23 +0100
Message-ID: <20250217100024.42995-3-alexander.heinisch@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17857

From: Alexander Heinisch <alexander.heinisch@siemens.com>

Detected errors during the filesystem check caused the script to
abort. This is caused by the `set -e` in the script-header.tmpl
in isar/meta/recipes-initramfs/initramfs-hook/files/script-header.tmpl

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 .../initramfs-overlay-hook/files/local-bottom.tmpl           | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
index 1087c3f..71cc63c 100644
--- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
+++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
@@ -23,8 +23,9 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
 
 	case $partition_fstype in
 	ext*)
-		e2fsck -p -f "$ovl_partition_device"
-		fsck_ret="$?"
+		fsck_ret=0
+		e2fsck -p -f "$ovl_partition_device" || fsck_ret="$?"
+
 		# e2fsck returns a 1 in case of repairing the file system
 		# https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE
 		if [ "$fsck_ret" -gt "1" ]  && [ -x "$ovl_recovery_script" ]; then
-- 
2.39.5


