Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60292C001DC
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 08:51:22 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.4095.1689238271590396839
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 01:51:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=NMLBPYDj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20230713085108317ffe37f24197f3a0-jkmbqx@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20230713085108317ffe37f24197f3a0
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jul 2023 10:51:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=azqtoWj18hkNbQpPOf7KJu/ncS90mZzx/uUI8onVz34=;
 b=NMLBPYDjKM1nbT2Tv5LHiXGrHw5DeeXEWSOyIm9sLzmPaLMNa4xCucVnT37iHqG6zb++Pm
 GP5i8w14XUpXCWY/YgCpq1Eh2uQgcaSvtriEUlNjjsBkh2/Scg/LFk7Bgv48J0+ttNxv1zUy
 I5N0IpgNx1xAVAwSoCwURarpw+HJc=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][RFC 2/3] swupdate.bbclass: Use new swupdate-certificate
Date: Thu, 13 Jul 2023 10:51:05 +0200
Message-Id: <20230713085106.2062587-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230713085106.2062587-1-Quirin.Gylstorff@siemens.com>
References: <20230713085106.2062587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 08:51:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12331

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This also changes the signing type from
RSA PKCS#1.5[1](SWUPDATE_SIGNATURE_TYPE="rsa") to
certificates[2](SWUPDATE_SIGNATURE_TYPE="cms").
certificates are the default of the debian SWUpdate package.

[1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-rsa-pkcs-1-5-or-rsa-pss
[2]:https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes/swupdate.bbclass | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 3d2b5f0..f5186de 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -27,12 +27,13 @@ SWU_DESCRIPTION_FILE ?= "sw-description"
 SWU_ADDITIONAL_FILES ?= "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
 SWU_SIGNED ?= ""
 SWU_SIGNATURE_EXT ?= "sig"
-SWU_SIGNATURE_TYPE ?= "rsa"
+SWU_SIGNATURE_TYPE ?= "cms"
 
 SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
 
 IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
-IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
+IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
 
 IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
 IMAGE_TEMPLATE_FILES:swu = "${SWU_DESCRIPTION_FILE}.tmpl"
@@ -102,10 +103,6 @@ IMAGE_CMD:swu() {
 
     # Prepare for signing
     export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
-    if [ -n "$sign" ]; then
-        cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
-        test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
-    fi
 
     sudo -E chroot ${BUILDCHROOT_DIR} sh -c ' \
         # Fill in file check sums
@@ -123,14 +120,14 @@ IMAGE_CMD:swu() {
             if [ -n "$sign" -a "${SWU_DESCRIPTION_FILE}" = "$file" ]; then
                 if [ "${SWU_SIGNATURE_TYPE}" = "rsa" ]; then
                     openssl dgst \
-                        -sha256 -sign "${PP_WORK}/dev.key" "$file" \
+                        -sha256 -sign "/usr/share/swupdate-signing/swupdate-sign.key" "$file" \
                         > "$file.${SWU_SIGNATURE_EXT}"
                 elif [ "${SWU_SIGNATURE_TYPE}" = "cms" ]; then
                     openssl cms \
                         -sign -in "$file" \
                         -out "$file"."${SWU_SIGNATURE_EXT}" \
-                        -signer "${PP_WORK}/dev.crt" \
-                        -inkey "${PP_WORK}/dev.key" \
+                        -signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
+                        -inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
                         -outform DER -nosmimecap -binary
                 fi
                 # Set file timestamps for reproducible builds
-- 
2.40.1


