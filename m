Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5220C00A8F
	for <webhook@archiver.kernel.org>; Mon, 23 Oct 2023 15:02:51 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.122857.1698073370357591545
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Oct 2023 08:02:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=M7Fz70V8;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-51332-202310231502480111daadf2d8b5ba62-k7tlad@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202310231502480111daadf2d8b5ba62
        for <cip-dev@lists.cip-project.org>;
        Mon, 23 Oct 2023 17:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=4IkDu18R4zE1qepCehBL+sZyXeRAoOF8S/C6JS/KvVU=;
 b=M7Fz70V8jvn6Ofjo4gxMBLH1I5jaQ6xmFh6ZGju5+ySXNBwo7e15jyWhU7j+yxXy/EBde3
 UDcLs2IyGktd4tMnGobYlcEOlX4OzZ+kaZaikhon2sWm2n7Y9pamdAbXULO8lZAcaVGfhLAg
 MuSeR2yfDg0vf5EdUM6uIGy8qdUBg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move packages to security-customization
Date: Mon, 23 Oct 2023 17:00:05 +0200
Message-ID: <20231023150243.3990309-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Oct 2023 15:02:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13441

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To ensure that the package security-customizations is installable
move packages from cip-core-image-security as dependencies to
security-paackges.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/images/cip-core-image-security.bb     | 12 +-----------
 .../security-customizations.bb                     | 14 +++++++++++---
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 3421ce5..525a346 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -28,24 +28,14 @@ IMAGE_PREINSTALL += " \
 	tpm2-tools \
 	tpm2-abrmd \
 	acl \
-	audispd-plugins auditd \
+	audispd-plugins \
 	uuid-runtime \
 	sudo \
 	aide-common \
-	libpam-google-authenticator \
 	passwd \
 	login \
-	libpam-runtime \
 	util-linux \
 "
 
-# Package names based on the distro version
-IMAGE_PREINSTALL:append:buster = " libtss2-esys0 \
-                                   libpam-cracklib"
-IMAGE_PREINSTALL:append:bullseye = " libtss2-esys-3.0.2-0 \
-                                     libpam-cracklib"
-IMAGE_PREINSTALL:append:bookworm = " libtss2-esys-3.0.2-0 \
-                                     libpam-passwdqc"
-
 CIP_IMAGE_OPTIONS ?= ""
 require ${CIP_IMAGE_OPTIONS}
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index d3cede8..162d2f6 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -11,14 +11,22 @@
 
 inherit dpkg-raw
 
-DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
+DESCRIPTION = "CIP Security configuration for IEC62443-4-2 evaluation"
 
 SRC_URI = "file://postinst \
            file://ssh-remote-session-term.conf \
            file://ssh-pam-remote.conf"
 
-DEPENDS = "customizations, sshd-regen-keys"
-DEBIAN_DEPENDS = "customizations , sshd-regen-keys, libpam-google-authenticator"
+DEPENDS = "customizations sshd-regen-keys"
+DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
+
+# Package names based on the distro version
+DEBIAN_DEPENDS:append:buster = ", libtss2-esys0, \
+                                   libpam-cracklib"
+DEBIAN_DEPENDS:append:bullseye = ", libtss2-esys-3.0.2-0, \
+                                     libpam-cracklib"
+DEBIAN_DEPENDS:append:bookworm = ", libtss2-esys-3.0.2-0, \
+libpam-passwdqc"
 
 do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
 do_install () {
-- 
2.42.0


