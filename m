Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E474E7070C
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:23:40 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.12715.1695291815849403311
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:23:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=PGCTyCmd;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-294854-20230921102332166ea1ab540ee3ec5b-pxkmz4@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230921102332166ea1ab540ee3ec5b
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Sep 2023 12:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8O1VcCJDKsvfeZXa7FwQVMq4QsZeyOG19NjcVnx0rQY=;
 b=PGCTyCmdFToUDM3AhPF5FD+nsdivJ+xdid5ulsjQdF5pGGweB/lceK0XzB6dIj4NNUDMVt
 +5JR6de+wcyorhDFdmLOA+r8zaPI6mDbmwrhwOQSmFrI6tnaG7q83d8h0J0i5u9VLzNYWqvX
 dqTKU2fLqNllksv+AVSULHfFlao68=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 2/5] linux-cip: Move KERNEL_DEFCONFIG_VERSION into linux-cip-common.inc
Date: Thu, 21 Sep 2023 12:23:28 +0200
Message-Id: <e9ce7b86891f815ec4f1299fc16b28146c74b5ad.1695291811.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1695291811.git.jan.kiszka@siemens.com>
References: <cover.1695291811.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Sep 2023 10:23:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13192

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc                 | 1 +
 recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb | 2 --
 recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb   | 2 --
 recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb  | 2 --
 recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb      | 2 --
 recipes-kernel/linux/linux-cip_4.19.292-cip102.bb         | 2 --
 recipes-kernel/linux/linux-cip_4.4.302-cip79.bb           | 2 --
 recipes-kernel/linux/linux-cip_5.10.191-cip38.bb          | 2 --
 recipes-kernel/linux/linux-cip_6.1.52-cip5.bb             | 2 --
 9 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index 8848581f..5d1b8ac0 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -13,6 +13,7 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
 KERNEL_MAJOR_MINOR = "${@d.getVar('PV').split('.')[0] + '.' + d.getVar('PV').split('.')[1]}"
 
+KERNEL_DEFCONFIG_VERSION ?= "${KERNEL_MAJOR_MINOR}.y-cip"
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
 require recipes-kernel/linux/linux-custom.inc
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
index 23a7fec4..a8e75020 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
@@ -11,6 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
-
 SRC_URI[sha256sum] = "faf282166d669a1d4a044963199804b9cf7272041bf723d62a5162303e443219"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
index 1ebc5b63..478786b8 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
@@ -11,6 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
-
 SRC_URI[sha256sum] = "ef3e1dd8ea1445d3b1321ff158f41a50f5319f81539d17110eab4a1cc2f79fde"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb b/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
index 4ac1b6eb..277c1612 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
@@ -11,6 +11,4 @@
 
 require linux-cip-rt-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
-
 SRC_URI[sha256sum] = "076f4b1019a37fe03aa53ad47e2f530316d2190608200c5c09557b84651797e5"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
index b6f3eabc..5a00b6de 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
@@ -7,6 +7,4 @@
 
 require linux-cip-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
-
 SRC_URI[sha256sum] = "29f926c8755a503baa3e34bb967437e230075c9d9798c22415248983e9f53666"
diff --git a/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
index c6285118..3df4a946 100644
--- a/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
@@ -11,6 +11,4 @@
 
 require linux-cip-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
-
 SRC_URI[sha256sum] = "15e962738fcf4e98189f887c4d80037b04dcaaa227a0aaa6c7447b7367f6dac2"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
index a14259f6..68483c79 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
@@ -11,6 +11,4 @@
 
 require linux-cip-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
-
 SRC_URI[sha256sum] = "cc84633377b3e46e48b25fba7061fdea319a44b541d466221707a014c0136e41"
diff --git a/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
index edd7a958..73008c05 100644
--- a/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
@@ -11,6 +11,4 @@
 
 require linux-cip-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
-
 SRC_URI[sha256sum] = "285dee8d7076fa4ac236167c0be10122f7eac5052e2ec20379fdf5be6452ec79"
diff --git a/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb b/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
index ccc921a0..2f2367b2 100644
--- a/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
@@ -7,6 +7,4 @@
 
 require linux-cip-common.inc
 
-KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
-
 SRC_URI[sha256sum] = "b2271049dface2d9220d185f58d567f593fcd94cd7819ab0e6a3c131c02d97c7"
-- 
2.35.3


