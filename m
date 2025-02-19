Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F8C021AA
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 16:13:44 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.26254.1739981615204700847
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2025 08:13:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=Dg7IC5s6;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202502191613328dfef27b1353ecc511-mcwbxc@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202502191613328dfef27b1353ecc511
        for <cip-dev@lists.cip-project.org>;
        Wed, 19 Feb 2025 17:13:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=gm3MNVw9t3QsrjXhUmWO9nC2cj+xvUESVs/wfe5mjgQ=;
 b=Dg7IC5s6v1iJbSSGD2O7mwumG5MrfV3q9aiy8E9zEofU+nK5wzY8v0jnysmm2cmDubYvuV
 vILKmJS5+F576NWHY+KhwVyS6++2fR6bT2JWMx67CX+P9hOq4YKc3eZCrjj3to0QV+J7zYhY
 Ripr/lPWbTsZ4Wlp83uudVp4DBJC4XMqDkGvY9QXmn0fzgcBomNoHKkGDvyzQABet3lNzFZK
 JA6gExq/phKQAvq/vJL/NUMFr5c/HwEPxsgcwGuL3SxR+bHt5jD+Xw3X/bBAeGTAEInvb3zn
 WVIUppI4WsfZJDoGbcRg1oydTJENTEQlOp0SoC4mRGkIlM4TVyAeYBFA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] crypt: remove e2fsck.config option system_broken_clock
Date: Wed, 19 Feb 2025 17:13:08 +0100
Message-ID: <20250219161331.1669565-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2025 16:13:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17868

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

In case of enabling disk encryption after the first boot( e.g. enabling
encryption after a firmware update) setting
the option `system_broken_clock` to true will lead to a panic in
the initrd as resize2fs will fail with the message:

```
+ resize2fs /dev/sda6 1330380K
resize2fs 1.47.0 (5-Feb-2023)
Please run 'e2fsck -f /dev/sda6' first
```

resize2fs checks if the time stamp of the last mount is before the
last check. The e2fsck option `-p`(prune) repairs this mismatch on
systems with a unbuffered system clock.

If the encryption occurs during first boot, mount timestamp is not set,
the system boots.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---

was: crypt: do not assume that all system clocks are broken
Changes v2:
 - drop setting the e2fsck option instead optional enabling.

 .../initramfs-crypt-hook/files/local-top-complete            | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 54b8a6e..5ef7ca4 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -75,11 +75,6 @@ reencrypt_existing_partition() {
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
-		export E2FSCK_CONFIG=/tmp/e2fsck.conf
-		cat > "$E2FSCK_CONFIG" << EOF
-[options]
-	broken_system_clock=true
-EOF
 		e2fsck -p -f "$1"
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"
-- 
2.47.0


