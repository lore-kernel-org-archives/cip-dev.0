Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E9BC001E0
	for <webhook@archiver.kernel.org>; Mon, 17 Jul 2023 10:54:26 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web11.5436.1689591261810284541
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jul 2023 03:54:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=h9ODb9Ae;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202307171054190d0137a4842e36f025-whmh_0@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202307171054190d0137a4842e36f025
        for <cip-dev@lists.cip-project.org>;
        Mon, 17 Jul 2023 12:54:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=IwVlV7k3RdFrJQS/Cst5e/if2rZDqfznrOoEGdM4Sco=;
 b=h9ODb9AeAe9XrJ0LIqb4d4jW/C40C3no8QHKzdLgCHHfIwT3uhFJY1/Bb31G3cyOEaPoSz
 xFCYFq0tDpdwyDRVjONd2urrQhtnd9EoLz95hLSJj2S2h+57JNHsbedwImzZDjCBxFVztVb6
 MRjpZoaHO4/Zua2hbyqEB6WWTICu0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed updates
Date: Mon, 17 Jul 2023 12:54:17 +0200
Message-Id: <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Jul 2023 10:54:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12369

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

With this change SWUpdate requires signed binaries to update
the system. An update without the correct signature will lead to the
following error message:
```
Error: SWUpdate is built for signed images, provide a public key file.
```

If unsigned binaries are wanted readd the Build option
```
DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
```
to a swupdate_%.bbappend recipe

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/swupdate.yml                                   | 2 ++
 recipes-core/customizations/files/swupdate.cfg         | 1 +
 recipes-core/images/swupdate.inc                       | 2 +-
 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 9 ++++++---
 recipes-core/swupdate/swupdate_2023.05.bb              | 8 ++++++--
 5 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index b0293ce..0e30e89 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -28,3 +28,5 @@ local_conf_header:
     INITRAMFS_INSTALL:append = " initramfs-squashfs-hook"
     ABROOTFS_PART_UUID_A ?= "fedcba98-7654-3210-cafe-5e0710000001"
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
+    PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
+    PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
diff --git a/recipes-core/customizations/files/swupdate.cfg b/recipes-core/customizations/files/swupdate.cfg
index 9ee47c7..3e2b45c 100644
--- a/recipes-core/customizations/files/swupdate.cfg
+++ b/recipes-core/customizations/files/swupdate.cfg
@@ -1,4 +1,5 @@
 globals :
 {
     bootloader = "ebg";
+    public-key-file = "/usr/share/swupdate-signing/swupdate-sign.crt"
 };
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 5d9cd58..4983f7c 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2020
+# Copyright (c) Siemens AG, 2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
diff --git a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
index 2384f41..8f7a97d 100644
--- a/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
+++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2023
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -29,8 +29,11 @@ SRC_URI += "file://0001-debian-Remove-SWUpdate-USB-service-and-Udev-rules.patch
 
 # end patching for dm-verity based images
 
-# deactivate signing and hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+# The option: "pkg.swupdate.nosigning" disables the required signing
+# of update binaries
+# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+
+# deactivate hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
 
 # add cross build and deactivate testing for arm based builds
diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index 26c0e67..762fac2 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -31,8 +31,12 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
             file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
             file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
 
-# deactivate signing and hardware compability for simple a/b rootfs update
-DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+
+# The option: "pkg.swupdate.nosigning" disables the required signing
+# of update binaries
+# DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
+
+# deactivate hardware compability for simple a/b rootfs update
 DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
 
 # suricatta wfx requires suricatta lua and the dependency
-- 
2.40.1


