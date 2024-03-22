Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329E6CD1287
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:20 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.9596.1711101969632521602
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=RqoidbVe;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-20240322100607dcbc138bf5c0e29ba6-dejlsa@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20240322100607dcbc138bf5c0e29ba6
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=84SeeW0dOuA/Z5FRWvQNGIgk9yS0VOW6y0EvgysVAdo=;
 b=RqoidbVe7a5xEh8Ye5VCy1JrXwCdt2GkBg6/HFsfVgNmpMZ4mjFFtebDv9cqFHEE/069OX
 jPEWmZ6qOLlXfXAwtzOkYPY7D2hYXrFzJ/BWX661LZ3QZmiJWuSAdMpUhaompWPxv62GpZkg
 QsBfKPcpaqP++ko7qLxm4rVqtAaZY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 06/13] initramfs-crypt-hook: add e2fsck to avoid resize error
Date: Fri, 22 Mar 2024 11:05:16 +0100
Message-ID: <20240322100605.4129226-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15401

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids the following error during resizing a file system:
`Please run ‘e2fsck -f /dev/<disk>’ first`

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.script   | 1 +
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index e0fcbf4..22caa46 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
@@ -81,6 +81,7 @@ reencrypt_existing_partition() {
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
+	e2fsck -f "$1"
 	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 		panic "reencryption of filesystem $1 cannot continue!"
 	fi
diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 48ce999..85b4fbc 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -94,6 +94,7 @@ reencrypt_existing_partition() {
 	reduced_size="$(expr "$part_size_blocks" - 65536 )"
 	reduced_size_in_byte="$(expr "$reduced_size" \* 512)"
 	reduced_size_in_kb="$(expr "$reduced_size_in_byte" / 1024)K"
+	e2fsck -f "$1"
 	if ! resize2fs "$1" "${reduced_size_in_kb}"; then
 		panic "reencryption of filesystem $1 cannot continue!"
 	fi
-- 
2.43.0


