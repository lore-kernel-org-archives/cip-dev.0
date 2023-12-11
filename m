Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0744C4332F
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 20:34:46 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.2111.1702326876957884977
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 12:34:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=aQFLrf/9;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20231211203433d681e6e435b90da508-lutyi7@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20231211203433d681e6e435b90da508
        for <cip-dev@lists.cip-project.org>;
        Mon, 11 Dec 2023 21:34:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=XTpycov7aBE7St7ama9JLNPAbWkwz6rRmsqhWSMlIMk=;
 b=aQFLrf/9CNHhAGnxSc4rCAyC1fljuWVdryuie2abAphBXmJdYjDQ71A+CtIRomp6ovmPZK
 N2OlZ5WVw9ltnJj5106eDPBwxuNJkQx7qBXwy1NCK6RZMxXlZDIQlY/k8hus9ZhQGz5iVIe/
 wc9PRJaDuklCFqoYq7MWqdndAl+Ko=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: Quirin.Gylstorff@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2] swupdate-certificates: Fix shell error
Date: Mon, 11 Dec 2023 21:34:18 +0100
Message-ID: <20231211203432.846459-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 20:34:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14039

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


An Additional bracket was added to all if cases, which leads to build
errors if the variable SWU_SIGN_CERT,SWU_SIGN_SCRIPT and/or SWU_SIGN_KEY
are not set.

Introduced with daa9e6738d1763a953fadc4de6010fe8dfddf27a for SWU_SIGN_CERT and SW_SIGN_KEY. 3a4b25d introduces it for SWU_SIGN_SCRIPT.


Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../swupdate-certificates/swupdate-certificates-key.inc       | 4 ++--
 .../swupdate-certificates/swupdate-certificates.inc           | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
index 0b3e045..d3d2e16 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
@@ -21,11 +21,11 @@ SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SI
 do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
                          ${D}/usr/bin/"
 do_install() {
-    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ] ]; then
+    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ]; then
         bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
     fi
     install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
-    if [ -z ${SWU_SIGN_KEY} ] ]; then
+    if [ -z ${SWU_SIGN_KEY} ]; then
         bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
     fi
     TARGET=${D}/usr/share/swupdate-signing/
diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
index 0553c25..6673383 100644
--- a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
+++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
@@ -18,7 +18,7 @@ SWU_SIGN_CERT ??= ""
 SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
 
 do_install() {
-    if [ -z ${SWU_SIGN_CERT} ] ]; then
+    if [ -z ${SWU_SIGN_CERT} ]; then
         bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
     fi
     TARGET=${D}/usr/share/swupdate-signing/
-- 
2.42.0


