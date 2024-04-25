Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B6EC25B5F
	for <webhook@archiver.kernel.org>; Thu, 25 Apr 2024 11:51:30 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web11.14903.1714045884215057899
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Apr 2024 04:51:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Vgu0v4ep;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-202404251151211dfdf544ad6c702515-lryuce@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202404251151211dfdf544ad6c702515
        for <cip-dev@lists.cip-project.org>;
        Thu, 25 Apr 2024 13:51:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=uqit3BLEeDuEB4mr1mO8T+mdkR0/0w4koXdXGP2Gw3w=;
 b=Vgu0v4epq4j2SBTZLzqMjqnBQh2qHZ7bzuxyDAIkrit1O1hZQtXDynQAErtdOa4Lb43TTU
 cR5AlW9V/YvU352evzEYMHu9uRhunUBhH3+x24tEE52qo3ulzxNpPRFSzx1itWMIW8cfqlWR
 JzWZyIDdAM9yd0M5zDhtu6XeJraB8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 3/9] initramfs-crypt: Only resize partition if ext* formatted
Date: Thu, 25 Apr 2024 13:50:31 +0200
Message-ID: <20240425115119.813384-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
References: <20240425115119.813384-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Apr 2024 11:51:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15753

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

squashfs or empty partition cannot be resized with resize2fs.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/encrypt_partition.script            | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index 8f6cbf6..51c81f3 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -64,14 +64,26 @@ service_watchdog() {
 reencrypt_existing_partition() {
 	part_size_blocks="$(cat /sys/class/block/"$(awk -v dev="$1" 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)"
 	# reduce the filesystem and partition by 32M to fit the LUKS header
+	partition_fstype=$(get_fstype "${1}")
 	reduce_device_size=32768
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
-	e2fsck -f "$1"
-	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
-		panic "reencryption of filesystem $1 cannot continue!"
-	fi
+	case $partition_fstype in
+	ext*)
+		# reduce the filesystem and partition by 32M to fit the LUKS header
+		e2fsck -f "$1"
+		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
+			panic "reencryption of filesystem $1 cannot continue!"
+		fi
+		;;
+	squashfs|"")
+		echo "skip disk resize as it not support or unnecessary for fstype: '$partition_fstype'"
+		;;
+	*)
+		panic "cannot resize parition. unsupport fstype: $partition_fstype"
+		;;
+	esac
 	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
 		/usr/sbin/cryptsetup-reencrypt --new --reduce-device-size "$reduce_device_size"k "$1" < "$2"
 	else
-- 
2.43.0


