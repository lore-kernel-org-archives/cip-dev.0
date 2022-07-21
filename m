Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96684C433EF
	for <webhook@archiver.kernel.org>; Thu, 21 Jul 2022 06:59:33 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.3496.1658386764187157343
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jul 2022 23:59:24 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 26L6xL9P010524;
 Thu, 21 Jul 2022 15:59:22 +0900
X-Iguazu-Qid: 2wHHJgaTyUbWAFjfEq
X-Iguazu-QSIG: v=2; s=0; t=1658386761; q=2wHHJgaTyUbWAFjfEq;
 m=nm2TNRGBq8hNIx6iQGsi6ga4/nTYfXbeUnrgng+JTpE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1113) id 26L6xKVw037824
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 21 Jul 2022 15:59:21 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] security-customizations: Fix pam_tally2 deprecation
Date: Thu, 21 Jul 2022 12:29:17 +0530
X-TSB-HOP2: ON
Message-Id: <20220721065917.11637-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Jul 2022 06:59:17.0591 (UTC)
 FILETIME=[651BBE70:01D89CCF]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 21 Jul 2022 06:59:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8864

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

pam_tally2 is deprecated from PAM version 1.4.0 that is from
Debian Bullseye, and introduced pam_faillock as replacement [1].

Modified the security customizations to check first pam_tally2 existence
for backward compatibility and if not found use the pam_faillock to
achieve the same functionality.

Fixes #33

[1] https://github.com/linux-pam/linux-pam/releases/tag/v1.4.0

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .../security-customizations/files/postinst    | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 9ba8540..ae06ab7 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -22,11 +22,22 @@ sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE
 # CR1.11: Unsuccessful login attempts
 # Lock user account after unsuccessful login attempts
 PAM_AUTH_FILE="/etc/pam.d/common-auth"
-pam_tally="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
-if grep -c "pam_tally2.so" "${PAM_AUTH_FILE}";then
-        sed -i '/pam_tally2/ s/^#*/#/'  "${PAM_AUTH_FILE}"
+# pam_tally2 is deprecated from pam version 1.4.0-7
+if [ -f /lib/*-linux-gnu*/security/pam_tally2.so ]; then
+       PAM_MODULE="pam_tally2.so"
+       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
+elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
+       PAM_MODULE="pam_faillock.so"
+       PAM_CONFIG="auth   required  pam_faillock.so preauth silent  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
+               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
+else
+       echo "No suitable pam module found to lock failed login attempts"
 fi
-sed -i "0,/^auth.*/s/^auth.*/${pam_tally}\n&/" "${PAM_AUTH_FILE}"
+
+if grep -c "${PAM_MODULE}" "${PAM_AUTH_FILE}";then
+        sed -i '/${PAM_MODULE}/ s/^#*/#/'  "${PAM_AUTH_FILE}"
+fi
+sed -i "0,/^auth.*/s/^auth.*/${PAM_CONFIG}\n&/" "${PAM_AUTH_FILE}"
 
 # CR2.6: Remote session termination
 # Terminate remote session after inactive time period
-- 
2.20.1



