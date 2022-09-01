Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C110ECAAD8
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 14:56:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.13321.1662044160249285171
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 07:56:01 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 281EtwPQ026138;
 Thu, 1 Sep 2022 23:55:58 +0900
X-Iguazu-Qid: 34tKCr8CRkLEEh6OG0
X-Iguazu-QSIG: v=2; s=0; t=1662044157; q=34tKCr8CRkLEEh6OG0;
 m=+Sh06hBhUYag7fuigDSdDuokgRSNAOUKBgDaqDGw+Lg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1511) id 281Etu1v021070
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Sep 2022 23:55:57 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] cip-core-image-security.bb: Add packages required for
 IEC security requirements
Date: Thu,  1 Sep 2022 20:25:54 +0530
X-TSB-HOP2: ON
Message-Id: <20220901145554.11456-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Sep 2022 14:55:55.0041 (UTC)
 FILETIME=[EFDDD110:01D8BE12]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 14:56:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9423

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Add packages that are necessary for IEC requirments, even though these packages
are installed as part of CIP base system, mentioning them in this recipe will
make sure the packages are installed and also it provides the information of
what packages are required to satisfy IEC requirements.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-security.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 24b1f46..8ea032c 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -34,6 +34,10 @@ IMAGE_PREINSTALL += " \
 	sudo \
 	aide-common \
 	libpam-google-authenticator \
+	passwd \
+	login \
+	libpam-runtime \
+	util-linux \
 "
 
 OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
-- 
2.20.1



