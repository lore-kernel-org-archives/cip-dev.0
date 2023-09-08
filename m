Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE856EE7FED
	for <webhook@archiver.kernel.org>; Fri,  8 Sep 2023 12:42:46 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.37804.1694176963669132065
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Sep 2023 05:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 388CgfaG2977164; Fri, 8 Sep 2023 21:42:42 +0900
X-Iguazu-Qid: 2yAasULiHY2XxK5kcS
X-Iguazu-QSIG: v=2; s=0; t=1694176961; q=2yAasULiHY2XxK5kcS; m=PY/ZIdJ2egFfcoaVbHqxLfvzPBhWBC+CuXoN09Eme/I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 388Cge0L3160857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 8 Sep 2023 21:42:40 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 3/3][v2] security.yml: Add additional features to security image
Date: Fri,  8 Sep 2023 18:12:37 +0530
X-TSB-HOP2: ON
Message-Id: <20230908124237.508469-4-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20230908124237.508469-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 08 Sep 2023 12:42:38.0251 (UTC) FILETIME=[F3137FB0:01D9E251]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Sep 2023 12:42:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13008

From: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>

From IEC certification perspective, a security image is needed
which has the below features along with security customizations.

1. Data encryption (CR 4.1)
2. Secure boot (EDR 3.14)
3. Swupdate (NDR 3.10)

Signed-off-by: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
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



