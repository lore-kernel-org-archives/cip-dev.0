Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCE5FF886F
	for <webhook@archiver.kernel.org>; Thu, 30 Apr 2026 05:24:14 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13694.1777526647772911029
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Apr 2026 22:24:08 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 63U5O4ik1797278; Thu, 30 Apr 2026 14:24:04 +0900
X-Iguazu-Qid: 2yAaziuywO0l1dJVXP
X-Iguazu-QSIG: v=2; s=0; t=1777526643; q=2yAaziuywO0l1dJVXP; m=LbX033mKs+p4QVgynH3RTxznRMayXCLMn+hFUeaf7Ic=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4g5jJg5K80zyPZ; Thu, 30 Apr 2026 14:24:03 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v1] security-customizations: Hardening ssh configuration
Date: Thu, 30 Apr 2026 01:41:11 -0400
X-TSB-HOP2: ON
Message-Id: <20260430054112.250485-1-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Apr 2026 05:24:01.0525 (UTC) FILETIME=[8DB68A50:01DCD861]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Apr 2026 05:24:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22824

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

IEC security assessment had a few suggestions to consider w.r.t the ssh
configuration in our security images. The suggestions are listed in [1]

This patch addresses some of the suggestions from [1] like:
- MaxAuthTries (set 6 to 3)
- MaxSessions (set 10 to 2)
- X11Forwarding (set YES to NO)
- AllowAgentForwarding (set YES to NO)
- AllowTcpForwarding (set YES to NO)

Suggestions *not* considered:
- LogLevel (set INFO to VERBOSE): given that embedded storage may age quicker, overlogging must be avoided.
- TCPKeepAlive (set YES to NO): the suggestion to disable is due to TCPKeepAlive messages being unencrypted and spoofable.
But I couldn't find any resource that suggests that there's an exploitable vulnerability with TCPKeepAlive.

Closes #153

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/153

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 .../security-customizations/files/ssh-hardening.conf   | 10 ++++++++++
 .../security-customizations/security-customizations.bb |  4 +++-
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 recipes-core/security-customizations/files/ssh-hardening.conf

diff --git a/recipes-core/security-customizations/files/ssh-hardening.conf b/recipes-core/security-customizations/files/ssh-hardening.conf
new file mode 100644
index 0000000..3699370
--- /dev/null
+++ b/recipes-core/security-customizations/files/ssh-hardening.conf
@@ -0,0 +1,10 @@
+#
+# SPDX-License-Identifier: MIT
+#
+# Generic SSH hardening settings
+
+MaxAuthTries 3
+MaxSessions 2
+X11Forwarding no
+AllowAgentForwarding no
+AllowTcpForwarding no
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index 382f0c8..90af8f4 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -17,7 +17,8 @@ DESCRIPTION = "CIP Security configuration for IEC62443-4-2 evaluation"
 
 SRC_URI = "file://postinst \
            file://ssh-remote-session-term.conf \
-           file://ssh-pam-remote.conf"
+           file://ssh-pam-remote.conf \
+           file://ssh-hardening.conf"
 
 DEPENDS = "customizations sshd-regen-keys"
 DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator, libpam-modules, libpam-runtime, auditd"
@@ -34,4 +35,5 @@ do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
 do_install () {
     install -m 600 ${WORKDIR}/ssh-remote-session-term.conf ${D}/etc/ssh/sshd_config.d/
     install -m 600 ${WORKDIR}/ssh-pam-remote.conf ${D}/etc/ssh/sshd_config.d/
+    install -m 600 ${WORKDIR}/ssh-hardening.conf ${D}/etc/ssh/sshd_config.d/
 }
-- 
2.39.5



