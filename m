Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2889ACFD376
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 03:24:16 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9271.1763961399679305517
 for <cip-dev@lists.cip-project.org>;
 Sun, 23 Nov 2025 21:16:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=gourav.singh.ext@siemens.com header.s=fm1 header.b=dTC4B040;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-1333022-20251124050631fac19df4a800020746-y7d9no@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20251124050631fac19df4a800020746
        for <cip-dev@lists.cip-project.org>;
        Mon, 24 Nov 2025 06:06:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=gourav.singh.ext@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=dUtNxlJYSmh/SUI97+vZUUnsTbmtXtapnW8VYixb7Cg=;
 b=dTC4B040x8RkM2FJ7i9i2XahAbHmPzHg38P9PdS4CfPrL+b0rnU+Z2Q9Qbr8F/JGXNR4Ee
 8NOzVy9AEj9wMF4ubsjzYYYM7nousv2FHYD/TK3ifbul0+YSxr/NRpa9R6AtN/BhgeFVj+2N
 PBfnyMf9U31BCrlEGmwHiLUDiSFNYItBaAC1Wg0EdMlCSy9y94dB2lbdazV5dRXcukKu951y
 /0hhBvA7T685vswF3xVFFaDKCN5udTiBQ2/fkDvLy50xuB4NleHWUa0udbdU375E2h24RXSE
 vPyXd0EgWX+h8OHtn4f530qddQ4YVyA3Tr7gkGwe9brgpCHm50xZQ1XA==;
From: Gourav Singh <gourav.singh.ext@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Gourav Singh <gourav.singh.ext@siemens.com>
Subject: [isar-cip-core][PATCH] fix(security): add libpam-systemd in Debian trixie
Date: Mon, 24 Nov 2025 10:36:07 +0530
Message-Id: <20251124050607.876836-1-gourav.singh.ext@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1333022:519-21489:flowmailer
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Nov 2025 03:24:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20719

In Debian Trixie, /run/utmp has been removed, so traditional
session-tracking mechanisms (used by w/who) no longer work.
To restore secure and correct session accounting (needed for
enforcing limits like maxlogins to comply with IEC 62443
CR2.7_1), we can add libpam-systemd.

This ensures that PAM can register user sessions with
systemd-logind, aligning with Debian’s design for Trixie.
See Debian-devel discussion: "/run/utmp is no longer provided
in trixie ... replacement mechanism provided by systemd."

Ref: https://lists.debian.org/debian-devel/2025/04/msg00011.html

Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
---
 .../security-customizations/security-customizations.bb         | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 717e2d3..d8fa22b 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -25,6 +25,9 @@ DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator,
 # - libpam-passwdqc: Preferred for newer Debian releases (post-Bullseye).
 DEBIAN_DEPENDS:append = ", libpam-passwdqc | libpam-cracklib"
 
+# Append systemd PAM package to limit concurrent sessions in Debian trixie
+DEBIAN_DEPENDS:append:trixie = ", libpam-systemd"
+
 do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
 do_install () {
     install -m 600 ${WORKDIR}/ssh-remote-session-term.conf ${D}/etc/ssh/sshd_config.d/
-- 
2.39.5


