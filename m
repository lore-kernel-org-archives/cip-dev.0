Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CAEC43334
	for <webhook@archiver.kernel.org>; Sun, 24 Jul 2022 17:53:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.19101.1658685229851671386
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Jul 2022 10:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.153,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 26OHrloW022179;
 Mon, 25 Jul 2022 02:53:48 +0900
X-Iguazu-Qid: 34trAWry5WxcmGu6i1
X-Iguazu-QSIG: v=2; s=0; t=1658685227; q=34trAWry5WxcmGu6i1;
 m=lTAVeFugv8Ri37JuA+353sU2ZLBTNkuRpyI2VztW9j8=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 26OHrkDI039554
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 25 Jul 2022 02:53:47 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2] security-customizations: Fix pam_tally2
 deprecation
Date: Sun, 24 Jul 2022 23:23:44 +0530
X-TSB-HOP2: ON
Message-Id: <20220724175344.14522-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1704D51B3A6B759B.22812@lists.cip-project.org>
References: <1704D51B3A6B759B.22812@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Jul 2022 17:53:44.0681 (UTC)
 FILETIME=[515B6D90:01D89F86]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 24 Jul 2022 17:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8899

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

pam_tally2 is deprecated from PAM version 1.4.0-7 that is from
Debian Bullseye, and introduced pam_faillock as replacement.

Modified the security customizations to check first pam_tally2 existence
for backward compatibility and if not found use the pam_faillock
instead to achieve the same functionality.

Fixes #33

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .../security-customizations/files/postinst    | 20 +++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 9ba8540..0d0eb07 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -22,11 +22,23 @@ sed -i "0,/^password.*/s/^password.*/${pam_cracklib_config}\n&/" "${PAM_PWD_FILE
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
+       exit 1
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



