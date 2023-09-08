Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39BBEE7FEB
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 12:42:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.37803.1694176963300200050
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Sep 2023 05:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 388CgeeG2977150; Fri, 8 Sep 2023 21:42:41 +0900
X-Iguazu-Qid: 2yAaEO0URXvSYDiD0S
X-Iguazu-QSIG: v=2; s=0; t=1694176959; q=2yAaEO0URXvSYDiD0S; m=h93LUNx7ZZeC1/FOk9kxwL+dkXFQ9IkmPkgpdSfZ/rQ=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 388Cgdh93215802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Sep 2023 21:42:39 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/3][v2] Kconfig: Opt additional IEC 62443-4-2 features when security option is selected
Date: Fri,  8 Sep 2023 18:12:35 +0530
X-TSB-HOP2: ON
Message-Id: <20230908124237.508469-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Sep 2023 12:42:38.0095 (UTC) FILETIME=[F2FBB1F0:01D9E251]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 12:42:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13009

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

Data encryption, Secureboot and Swupdate options will be automatically
selected when security extensions is selected.

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
---
 Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Kconfig b/Kconfig
index ec49631..dca137d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -170,6 +170,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
 
 config IMAGE_SECURITY
 	bool "Security extensions"
+	select IMAGE_DATA_ENCRYPTION
+        help
+          This enables security, encryption, secureboot and swupdate for IEC 62443-4-2.
 
 config KAS_INCLUDE_SECURITY
 	string
-- 
2.30.2



