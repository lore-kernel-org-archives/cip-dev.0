Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16865C4321E
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 05:25:18 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.110839.1669613109553353506
 for <cip-dev@lists.cip-project.org>;
 Sun, 27 Nov 2022 21:25:10 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 2AS5P70G015848; Mon, 28 Nov 2022 14:25:07 +0900
X-Iguazu-Qid: 34trdMalR0YiEb1nqb
X-Iguazu-QSIG: v=2; s=0; t=1669613106; q=34trdMalR0YiEb1nqb; m=zhbqRCj1pf2negog8YAuNJpWUA3U9e0cPSDabqE7vaY=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 2AS5P5QK017487
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 28 Nov 2022 14:25:06 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] security-customizations: Fix account locked for non-consecutive failed attempts
Date: Mon, 28 Nov 2022 10:55:02 +0530
X-TSB-HOP2: ON
Message-Id: <20221128052502.19286-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Nov 2022 05:25:04.0353 (UTC) FILETIME=[C5379510:01D902E9]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Nov 2022 05:25:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10125

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

As per security configuration the user account should be locked for consecutive
failed login attempts, but with current pam configuration it is locked even for
non-consecutive failed login attempts, because it is missing the pam configuration
in account phase which will do necessary reset for non-consecutive failed attempts.

Closes [1]
[1] https://gitlab.com/cip-project/cip-testing/cip-security-tests/-/issues/3

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 recipes-core/security-customizations/files/postinst | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-core/security-customizations/files/postinst
index 0d0eb07..4ff8ecf 100644
--- a/recipes-core/security-customizations/files/postinst
+++ b/recipes-core/security-customizations/files/postinst
@@ -25,11 +25,13 @@ PAM_AUTH_FILE="/etc/pam.d/common-auth"
 # pam_tally2 is deprecated from pam version 1.4.0-7
 if [ -f /lib/*-linux-gnu*/security/pam_tally2.so ]; then
        PAM_MODULE="pam_tally2.so"
-       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
+       PAM_CONFIG="auth   required  pam_tally2.so  deny=3 even_deny_root unlock_time=60 root_unlock_time=60
+                 \naccount required pam_tally2.so"
 elif [ -f /lib/*-linux-gnu*/security/pam_faillock.so ]; then
        PAM_MODULE="pam_faillock.so"
        PAM_CONFIG="auth   required  pam_faillock.so preauth silent  deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
-               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60"
+               \nauth   required  pam_faillock.so .so authfail deny=3 even_deny_root unlock_time=60 root_unlock_time=60 \
+               \naccount required pam_faillock.so"
 else
        echo "No suitable pam module found to lock failed login attempts"
        exit 1
-- 
2.20.1



