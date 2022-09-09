Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B05CECAAD5
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 07:04:01 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.3727.1662707036743311198
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 00:03:57 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 28973soD026301;
 Fri, 9 Sep 2022 16:03:54 +0900
X-Iguazu-Qid: 34tKCr8CRxNfoCo4cY
X-Iguazu-QSIG: v=2; s=0; t=1662707034; q=34tKCr8CRxNfoCo4cY;
 m=P7jsN6yOs5e5FwSoILBoqrE6X9AZy1ku6Dk/9ahIG9E=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 28973rDo022582
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Sep 2022 16:03:53 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/2] cip-core-image-security.bb: Add duplicity package
 to enable IEC requirement
Date: Fri,  9 Sep 2022 12:33:48 +0530
X-TSB-HOP2: ON
Message-Id: <20220909070349.10519-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220909070349.10519-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20220909070349.10519-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Sep 2022 07:03:50.0150 (UTC)
 FILETIME=[50387260:01D8C41A]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 07:04:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9475

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



