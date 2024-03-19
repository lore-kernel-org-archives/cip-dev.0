Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C46CD11BF
	for <webhook@archiver.kernel.org>; Tue, 19 Mar 2024 18:20:41 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.23524.1710872431292357602
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Mar 2024 11:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=nT64cg2P;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202403191820299c7c2bf8bf1c3c2c75-_trxn2@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202403191820299c7c2bf8bf1c3c2c75
        for <cip-dev@lists.cip-project.org>;
        Tue, 19 Mar 2024 19:20:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=05BhD/qINPIeOPskabF8QakDCUtkBq5OSKpeAoOiVNE=;
 b=nT64cg2PYl4K+EiPfo2SaMaQJPU+NABb1FRAkZCBh6b5MPu8GX0u09BtFNvmYy4waGqano
 auut0dYELR5E00Q1qiBJhCuP4fERQMUmXJY8I+vv/n4lmCWjl39mAOx8Zh8czxd18nSg017A
 r3cb0+FVWV+jPSc5PW5PtiFYAg9yU=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][RFC 6/8] initramfs-crypt-hook: add e2fsck to avoid resize error
Date: Tue, 19 Mar 2024 19:18:30 +0100
Message-ID: <20240319182026.1571362-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
References: <20240319182026.1571362-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Mar 2024 18:20:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15368

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This avoids the following error during resizing a file system:

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../initramfs-crypt-hook/files/encrypt_partition.clevis.script   | 1 +
 .../initramfs-crypt-hook/files/encrypt_partition.systemd.script  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.script
index 6e2713f..0bb6720 100644
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
index 2e6691a..9809c87 100644
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


