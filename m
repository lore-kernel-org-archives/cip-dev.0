Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0DCECAAA1
	for <webhook@archiver.kernel.org>; Tue, 30 Aug 2022 14:02:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.11901.1661868122593855511
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Aug 2022 07:02:03 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27UE20xN017020;
 Tue, 30 Aug 2022 23:02:00 +0900
X-Iguazu-Qid: 34tMXISijtCJXAVNxI
X-Iguazu-QSIG: v=2; s=0; t=1661868119; q=34tMXISijtCJXAVNxI;
 m=WqG7GBVE61aFPBDlPLr7i+WqlXQRcWCK6pDWr5WJbYQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 27UE1wXU033289
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 30 Aug 2022 23:01:59 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core] cip-core-image-security.bb: Add duplicity package to
 enable IEC requirement
Date: Tue, 30 Aug 2022 19:31:56 +0530
X-TSB-HOP2: ON
Message-Id: <20220830140156.2326-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 30 Aug 2022 14:01:56.0789 (UTC)
 FILETIME=[10E44650:01D8BC79]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Aug 2022 14:02:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9323

From: Sai <Sai.Sathujoda@toshiba-tsip.com>

Duplicity package provides below features in order to implement IEC
requirement "Control System Backup"
1. Backup and restore
2. Encryption of backup
3. Checks integrity before restore

Python3-paramiko package is required to enable remote backups.

Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
---
 recipes-core/images/cip-core-image-security.bb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
index 24b1f46..9e9e43a 100644
--- a/recipes-core/images/cip-core-image-security.bb
+++ b/recipes-core/images/cip-core-image-security.bb
@@ -34,6 +34,7 @@ IMAGE_PREINSTALL += " \
 	sudo \
 	aide-common \
 	libpam-google-authenticator \
+	duplicity python3-paramiko \
 "
 
 OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
-- 
2.20.1



