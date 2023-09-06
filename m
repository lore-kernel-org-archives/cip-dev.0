Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B696EB8FB5
	for <webhook@archiver.kernel.org>; Wed,  6 Sep 2023 04:56:59 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.1799.1693976211354366849
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Sep 2023 21:56:51 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 3864un452617035; Wed, 6 Sep 2023 13:56:49 +0900
X-Iguazu-Qid: 2rWgqlGKychAQo5q6C
X-Iguazu-QSIG: v=2; s=0; t=1693976208; q=2rWgqlGKychAQo5q6C; m=yJqz/tb2SA5rOHxgKikwft1BnmqEno3HSU/39ScnDoM=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 3864ulgK3853591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 6 Sep 2023 13:56:48 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3] security.yml: Add additional features to security image
Date: Wed,  6 Sep 2023 10:26:43 +0530
X-TSB-HOP2: ON
Message-Id: <20230906045643.2640096-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230906045643.2640096-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 06 Sep 2023 04:56:43.0313 (UTC) FILETIME=[87CEFA10:01D9E07E]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Sep 2023 04:56:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12972

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

From IEC certification perspective, a security image is needed which
has the below features along with security customizations.

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



