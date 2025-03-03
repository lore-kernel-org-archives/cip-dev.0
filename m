Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DD3C282C5
	for <webhook@archiver.kernel.org>; Mon,  3 Mar 2025 06:30:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web10.47730.1740983443401203888
 for <cip-dev@lists.cip-project.org>;
 Sun, 02 Mar 2025 22:30:43 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5236Ue1G1537292; Mon, 3 Mar 2025 15:30:41 +0900
X-Iguazu-Qid: 2rWhWAeBk6iTLi6k0P
X-Iguazu-QSIG: v=2; s=0; t=1740983440; q=2rWhWAeBk6iTLi6k0P; m=aea69VwViAn9/8UdlAvy5flFLCPZy2JUIe8Nfru4GL0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 5236UdhH3168770
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Mar 2025 15:30:40 +0900
From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        Adithya.Balakumar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com
Subject: [isar-cip-core][PATCH v1] Set fixed UUID for EROFS
Date: Mon,  3 Mar 2025 11:52:20 +0530
X-TSB-HOP2: ON
Message-Id: <20250303062220.4190969-1-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Mar 2025 06:30:36.0076 (UTC) FILETIME=[C5EA66C0:01DB8C05]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Mar 2025 06:30:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17993

Pass fixed UUID based on the SOURCE_DATE_EPOCH variable to make the EROFS
filesystem reproducible.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 classes/erofs.bbclass | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
index 72458bb..2743bd1 100644
--- a/classes/erofs.bbclass
+++ b/classes/erofs.bbclass
@@ -25,6 +25,14 @@ python __anonymous() {
     for dir in exclude_directories:
         args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
     d.appendVar('EROFS_CREATION_ARGS', args)
+
+    import uuid
+
+    sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
+    erofs_uuid = uuid.UUID(int=sde_time)
+
+    args = "-U " + str(erofs_uuid)
+    d.appendVar('EROFS_CREATION_ARGS', args)
 }
 
 IMAGE_CMD:erofs[depends] = "${PN}:do_transform_template"
-- 
2.39.2



