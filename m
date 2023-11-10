Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DA7C4332F
	for <webhook@archiver.kernel.org>; Fri, 10 Nov 2023 08:05:13 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.23425.1699603512107395666
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Nov 2023 00:05:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 3AA859ts2022540; Fri, 10 Nov 2023 17:05:10 +0900
X-Iguazu-Qid: 2yAaLcf4NtKCHDFLEO
X-Iguazu-QSIG: v=2; s=0; t=1699603509; q=2yAaLcf4NtKCHDFLEO; m=sq88A/0/ciA0xm96AreKdsY9GB8tyuMMk0AxHn+fSvk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 3AA858Zf3272718
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 10 Nov 2023 17:05:09 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] ebg-secure-boot-signer: sign artifiacts reproducibly
Date: Fri, 10 Nov 2023 13:35:08 +0530
X-TSB-HOP2: ON
Message-Id: <20231110080508.20807-1-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Nov 2023 08:05:06.0505 (UTC) FILETIME=[9DE2F390:01DA13AC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Nov 2023 08:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13565

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

When artifacts are signed with sbsign the images are not reproducible
because the signatures includes build time-stamps.

This can be avoided by creating the signatures on fixed time-stamp
(SOURCE_DATE_EPOCH) using faketime.

Fixes: #83

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 .../ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb   | 2 +-
 .../ebg-secure-boot-signer/files/sign_secure_image.sh      | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
index 546fded..57ad1be 100644
--- a/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
+++ b/recipes-devtools/ebg-secure-boot-signer/ebg-secure-boot-signer_0.1.bb
@@ -15,7 +15,7 @@ inherit dpkg-raw
 DESCRIPTION = "Signing script for EFI Boot Guard setups"
 
 DEPENDS = "secure-boot-secrets"
-DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets"
+DEBIAN_DEPENDS = "sbsigntool, secure-boot-secrets, faketime"
 
 SRC_URI = "file://sign_secure_image.sh"
 
diff --git a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
index 0c9b898..213cf8a 100644
--- a/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
+++ b/recipes-devtools/ebg-secure-boot-signer/files/sign_secure_image.sh
@@ -30,4 +30,9 @@ fi
 
 keydir=/usr/share/secure-boot-secrets
 
-sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
+faketime_cmd=""
+if [ -n "$SOURCE_DATE_EPOCH" ]; then
+    faketime_cmd="faketime -f \"$(TZ=UTC date -d @$SOURCE_DATE_EPOCH +'%Y-%m-%d %H:%M:%S')\""
+fi
+
+eval $faketime_cmd sbsign --key ${keydir}/secure-boot.key --cert ${keydir}/secure-boot.pem --output $signed $signee
-- 
2.20.1



