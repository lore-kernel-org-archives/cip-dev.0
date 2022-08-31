Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9E0ECAAD3
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 07:36:09 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.22751.1661931368008648892
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 00:36:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=gkMIwgUy;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228,
 mailfrom: fm-294854-20220831073123c63490164ec47f22c8-z_bcno@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20220831073123c63490164ec47f22c8
        for <cip-dev@lists.cip-project.org>;
        Wed, 31 Aug 2022 09:36:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=qn8yvx2u7/aaK86OPEojEq0cV1j1CbBrgRON/QsO6tA=;
 b=gkMIwgUyKlicM5+Jii69O4eH8LVgRCKNIztHv+9w3CqkNuOvBAIZG1uCU/ZU/I28ZQIKgS
 wYtQiKEkvfvFQLvWq1nQMhphybbqgjjscr9HcKtOC/gq0bSX6vxodhQtua/aG7NxjO4yCIP6
 D++B5cmUtgPmdH1K5Qi50U1nRPnxs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 1/6] swupdate: Use cpio from buildchroot
Date: Wed, 31 Aug 2022 09:31:16 +0200
Message-Id: 
 <fa31a98f0d180d5d25afab4678cb070586ebde8f.1661931081.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1661931081.git.jan.kiszka@siemens.com>
References: <cover.1661931081.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Aug 2022 07:36:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9334

From: Jan Kiszka <jan.kiszka@siemens.com>

The cpio tool is not an essential dependency of Isar, so we cannot use
it from the host environment. This only worked so far with the kas
container by chance but will change with its next release.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate.bbclass | 53 ++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 26 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index c3fc303..46d2a36 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -16,6 +16,9 @@ SWU_SIGNED ?= ""
 SWU_SIGNATURE_EXT ?= "sig"
 SWU_SIGNATURE_TYPE ?= "rsa"
 
+BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
+
+IMAGER_INSTALL += "cpio"
 IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
@@ -46,16 +49,17 @@ do_swupdate_binary() {
     # Create symlinks for files used in the update image
     for file in ${SWU_ADDITIONAL_FILES}; do
         if [ -e "${WORKDIR}/$file" ]; then
-            ln -s "${WORKDIR}/$file" "${WORKDIR}/swu/$file"
+            ln -s "${PP_WORK}/$file" "${WORKDIR}/swu/$file"
         else
-            ln -s "${DEPLOY_DIR_IMAGE}/$file" "${WORKDIR}/swu/$file"
+            ln -s "${PP_DEPLOY}/$file" "${WORKDIR}/swu/$file"
         fi
     done
 
+    image_do_mounts
+
     # Prepare for signing
     sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
     if [ -n "$sign" ]; then
-        image_do_mounts
         cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
         test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
     fi
@@ -66,29 +70,26 @@ do_swupdate_binary() {
             '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
     done
 
-    cd "${WORKDIR}/swu"
-    for file in '${SWU_DESCRIPTION_FILE}' ${SWU_ADDITIONAL_FILES}; do
-        echo "$file"
-        if [ -n "$sign" -a \
-             '${SWU_DESCRIPTION_FILE}' = "$file" ]; then
-            if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
-                sudo chroot ${BUILDCHROOT_DIR} /usr/bin/openssl dgst \
-                    -sha256 -sign '${PP_WORK}/dev.key' \
-                    '${PP_WORK}/swu/'"$file" \
-                        > '${WORKDIR}/swu/'"$file".'${SWU_SIGNATURE_EXT}'
-            elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
-                sudo chroot ${BUILDCHROOT_DIR} /usr/bin/openssl cms \
-                    -sign -in '${PP_WORK}/swu/'"$file" \
-                    -out '${WORKDIR}/swu/'"$file".'${SWU_SIGNATURE_EXT}' \
-                    -signer '${PP_WORK}/dev.crt' \
-                    -inkey '${PP_WORK}/dev.key' \
-                    -outform DER -nosmimecap -binary
-            fi
-            echo "$file".'${SWU_SIGNATURE_EXT}'
-        fi
-    done | cpio -ovL -H crc \
-        > '${SWU_IMAGE_FILE}'
-    cd -
+    sudo -E chroot ${BUILDCHROOT_DIR} sh -c ' \
+        cd "${PP_WORK}/swu"
+        for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
+            echo "$file"
+            if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
+                if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
+                    openssl dgst \
+                        -sha256 -sign "${PP_WORK}/dev.key" "$file" \
+                        > "$file.${SWU_SIGNATURE_EXT}"
+                elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
+                    openssl cms \
+                        -sign -in "$file" \
+                        -out "$file"."${SWU_SIGNATURE_EXT}" \
+                        -signer "${PP_WORK}/dev.crt" \
+                        -inkey "${PP_WORK}/dev.key" \
+                        -outform DER -nosmimecap -binary
+                fi
+                echo "$file.${SWU_SIGNATURE_EXT}"
+           fi
+        done | cpio -ovL -H crc > "${BUILDCHROOT_IMAGE_FILE}"'
 }
 
 addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
-- 
2.35.3


