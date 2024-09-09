Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057DECE585
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:23:23 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.50638.1725880993254381473
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ONuPOfqr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20240909112310b9b3bbbd86f95e2c14-wid_5y@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20240909112310b9b3bbbd86f95e2c14
        for <cip-dev@lists.cip-project.org>;
        Mon, 09 Sep 2024 13:23:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=Nf6WztQS3u8r0HDeIbo8ZjZzjPs7+kJgk+J85Yp7uOg=;
 b=ONuPOfqrc+Nl6gEZ3xUNOcxEWdos+oOLX//eM56fzPrqY8RX6lUzExTOqQt4UeaAlwvrUI
 FKUA8CWNN04RXrmLHkcdfe2ml3x06QoGVK/m7cVCxBgWblGLcQGDxxpIi762kChTKhK4/u3l
 ZAKM57XWp9Qg6zWfdJr+HpPg+WrPvlrceRVAUel4M1r7RHv3TP2ARIDRbGxXO34Akd+P0x8K
 2ICjPkbqABAirxhQ4ggHuAL6FfkVgQ6FLk1VJLGFK0fH0FqUs//+BFup9XI4UiAxnrrStRGT
 CkQ8FKnYb6OYHi+SBKYThnh49a7nEFuf3zV/5/Sq5WQrOln/K9ZMKmVQ==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 1/3] Move signing script to seperate package to better support HSM signing
Date: Mon,  9 Sep 2024 13:21:38 +0200
Message-ID: <20240909112309.1028531-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:23:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16868

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

If a Hardware security module(HSM) is used, the user needs to modify the
swupdate-certificate-key package in multiple ways to remove the error
message in case of a missing key.

This changes decouples the signing
key from the signing script to allow easier integration with HSM based
signing

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                      |  3 +--
 recipes-core/images/swupdate.inc              |  5 +++-
 .../swupdate-certificates-key.inc             |  9 +------
 .../files/sign-swu-cms                        |  0
 .../files/sign-swu-rsa                        |  0
 .../swupdate-signer/swupdate-signer_0.1.bb    | 25 +++++++++++++++++++
 6 files changed, 31 insertions(+), 11 deletions(-)
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
 rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-rsa (100%)
 create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb

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
diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa b/recipes-devtools/swupdate-signer/files/sign-swu-rsa
similarity index 100%
rename from recipes-devtools/swupdate-certificates/files/sign-swu-rsa
rename to recipes-devtools/swupdate-signer/files/sign-swu-rsa
diff --git a/recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb
new file mode 100644
index 0000000..71cc10c
--- /dev/null
+++ b/recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb
@@ -0,0 +1,25 @@
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
+DEPENDS = "swupdate-certificates-key"
+DEBIAN_DEPENDS += "openssl, swupdate-certificates-key"
+
+SWU_SIGN_SCRIPT ??= "sign-swu-cms"
+
+SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
+
+do_install[cleandirs] = "${D}/usr/bin/"
+do_install() {
+    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
+}
-- 
2.45.2


