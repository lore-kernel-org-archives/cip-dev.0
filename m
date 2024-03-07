Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BAFC54E55
	for <webhook@archiver.kernel.org>; Thu,  7 Mar 2024 07:46:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.18098.1709797555629100521
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Mar 2024 23:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4277jrvh385348; Thu, 7 Mar 2024 16:45:54 +0900
X-Iguazu-Qid: 2yAaO2s1xlLVusC6mK
X-Iguazu-QSIG: v=2; s=0; t=1709797553; q=2yAaO2s1xlLVusC6mK; m=Ouzuz8Ru1yAcU0nLsnEU9ntpJ6s4tXvomgOmAkVvyD4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4277jqQe1046023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Mar 2024 16:45:53 +0900
From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][RFC v1 3/6] swupdate: Enable Delta handler in swupdate
Date: Thu,  7 Mar 2024 13:16:09 +0530
X-TSB-HOP2: ON
Message-Id: <20240307074612.1996609-4-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 07:45:48.0712 (UTC) FILETIME=[78884280:01DA7063]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Mar 2024 07:46:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15253

Enable delta handler in swupdate for bookworm and disable cross compile
for arm and arm64 on bookworm to avoid build issues

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 recipes-core/swupdate/swupdate_2023.05.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
index d1fe1fa..7a22947 100644
--- a/recipes-core/swupdate/swupdate_2023.05.bb
+++ b/recipes-core/swupdate/swupdate_2023.05.bb
@@ -36,10 +36,13 @@ SRC_URI:append:bullseye = " file://0004-d-swupdate-www.install-Fix-path-for-debi
 DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
 # add suricatta wfx
 DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
+# add delta update build profile for bookworm
+DEB_BUILD_PROFILES:append:bookworm = " pkg.swupdate.delta"
 
 # Disable cross for arm and arm64 on bullseye
 # with cross compile we have a unsat-dependency to dh-nodejs on arm/arm64
 ISAR_CROSS_COMPILE:bullseye = "0"
+ISAR_CROSS_COMPILE:bookworm = "0"
 
 # use backport build profile for bullseye
 DEB_BUILD_PROFILES:append:bullseye = " pkg.swupdate.bpo"
-- 
2.39.2



