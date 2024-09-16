Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAE1C3ABD2
	for <webhook@archiver.kernel.org>; Mon, 16 Sep 2024 12:55:24 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.7846.1726491322591550524
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Sep 2024 05:55:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=T8rBEr2M;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-202409161255192f6c766f08cf7788ea-6fbpvl@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202409161255192f6c766f08cf7788ea
        for <cip-dev@lists.cip-project.org>;
        Mon, 16 Sep 2024 14:55:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=LttgBzdtFh6jT9kL1mmJBDMxwBs5r4p73///EjHhefM=;
 b=T8rBEr2MA0eW7edJSFPrg+OirJNuekVmigeLpod4XkmeZEgFbeF82CmH85t0YX3CFyoa6M
 eqkXfQ9kKavOWyJLc9aNR1amJfiZwnsOcFmVrUVS1y2/5TKjIRcv3zd6UUXBHguxc8UKeIwJ
 qXc6m3DgLu8r1tEg+qiB+geiGfG5nIwUfGc6TAfGHI6K2ebWbNDAixEv31vfAk6lETPdhABV
 pX4RIo/kfiGA14DL59IXLZOivc1Gh73F6gIWhpBxv0Q+rGbc7nkg48+Y5xQg+3cZQ/7179gC
 ZXf+8bMAfchYuV8cSLVKDOs+Y6Pk5is+LG92tb/brHTsd+VWF9fl2b4g==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 1/3] Move signing script to seperate package to better support HSM signing
Date: Mon, 16 Sep 2024 14:54:53 +0200
Message-ID: <20240916125518.614224-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
References: <20240916125518.614224-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Sep 2024 12:55:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16905

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If a Hardware security module(HSM) is used, the user needs to modify the
swupdate-certificate-key package in multiple ways to remove the error
message in case of a missing key.

This changes decouples the signing key from the signing script to allow
easier integration with HSM based signing.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                      |  3 +--
 kas/opt/swupdate.yml                          |  1 +
 recipes-core/images/swupdate.inc              |  5 +++-
 .../swupdate-certificates/files/sign-swu-rsa  |  6 -----
 .../swupdate-certificates-key.inc             |  9 +------
 .../files/sign-swu-cms                        |  0
 .../swupdate-signer-cms_0.1.bb                | 26 +++++++++++++++++++
 7 files changed, 33 insertions(+), 17 deletions(-)
 delete mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index eeb05b2..06418e5 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -46,8 +46,7 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
     if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
     else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
 
-IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
-IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_INSTALL:swu += "cpio"
 IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 
diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
index ef61e4e..7398200 100644
--- a/kas/opt/swupdate.yml
+++ b/kas/opt/swupdate.yml
@@ -30,3 +30,4 @@ local_conf_header:
     ABROOTFS_PART_UUID_B ?= "fedcba98-7654-3210-cafe-5e0710000002"
     PREFERRED_PROVIDER_swupdate-certificates-key ??= "swupdate-certificates-key-snakeoil"
     PREFERRED_PROVIDER_swupdate-certificates ??= "swupdate-certificates-snakeoil"
+    PREFERRED_PROVIDER_swupdate-signer ??= "swupdate-signer-cms"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
index 1d237f7..96994b5 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2023
+# Copyright (c) Siemens AG, 2023-2024
 #
 # Authors:
 #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
@@ -14,6 +14,9 @@ inherit read-only-rootfs
 
 SWU_SIGNED ?= "1"
 SWU_HW_COMPAT ?= "cip-core-1.0"
+IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 IMAGE_INSTALL += " swupdate"
 
 IMAGE_INSTALL:remove:sid = "swupdate"
diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
deleted file mode 100644
index fad3004..0000000
--- a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-in_file=$1
-out_file=$2
-openssl dgst \
-	-sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$in_file" \
-	> "$out_file"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 93cf255..bcc8e2a 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -18,17 +18,10 @@ PROVIDES += "swupdate-certificates-key"
 DEBIAN_PROVIDES = "swupdate-certificates-key"
 
 SWU_SIGN_KEY ??= ""
-SWU_SIGN_SCRIPT ??= "sign-swu-cms"
 SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
-SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
 
-do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
-                         ${D}/usr/bin/"
+do_install[cleandirs] = "${D}/usr/share/swupdate-signing"
 do_install() {
-    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ]; then
-        bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
-    fi
-    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
     if [ -z ${SWU_SIGN_KEY} ]; then
         bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
     fi
diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
similarity index 100%
rename from recipes-devtools/swupdate-certificates/files/sign-swu-cms
rename to recipes-devtools/swupdate-signer/files/sign-swu-cms
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
new file mode 100644
index 0000000..3600c3d
--- /dev/null
+++ b/recipes-devtools/swupdate-signer/swupdate-signer-cms_0.1.bb
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dpkg-raw
+DPKG_ARCH = "all"
+DEBIAN_MULTI_ARCH = "foreign"
+
+PROVIDES = "swupdate-signer"
+DEBIAN_PROVIDES = "swupdate-signer"
+
+DEPENDS = "swupdate-certificates-key"
+DEBIAN_DEPENDS += "openssl, swupdate-certificates-key"
+
+SRC_URI = "file://sign-swu-cms"
+
+do_install[cleandirs] = "${D}/usr/bin/"
+do_install() {
+    install -m 0755 ${WORKDIR}/sign-swu-cms ${D}/usr/bin/sign-swu
+}
-- 
2.45.2


