Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B24CED63F
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 13:06:40 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8982.1763459883739681764
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 01:58:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gourav.singh.ext@siemens.com header.s=fm1 header.b=nh0gEupH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1333022-202511180947549087206af7000207b9-l8k96j@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202511180947549087206af7000207b9
        for <cip-dev@lists.cip-project.org>;
        Tue, 18 Nov 2025 10:47:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gourav.singh.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=+AY9xllI/MdTfL4QN8fM/9yJxOLRUqsa44ezZoudLBI=;
 b=nh0gEupH343BOlJ+GNXbHQltpyMwjrm5nLC/10BvvhO9wJ+lQ/rLYUmQ6IzdwqaUHtzEnh
 s3z3t2bNVcH102mR0T9C80a8MBy2UYMBP+YXdz1z4rHbL+zjTdH8EbwpFNCCBIvFx29ckUpY
 I+ILFftFFWXw0owxgChZUpfsawDqa3ebn7pm8T2XTQ1fyGaiJwslHCbMezEkE89FC/WOQnPf
 /33RD0Z4uH/wZJ5CwpbaRUqx4HJX/nZ3OeYJ7Z+gZ4VhQ/fezioCh4oS4wbttdDlV6JzcUr+
 1ogwS9YYx6Qlhwg28j2122AJiOy93jVRGI5OoYwSK4He67DtYOAqCejg==;
From: Gourav Singh <gourav.singh.ext@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gourav.singh.ext@siemens.com>
Subject: [isar-cip-core][PATCH] fix(security): add libpam-passwdqc for debian trixie
Date: Tue, 18 Nov 2025 15:17:37 +0530
Message-Id: <20251118094737.4613-1-gourav.singh.ext@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 13:06:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20613

The IEC 62443 security requirement TC_CR1.7_1 (Validate
strength of password-based authentication) is failing for
Debian trixie because the required package `libpam-passwdqc`
was not added. This commit adds the missing package to ensure
compliance with the security requirements.

Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
---
 recipes-core/security-customizations/security-customizations.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 75a6a99..f638f8b 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -24,6 +24,7 @@ DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator,
 DEBIAN_DEPENDS:append:buster = ", libpam-cracklib"
 DEBIAN_DEPENDS:append:bullseye = ", libpam-cracklib"
 DEBIAN_DEPENDS:append:bookworm = ", libpam-passwdqc"
+DEBIAN_DEPENDS:append:trixie = ", libpam-passwdqc"
 
 do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
 do_install () {
-- 
2.39.5


