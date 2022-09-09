Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303DBECAAD3
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 08:07:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.4150.1662710862014580719
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 01:07:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.157,
 mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 28987cYb027636;
 Fri, 9 Sep 2022 17:07:39 +0900
X-Iguazu-Qid: 2wGr4d9xrS6SJ6JOkO
X-Iguazu-QSIG: v=2; s=0; t=1662710858; q=2wGr4d9xrS6SJ6JOkO;
 m=4B2vHjhKzWE74HnUnPW8/UQVvh5bsHblibfrXmsT0oU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 28987bgE023131
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 9 Sep 2022 17:07:38 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Sai <Sai.Sathujoda@toshiba-tsip.com>, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 2/2] cip-core-image-security.bb: Add duplicity package
 to enable IEC requirement
Date: Fri,  9 Sep 2022 13:37:31 +0530
X-TSB-HOP2: ON
Message-Id: <20220909080731.10848-3-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220909080731.10848-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20220909080731.10848-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Sep 2022 08:07:32.0085 (UTC)
 FILETIME=[36457250:01D8C423]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 08:07:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9480

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



