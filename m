Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F187E7070E
	for <webhook@archiver.kernel.org>; Thu, 21 Sep 2023 10:23:40 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.12713.1695291815690553360
 for <cip-dev@lists.cip-project.org>;
 Thu, 21 Sep 2023 03:23:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=UVyVlAzo;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-294854-20230921102332caef3cf113cad3af36-qyqacl@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230921102332caef3cf113cad3af36
        for <cip-dev@lists.cip-project.org>;
        Thu, 21 Sep 2023 12:23:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=8gpsc0ExoHy5zfMGdpJip0o8NJdAIz9uyF0CTKcBNYw=;
 b=UVyVlAzoakb2C7M/2MZ3saa+VHe1Ii6rqiOAYeUV34/XaKNHei9qD1CsggGLa5JTalgEls
 HlmhRlvKy5vGnopbQO+voY+al+C6nKJ/npmw7iGJsixXOgLoxLNZCXKO/hn207pUkRtdz4tu
 PqWG+zFiqHn3dKJ5VCnzgdNCckBGI=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/5] linux-cip: Switch to new download space
Date: Thu, 21 Sep 2023 12:23:27 +0200
Message-Id: <35c45a4159bad07bd1512c868d952a4c4642ea71.1695291811.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13191

From: Jan Kiszka <jan.kiszka@siemens.com>

This should resolve our and downstream's fetching issues, specifically
in CI environments.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc                 | 4 +++-
 recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb | 2 +-
 recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb   | 2 +-
 recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb  | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb      | 2 +-
 recipes-kernel/linux/linux-cip_4.19.292-cip102.bb         | 2 +-
 recipes-kernel/linux/linux-cip_4.4.302-cip79.bb           | 2 +-
 recipes-kernel/linux/linux-cip_5.10.191-cip38.bb          | 2 +-
 recipes-kernel/linux/linux-cip_6.1.52-cip5.bb             | 2 +-
 9 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index c0f076a9..8848581f 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -11,13 +11,15 @@
 
 FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files:"
 
+KERNEL_MAJOR_MINOR = "${@d.getVar('PV').split('.')[0] + '.' + d.getVar('PV').split('.')[1]}"
+
 KERNEL_DEFCONFIG ?= "${MACHINE}_defconfig"
 
 require recipes-kernel/linux/linux-custom.inc
 require recipes-kernel/linux/cip-kernel-config.inc
 
 SRC_URI += " \
-    https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/snapshot/linux-cip-${PV}.tar.gz \
+    https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MINOR}/linux-cip-${PV}.tar.xz \
     "
 
 S = "${WORKDIR}/linux-cip-${PV}"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
index 19c269b5..23a7fec4 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.288-cip101-rt32.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "e147634e8d2730f6b0ea0e192f50bc3e30205d0076c6f83adbef9e5eccafaf3a"
+SRC_URI[sha256sum] = "faf282166d669a1d4a044963199804b9cf7272041bf723d62a5162303e443219"
diff --git a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
index 0083be1c..1ebc5b63 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.4.302-cip78-rt45.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "7b3efe2a56531eabd4ed0b9682d4713c3933341a357f47eb03bf2ec75f89db1a"
+SRC_URI[sha256sum] = "ef3e1dd8ea1445d3b1321ff158f41a50f5319f81539d17110eab4a1cc2f79fde"
diff --git a/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb b/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
index 34dfee72..4ac1b6eb 100644
--- a/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
+++ b/recipes-kernel/linux/linux-cip-rt_5.10.186-cip37-rt15.bb
@@ -13,4 +13,4 @@ require linux-cip-rt-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "754f2dba8d1fa098299007d2b8384e349be0ca7533bda497c98df110d8b95728"
+SRC_URI[sha256sum] = "076f4b1019a37fe03aa53ad47e2f530316d2190608200c5c09557b84651797e5"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
index 89610e17..b6f3eabc 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.46-cip4-rt2.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "f59d2c191269709d1873a445189281adb5c2f26ccdcaa459ea495d2ef7ac7b28"
+SRC_URI[sha256sum] = "29f926c8755a503baa3e34bb967437e230075c9d9798c22415248983e9f53666"
diff --git a/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
index 8b1d4b37..c6285118 100644
--- a/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.292-cip102.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.19.y-cip"
 
-SRC_URI[sha256sum] = "106b3bcf4b3cc8b4ed25995a843839875e5fbbaf3b533df9d666199314628e31"
+SRC_URI[sha256sum] = "15e962738fcf4e98189f887c4d80037b04dcaaa227a0aaa6c7447b7367f6dac2"
diff --git a/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb b/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
index 58ef7d26..a14259f6 100644
--- a/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
+++ b/recipes-kernel/linux/linux-cip_4.4.302-cip79.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "4.4.y-cip"
 
-SRC_URI[sha256sum] = "626c3f29ed71fdef637d69938d885a54c6516d41f44a17f1a4e2dd405fd543c0"
+SRC_URI[sha256sum] = "cc84633377b3e46e48b25fba7061fdea319a44b541d466221707a014c0136e41"
diff --git a/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
index cf66e55b..edd7a958 100644
--- a/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.191-cip38.bb
@@ -13,4 +13,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "5.10.y-cip"
 
-SRC_URI[sha256sum] = "cee2c13b4e7280e6eb92746d14ec2b5e0e76c3842808de4348765e33b9e6dd39"
+SRC_URI[sha256sum] = "285dee8d7076fa4ac236167c0be10122f7eac5052e2ec20379fdf5be6452ec79"
diff --git a/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb b/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
index 77b3760e..ccc921a0 100644
--- a/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
+++ b/recipes-kernel/linux/linux-cip_6.1.52-cip5.bb
@@ -9,4 +9,4 @@ require linux-cip-common.inc
 
 KERNEL_DEFCONFIG_VERSION ?= "6.1.y-cip"
 
-SRC_URI[sha256sum] = "6d06628abc5eb30301d3bf0abfbfd90f7ceb01d24170e39d02adc8b730332d76"
+SRC_URI[sha256sum] = "b2271049dface2d9220d185f58d567f593fcd94cd7819ab0e6a3c131c02d97c7"
-- 
2.35.3


