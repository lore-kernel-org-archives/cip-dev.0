Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800BCCD12A6
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:51 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.135723.1712668002569467528
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=QQNYBTyN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-202404091306408e863898d6339c58f5-b3ep_v@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202404091306408e863898d6339c58f5
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=84SeeW0dOuA/Z5FRWvQNGIgk9yS0VOW6y0EvgysVAdo=;
 b=QQNYBTyNkSAJ5g9g2f3JncfSYDJXFUzLLtThEeHoOZQdodbErzjkh33asqefgdVTiFYZlx
 EIWIM2lLNH3+SMOXtf/KzoCLZ2RdMIjyOlX61KScmMA/LEi11LdmD7yDs+g8ajo3mOBhDa27
 6VHfnEyGVz6G8erxO/eBkWUryfnN8=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 06/15] initramfs-crypt-hook: add e2fsck to avoid resize error
Date: Tue,  9 Apr 2024 15:05:23 +0200
Message-ID: <20240409130638.559398-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15521

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


