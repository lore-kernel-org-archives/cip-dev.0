Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B40CF8554
	for <webhook@archiver.kernel.org>; Thu, 20 Nov 2025 08:17:34 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.29237.1763623640752696556
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Nov 2025 23:27:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gourav.singh.ext@siemens.com header.s=fm1 header.b=RkG2a+Xh;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1333022-202511200717141b6ab0b8a2000207f7-gfofjs@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202511200717141b6ab0b8a2000207f7
        for <cip-dev@lists.cip-project.org>;
        Thu, 20 Nov 2025 08:17:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gourav.singh.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=TIbjKC+I9Ce6XmOdpdIArTUJB101r0Ue/VEY7unoleg=;
 b=RkG2a+XhMtbFOpMadCT0m5zp6twGrJXlv9vNkzriQz2TEBO9WfF7JArhkjeTEYXlaYHa4x
 /HO2+SROAtMlDixhgi8R2qFGqey8g2TyCImS5CHWVQz47J5KKGaWXAPVMXqEgLuvpBaz287d
 1kmCiUZ4oz9Uo1hkXyFhSXIsCf2EyUD8NqBIY+snn+cEiZtNlDgAFX9Ut8HveLL8fDo0b3qD
 kxBXTOWF5Ixh4iXqFqil7bqcPRTqKfQfQAoGl414tR9wn/t91IojGClZdaIGplooGstnnRp/
 +pN7I/7C4hBVSuLNvoR5k9jyt+aRjBhNCmxn3SMR8vEeUFyCBBLInS7g==;
From: Gourav Singh <gourav.singh.ext@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gourav.singh.ext@siemens.com>
Subject: [isar-cip-core][PATCH v2 2/2] fix(security): add libpam-passwdqc for debian trixie
Date: Thu, 20 Nov 2025 12:46:53 +0530
Message-Id: <20251120071653.606694-2-gourav.singh.ext@siemens.com>
In-Reply-To: <20251120071653.606694-1-gourav.singh.ext@siemens.com>
References: <20251120071653.606694-1-gourav.singh.ext@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Nov 2025 08:17:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20634

The IEC 62443 security requirement TC_CR1.7_1 (Validate
strength of password-based authentication) is failing for
Debian trixie because the required package `libpam-passwdqc`
was not added. This commit adds the missing package to ensure
compliance with the security requirements.

Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
---
 .../security-customizations/security-customizations.bb    | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 75a6a99..717e2d3 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -20,10 +20,10 @@ SRC_URI = "file://postinst \
 DEPENDS = "customizations sshd-regen-keys"
 DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
 
-# Package names based on the distro version
-DEBIAN_DEPENDS:append:buster = ", libpam-cracklib"
-DEBIAN_DEPENDS:append:bullseye = ", libpam-cracklib"
-DEBIAN_DEPENDS:append:bookworm = ", libpam-passwdqc"
+# Append PAM module dependencies for password strength enforcement based on the Debian version
+# - libpam-cracklib: Deprecated, but still supported in Debian Buster and Bullseye.
+# - libpam-passwdqc: Preferred for newer Debian releases (post-Bullseye).
+DEBIAN_DEPENDS:append = ", libpam-passwdqc | libpam-cracklib"
 
 do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
 do_install () {
-- 
2.39.5


