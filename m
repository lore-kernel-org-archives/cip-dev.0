Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052DBC61D97
	for <webhook@archiver.kernel.org>; Fri, 24 Nov 2023 14:13:38 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.137965.1700835211795743550
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Nov 2023 06:13:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=TIJuou4Y;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202311241413271111e3f642bdafcc70-kdudpj@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202311241413271111e3f642bdafcc70
        for <cip-dev@lists.cip-project.org>;
        Fri, 24 Nov 2023 15:13:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Qja17M01hhjwUdhNmWZKaGyWJVEiWPJR1qHOsktM8qc=;
 b=TIJuou4Yz0TUtaJjk03tWmVwlCD3M9QmZi86gNVuRnrfCbc+lu8kacImA/9QR0q19+QWhd
 yf5ZYkcHMCb76JM3MkerE+hfQZpXzRtqWhcFX3iP47YJXaf8G86pGUjvinmmpacp4k3kt8cg
 ljYpx0ZB/P4mX+Se1Pq4sJWZ78VMY=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	wei.hao@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC] swupdate: Move signing to seperate script
Date: Fri, 24 Nov 2023 15:12:43 +0100
Message-ID: <20231124141326.2661397-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Nov 2023 14:13:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13746

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This allows to use third party service to sign the swupate packages
during build.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass                            | 13 +------------
 .../swupdate-certificates/files/sign-swu-cms        |  9 +++++++++
 .../swupdate-certificates/files/sign-swu-rsa        |  6 ++++++
 .../swupdate-certificates-key.inc                   | 12 +++++++++---
 4 files changed, 25 insertions(+), 15 deletions(-)
 create mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-cms
 create mode 100644 recipes-devtools/swupdate-certificates/files/sign-swu-rsa

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 38c2e0a..117f9fe 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -120,18 +120,7 @@ IMAGE_CMD:swu() {
             fi
             echo "$file"
             if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
-                if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
-                    openssl dgst \
-                        -sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$file" \
-                        > "$file.${SWU_SIGNATURE_EXT}"
-                elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
-                    openssl cms \
-                        -sign -in "$file" \
-                        -out "$file"."${SWU_SIGNATURE_EXT}" \
-                        -signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
-                        -inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
-                        -outform DER -noattr -binary
-                fi
+                sign-swu "$file" "$file.${SWU_SIGNATURE_EXT}"
                 # Set file timestamps for reproducible builds
                 if [ -n "${SOURCE_DATE_EPOCH}" ]; then
                     touch -d@"${SOURCE_DATE_EPOCH}" "$file.${SWU_SIGNATURE_EXT}"
diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-cms b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
new file mode 100644
index 0000000..7bd04ef
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/sign-swu-cms
@@ -0,0 +1,9 @@
+#!/bin/sh
+in_file=$1
+out_file=$2
+openssl cms \
+	-sign -in "$in_file" \
+	-out "$out_file" \
+	-signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
+	-inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
+	-outform DER -noattr -binary
diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
new file mode 100644
index 0000000..fad3004
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/sign-swu-rsa
@@ -0,0 +1,6 @@
+#!/bin/sh
+in_file=$1
+out_file=$2
+openssl dgst \
+	-sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$in_file" \
+	> "$out_file"
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 1b6b6dd..0b3e045 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -14,16 +14,22 @@ inherit dpkg-raw
 PROVIDES += "swupdate-certificates-key"
 
 SWU_SIGN_KEY ??= ""
-
+SWU_SIGN_SCRIPT ??= "sign-swu-cms"
 SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
+SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
 
+do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
+                         ${D}/usr/bin/"
 do_install() {
+    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
+        bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
+    fi
+    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
     if [ -z ${SWU_SIGN_KEY} ] ]; then
         bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
     fi
     TARGET=${D}/usr/share/swupdate-signing/
-    install -d -m 0700 ${TARGET}
-    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
+    install -m 0600 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
 }
 
 do_prepare_build:append() {
-- 
2.42.0


