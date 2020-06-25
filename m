Return-Path: <SRS0=JPOe=AG=lists.cip-project.org=bounce+64572+4815+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3331AC433E0
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:12:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071FC20720
	for <cip-dev@archiver.kernel.org>; Thu, 25 Jun 2020 13:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bYjsqUUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071FC20720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4815+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gLj5YY4521723xbt2TjL5EKy; Thu, 25 Jun 2020 06:12:57 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web11.10201.1593090776632156024
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jun 2020 06:12:57 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05PDCnLD020575
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Thu, 25 Jun 2020 15:12:49 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.6.122])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 05PDCmRH024761;
	Thu, 25 Jun 2020 15:12:49 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH 1/2] update ISAR
Date: Thu, 25 Jun 2020 15:12:47 +0200
Message-Id: <20200625131248.15742-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200625131248.15742-1-Quirin.Gylstorff@siemens.com>
References: <20200625131248.15742-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7MiRDYkkEqfIVCXnrvcfSTKrx4520388AA=
Content-Type: multipart/mixed; boundary="hSiNgnyHrr80X1ONrF6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593090777;
 bh=+8E7W20hlXrkwWiS8Osz4nPyawsM/AJZ23IxjsG/UDc=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bYjsqUUy9/+A7xRcE/Eqku918xx/i6eO0QQKU8ybbr9fSjbhsnDvoRXCXJmP9jFovtb
 3P4OZwjZueCiH9WoSkPVy9qqcGauA3NZseUXhirK/UaBVeYeD8IumCf823f/NeJQHfCCE
 1pqu4QzcVATAbKEto9jAp/ONTDp9utoqaVU=

--hSiNgnyHrr80X1ONrF6I
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/machine/hihope-rzg2m.conf                |  4 +-
 conf/machine/iwg20m.conf                      |  4 +-
 ...d-path-to-image-for-arm-kernels-4.12.patch | 37 -------------------
 kas.yml                                       |  7 +---
 4 files changed, 5 insertions(+), 47 deletions(-)
 delete mode 100644 isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch

diff --git a/conf/machine/hihope-rzg2m.conf b/conf/machine/hihope-rzg2m.conf
index 8278205..a2ae03d 100644
--- a/conf/machine/hihope-rzg2m.conf
+++ b/conf/machine/hihope-rzg2m.conf
@@ -15,5 +15,5 @@ IMAGE_TYPE ?= "wic-img"
 
 KERNEL_DEFCONFIG = "cip-kernel-config/4.19.y-cip/arm64/renesas_defconfig"
 USE_CIP_KERNEL_CONFIG = "1"
-DTB_FILE = "r8a774a1-hihope-rzg2m-ex.dtb"
-IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
+DTB_FILES = "r8a774a1-hihope-rzg2m-ex.dtb"
+IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/conf/machine/iwg20m.conf b/conf/machine/iwg20m.conf
index 37f98fa..91bfd94 100644
--- a/conf/machine/iwg20m.conf
+++ b/conf/machine/iwg20m.conf
@@ -21,6 +21,6 @@ USE_CIP_KERNEL_CONFIG = "1"
 KERNEL_DEFCONFIG = "cip-kernel-config/4.4.y-cip/arm/renesas_shmobile_defconfig"
 
 # Boot partition files
-DTB_FILE = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
+DTB_FILES = "r8a7743-iwg20d-q7-dbcm-ca.dtb"
 KERNEL_IMAGE="zImage"
-IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILE}"
+IMAGE_BOOT_FILES = "${KERNEL_IMAGE} ${DTB_FILES}"
diff --git a/isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch b/isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch
deleted file mode 100644
index 3e4e13e..0000000
--- a/isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch
+++ /dev/null
@@ -1,37 +0,0 @@
-From 4961476f3affabd2bfb8f12ccc86c0abc6a66200 Mon Sep 17 00:00:00 2001
-From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
-Date: Wed, 8 Jan 2020 14:43:01 +0100
-Subject: [PATCH] linux-custom: add path to image for arm* kernels < 4.12
-To: isar-users@googlegroups.com
-
-ARM/ARM64 Kernel with a version < 4.12 do not contain the path to
-the kernel image in image_name. This was added with commits:
-152e6744ebfc8fa6cc9fff4ba36271f5f1ba2821 for arm and
-06995804b5762f016c7a80503406da853a8f3785 for arm64.
-
-Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
----
- meta/recipes-kernel/linux/files/debian/isar/install.tmpl | 7 ++++++-
- 1 file changed, 6 insertions(+), 1 deletion(-)
-
-diff --git a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-index 67b7ce3..ac347aa 100644
---- a/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-+++ b/meta/recipes-kernel/linux/files/debian/isar/install.tmpl
-@@ -56,7 +56,12 @@ EOF
- 
- install_image() {
-     install -m 755 -d ${deb_img_dir}/$(dirname ${kimage_path})
--    cp ${O}/${kimage} ${deb_img_dir}/${kimage_path}
-+    # ARM/ARM64 kernels < 4.12 do not include the path to the kernel
-+    if [ -e ${O}/${kimage} ]; then
-+        cp ${O}/${kimage} ${deb_img_dir}/${kimage_path}
-+    else
-+        cp ${O}/arch/$ARCH/boot/${kimage} ${deb_img_dir}/${kimage_path}
-+    fi
- 
-     # Make sure arm64 kernels are decompressed
-     if [ "${ARCH}" = "arm64" ]; then
--- 
-2.20.1
-
diff --git a/kas.yml b/kas.yml
index a157dc9..019b31e 100644
--- a/kas.yml
+++ b/kas.yml
@@ -19,14 +19,9 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    refspec: 619d6d88ac8c745282fd16773d50a466567615b6
+    refspec: 351af175bc54a201c6f44307d4e998bd6c0afdb8
     layers:
       meta:
-    patches:
-      build-arm-with-4.4:
-        path: isar-patches/0001-linux-custom-add-path-to-image-for-arm-kernels-4.12.patch
-        repo: cip-core
-
 
 bblayers_conf_header:
   standard: |
-- 
2.20.1


--hSiNgnyHrr80X1ONrF6I
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4815): https://lists.cip-project.org/g/cip-dev/message=
/4815
Mute This Topic: https://lists.cip-project.org/mt/75102309/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--hSiNgnyHrr80X1ONrF6I--
