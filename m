Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF2AC00142
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 08:49:49 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web11.182064.1698742187653013004
 for <cip-dev@lists.cip-project.org>;
 Tue, 31 Oct 2023 01:49:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=mnyMGRz4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-51332-202310310849451aa6ec3f6f67475676-58cmvv@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202310310849451aa6ec3f6f67475676
        for <cip-dev@lists.cip-project.org>;
        Tue, 31 Oct 2023 09:49:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=b3ESTw/WyWgx1z2zLpB4b04iyAVbpWnEdJ8ZFMpm4lc=;
 b=mnyMGRz49QclSnqDaSJI02bF1GFfyc3ILq7R2AY4/yXAqrd0kwUTGssd1wCWdao/6GYeN/
 k+avwdRIastPmzX6Kf0nGH3ro1H8x4hDhCv/vnZNlavs4bA0a5W6LLJOIAFsjZ7Ei1LcWJaZ
 Mj6Qf3C4woVpzb4VGe+whQB9Zld4o=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	venkata.pyla@toshiba-tsip.com,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp
Subject: [cip-dev][isar-cip-core][RFC v2 6/9] security-customizations: Extract sshd config from postinst to files
Date: Tue, 31 Oct 2023 09:37:40 +0100
Message-ID: <20231031084943.3105056-7-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
References: <20231031084943.3105056-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Oct 2023 08:49:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13503

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

For easier maintenance extract the ssh configuration to
/etc/sshd_config.d/.

Configuration entries in sshd_config.d will overwrite elements in
sshd_config.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../security-customizations/files/postinst       | 16 ----------------
 .../files/ssh-pam-remote.conf                    |  4 ++++
 .../files/ssh-remote-session-term.conf           |  5 +++++
 .../security-customizations.bb                   |  9 ++++++++-
 4 files changed, 17 insertions(+), 17 deletions(-)
 create mode 100644 recipes-core/security-customizations/files/ssh-pam-remote.conf
 create mode 100644 recipes-core/security-customizations/files/ssh-remote-session-term.conf

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 717b7ac..daade83 100755
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -51,14 +51,6 @@ if grep -c "${PAM_MODULE}" "${PAM_AUTH_FILE}";then
 fi
 sed -i "0,/^auth.*/s/^auth.*/${PAM_CONFIG}\n&/" "${PAM_AUTH_FILE}"
 
-# CR2.6: Remote session termination
-# Terminate remote session after inactive time period
-SSHD_CONFIG="/etc/ssh/sshd_config"
-alive_interval=$(sed -n '/ClientAliveInterval/p' "${SSHD_CONFIG}")
-alive_countmax=$(sed -n '/ClientAliveCountMax/p' "${SSHD_CONFIG}")
-sed -i "/${alive_interval}/c ClientAliveInterval 120"  "${SSHD_CONFIG}"
-sed -i "/${alive_countmax}/c ClientAliveCountMax 0" "${SSHD_CONFIG}"
-
 # CR2.7: Concurrent session control
 # Limit the concurrent login sessions
 LIMITS_CONFIG="/etc/security/limits.conf"
@@ -80,12 +72,4 @@ if grep -c "pam_google_authenticator.so" "${SSHD_AUTH_CONFIG}";then
         sed -i '/pam_google_authenticator.so/ s/^#*/#/'  "${SSHD_AUTH_CONFIG}"
 fi
 echo "auth required pam_google_authenticator.so nullok" | tee -a "${SSHD_AUTH_CONFIG}"
-# Enable PAM configuration for Remote Session
-if grep -s -q "ChallengeResponseAuthentication" "${SSHD_CONFIG}";then
-       sed -i 's/ChallengeResponseAuthentication no/ChallengeResponseAuthentication yes/g' "${SSHD_CONFIG}"
-fi
 
-if grep -s -q "KbdInteractiveAuthentication" "${SSHD_CONFIG}";then
-       sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/g' "${SSHD_CONFIG}"
-fi
-echo "AuthenticationMethods keyboard-interactive" | tee -a "${SSHD_CONFIG}"
diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-core/security-customizations/files/ssh-pam-remote.conf
new file mode 100644
index 0000000..d460b0c
--- /dev/null
+++ b/recipes-core/security-customizations/files/ssh-pam-remote.conf
@@ -0,0 +1,4 @@
+# Enable PAM configuration for Remote Session
+ChallengeResponseAuthentication yes
+KbdInteractiveAuthentication yes
+AuthenticationMethods keyboard-interactive
diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
new file mode 100644
index 0000000..d11b92e
--- /dev/null
+++ b/recipes-core/security-customizations/files/ssh-remote-session-term.conf
@@ -0,0 +1,5 @@
+# CR2.6: Remote session termination
+# Terminate remote session after inactive time period
+
+ClientAliveInterval 120
+ClientAliveCountMax 0
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
index d5249a2..d3cede8 100644
--- a/recipes-core/security-customizations/security-customizations.bb
+++ b/recipes-core/security-customizations/security-customizations.bb
@@ -13,8 +13,15 @@ inherit dpkg-raw
 
 DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
 
-SRC_URI = "file://postinst"
+SRC_URI = "file://postinst \
+           file://ssh-remote-session-term.conf \
+           file://ssh-pam-remote.conf"
 
 DEPENDS = "customizations, sshd-regen-keys"
 DEBIAN_DEPENDS = "customizations , sshd-regen-keys, libpam-google-authenticator"
 
+do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
+do_install () {
+    install -m 600 ${WORKDIR}/ssh-remote-session-term.conf ${D}/etc/ssh/sshd_config.d/
+    install -m 600 ${WORKDIR}/ssh-pam-remote.conf ${D}/etc/ssh/sshd_config.d/
+}
-- 
2.42.0


