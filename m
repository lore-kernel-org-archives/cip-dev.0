Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F0FC6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 04:41:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.7098.1693370481547353415
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 21:41:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 37U4fJkQ3253075; Wed, 30 Aug 2023 13:41:20 +0900
X-Iguazu-Qid: 2rWgoVec2D0oz0eZ7e
X-Iguazu-QSIG: v=2; s=0; t=1693370479; q=2rWgoVec2D0oz0eZ7e; m=Es92qf8ik2lQ7B5wkieKsgUp91auIj2IbXB3HsTUoCc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 37U4fIUV1003217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Aug 2023 13:41:18 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/3] Kconfig: Opt additional IEC 62443-4-2 features when security option is selected
Date: Wed, 30 Aug 2023 10:11:13 +0530
X-TSB-HOP2: ON
Message-Id: <20230830044115.1112349-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Aug 2023 04:41:16.0087 (UTC) FILETIME=[363F4470:01D9DAFC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 04:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12903

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Data encryption, Secureboot and Swupdate options will be automatically
selected when security extensions is selected.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Kconfig b/Kconfig
index ec49631..75d6ba4 100644
--- a/Kconfig
+++ b/Kconfig
@@ -170,6 +170,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
 
 config IMAGE_SECURITY
 	bool "Security extensions"
+        select IMAGE_DATA_ENCRYPTION
+        help
+          This enables security, encrpytion, secureboot and swupdate for IEC 62443-4-2.
 
 config KAS_INCLUDE_SECURITY
 	string
-- 
2.30.2



