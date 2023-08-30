Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D70C83F15
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 04:41:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.7101.1693370482926065121
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Aug 2023 21:41:23 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 37U4fLBx3232686; Wed, 30 Aug 2023 13:41:21 +0900
X-Iguazu-Qid: 2rWgbWvRznAFJUfdUh
X-Iguazu-QSIG: v=2; s=0; t=1693370481; q=2rWgbWvRznAFJUfdUh; m=pJ+agS6wQAqRE8RmTP/8RX6Q2LJ8H4Y3WSQWGBQuSLw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 37U4fJe41003263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 30 Aug 2023 13:41:20 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] security.yml: Add additional features to security image
Date: Wed, 30 Aug 2023 10:11:15 +0530
X-TSB-HOP2: ON
Message-Id: <20230830044115.1112349-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230830044115.1112349-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Aug 2023 04:41:16.0182 (UTC) FILETIME=[364DC360:01D9DAFC]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Aug 2023 04:41:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12906

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

From IEC certification perspective, a security image is needed which has the below features along with security customizations.
1. Data encryption (CR4.1)
2. Secure boot (EDR 3.14)
3. SWupdate (NDR 3.10)

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 kas/opt/security.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kas/opt/security.yml b/kas/opt/security.yml
index 1f3745b..67bf4ff 100644
--- a/kas/opt/security.yml
+++ b/kas/opt/security.yml
@@ -10,6 +10,9 @@
 #
 header:
   version: 12
+  includes:
+   - kas/opt/encrypt-partitions.yml
+   - kas/opt/ebg-secure-boot-snakeoil.yml
 
 target: cip-core-image-security
 
-- 
2.30.2



