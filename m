Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599E3C433EF
	for <webhook@archiver.kernel.org>; Wed,  8 Dec 2021 11:28:33 +0000 (UTC)
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web09.11098.1638962911705361769
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Dec 2021 03:28:32 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.28, mailfrom: quirin.gylstorff@siemens.com)
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 1B8BSStf028601
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 8 Dec 2021 12:28:29 +0100
Received: from md2dvrtc.fritz.box ([167.87.33.37])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 1B8BSSre014869;
	Wed, 8 Dec 2021 12:28:28 +0100
From: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] sw-description: Use Labels for Boot
 partitions
Date: Wed,  8 Dec 2021 12:28:27 +0100
Message-Id: <20211208112827.3121367-1-Quirin.Gylstorff@siemens.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Dec 2021 11:28:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7074

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows an update process independent from boot order or
file systems, e.g. if a usb stick is plug in.

As SWUpdate returns only the device identifier in case of device mapper
mount point the `sw-description` for secure boot
still use device identifiers.

This also fixes [1].

[1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/16

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/files/secure-boot/sw-description.tmpl | 2 +-
 recipes-core/images/files/sw-description.tmpl             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-core/images/files/secure-boot/sw-description.tmpl b/recipes-core/images/files/secure-boot/sw-description.tmpl
index 34a58a3..f8e5375 100644
--- a/recipes-core/images/files/secure-boot/sw-description.tmpl
+++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
@@ -26,7 +26,7 @@ software =
             filename = "linux.signed.efi";
             path = "linux.signed.efi";
             type = "roundrobin";
-            device = "sda4->sda2,sda5->sda3";
+            device = "sda4->BOOT0,sda5->BOOT1";
             filesystem = "vfat";
             properties: {
                         subtype = "kernel";
diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
index 3309271..c44c2a8 100644
--- a/recipes-core/images/files/sw-description.tmpl
+++ b/recipes-core/images/files/sw-description.tmpl
@@ -26,7 +26,7 @@ software =
             filename = "${KERNEL_IMAGE}";
             path = "vmlinuz";
             type = "roundrobin";
-            device = "fedcba98-7654-3210-cafe-5e0710000001->sda2,fedcba98-7654-3210-cafe-5e0710000002->sda3";
+            device = "fedcba98-7654-3210-cafe-5e0710000001->BOOT0,fedcba98-7654-3210-cafe-5e0710000002->BOOT1";
             filesystem = "vfat";
             properties: {
                         subtype = "kernel";
@@ -36,7 +36,7 @@ software =
             filename = "${INITRD_IMAGE}";
             path = "${INITRD_IMAGE}";
             type = "roundrobin";
-            device = "fedcba98-7654-3210-cafe-5e0710000001->sda2,fedcba98-7654-3210-cafe-5e0710000002->sda3";
+            device = "fedcba98-7654-3210-cafe-5e0710000001->BOOT0,fedcba98-7654-3210-cafe-5e0710000002->BOOT1";
             filesystem = "vfat";
             properties: {
                         subtype = "initrd";
-- 
2.30.2


