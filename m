Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CEEC61DD2
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:11 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15251.1787757661250031676
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=AAXstILX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20260826152059b84da1ea4f00020749-u2xa3q@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260826152059b84da1ea4f00020749
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=R9pu1VuQwMcccV1pxQ39viL7cbXPQGmwwoMK/qnOwYg=;
 b=AAXstILXCZOyUDoN9qm4ZNJjQSGTj/rLiwOx++fMd4m/jgpVQ9nv33saSorWDQ+cSpn+AU
 z6th3odlLXP0vvP1O+i3TMp85IuYCXY695ix2mJ757jXO0LgAUFhM8OtLddCTkYAnCDartmq
 KHdj9/LN9+puyYJYJOs+PLQ3CJyAH9W0eeR9eHvnzsIeF8Im0boWSJ3KNTBMiXwwZyHHwpFJ
 zZwB22DhEXGh4m5Il4FjVwxtOODIml///Fij9waza2EN6DJy3bfUQPby7nqMO5mcXKdbzeGX
 5VgyFYWCZg3v5EhAy36OGAGArjx2ChRyo7Ha2L+ZpkCKOxW7tIV1WrsQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 7/7] initramfs-crypt-hook: Prevent encryption without secure boot
Date: Wed, 26 Aug 2026 17:20:55 +0200
Message-ID: <564072d29671d6f838279fb41785f802762e8426.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24026

From: Jan Kiszka <jan.kiszka@siemens.com>

We so far allowed to run first-boot encryption in any secure boot state.
This remained unnoticed because the QEMU x86 machine was started with
certificates provisioned, and the QEMU arm64 machine did not support
measured boot. The latter is fixed now, and we also deploy certs during
first boot now if they aren't pre-deployed. Time to raise the bar and
reject generally insecure states.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../initramfs-crypt-hook/files/local-top-complete             | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
index 7bc08e55..3312e632 100755
--- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
+++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
@@ -297,6 +297,10 @@ for partition_set in $partition_sets; do
 		continue
 	fi
 
+	if ! secure_boot_enabled; then
+		panic "Secure boot disabled! Must be enabled to ensure correct key sealing."
+	fi
+
 	# check if we are trying to mount root, set ROOT to decrypted partition:
 	if [ "$partition_mountpoint" = "/" ]; then
 		echo "ROOT=$decrypted_part" >/conf/param.conf
-- 
2.47.3


