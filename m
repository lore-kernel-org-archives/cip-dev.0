Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F2C2BA1A
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 10:52:29 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.70035.1718967138791673165
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 03:52:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=v0RwCLol;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-2024062110521619d7484e61e4045710-hx52tv@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2024062110521619d7484e61e4045710
        for <cip-dev@lists.cip-project.org>;
        Fri, 21 Jun 2024 12:52:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=qQ29ErfXW2yr1XLpmVTVOZNabjM1cOFpzjUnDXXfyTE=;
 b=v0RwCLolnmQB1ejlH6B6jA1KGjC+bbGRrtDejuTKS0r6hvROa60jUT2T3GtRBwIwg9aT9B
 sSCUtgvX1jhxd95krwKXBj111gScagMe4cTxk+8e8CrUr1/Lal2TT9Xb1IEQQZsqUjyq3rCr
 cFSv1cGj5zxBem7bp7/bacJkDxfwg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 2/2] encryption: assume broken_system_clock for e2fsck before resize
Date: Fri, 21 Jun 2024 12:12:29 +0200
Message-ID: <20240621105215.2233044-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
References: <20240621105215.2233044-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 10:52:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16311

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Some embedded system have no battery and default to some time to
avoid an fsck error do to a superblock in the future.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.script    | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
index c319540..ff4c135 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
@@ -72,7 +72,12 @@ reencrypt_existing_partition() {
 	case $partition_fstype in
 	ext*)
 		# reduce the filesystem and partition by 32M to fit the LUKS header
-		e2fsck -f "$1"
+		export E2FSCK_CONFIG=/tmp/e2fsck.conf
+		cat > "$E2FSCK_CONFIG" << EOF
+[options]
+	broken_system_clock=true
+EOF
+		e2fsck -p -f "$1"
 		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 			panic "reencryption of filesystem $1 cannot continue!"
 		fi
-- 
2.43.0


