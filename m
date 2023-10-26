Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA85C25B48
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 08:30:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.195384.1698309004234729045
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Oct 2023 01:30:05 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 39Q8U2po2225239; Thu, 26 Oct 2023 17:30:02 +0900
X-Iguazu-Qid: 2rWgaNhqoSFCDRvRea
X-Iguazu-QSIG: v=2; s=0; t=1698309001; q=2rWgaNhqoSFCDRvRea; m=5CdSWlRjbg4WabBjxZs2DOB88Rp9ilp2XsJHXmQTMN4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 39Q8U0KT3550830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 17:30:01 +0900
From: venkata.pyla@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: venkata pyla <venkata.pyla@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v2 2/3] swupdate.bbclass: make signed swupdate file reproducible
Date: Thu, 26 Oct 2023 13:59:58 +0530
X-TSB-HOP2: ON
Message-Id: <20231026082959.16939-3-venkata.pyla@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
References: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 26 Oct 2023 08:29:57.0935 (UTC) FILETIME=[9AA6DBF0:01DA07E6]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 08:30:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13459

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

The swupdate file when signed with "cms" method it is not reproducible
because "cms" method add signing time as attributes in the signature data.

These attributes are not used in the verification process and so
disabling them with "-noattr" option.

Fixes: #80

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 classes/swupdate.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 55dad32..3cf17a2 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -130,7 +130,7 @@ IMAGE_CMD:swu() {
                         -out "$file"."${SWU_SIGNATURE_EXT}" \
                         -signer "/usr/share/swupdate-signing/swupdate-sign.crt" \
                         -inkey "/usr/share/swupdate-signing/swupdate-sign.key" \
-                        -outform DER -nosmimecap -binary
+                        -outform DER -noattr -binary
                 fi
                 # Set file timestamps for reproducible builds
                 if [ -n "${SOURCE_DATE_EPOCH}" ]; then
-- 
2.20.1



