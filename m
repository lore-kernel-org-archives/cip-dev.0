Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F086C27C4F
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 14:49:13 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web10.23983.1716907747550113222
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 07:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=PaaW+5+F;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-20240528144904c59e278cdcef50c4c6-z_ftqt@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20240528144904c59e278cdcef50c4c6
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 May 2024 16:49:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gXAa1vJoNVKn49KwABtOoEtk09uQdM5cRj+BFeBxVOA=;
 b=PaaW+5+FGFOkWTQl8pwHTaOLPqVqCCwbUuiH9pAFq7RVQozWXRJ2CnD2bf/ssiyHWmAy7U
 ne8gxmEVCXwaDxWs14N+5OkrZU/7NpFOfj+B2JjBYSbC3IfE1F3X8q/ZUXgZ7CwATnitx7m+
 wo8O+QHuS627ate9aYg5x9IBJpmGg=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 2/3] Add fail2ban-config
Date: Tue, 28 May 2024 16:42:44 +0200
Message-ID: <20240528144903.922587-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 14:49:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15965

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

To decrease the dependency in the cip security package use
systemd as the fail2ban logging backend.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../images/cip-core-image-security.bb         |  3 +--
 .../fail2ban-config/fail2ban-config.bb        | 23 +++++++++++++++++++
 .../files/systemd-defaults.conf               | 11 +++++++++
 3 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 recipes-security/fail2ban-config/fail2ban-config.bb
 create mode 100644 recipes-security/fail2ban-config/files/systemd-defaults.conf

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index eea50ee..2b1f3ef 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -14,13 +14,12 @@ require cip-core-image.inc
 DESCRIPTION = "CIP Core image including security packages"
 
 IMAGE_INSTALL += "security-customizations"
+IMAGE_INSTALL += "fail2ban-config"
 
 # Debian packages that provide security features
 IMAGE_PREINSTALL += " \
 	openssl \
-	fail2ban \
 	openssh-server openssh-sftp-server openssh-client \
-	syslog-ng-core syslog-ng-mod-journal \
 	aide \
 	nftables \
 	libpam-pkcs11 \
diff --git a/recipes-security/fail2ban-config/fail2ban-config.bb b/recipes-security/fail2ban-config/fail2ban-config.bb
new file mode 100644
index 0000000..a0f72fe
--- /dev/null
+++ b/recipes-security/fail2ban-config/fail2ban-config.bb
@@ -0,0 +1,23 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+DESCRIPTION = "Basic fail2ban config with systemd as backend"
+
+inherit dpkg-raw
+
+DPKG_ARCH = "all"
+
+SRC_URI += "file://systemd-defaults.conf"
+
+DEBIAN_DEPENDS += "fail2ban, python3-systemd, python3-pyinotify"
+
+do_install[cleandirs] = "${D}/etc/fail2ban/jail.d/"
+do_install() {
+    install -m 644 ${WORKDIR}/systemd-defaults.conf ${D}/etc/fail2ban/jail.d/
+}
diff --git a/recipes-security/fail2ban-config/files/systemd-defaults.conf b/recipes-security/fail2ban-config/files/systemd-defaults.conf
new file mode 100644
index 0000000..fe9de72
--- /dev/null
+++ b/recipes-security/fail2ban-config/files/systemd-defaults.conf
@@ -0,0 +1,11 @@
+[DEFAULT]
+
+syslog_backend = systemd
+sshd_backend = systemd
+dropbear_backend = systemd
+proftpd_backend = systemd
+pureftpd_backend = systemd
+wuftpd_backend = systemd
+postfix_backend = systemd
+dovecot_backend = systemd
+
-- 
2.43.0


