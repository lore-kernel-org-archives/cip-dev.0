Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B36C3DA4D
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 08:51:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.3547.1720774287132298164
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 01:51:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 46C8pOYI2173045; Fri, 12 Jul 2024 17:51:24 +0900
X-Iguazu-Qid: 2rWgcwEFXpxD9ZSfMO
X-Iguazu-QSIG: v=2; s=0; t=1720774284; q=2rWgcwEFXpxD9ZSfMO; m=7Ur00ltjf64/uYTe1CvnqtxySjxbZ63DcBmfAtmVcqE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 46C8pNQI3954519
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 12 Jul 2024 17:51:23 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] doc/README.secureboot.md: Add information of DB and KEK in case of snakeoil keys
Date: Fri, 12 Jul 2024 14:15:56 +0530
X-TSB-HOP2: ON
Message-Id: <20240712084557.3351285-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20240712084557.3351285-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Jul 2024 08:51:21.0116 (UTC) FILETIME=[AAE3BDC0:01DAD438]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 08:51:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16464

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 doc/README.secureboot.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
index 337ece0..8ab67a8 100644
--- a/doc/README.secureboot.md
+++ b/doc/README.secureboot.md
@@ -308,6 +308,8 @@ sign-efi-sig-list -k recipes-devtools/secure-boot-secrets/files/bookworm/PkKek-1
 
 The package `efitools` needs to be installed for this.
 
+In this case, the PK.esl can be used as DB and KEK keys. The PK.auth file is for PK key.
+
 ### Secure boot key enrollment
 
 > :exclamation:**IMPORTANT** This document is not for generating a Machine Owner Key(MOK).
-- 
2.39.2



