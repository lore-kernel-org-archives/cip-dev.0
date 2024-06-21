Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A8C27C4F
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 11:08:19 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.70447.1718968097744021860
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Jun 2024 04:08:18 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 45LB8F1d4114916; Fri, 21 Jun 2024 20:08:16 +0900
X-Iguazu-Qid: 2rWhAUbYkOyBmtXf0r
X-Iguazu-QSIG: v=2; s=0; t=1718968095; q=2rWhAUbYkOyBmtXf0r; m=30+XuaDspZs+ZdpmHFj17r6/uPYtMkNEt0V9s6y+Jp0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1120) id 45LB8EJK3203350
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Jun 2024 20:08:14 +0900
From: Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] doc/README.secureboot.md: Fix incorrect secure boot user generated keys path
Date: Fri, 21 Jun 2024 16:33:10 +0530
X-TSB-HOP2: ON
Message-Id: <20240621110310.2335906-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Jun 2024 11:08:13.0071 (UTC) FILETIME=[4EEBE1F0:01DAC3CB]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 11:08:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16315

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.secureboot.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 509de97..e6c8b0f 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -181,7 +181,7 @@ local_conf_header:
 ```
 
 Replace `demo` with the name of the user-generated certificates. The user-generated certificates
-need to stored in the folder `recipes-devtools/ebg-secure-boot-secrets/files`.
+need to stored in the folder `recipes-devtools/secure-boot-secrets/files`.
 
 Build the image with user-generated keys by executing the command:
 
-- 
2.39.2



