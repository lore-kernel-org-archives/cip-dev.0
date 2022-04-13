Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08927C352B6
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:07 +0000 (UTC)
Received: from mta-64-227.flowmailer.net (mta-64-227.flowmailer.net
 [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web12.3486.1649834200902452012
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Apr 2022 00:16:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=g3mBjTh2;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-294854-2022041307164201b1df86640b4d8324-pixonj@rts-flowmailer.siemens.com)
Received: by mta-64-227.flowmailer.net with ESMTPSA id
 2022041307164201b1df86640b4d8324
        for <cip-dev@lists.cip-project.org>;
        Wed, 13 Apr 2022 09:16:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=cv9NeKNXiaWE1LNXo2zWOhF9f96vfPGiUI528SMfhps=;
 b=g3mBjTh2d2hECDcFpLnx9kvdgYlk2jmfmisbG7ib7R2EF/QQJuqU8mfcXtvro3x0LoAiEr
 vkAqIoHVyW87X1irEyLB8mVBYzv2h7+vWbumoFYT2ziSi8nosc+qMCtkhvaKZQXpDoXS5EhK
 nyuNgsAg8gP7RYGDigrkZ/iKs52/s=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH 14/19] swupdate: Switch to
 bootenv_rrmap+kernelfile for device selection
Date: Wed, 13 Apr 2022 09:16:31 +0200
Message-Id: 
 <8c6b9776be2e54190b101bd63f12cc22e5d5feaf.1649834193.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1649834193.git.jan.kiszka@siemens.com>
References: <cover.1649834193.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Apr 2022 15:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8067

From: Jan Kiszka <jan.kiszka@siemens.com>

This allows for a medium-independent sw-description. Not required so far
for QEMU, but it may become useful in the future or for downstream
layers, at least as reference.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/images/files/sw-description.tmpl             | 4 ++--
 .../files/swupdate.handler.efibootguard.ini               | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index 7dd67f9..f5cafeb 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -14,7 +14,7 @@ software =
     name = "cip software update";
     images: ({
             filename = "${ROOTFS_PARTITION_NAME}";
-            device = "sda4,sda5";
+            device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
             type = "roundrobin";
             compressed = "zlib";
             filesystem = "ext4";
@@ -26,7 +26,7 @@ software =
             filename = "linux.efi";
             path = "linux.efi";
             type = "roundrobin";
-            device = "sda4->BOOT0,sda5->BOOT1";
+            device = "C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1";
             filesystem = "vfat";
             properties: {
                         subtype = "kernel";
diff --git a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
index b5e8070..58271da 100644
--- a/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
+++ b/recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.efibootguard.ini
@@ -2,15 +2,15 @@
 chainhandler=raw
 
 [image.selector]
-method=getroot_rr
-key=root
+method=bootenv_rrmap
+key=kernelfile
 
 [kernel]
 chainhandler=rawfile
 
 [kernel.selector]
-method=getroot_rrmap
-key=root
+method=bootenv_rrmap
+key=kernelfile
 
 [kernel.bootenv]
 kernelfile=C:BOOT${rrindex}:linux.efi
-- 
2.34.1


