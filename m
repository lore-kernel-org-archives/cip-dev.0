Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9832FC61DA4
	for <webhook@archiver.kernel.org>; Thu, 16 Feb 2023 03:37:06 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.2521.1676518621485032881
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Feb 2023 19:37:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Wmvivqux;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-72506-202302160336584ef060ebf1cd9f4340-11ao5_@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202302160336584ef060ebf1cd9f4340
        for <cip-dev@lists.cip-project.org>;
        Thu, 16 Feb 2023 04:36:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=fnzizk7RTE8eUPDNDXV4vJ87+HoZfi8uHrcABnKubN8=;
 b=WmvivquxS0iroUzrqST8/G6DtNlI1wYyXgRSlHd7Quxcw2urq/7QkPjz83Fvf7ppTzZpw2
 L4iNB9Cg9Xl78cHwOmILed/ZgbvgRzZywYL4MQtZNVCkkW0e7p0bxch/pXCyxEjnR4LIJpP+
 +DueZ+PqfU/sy6XL+4QpsZg2LYpcc=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: adriaan.schmidt@siemens.com,
	jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v5 1/8] register image classes via layer.conf
Date: Thu, 16 Feb 2023 03:35:37 +0000
Message-Id: <20230216033544.1990604-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230216033544.1990604-1-felix.moessbauer@siemens.com>
References: <20230216033544.1990604-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Feb 2023 03:37:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10702

This patch registers the provided image classes via the bblayer.conf
file. By that, no manual additions of these classes via kas is required
and erronous implementations are detected early (e.g. mandatory inputs
without defaults).

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 conf/layer.conf                      | 2 ++
 doc/README.secureboot.md             | 1 -
 kas/opt/ebg-secure-boot-snakeoil.yml | 1 -
 kas/opt/swupdate.yml                 | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index 0c5fd39..2c888b2 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -22,3 +22,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
 
 LAYERDIR_cip-core = "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
+
+IMAGE_CLASSES += "squashfs verity swupdate"
diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 50562e1..b15ea93 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -151,7 +151,6 @@ header:
 
 local_conf_header:
   secure-boot-image: |
-    IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
     INITRAMFS_INSTALL:append = " initramfs-verity-hook"
diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
index a182a67..9a28453 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -16,7 +16,6 @@ header:
 
 local_conf_header:
   secure-boot-image: |
-    IMAGE_CLASSES += "verity"
     IMAGE_FSTYPES = "wic"
     IMAGE_TYPEDEP:wic += "verity"
     WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index ae5e3a1..7902d82 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -19,7 +19,6 @@ local_conf_header:
     CIP_IMAGE_OPTIONS:append = " swupdate.inc"
 
   wic-swu: |
-    IMAGE_CLASSES += "squashfs"
     IMAGE_TYPEDEP:wic += "squashfs"
     IMAGE_FSTYPES = "wic"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
-- 
2.34.1


